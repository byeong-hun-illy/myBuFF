/*******************************************
  @fileName    : stock.js
  @author      : 이병훈
  @date        : 2024. 10. 01
  @description : 거래처 재고 관련 코드
********************************************/

// @methodName  : insertStockQty
// @author      : 이병훈
// @date        : 2024.10.01
// @jsp         : cnpt/stock/insertStockQty
// @description : 거래처 재고 조정 처리
// 재고 조정 등록 비동기 ajax 처리
function insertStockQty(){
	console.log("insertStockAjmt 함수 호출됨");
	
	let qty = $("#qty").val();
	let ajmtRsn = $("#ajmtRsn").val() || null;
	let stockAjmtType = $("#stockAjmtType").val();
	
	if(gdsCode){
		$("#gdsNm").val(gdsNm);
		$("#gdsNm").attr("disabled", true);
	}
	
	// 필수 입력값 체크
	if(!qty || isNaN(qty) || qty <= 0 || !stockAjmtType){
		Swal.fire({
            icon: 'error',
            title: '필수 입력값 오류!',
            text: '수량은 숫자여야 하며, 조정 유형을 입력해주세요!',
            confirmButtonText: '확인'
        });
        return;
	}
	
	 // stockVO와 stockAjmtVO 데이터를 생성
    stockVO = {
        gdsCode: gdsCode,
        bzentNo: bzentNo,
        qty: qty
    };

    stockAjmtVO = {
        gdsCode: gdsCode,
        bzentNo: bzentNo,
        ajmtType: stockAjmtType,
        qty: qty,
        ajmtRsn: ajmtRsn
    };
	
	
	// ajax 서버 전송
	$.ajax({
		url : "/cnpt/stock/insertStockQtyAjax",
		type : "POST", 
		contentType : "application/json; charset=utf-8;",
		data : JSON.stringify({
			gdsCode : gdsCode,
			bzentNo : bzentNo,
			qty : qty,
			ajmtRsn : ajmtRsn,
			stockAjmtType : stockAjmtType,
			stockVO : stockVO,
			stockAjmtVO : stockAjmtVO
		}),
		beforeSend : function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success : function(res){
			console.log("res : ", res);
			 Swal.fire({
                 icon: 'success',
                 title: '저장 성공',
                 text: '재고 조정이 완료되었습니다!',
                 confirmButtonText: '확인'
             }).then(() => {
                 // 성공 후 재고 목록으로 이동
                 location.href = '/cnpt/stockAjmt/list'; 
             });
		},
		error : function(xhr, status, error){
            console.error("에러 상태: ", status);
            console.error("에러 내용: ", xhr.responseText);
            
			 Swal.fire({
                 icon: 'error',
                 title: '저장 실패',
                 text: '저장 중 문제가 발생했습니다!',
                 confirmButtonText: '확인'
             });
		}
	// ajax 끝	
	});
// 재고조정 function 끝	
}

// @methodName  : pointGds
// @author      : 이병훈
// @date        : 2024.10.01
// @jsp         : cnpt/stock/insertStockQty
// @description : 모달에서 선택한 상품의 상품 코드와 상품 명 insertStockQty에 삽입
// 모달에서 상품 선택 시 처리
function pointGds(selectedGdsCode ,selectedGdsNm, selectedUnitNm){
	console.log("pointGds 함수 호출됨:");
	// 모달에서 선택한 값이 전역변수로 쓰이게
	gdsCode = selectedGdsCode;
	gdsNm = selectedGdsNm;
	unitNm = selectedUnitNm;
	
	console.log("pointGds 함수 호출됨:");
    console.log("Selected gdsCode:", gdsCode);
    console.log("Selected gdsNm:", gdsNm);
    console.log("Selected UnitNm:", unitNm);
    
	$("#gdsCode").val(gdsCode);
	$("#gdsNm").val(gdsNm);
	$("#unitNm").val(unitNm);
	$("#gdsModal").modal("hide");
	
	// 상품등록 페이지를 걸치지 않고 재고조정 페이지를 들어왔을 경우, stockVO, stockAjmtVO가 없기 때문에
	stockVO = {
		gdsCode : gdsCode,
		bzentNo : bzentNo,
		qty : $("#qty").val() || 0
	};
	
	stockAjmtVO = {
		gdsCode : gdsCode,
		bzentNo : bzentNo,
		ajmtType : $("#stockAjmtType").val(),
		qty : $("#qty").val(),
		ajmtRsn : $("#ajmtRsn").val()
		
	};
	
	console.log("Selected gdsCode:", gdsCode);
	console.log("Selected gdsNm:", gdsNm);
	console.log("stockVO:", stockVO);
    console.log("stockAjmtVO:", stockAjmtVO);
		
	
// pointGds 끝
}

// @methodName  : openGdsModal
// @author      : 이병훈
// @date        : 2024.10.01
// @jsp         : cnpt/stock/insertStockQty
// @description : 상품명 비어있을 시, 클릭하면 모달 열리게 하는 이벤트 모달 함수
// 상품 선택 시, 리스트 모달 열기
function openGdsModal(){
	console.log("모달 열기 함수 호출됨");
	
	$.ajax({
		url : "/cnpt/stock/selectGdsList",
		type : "GET",
		data : { bzentNo: bzentNo },
		success : function(res){
			console.log("Ajax 성공 : ", res);
		
			// 모달에 상품 리스트 채우기
			let str = '';
			res.forEach(gds => {
				console.log("unitNm", gds.unitNm);     // unitNm 값 확인
				console.log("gdsCode:", gds.gdsCode);  // gdsCode 값 확인
			    console.log("gdsNm:", gds.gdsNm);      // gdsNm 값 확인
				console.log("gds", gds);
				// gdsCode와 gdsNm을 템플릿에 반영하여 문자열 생성
				str += `<tr data-gds-code="${gds.gdsCode}" onclick= "pointGds('${gds.gdsCode}','${gds.gdsNm}', '${gds.unitNm}')">
			                <td style="width:255px;">${gds.gdsNm}</td>
			                <td style="width:200px;">${gds.unitNm}</td>
			            </tr>`;
			});
			$("#gdsModalTableBody").html(str);
			$("#gdsModal").show();
			
		},
		 error: function(xhr, status, error) {
			 	console.error("Error details:", xhr, status, error);
	            Swal.fire({
	                icon: 'error',
	                title: '조회 실패',
	                text: '상품 데이터를 불러오지 못했습니다.',
	                confirmButtonText: '확인'
	            });
	        }
	// ajax 끝	
	});
// 모달 열기 function 끝	
}
/*******************************************
  신규 기초 재고 등록 추가 시 이벤트 핸들러
********************************************/
function insertNewGdsBtn(){
	// 입력한 값 가져오기
		let gdsCode = $("#gdsNm").val();
		let gdsNm = $("#gdsNm option:selected").text();
		let gdsType = $("#gdsType").val();
		let gdsTypeNm = $("#gdsTypeNm").val();
		let unitNm = $("#unitNm").val();
		let qty = $("#qty").val();
		let amt = $("#amt").val();
		let ntslType = $("#ntslType").val();
		let ntslTypeNm = $("#ntslType option:selected").text();
		
		console.log("gdsCode : ", gdsCode);
		console.log("gdsNm : ", gdsNm);
		console.log("gdsType : ", gdsType);
		console.log("gdsTypeNm : ", gdsTypeNm);
		console.log("unitNm : ", unitNm);
		console.log("qty : ", qty);
		console.log("amt : ", amt);
		console.log("ntslType : ", ntslType);
		console.log("ntslTypeNm : ", ntslTypeNm);
	
		
		// 필수 입력값 체크
		if(!gdsCode || !gdsType || !unitNm || !qty || !amt || !ntslType ){
			Swal.fire({
			      icon: 'error',
			      title: '필수 항목 입력 오류!',
			      text: '필수 입력 항목들을 모두 입력하세요.'
			});
			return;
		}
		
		// 데이터 객체 생성
		let gdsData = {
				gdsCode : gdsCode, 
				gdsNm : gdsNm,
				gdsType : gdsType,
				unitNm : unitNm,
				qty : qty,
				amt : amt,
				ntslType : ntslType,
				bzentNo : bzentNo
			
		};
		
		// 데이터 배열에 추가
		gdsList.push(gdsData);
		
		// 테이블에 행 추가
		$("#gds-list").append(`
				<tr>
					<td><button type="button" class="delete-btn">삭제</button></td>
					<td style="text-align:center;">${gdsNm}</td>
					<td style="text-align:center;">${gdsTypeNm}</td>
					<td style="text-align:center;">${unitNm}</td>
					<td style="text-align:center;">${qty}</td>
					<td style="text-align:center;">${ntslTypeNm}</td>
					<td style="text-align:center;">${amt}</td>
				</tr>
				`);
		
		// 추가한 상품 수
		let total = $("#gds-list tr").length;
		console.log("상품 추가 수 : ", total);
		$("#clclnAmt").text(total);
				
		// 입력한 값 초기화
		$(".input-reset").val("");
		$("#gdsNm").val('').trigger('change');  // select 박스 초기화 및 Select2 리셋
		
// insertNewGdsBtn() 함수 끝
}
/*******************************************
  자동 입력 버튼 클릭시 이벤트 핸들러
********************************************/
// 자동입력 버튼 클릭 시 이벤트 핸들러
	$("#autoBtn").on("click", function() {
	    // 자동입력할 데이터 설정 (예시 데이터)
	    const autoData = [
	        {
	            gdsCode: "FDF002",
	            gdsNm: "치즈스틱(20cm)",
	            gdsType: "FD06",
	            gdsTypeNm: "냉동식품",
	            unitNm: "개",
	            qty: 500,
	            ntslType: "GDNT03", // 판매중
	            ntslTypeNm: "판매중",
	            amt: 1300
	        },
	        {
	            gdsCode: "FDM003",
	            gdsNm: "치킨패티(60g)",
	            gdsType: "FD01",
	            gdsTypeNm: "축산",
	            unitNm: "개",
	            qty: 900,
	            ntslType: "GDNT03",
	            ntslTypeNm: "판매중",
	            amt: 2500
	        },
	        {
	            gdsCode: "FDS001",
	            gdsNm: "데리야끼 소스",
	            gdsType: "FD05",
	            gdsTypeNm: "조미료/소스",
	            unitNm: "kg",
	            qty: 100,
	            ntslType: "GDNT03",
	            ntslTypeNm: "판매중",
	            amt: 7600
	        },
	        {
	            gdsCode: "FDU003",
	            gdsNm: "모짜렐라 치즈",
	            gdsType: "FD03",
	            gdsTypeNm: "유제품",
	            unitNm: "kg",
	            qty: 1000,
	            ntslType: "GDNT03",
	            ntslTypeNm: "판매중",
	            amt: 12500
	        }
	    ];

	    // 자동입력 데이터를 순회하면서 각 데이터를 추가
	    autoData.forEach(data => {
	        // 데이터 배열에 추가
	        gdsList.push({
	            gdsCode: data.gdsCode,
	            gdsNm: data.gdsNm,
	            gdsType: data.gdsType,
	            unitNm: data.unitNm,
	            qty: data.qty,
	            amt: data.amt,
	            ntslType: data.ntslType,
	            bzentNo: bzentNo
	        });

	        // 테이블에 행 추가
	        $("#gds-list").append(`
	            <tr>
	                <td><button type="button" class="delete-btn">삭제</button></td>
	                <td style="text-align:center;">${data.gdsNm}</td>
	                <td style="text-align:center;">${data.gdsTypeNm}</td>
	                <td style="text-align:center;">${data.unitNm}</td>
	                <td style="text-align:center;">${data.qty}</td>
	                <td style="text-align:center;">${data.ntslTypeNm}</td>
	                <td style="text-align:center;">${data.amt}</td>
	            </tr>
	        `);
	    });

	    // 추가한 상품 수를 업데이트
	    let total = $("#gds-list tr").length;
	    $("#clclnAmt").text(total);
	});

/*******************************************
   필수 입력값들이 모두 입력되었는지 확인하는 함수
********************************************/	
function validateInputs() {
    let qty = $('#qty').val();
    let stockAjmtType = $('#stockAjmtType').val();

    // 필수 입력값 체크 (모든 조건이 만족되면 버튼 활성화)
    if(!isNaN(qty)) {
        $("#saveBtn").prop("disabled", false)  // 버튼 활성화
                    .removeClass("btn-default")  // 기본 클래스 제거
                    .addClass("btn-active");     // 활성 클래스 추가
    } else {
        $("#saveBtn").prop("disabled", true)   // 버튼 비활성화
                    .removeClass("btn-active")  // 활성 클래스 제거
                    .addClass("btn-default");   // 기본 클래스 추가
    }
}
