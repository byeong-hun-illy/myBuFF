<%--
    @fileName    : insertOrdr.jsp
    @programName : 고객 주문 화면
    @description : 고객이 가맹지점에 주문하는 화면, 가맹지점, 메뉴 구부을 선택후 메뉴담기가 가능함.
    @author      : 서윤정
    @date        : 2024. 09. 11
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>  <!-- 아임포트 SDK 로드 -->
<sec:authentication property="principal.memberVO" var="user" />
<link href="/resources/cust/css/insertOrder.css" rel="stylesheet">
<script src="/resources/cust/js/insertOrder.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
/* 셀렉트 커스텀 */
.select2-selection[aria-labelledby="select2-menuType-container"] { 
   width: 200px !important;
}
.select2-selection[aria-labelledby="select2-menuType-container"] .select2-dropdown {
   width: 198px !important;
}

/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox  */
input[type='number'] {
  -moz-appearance: textfield;
}

/* modal-body 스크롤바 */
.modal-body::-webkit-scrollbar {
    width: 7px;
    height: 7px;
}
.modal-body::-webkit-scrollbar-thumb {
    background: var(--gray--4);
    border-radius: 45px;
}
.modal-body::-webkit-scrollbar-thumb:hover {
    background: var(--green--4);
}
.modal-body::-webkit-scrollbar-track {
    background: transparent;
}

</style>


<%! 
    public boolean isNewMenu(String regDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        try {
            Date registrationDate = sdf.parse(regDate);
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -30); // 현재 날짜에서 30일 전으로 설정
            Date thirtyDaysAgo = cal.getTime();
            return registrationDate.after(thirtyDaysAgo); // 등록일이 30일 이내인지 확인
        } catch (Exception e) {
            return false; // 오류 발생 시 false 리턴
        }
    }
%>


<script type="text/javascript">
<%--
@fileName    : insertOrdr.jsp
@programName : 고객 주문 화면
@description : 가맹점 선택 후, 메뉴 주문
@author      : 서윤정
@date        : 2024. 10. 05
--%>
let urlParams = new URLSearchParams(window.location.search);
let mbrId = '<c:out value="${user.mbrId}" />';
console.log(mbrId);
let bzentNo ='';
let menuNo = '';
let menuType = ''; 
let price = '';
let cpMenu = '';
let issuSn = ''; // 쿠폰 사용 시 저장
let dscntAmt = 0;
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

$(function(){
	if(urlParams.has('bzentNo')){
		bzentNo = urlParams.get('bzentNo');
		selectFrcsMenu();
	}
	
   // 지역 선택 후, 가맹 지점 선택
   $("#rgnNo").on("change",function(){
        let rgnNo = $(this).val();
        //console.log("rgnNo : ", rgnNo);
        selectFrcs(rgnNo);
     });//end 달러샵 rgnNo
      
            
   // 가맹점 선택 시 해당 가맹점의 메뉴 나옴
   $(document).on("change", "#frcsNo", function() {
       bzentNo = $(this).val(); 

      selectFrcsMenu();
      
      //가맹점을 변경시에 기존에 장바구니에 담았던 내용이 삭제
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
      
   }); // end bz 가맹점 메뉴

   // 메뉴 구분 클릭시, 선택된 구분의 메뉴만 나옴
   $("#menuType").on("change",function(){
        menuType =  $(this).val(); 
        if(bzentNo==''){
        	alert("선택한 가맹점이 없습니다");    /// 수정!!!!!!!!!
        	return;
        }
      selectFrcsMenu();
   }); // end bz 가맹점 메뉴, 메뉴 구분 끝
   
   
   // 버튼  + 수량 
   $(document).on('click', '.plus-qty', function() {
      // 현재 클릭한 버튼의 부모 .cart-qty 찾기 
       let form = $(this).closest('.cart-qty');
       
       // 부모에 속한 .num 가져오기
       let num = form.find('.num');
       
       // input[type=text]으로 작성된 .num의 value를 숫자로 형변환
       let qty = parseInt(num.val());
       
       // 숫자인지 검사하기
       if (!isNaN(qty)) {
           num.val(qty + 1);
       }
   });

   // 버튼 - 수량
   $(document).on('click', '.minus-qty', function() {
       // 현재 클릭한 버튼의 부모 .cart-qty 찾기 
       let form = $(this).closest('.cart-qty');
       
       // 부모에 속한 .num 가져오기
       let num = form.find('.num');
       
       // input[type=text]으로 작성된 .num의 value를 숫자로 형변환
       let qty = parseInt(num.val());
       
       // 숫자인지 검사하기
       if (!isNaN(qty)) {
           if (qty <= 1) {
               num.val(1);
           } else {
               num.val(qty - 1);
           }
       }
   });
   
   $(document).on('click', '.cartQty', function(){
	// 현재 클릭한 버튼의 부모 .cart-qty 찾기 
       let form = $(this).closest('.cart-qty');
	
    // 부모에 속한 .num 가져오기
       let num = form.find('.num');
    
		let amt = num.data("amt");
		let qty = num.val();
		
		form.next().text((amt * qty).toLocaleString() +" 원");
		updateTotal(); // 총 가격과 수량 변화
   })
   
   // 장바구니 메뉴 담기 
   $(document).on("click", ".menu-add", function() {
       //console.log("메뉴 담기 클릭!");
       let $li = $(this).closest("li");
       addCart($li);
    
   });


   // 전체 선택 버튼 눌렀을 때, 모든 체크 박스 체크 표시
   $("#allChk").on("click", function() {
       let isChecked = $(this).hasClass("checked");
       $(this).toggleClass("checked"); 

       $(".check-btn").prop("checked", !isChecked);
   });

   // 장바구니에서 선택된 메뉴 삭제
   $("#cartDelete").on("click", function() {
       $(".menu-list li").each(function() {
    	if(cpMenu==$(this).data("no")){
   			issuSn = '';
   			cpMenu = '';
   			dscntAmt = 0;
   			$('.chk-coupon').html('');
   		}
    	   
           let isChecked = $(this).find(".check-btn").is(":checked");
           if (isChecked) {
               $(this).remove(); // 선택된 메뉴 삭제
           }
       });
       // 장바구니에 모든 메뉴가 삭제 됏을 때, 선택한 메뉴 없음 뜨기
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
    	// 삭제 후 총 수량과 합산금액 변화
       updateTotal();
   });
   
   $(document).on('click', '.menu-delete', function(){
	    // 클릭된 menuDelete의 가장 가까운 cart-cont 요소를 찾음
	    let cartItem = $(this).closest('.cart-cont');
		if(cpMenu==cartItem.data("no")){
			issuSn = '';
			cpMenu = '';
			dscntAmt = 0;
			$('.chk-coupon').html('');
		}
	    // cart-cont 요소를 제거
	    cartItem.remove();
	    
	 // 장바구니에 모든 메뉴가 삭제 됏을 때, 선택한 메뉴 없음 뜨기
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
	    
    	// 삭제 후 총 수량과 합산금액 변화
       updateTotal();
   })
   
	var modal = new bootstrap.Modal(document.getElementById('ccModal'));
	
	$('#couponModal').on('click', function(){
		modal.show();
		selectCoupon();
	})
	
	$(document).on('click', '.coupon-active', function(){
		issuSn = $(this).data("sn");
		cpMenu = $(this).data("menu");
		let menNm = $(this).data("nm");
		dscntAmt = $(this).data('amt');
		couponText(menNm, dscntAmt)    
		modal.hide();
		updateTotal();
	})
	
	$(document).on('click', '#orderBtn', function(){
		requestPay();
	})
	
});//end 달러function



</script>


<div class="wrap order-wrap">
   
   <!-- 공통 컨테이너 영역 -->   
   <div class="wrap-cont">
   
      <!-- 공통 타이틀 영역 -->
      <div class="wrap-title">주문하기</div>
      <!-- /.wrap-title -->
      
      <!-- 탭 영역 -->
      <div class="order-tap">
         <div class="tap-select tap-frcs active">가맹점 선택</div>
         <div class="tap-select tap-cart">장바구니 (<span id="cartQty">0</span>)</div>
      </div>
      <!-- /.tap-wrap -->
      
      <!-- 주문 상세 영역 -->
      <div class="dtl-wrap">
         
         <!-- 주문 상세 오른쪽 영역 -->
         <div class="dtl-cont left">
            
            <!-- 가맹점 선택 영역 -->
            <div class="dtl-inner frcs">
            
               <!-- 셀렉트 영역 -->
               <div class="select-wrap">
                  <!-- 지역 선택 셀렉트 영역 -->
                  <select name="rgnNo" id="rgnNo" class="select2-custom">
                     <option value="" selected>지역을 선택해주세요</option>
                     <option value="RGN11"<c:if test="${param.rgnNo == 'RGN11'}">selected</c:if>>서울특별시</option>
                     <option value="RGN21"<c:if test="${param.rgnNo == 'RGN21'}">selected</c:if>>부산광역시</option>
                     <option value="RGN22"<c:if test="${param.rgnNo == 'RGN22'}">selected</c:if>>대구광역시</option>
                     <option value="RGN23"<c:if test="${param.rgnNo == 'RGN23'}">selected</c:if>>인천광역시</option>
                     <option value="RGN24"<c:if test="${param.rgnNo == 'RGN24'}">selected</c:if>>광주광역시</option>
                     <option value="RGN25"<c:if test="${param.rgnNo == 'RGN25'}">selected</c:if>>대전광역시</option>
                     <option value="RGN26"<c:if test="${param.rgnNo == 'RGN26'}">selected</c:if>>울산광역시</option>
                     <option value="RGN29"<c:if test="${param.rgnNo == 'RGN29'}">selected</c:if>>세종특별자치시</option>
                     <option value="RGN31"<c:if test="${param.rgnNo == 'RGN31'}">selected</c:if>>경기도</option>
                     <option value="RGN32"<c:if test="${param.rgnNo == 'RGN32'}">selected</c:if>>강원도</option>
                     <option value="RGN33"<c:if test="${param.rgnNo == 'RGN33'}">selected</c:if>>충청북도</option>
                     <option value="RGN34"<c:if test="${param.rgnNo == 'RGN34'}">selected</c:if>>충청남도</option>
                     <option value="RGN35"<c:if test="${param.rgnNo == 'RGN35'}">selected</c:if>>전라북도</option>
                     <option value="RGN36"<c:if test="${param.rgnNo == 'RGN36'}">selected</c:if>>전라남도</option>
                     <option value="RGN37"<c:if test="${param.rgnNo == 'RGN37'}">selected</c:if>>경상북도</option>
                     <option value="RGN38"<c:if test="${param.rgnNo == 'RGN38'}">selected</c:if>>경상남도</option>
                     <option value="RGN39"<c:if test="${param.rgnNo == 'RGN39'}">selected</c:if>>제주특별자치도</option>
                  </select>
                     
                  <!-- 가맹점 셀렉트 영역 -->
                   <select class="select2-custom" name="frcsNo" id="frcsNo">
                        <option value="">가맹점을 선택해주세요</option>
                     <!-- ajax() 출력 영역 --> 
                        <c:forEach var="bzentVO" items="${bzentVOList}">
                             <option value="${bzentVO.bzentNo}" <c:if test="${param.bzentNo == bzentVO.bzentNo}">selected</c:if>>${bzentVO.bzentNm}</option>
                          </c:forEach>
                  </select>
                  <!-- 메뉴 구분 셀렉트 영역 -->
                  <select name="menuType" id="menuType" class="select2-custom">
                        <option  value="" selected >메뉴 선택</option>
                        <option  value="">전체</option>
                        <option value="MENU01"<c:if test="${param.menuType == 'MENU01'}">selected</c:if>>세트</option>
                        <option value="MENU02"<c:if test="${param.menuType == 'MENU02'}">selected</c:if>>햄버거</option>
                        <option value="MENU03"<c:if test="${param.menuType == 'MENU03'}">selected</c:if>>사이드</option>
                        <option value="MENU04"<c:if test="${param.menuType == 'MENU04'}">selected</c:if>>음료</option>
                  </select>
               </div>   
               <!-- /.select-wrap -->   
               
               <!-- 메뉴 영역 -->
                <div class="frcs-menu">
                   <ul class="list-box">
                     <!-- ajax() 출력 영역 --> 
                        </ul>
                         <div class="frcs-none">
                      <div class="frcs-wrap">
                         <div class="error-info">
                        <span class="icon material-symbols-outlined">error</span>
                        <div class="error-msg">가맹점을 선택해주세요</div>
                     </div>
                      </div>
                   </div>
                </div>
                        
            </div>
            <!-- /.frcs-menu -->
            
            <!-- 장바구니 영역 -->
            <div class="dtl-inner cart" style="display:none">
               <div class="cart-top">
                  <div class="cart-title">선택한 메뉴</div>
                  <div class="cart-controll">
                     <div class="cart-all" id="allChk">전체선택</div>
                     <div class="cart-delete" id="cartDelete">삭제</div>
                  </div>
               </div>
                   <ul class="cart-wrap menu-list">
                   
               <!-- ajax() 출력 영역 --> 
               
                   </ul>
                   <!-- /.menu-list -->
                   
                   <div class="menu-none">
                      <div class="cart-wrap">
                         <div class="error-info">
                        <span class="icon material-symbols-outlined">error</span>
                        <div class="error-msg">선택한 메뉴가 없습니다</div>
                     </div>
                      </div>
                   </div>
            </div>
            <!-- /.select-menu -->
         
         </div>
         <!-- /.dtl-cont.left -->
         
         <!-- 주문 상세 왼쪽 영역 -->
         <div class="dtl-cont right">
            
            <div class="dtl-right">
            
               <!-- 주문 확인 영역 -->
               <div class="chk-inner">
                  <p class="chk-title">주문을 확인하세요!</p>
                  
                  <div class="chk-wrap top">
                     <div class="chk-cont">
                        <div class="rigth">총 수량</div>
                        <div class="left" id="sumQty">0개</div>
                     </div>
                     <div class="chk-cont">
                        <div class="rigth">합산금액</div>
                        <div class="left" id="sumTotal">0원</div>
                     </div>
                     <div class="chk-cont">
                        <div class="rigth">쿠폰사용</div>
                        <div class="left">
                           <button type="button" id="couponModal">쿠폰선택</button>
                        </div>
                     </div>
                     <div class="chk-coupon" id="cp-use">
                     </div>
                     <div class="chk-cont">
                        <div class="rigth">주문유형</div>
                        <div class="left">
                           <input type="radio" class="radio-btn" id="ordr02" name="ordr" value="ORDR02" <c:if test="${param.ordrType == 'ORDR02'}">checked</c:if>>   
                               <label for="ordr02"> 포장</label>
                           <input type="radio" class="radio-btn" id="ordr01" name="ordr" value="ORDR01" <c:if test="${param.ordrType == 'ORDR01'}">checked</c:if>>   
                               <label for="ordr01"> 매장</label>
                         </div>
                     </div>
                  </div>
                  <!-- /.chk-wrap.top-->
                  
                  <div class="chk-wrap bom">
                     <div class="chk-cont">
                        <div class="rigth">결제예정금액</div>
                        <div class="left" id="totalAmt">0원</div>
                     </div>
                  </div>
                  <!-- /.chk-wrap.bom-->
                  
               </div>
               <!-- /.chk-inner-->
               
               <!-- 주문하기 버튼 영역 -->
               <div class="order-btn">
                  <button type="button" id="orderBtn">주문하기</button>
               </div>
               <!-- /.order-btn -->
            
            </div>
            
         </div>
         <!-- /.dtl-cont.rigth -->
         
      </div>
      <!-- /.dtl-wrap -->
      
   </div>
   <!--  /.wrap-cont -->
   </div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/resources/cust/js/insertOrder.js"></script>


<!-- 주문시 쿠폰 사용 모달!!!! -->
<!-- 재고조정을 위해 상품을 출력 -->
<!-- 메뉴에서 상품 추가 -->
<div class="modal fade" id="ccModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-ml modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">쿠폰 선택</h4>
			</div>
			<div>
			  	<button type="button" class="btn-icon" data-dismiss="modal"><span class="material-symbols-outlined icon-btn">close</span></button>
			</div>
   		</div>
      <div class="modal-body" style="justify-content: normal;">
      
      </div>
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
  <!-- modal-dialog -->
</div>
<!-- modal -->
