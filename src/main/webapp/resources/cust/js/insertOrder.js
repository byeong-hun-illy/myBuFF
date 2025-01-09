/**
 * 주문 페이지를 위한 js모음
 */
 document.write("<script src='/resources/js/global/value.js'></script>");
$(document).ready(function() {
 
	select2Custom(); // 셀렉트 디자인 라이브러리. common.js에서 호출 됨
	
	// 인풋 커스텀----------------------------------------------------------
    const plus = document.querySelectorAll('.cart-qty .plus-qty');
    plus.forEach(function(p){
        p.addEventListener('click',function(){
            // 현재 클릭한 버튼의 부모 찾기 closest()메서드
            let form = p.closest('.cart-qty');
            
            // 부모에 속한 .num 가져오기
            let num = form.querySelector('.num');
            
            // input[type:text]으로 작성 된 .num의 value를 숫자로 형변환
            let qty = parseInt(num.value);
            
            // 숫자로 강제 형변환 하는 경우, 'Not A Number'으로 검사 해야 한다
            if(!isNaN(qty)){ // 숫자가 맞는 경우
                num.value = qty+1;
            }
        })
    })
   
    const minus = document.querySelectorAll('.minus-qty')
    minus.forEach(function(m){
        m.addEventListener('click', function(){
            // 부모 찾기
            let form = m.closest('.cart-qty');

            // .num 찾기
            let num = form.querySelector('.num');

            // .num value 숫자로 바꾸기
            let qty = parseInt(num.value);

            // 숫자인지 검사하기
            if(!isNaN(qty)){
                if(num.value<=0){
                    num.value=0;
                }else{
                    num.value = qty-1;
                }
            }
        })
    })    
	// 인풋 커스텀----------------------------------------------------------
	
});

$('.tap-select').on('click', function() {
	$('.tap-select').removeClass('active');
	$(this).addClass('active');
	
	if( $('.tap-frcs').hasClass('active') ) {
		$('.dtl-inner.frcs').css('display','flex');
		$('.dtl-inner.cart').css('display','none');
	}
	
	if( $('.tap-cart').hasClass('active') ) {
		$('.dtl-inner.cart').css('display','flex');
		$('.dtl-inner.frcs').css('display','none');
	}
});

/*************************************************
		지역 선택 시에 선택한 지역의 frcs만을 보여주는 함수
****************************************************/
function selectFrcs(rgnNo){
	$.ajax({
	   url:"/cust/selectFrcsAjax",
	   data:{"rgnNo":rgnNo},
	   type:"post",
	   dataType:"json",
	   beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
	   success:function(result){
	     console.log("result : ", result);
	      
	    let str = "";
	    $("#frcsNo").html("");
	    str = "<option value='' selected>가맹점과 메뉴를 선택해주세요</option>";
	      
	    $.each(result.bzentVOList,function(idx,bzentVO){
	   
	    	str += "<option value='" + bzentVO.bzentNo +"'>" +bzentVO.bzentNm+ "</option>";
	   
	    });
	      
	   $("#frcsNo").html(str);
	   } // success 끝
	});
}

/*************************************************
		가맹점 선택 시에 가맹점의 판매 메뉴 보여줌
****************************************************/
function selectFrcsMenu(){
	let data = {};
  data.bzentNo = bzentNo;
  data.menuType = menuType;

	$.ajax({
           url: "/cust/ordr/selectMenu",  
           type: "GET", 
           data: data,
           dataType: "json",  
           beforeSend:function(xhr){ 
				xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
			},
           success: function(result) {
               console.log("result : ", result);
               
               $(".frcs-none").html("");
               let spnNew = "";
               let str = "";
               $.each(result, function(idx, menuVO) {
                   str += `<li class="newBox" data-no="${menuVO.menuNo}"> 
		                   <div class='img-box'>
		                   	<span style='background-image: url(${menuVO.menuImgPath})'></span>
		                   </div>  
		                   `;
		                   if(menuVO.regYmdNew>0){
		                   		spnNew = '<span>NEW</span>';
		                   } else {
		                   		spnNew = '';
		                   }
		                   
		                   str += `<div id="newBge">${spnNew}</div>`
		                   str += `<div class='list-menuNm'>${menuVO.menuNm} </div>
		                   <div class='list-price'><p>${menuVO.menuAmt.toLocaleString()}<em>원</em></p></div>
		                   
		                   <div class='preservation'>
			                    <div class='list-input'>
			                    <div class='cart-qty'>
				                    <input type='button' value='-' class='minus-qty'>
				                    <input type='number' value='1' class='num'>
				                    <input type='button' value='+' class='plus-qty'>
			                   </div>
			                   
			                    <button type='button' class='menu-add'>담기</button>
			                    </div>  
		                    </div>  
		                 </li>`;  
               });
               
               //console.log(str);
               $(".list-box").html(str);
           },
           error: function(xhr, status, error) {
               console.error("AJAX 에러: ", status, error);
           }
	});
}

/*************************************************
		담기 클릭시에  장바구니 메뉴 이동
****************************************************/
function addCart($li){
	// 메뉴 이미지, 이름, 가격, 수량 저장하기 
       let menuImg = $li.find(".img-box span").css("background-image").replace(/url\(["']?/, '').replace(/["']?\)/, ''); // url 과 ()을 삭제
       let menuNm = $li.find(".list-menuNm").text().trim();
       console.log(menuNm);
       let menuAmt = parseInt($li.find(".list-price p").text().trim().replace(/,/g, '').replace('원', '')); // 가격을 숫자로 바꿈
       let num = parseInt($li.find(".list-input .num").val());
       menuNo = $li.data("no"); 
       price = menuAmt * Math.max(num, 1);
       console.log(menuNo);
       
       // 장바구니에서 기존 메뉴 검사
       let cartMenu = $(".cart-wrap.menu-list").find("li").filter(function() {
           return $(this).data("no") === menuNo;
       });

       // 기존 메뉴가 있을 경우, 수량만 업데이트
       if (cartMenu.length > 0) {
           let currentQtyInput = cartMenu.find(".num");
           let currentQty = parseInt(currentQtyInput.val()) || 0; // 현재 수량 가져오기
           currentQtyInput.val(currentQty + num); // 새로운 수량으로 업데이트
           let updatedPrice = (currentQty + num) * menuAmt; // 새로운 수량에 따라 가격도 업데이트
        	cartMenu.find(".menu-price.cart-price").text(updatedPrice.toLocaleString() + " 원"); // 가격 업데이트
       } else {
           $(".menu-none").html("");
           
           // 새로운 메뉴 추가하는 로직
           let newRow = `<li class='cart-cont' data-no='${menuNo}'>
				           <div class='menu-info'>
					           	<div class=''>
						           <input type='checkbox' class='check-btn' id='menuChk_${menuNm}' name='menuChk'>   
						           <label for='menuChk_${menuNm}'></label>
						       </div>
					           <img class='menu-img' alt='${menuNm}' src='${menuImg}' style='width: 136.84px; height: 100px;'>
					           <p>${menuNm}</p>
					       </div>
					       <div class='menu-price list-input'>
					       		<div class='cart-qty'>
						           <input type='button' value='-' class='minus-qty cartQty'>
						           <input type='number' value='${num}' class='num cart-qty' data-amt=${menuAmt}> 
						           <input type='button' value='+' class='plus-qty cartQty'>
						       </div>
						       <div class='menu-price cart-price'>
						       		${price.toLocaleString()} 원
						       </div> 
						       <div class='menu-delete'>
					           <span class='material-symbols-outlined menuDelete'>close</span>
				           		</div>
				           	</div>
			           </li>`

           // 장바구니에 추가하기
           $("ul.cart-wrap.menu-list").append(newRow);
       }
       // 수량 초기화
       $li.find(".list-input .num").val(1); // 최소 1로 초기화
       // 총 수량과 합산금액 변화
       updateTotal();
}

 /*************************************************************************************
			가격 변경  -------------------------------------------
**************************************************************************************/
// 모든 gdsTotal 값을 합산하여 id="total"에 반영하는 함수
function updateTotal() {
    let total = 0;
    let totalQty = 0;

    // 모든 메뉴의 가격을 순회하여 합산
    $('.cart-price').each(function() {
        let price = parseFloat($(this).text().replace(/,/g, '').replace('원', '').trim());
        if (!isNaN(price)) {
            total += price;
        }
    });

    // 모든 수량을 순회하여 합산
    $('input.num.cart-qty').each(function() {
        let qty = parseInt($(this).val()) || 0;
        totalQty += qty;
    });

    // 총합을 업데이트
    $('#sumTotal').text(total.toLocaleString() + "원");
    $('#sumQty').text(totalQty.toLocaleString() + "개");
    $('#cartQty').text(totalQty.toLocaleString());

    let discount = typeof dscntAmt !== 'undefined' ? dscntAmt : 0;  // dscntAmt가 정의되어 있지 않을 때 0으로 설정
    $('#totalAmt').text((total - discount).toLocaleString() + "원");
}

 /*************************************************************************************
			쿠폰 조회  -------------------------------------------
**************************************************************************************/
function selectCoupon(){
	$.ajax({
           url: "/cust/ordr/selectCoupon",  
           type: "POST", 
           data: {"mbrId" : mbrId},
           beforeSend:function(xhr){ 
				xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
			},
           success: function(res) {
               let str = '';
               console.log(res);
				
				if(res.length==0){
					str += `
						<div class="error-info">
							<span class="icon material-symbols-outlined">error</span>
							<div class="error-msg">사용가능한 쿠폰이 없습니다</div>
						</div>`;
				}

               res.forEach(list => {
					// 장바구니에서 기존 메뉴 검사
			       let cartMenu = $(".cart-wrap.menu-list").find("li").filter(function() {
			           return $(this).data("no") === list.menuNo;
			       });
					let chk = false;
					if (cartMenu.length > 0) { chk = true; } 
					// 등록 일자
					let exp = strToDate(list.expYmd);	
		    		str += `
		    		<div class="card-con">
			    		<div class="couponCard ${chk? 'coupon-active':'coupon-disabled'}"  
				    		data-sn="${list.issuSn}" 
				    		data-amt ="${list.dscntAmt}"
				    		data-menu="${list.menuNo}"
				    		data-nm="${list.menuNm}"
				    		>
			    			<div class="cp-title">${list.couponNm}</div>
			    			<div class="cp-cont">
			    				<div class="cp-menu">${list.menuNm} </div>
			    				<div class="cp-amt">${list.dscntAmt.toLocaleString()}원 할인</div>
			    				<div class="cp-date">~ ${exp}까지 사용가능</div>
			    			</div>
			    		</div>
		    		</div>
					`;
			
				}); // 반복끝
				
				$('.modal-body').html(str);
				
           },
           error: function(xhr, status, error) {
               console.error("AJAX 에러: ", status, error);
           }
	});
}

function couponText(menNm, dscntAmt){
	$('#cp-use').html(`${menNm} ${dscntAmt.toLocaleString()}원 할인 <span class="material-symbols-outlined">subdirectory_arrow_left</span>`);

}
/***************
카카오 페이
***************/
// 아임포트 초기화 - 발급받은 가맹점 식별코드를 입력
function requestPay(){
	let ordrVO = {};
	let ordrDtlVOList = [];
	let totalAmt = $('#totalAmt').text().replace(/,/g, '').replace('원', '');
	let selectedRadio = $('.radio-btn:checked');
	if(totalAmt==0){
		Swal.fire({
		  title: "오류",
		  text: "메뉴를 선택해주세요.",
		  icon: "error",
		  confirmButtonColor: "#00C157",
		  confirmButtonText: "확인"
		})
		return;
	} else if(selectedRadio.length == 0) {
		Swal.fire({
		  title: "오류",
		  text: "주문 유형을 선택해주세요.",
		  icon: "error",
		  confirmButtonColor: "#00C157",
		  confirmButtonText: "확인"
		})
		return;
	}
	
	// ordrVO #{ordrType}, 'N', #{mbrId}, issuSn

	ordrVO.ordrType = $('.radio-btn:checked').val();
	ordrVO.mbrId = mbrId;
	ordrVO.issuSn = issuSn;

	// ordrDtlVO #{frcsNo}, #{menuNo}, #{ordrQty}
	
	$('.cart-cont').each(function(index) {
	    // tr에서 필요한 데이터를 추출
	    let mnNo = $(this).data('no'); 
	    // 수량을 'input.num.cart-qty'에서 가져옴
    	let ordrQty = $(this).find('.cart-qty .num').val(); // 수량 값

	    
	    // po_seq 부여하여 stockPOList에 추가
	    let ordrDtlVO = {
	        frcsNo: bzentNo,
	        menuNo: mnNo,
	        ordrQty : ordrQty
	    };
	    
	    ordrDtlVOList.push(ordrDtlVO);
	});
	
	//console.log(ordrVO);
	//console.log(ordrDtlVOList);
	
	ordrVO.ordrDtlVOList = ordrDtlVOList;
	//console.log(ordrVO);

// 주문 넣기

IMP.init('imp18451025'); // 고객사 식별코드
  IMP.request_pay({
    pg: "kakaopay",
    pay_method: "kakaopay",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : 'BUFF',
    amount : totalAmt,
    //buyer_email : 'iamport@siot.do',
    //buyer_name : '구매자',
    //buyer_tel : '010-1234-5678',
    //buyer_addr : '서울특별시 강남구 삼성동',
    //buyer_postcode : '123-456'
  }, function (rsp) { // callback
      if (rsp.success) {
        // 결제 성공 시 로직,
        var msg = '결제가 완료되었습니다.';
        msg += '\n고유ID : ' + rsp.imp_uid; // 아임포트 거래 고유 ID
        msg += '\n상점 거래ID : ' + rsp.merchant_uid; // 상점에서 전달한 거래 ID
        msg += '\n결제 금액 : ' + rsp.paid_amount; // 결제 금액
        msg += '\n카드 승인번호 : ' + rsp.apply_num; // 카드 승인번호
		// 서버전송
		$.ajax({
			url : "/cust/ordr/insertOrdr",
			type : "POST",
			data: JSON.stringify(ordrVO),  // JSON으로 변환
        	contentType: "application/json",  // JSON 형식으로 전송
	        beforeSend: function(xhr) { 
	            xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	        },
			success : function(res){
				Swal.fire({
				  title: "완료",
				  html: `<p>주문이 접수되었습니다.</p><p>주문 번호는 ${res}입니다.</p><p>추가 주문하시겠습니까?</p>`,
				  icon: "success",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  confirmButtonText: "확인",
				  cancelButtonText: "주문내역 확인"
				}).then((result) => {
					  if (result.isConfirmed) {
					  
					  		// 주문 초기화
						      $("ul.cart-wrap.menu-list").html('');
						      
						      if ($(".menu-list li").length === 0) {
						          $(".menu-none").html(`
						              <div class="cart-wrap">
						                  <div class="error-info">
						                      <span class="icon material-symbols-outlined">error</span>
						                      <div class="error-msg">선택한 메뉴가 없습니다</div>
						                  </div>
						              </div>
						          `);
						      }
						      
						      // 쿠폰 삭제
						      if(issuSn != ''){
									issuSn = '';
									cpMenu = '';
									dscntAmt = 0;
									$('.chk-coupon').html('');
						      }
						      
						      updateTotal(); // 총 가격과 수량 변화
					  } else{
					  	location.href = '/custPage/selectMyPage';
					  }
				});	
			} // success 끝
		});
		
      } else {
        // 결제 실패 시 로직,
      }
  });
  
}