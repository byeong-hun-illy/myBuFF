<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.buff.util.Telno" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src='/resources/com/js/deal.js'></script>
<link href="/resources/com/css/deal.css" rel="stylesheet">
<sec:authentication property="principal.MemberVO" var="user"/>
<c:set var="type" value="${param.type}"/>
<script>
let urlParams = new URLSearchParams(window.location.search);
let poNo = '';
let type = 'po'; 
let total = 0;
let actno = '';
let bankType = '';
let bankTypeNm = '';
let bzentNo = '<c:out value="${user.bzentNo}"/>';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	if (urlParams.has('poNo')) { // 상세
		poNo=urlParams.get('poNo');  
	} 
	if(type=='po'){
		$('.type-so').hide();
		$('.po-insert').hide();
	} else if(type=='so'){
		$('.type-po').hide();
		$('.po-insert').hide();
	} else{
		$('.type-so').hide();
		$('.type-po').hide();
	}
	selectDealDtlAjax();

	/////////////////////// 추가 /////////////////////////////
	$('#insertCnpt').on('click',function(){
		let bzentNm = $('#bzentNm').val();
		let bzentZip= $('#bzentZip').val();
		let bzentAddr= $('#bzentAddr').val();
		let bzentTelno1= $('#bzentTelno1').val();
		let bzentTelno2= $('#bzentTelno2').val();
		let bzentTelno3= $('#bzentTelno3').val();
		let bzentType=$('#bzentType').val();
		if(!bzentType || !bzentNm || !bzentZip || !bzentAddr || !bzentTelno1 || !bzentTelno2 || !bzentTelno3){
			Swal.fire({
				  title: "입력 오류",
				  text: "필수 항목을 입력해주세요",
				  icon: "error"
			});
			return;
		}
		
		Swal.fire({
			  title: "확인",
			  html: "해당 거래처를 등록하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "생성",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  insertCnpt();
					Swal.fire({
					  icon: "success",
					  title: "거래처 등록이 완료되었습니다",
					  showConfirmButton: false,
					  timer: 1000
					});
			  }
			});
	})

	/////////////////////////////////////////////////// 삭제
	$('#poDelete').on('click', function(){
		Swal.fire({
			  title: "확인",
			  html: "해당 거래처의 구매 신청 내역을 삭제하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "삭제",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  deletePoAjax(false);
			  }
			});
	})
	////////////////////////////////////////////////// 승인 미승인 (SO)
	$('#noAprv').on('click', function(){
		Swal.fire({
			  title: "미승인 사유를 작성해주세요",
			  input: "text",
			  inputAttributes: {
			    autocapitalize: "off"
			  },
			  showCancelButton: true,
			  confirmButtonText: "완료",
			  cancelButtonText: "취소",
			  showLoaderOnConfirm: true,
			  preConfirm: async (inputValue) => {
				  if (!inputValue) {
				      Swal.showValidationMessage('사유를 작성해주세요.');
				      return false; // 입력값이 없을 경우 경고 표시
				    }
				    return inputValue; // 입력값 반환
			  },
			  allowOutsideClick: () => !Swal.isLoading()
			}).then((result) => {
			  if (result.isConfirmed) {
				// 사용자가 입력한 값 가져오기
				    var inputValue = result.value;
			    // 입력값을 처리하는 로직
			    	poNoAprvAjax(inputValue);
			  }
			});
	})
	
	$('#aprv').on('click', function(){
		Swal.fire({
			  title: "확인",
			  html: "해당 발주를 승인하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "승인",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  poAprvAjax();
			  }
			});
	})
	
	///////////////////////////////////// 수정
	
	// 수량 변경
	// 수량 변경시 가격과 총 금액 변경
	$(document).on('change', '.poQty', function(){
		// 현재 입력한 수량을 가져옴
	    let inputQty = $(this).val();
		 
	    let amt = $(this).data('amt');
	    let gdsTotal = inputQty * amt;
	    
	 // 해당 tr의 gdsTotal 셀에 값을 업데이트
	    $(this).closest('tr').find('.gdsTotal').text(gdsTotal.toLocaleString());
	 
	 	// 총 합계(id="total")도 업데이트
	    updateTotal();
	})
	
	// 상품 삭제
	// gdsList에서 삭제 후 총금액변경
	$(document).on('click', '.remove', function(){
		$(this).closest("tr").remove();
	    
	 	// 총 합계(id="total")도 업데이트
	    updateTotal();
	})
	
	$('#poUpdate').on('click', function(){
		var stockPoVOList = [];
	    var poSeq = 1; // PO_SEQ는 1부터 자동 증가
		
	    // 테이블의 tr 요소를 찾음
	    var rows = $('#table-body tr');
	    
	    // tr이 없는 경우 처리
	    if (rows.length === 0) {
	    	// 없을 땐 삭제할건지 확인
	    	Swal.fire({
				  title: "확인",
				  html: "<p style='color:red'>담긴 상품의 정보가 없습니다</p><p>해당 구매 신청 내역을 삭제하시겠습니까?</p>",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "삭제",
				  cancelButtonText: "취소"
				}).then((result) => {
				  if (result.isConfirmed) {
					  deletePoAjax();
				  }
			});
	        return; // 함수 종료
	    }
	    
	    // 테이블의 tr 요소 순회
	    $('#table-body tr').each(function() {
	        var gdsCode = $(this).data('code');
	        var gdsAmt = $(this).data('amt');
	        var qty = $(this).find('.poQty').val();

	        // StockPoVO 객체 생성
	        var stockPoVO = {
	            poSeq: poSeq,       // 자동 증가되는 PO_SEQ
	            poNo: poNo,         // 파라미터로 받은 PO_NO
	            bzentNo: bzentNo,   // 파라미터로 받은 BZENT_NO
	            gdsCode: gdsCode,   // TR에서 데이터 속성으로 가져온 GDS_CODE
	            qty: Number(qty),           // input 필드에서 가져온 수량 QTY
	            gdsAmt: gdsAmt      // TR에서 데이터 속성으로 가져온 GDS_AMT
	        };

	        // 리스트에 추가
	        stockPoVOList.push(stockPoVO);
	        poSeq++; // PO_SEQ 증가
	    });
	    
	    //console.log(stockPoVOList);
	    
	    Swal.fire({
			  title: "확인",
			  html: "변경사항을 저장하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "저장",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  updateStockPoAjax(stockPoVOList);
			  }
		});
	})
	
	//////////////////////////////////////////// 배송 확정
	$('#deliEnd').on('click', function(){
		 Swal.fire({
			  title: "확인",
			  html: "<p>배송을 확정하시겠습니까?</p><p>해당 상품만큼 재고에 입고처리 됩니다.</p>",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "저장",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
					deliEndAjax();
			  }
		});
	})
	
	//////////////// 정산
	
	$("#billDownload").on('click', function(){
		// 파일 다운로드를 위한 URL을 호출
		var downloadUrl = "/com/deal/billAjax?poNo="+poNo+"&"+"&_csrf=" + csrfToken;
		location.href = downloadUrl;
	})
	
	$('#updateClcln').on('click', function(){
		console.log(bankTypeNm, actno)
		if(actno==''){
			Swal.fire({
				  title: "에러",
				  html: "등록된 계좌정보가 없습니다",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "확인",
				  cancelButtonText: "취소"
				})
				return;
		}
		let htmlStr = "<p>등록된 계좌정보인 "+bankTypeNm+"은행의 "+actno+"에서</p><p>정산의 총 합계만큼 정산처리하시겠습니까?</p><p>정산처리가 될 경우 <span class='es'>환불이 불가능</span>합니다.</p>";
		
		Swal.fire({
			  title: "확인",
			  html: htmlStr,
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "정산",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  updateClclnAjax();
			  }
		});
	})
})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/frcs/deal/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 type-po">구매 상세</h1>
	        <h1 class="m-0 type-so">판매 상세</h1>
	        <h1 class="m-0 po-insert">구매 신청</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default po-aprv" style="display: none;" onclick="selectDealDtlAjax();">초기화</button>
			<button type="button" class="btn-danger po-aprv" id="poDelete" style="display: none;">삭제</button>
			<button type="button" class="btn-active po-aprv" id="poUpdate" style="display: none;">수정</button>
			
			<button type="button" style="display:none;" class="btn-danger cnpt-aprv" id="noAprv">미승인</button>
			<button type="button" style="display:none;" class="btn-active cnpt-aprv" id="aprv">승인</button>
			
			<button type="button" style="display:none;" disabled class="btn-active deli-end" id="deliEnd">배송 확정</button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont po-dtl">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>발주 정보</div> 
			</div>
			<table class="table-blue">
				<tr>
					<th style="width:15%;">발주번호</th>
					<td id="poNo"></td>
					<th style="width:15%;">유형</th>
					<td id="deliType">
					</td>
				</tr>
				<tr>
					<th class="po-dtl">등록일자</th>
					<td class="po-dtl" id="regYmd"></td>
					<th>배송일자</th>
					<td id="deliYmd">
					</td>
				</tr>
				<tr class="deli04" style="display: none;">
					<th>반려사유</th>
					<td id="rjctRsn"></td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
		<!-- cont시작 !!!!!!!담당자-->
		<div class="cont">
			<!-- table-wrap 가맹점주 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">domain</span>본사 정보</div> <!-- 타입에따라 제목 변경 -->
				</div>
				<table class="table-blue">
					<tr>
						<th style="width:15%;">본사명</th>
						<td id="bzentNm" style="width:38%;"></td>
						<th style="width:15%;">전화번호</th>
						<td id="bzentTelno"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td id="bzentAddr" colspan="3"></td>
					</tr>
				</table>
			</div>
			<!-- /.table-wrap 가맹점주 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
			
			<!-- /.cont: 해당 영역의 설명 -->
			<div class="cont po-dtl">
			<!-- table-wrap 관리자 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">package_2</span>발주 상세정보</div> 
				</div>
				<table class="table-blue gds-table">
				<thead>
					<tr>
						<th style="text-align:center; width: 10%;">순번</th>
						<th style="text-align:center; width: 20%;">상품명</th>
						<th style="text-align:center; width: 15%;">유형</th>
						<th style="text-align:center; width: 15%;">수량</th>
						<th style="text-align:center; width: 10%;">단위</th>
						<th style="text-align:center; width: 10%;">단가(원)</th>
						<th style="text-align:center; width: 20%;">가격(원)</th>
					</tr>
				</thead>
				<tbody id="table-body" class="tale-error">
				</tbody>
				<tfoot>
					<tr>
						<th colspan="3" style="text-align:center; width: 20%;">총 금액(원)</th>
						<td colspan="4" id="clclnAmt"></td>
					</tr>
				</tfoot>
			</table>
			</div>
			<!-- /.table-wrap 관리자 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
			
						<!-- cont: 해당 영역의 설명 -->
			<div class="cont clcln-dtl">
			<!-- table-wrap 정산 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>정산 내역</div> 
						
						<div class="btn-wrap">
							<button class="btn-default" id="billDownload">영수증 <span class="icon material-symbols-outlined">download</span></button>
							<button class="btn-active" id="updateClcln">정산 <span class="icon material-symbols-outlined">East</span></button>
						</div>
				</div>
				<table class="table-blue">
				<thead>
					<tr>
						<th style="width: 15%;">등록일자</th>
						<td id="clregYmd"></td>
						<th style="width: 15%;">체납여부</th>
						<td id="npmntYn"></td>
					</tr>
					<tr>
						<th>정산일자</th>
						<td id="clclnYmd"></td>
						<th>정산여부</th>
						<td id="clclnYn"></td>
					</tr>
					<tr class="clclnY">
						<th>결제은행</th>
						<td id="bankTypeNm"></td>
						<th>결제계좌</th>
						<td id="actno"></td>
					</tr>
					<tr>
						<th>발주 금액</th>
						<td id="clclclnAmt"></td>
						<th>체납 금액</th>
						<td id="npmntAmt"></td>
					</tr>
					<tr>
						<th>총 정산 금액</th>
						<td id="totalAmt" colspan="3"></td>
					</tr>
				</thead>
			</table>
			</div>
			<!-- /.table-wrap 관리자 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
</div>
<!-- wrap 끝 -->

<!-- --------------------------------------- 모달 시작 ---------------------------------------------------- -->
<!-- 관리자 추가 모달 창 -->


