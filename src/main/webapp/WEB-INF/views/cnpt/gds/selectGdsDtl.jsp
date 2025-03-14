<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link href="/resources/cnpt/css/gds.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src="/resources/cnpt/js/gds.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
// 전역 차트 객체 선언
 let myChart;	
 let bzentNo = "${user.bzentNo}";
 let ntslType = '';
 let mbrId = '<c:out value="${user.mbrId}"/>';
 let urlParams = new URLSearchParams(window.location.search);
 var gdsCode = urlParams.get('gdsCode'); 
 const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
 const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
 
 console.log("user", "${user}");
 console.log("gdsCode", gdsCode);
$(function(){
	if (urlParams.has('gdsCode')) { // 상세
		gdsCode = urlParams.get('gdsCode');  
		$('.gds-insert').hide();
		$('#mbrId').val(mbrId);
		$('#mbrNm').val('<c:out value="${user.mbrNm}"/>');
		$('#mbrEmlAddr').val('<c:out value="${user.mbrEmlAddr}"/>');
		$('#mbrType').val('<c:out value="${user.mbrType}"/>');
		let telno = '<c:out value="${user.mbrTelno}"/>'
		let telnoArr = splitTel(telno);
		$('#mbrTelno1').val(telnoArr[0]);
		$('#mbrTelno2').val(telnoArr[1]);
		$('#mbrTelno3').val(telnoArr[2]);
		selectGdsDtlAjax();
	} else{ // 추가
		$('.gds-dtl').hide();
		$(".amt-dtl").hide();
		$('#mbrId').val(mbrId);
		$('#mbrNm').val('<c:out value="${user.mbrNm}"/>');
		$('#mbrEmlAddr').val('<c:out value="${user.mbrEmlAddr}"/>');
		let telno = '<c:out value="${user.mbrTelno}"/>'
		let telnoArr = splitTel(telno);
		$('#mbrTelno1').val(telnoArr[0]);
		$('#mbrTelno2').val(telnoArr[1]);
		$('#mbrTelno3').val(telnoArr[2]);
	}
	
	if($("#ntslType").val() == 'GDNT02'){
		$("#gds-delete").show();
	}
	console.log("gdsCode :", gdsCode);
	
	// 저장버튼 클릭 시 이벤트
	$('#gdsUpdate').on('click', function(){
		let amt = parseFloat($('#amt').val());
		console.log("단가 : ", amt);
		
		if(amt===0 && isNaN(amt)){
			Swal.fire({
				  icon: "error",
				  title: "입력오류",
				  text: "단가를 0보다 큰 값을 입력해주세요",
				  showConfirmButton: true,
				  confirmButtonText: "확인"
				});
			return;
			}
		
			let htmlString = `<p>해당 상품을 수정하시겠습니까?</p>`;
			if (!isNaN(amt)) {
			  htmlString += `<p style='color:red;'>단가나 안전 재고수량을 입력하시는 경우,</p><p style='color:red;'>더이상 상품 정보를 수정/삭제할 수 없습니다</p>`;
			}
			
				Swal.fire({
					  title: "확인",
					  html: htmlString,
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#00C157",
					  cancelButtonColor: "#E73940",
					  confirmButtonText: "수정",
					  cancelButtonText: "취소"
					}).then((result) => {
					  if (result.isConfirmed) {
						  updateAmtAjax();
							Swal.fire({
							  icon: "success",
							  title: "상품 수정이 완료되었습니다",
							  showConfirmButton: false,
							  timer: 1000
							});
					  }
				});// swal끝
	// 수정버튼 클릭시 이벤트 끝.	
	})
	
	// 초기화 버튼 클릭 시 이벤트 
	$('#resetBtn').on('click', function(){
		$('.input-reset').val('');
	})
	
	// 추가 버튼 클릭 시 이벤트 핸들러
	$('#insertGds').on('click',function(){
		let gdsNm = $('#gdsNm').val();
		let gdsType= $('#gdsType').val();
		let unitNm= $('#unitNm').val();
		let gdsQty = $("#gdsQty").val();
		
		if(!gdsNm || !gdsType || !unitNm ){
			Swal.fire({
				  title: "입력 오류",
				  text: "필수 항목을 입력해주세요",
				  icon: "error"
			});
			return;
		}
		let amt = $('#amt').val();
		let htmlString = `<p>해당 상품을 등록하시겠습니까?</p>`;
		if (amt !== '') {
		  htmlString += `<p style='color:red;'>상품 정보를 수정/삭제할 수 없습니다</p>`;
		}
		Swal.fire({
			  title: "확인",
			  html: htmlString,
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "생성",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  insertGds();
					
			  }
			});
	// 추가 이벤트 끝	
	})
	
	// 삭제버튼 클릭시 이벤트 핸들러
	$('#gdsDelete').on('click', function(){
		let qtyValue = parseInt($("#qty").val(), 10);
		
		console.log("qtyValue : ", qtyValue);
		
		if(qtyValue > 0){
			Swal.fire({
				  title: "수량이 있는 상품은 삭제할 수 없습니다!",
				  text: "삭제 필요시, 재고 조정이 필수입니다.",
				  icon: "error"
			}).then(()=>{
				Swal.fire({
					  title: "재고 조정페이지로 이동하시겠습니까?",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#00C157",
					  cancelButtonColor: "#E73940",
					  confirmButtonText: "이동",
					  cancelButtonText: "취소"
					}).then((result) => {
					  if (result.isConfirmed) {
						  location.href="/cnpt/stock/insertStockQty?gdsCode="+gdsCode;
					  }
					});
				});
				// 수량이 있을 경우, 아래 삭제 프로세스를 건너뛰게 	
				return;
			}
			Swal.fire({
				  title: "확인",
				  html: "해당 상품을 삭제하시겠습니까?",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "삭제",
				  cancelButtonText: "취소"
				}).then((result) => {
				  if (result.isConfirmed) {
					  deleteGdsAjax();
				  }
				});
		// 삭제 끝	
		})
	
	// 최근단가 삭제 버튼 클릭시 이벤트
	$('#lastAmt').on('click', function(){
		Swal.fire({
			  title: "확인",
			  html: "최근 작성된 단가를 삭제하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "삭제",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  deleteLastAmt();
				  Swal.fire({
					  icon: "success",
					  title: "삭제가 완료되었습니다",
					  showConfirmButton: false,
					  timer: 2000
				  });
		 	   }
			});
	})
	
	// 자동입력 버튼 이벤트 핸들러
	$("#autoBtn").on("click", function(){
		
		// bzentType 확인
	    let bzentType = "${bzentType}";
	    console.log("bzentType : ", bzentType);
		
		let autoGdsNm = "마라소스";
		let autoGdsType = "FD05";
		let autoUnitNm = "kg";
		let autoAmt = 3500;
		
        // 값 자동 설정
	    $("#gdsNm").val(autoGdsNm);
		$("#unitNm").val(autoUnitNm);
		$("#amt").val(autoAmt);
        $("#gdsType").val(autoGdsType);
        
        var selectedOptionText = $('#gdsType option:selected').text();
        $('#gdsType').parent().find('.select-selected').text(selectedOptionText);
        
        
        // 필드 확인을 위해 콘솔에 로그 출력
        console.log("자동 입력 완료:", {
            gdsNm: autoGdsNm,
            gdsType: autoGdsType,
            unitNm: autoUnitNm,
            amt : autoAmt
        });
		
		
	// 자동입력 버튼 클릭시 이벤트 핸들러	
	});
	
//--------------------------------------------------------------	
})


</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="crow mb-2 justify-content-between">
      	<div class="crow align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/cnpt/gds/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 gds-dtl">상품 상세</h1>
	        <h1 id="autoBtn" class="m-0 gds-insert">상품 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default gds-insert" id="resetBtn">초기화</button>
			<button type="button" class="btn-active gds-insert" id="insertGds">등록 <span class="icon material-symbols-outlined">East</span></button>
			<button type="button" class="btn-default gds-dtl">초기화</button>
			<button type="button" class="btn-danger gds-dtl gds-delete" id="gdsDelete">삭제</button>
			<button type="button" class="btn-active gds-dtl gds-update" id="gdsCorrect">수정 </button>
			<button type="button" class="btn-active gds-dtl amt-update" id="gdsUpdate">저장 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap" style="overflow-x: inherit !important;">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">package_2</span>상품 정보</div> 
					<div class="gds-insert" style="margin-left: var(--gap--l)"><span class="es">*</span> 표기된 항목은 필수입력 항목입니다.</div>
			</div>
			<table class="table-blue">
				<tr>
					<th>상품명  <span class="es gds-insert">*</span></th>
					<td><input id="gdsNm" type="text" class="text-input input-reset input-gds"></td>
					<th>유형  <span class="es gds-insert">*</span></th>
					<td style="width: 37%" class="gdsType">
						<div class="select-custom" style="width:200px;">
							<select name="gdsType" id="gdsType" class="input-reset input-gds">
								<option value="" disabled selected>미선택</option>
								<c:if test="${bzentType == 'BZ_C01' }">
									<option value="FD01" class="fd">축산 </option>
									<option value="FD02" class="fd">농산물 </option>
									<option value="FD03" class="fd">유제품</option>
									<option value="FD04" class="fd">베이커리</option>
									<option value="FD05" class="fd">조미료/소스</option>
									<option value="FD06" class="fd">냉동식품</option>
									<option value="FD07" class="fd">기타</option>
								</c:if>
								<c:if test="${bzentType == 'BZ_C02' }">
									<option value="SM01" class="sm">매장 소모품</option>
									<option value="SM02" class="sm">조리 용품</option>
									<option value="SM03" class="sm">위생 용품</option>
								</c:if>
								<c:if test="${bzentType == 'BZ_C03' }">
									<option value="PM01" class="pm">일회 용품</option>
								</c:if>
							</select>
						</div>	
					</td>
				</tr>
				<tr>
					<th>단위 <span class="es gds-insert">*</span></th>
					<td>
						<input id="unitNm" type="text" class="text-input input-reset input-gds">
					</td>
					<th>단가 <span class="es gds-insert">*</span></th>
					<td>
						<input id="amt" type="number" class="input-reset"> 원
					</td>
				</tr>
				<tr class="gds-dtl">
					<th>수량</th>
					<td id="qty"><input type="hidden" id="qty"/></td>
					<th>판매유형</th>
					<td id="ntslTypeTd">
						<div class="select-custom ">
							<select name="ntslType" id="ntslType">
								<option value="GDNT02">미판매</option>
								<option value="GDNT03">판매중</option>
							</select>
						</div>
					</td>
				</tr>
			</table>
			<div></div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	<div class="cont">
		<!-- table-wrap 등록자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>등록자 정보  <span class="es gds-insert">*</span></div> 
			</div>
			<table class="table-blue">
				<tr>
					<th>이름</th>
					<td>
						<div class="input-wrapper">
							<input id="mbrNm" disabled>
						</div>
					</td>
					<th class="gds-insert">아이디</th>
					<td class="gds-insert">
						<input id="mbrId" disabled class="text-input">
					</td>
					<th class="gds-dtl">회원 구분</th>
					<td class="gds-dtl" id="mbrType"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input id="mbrTelno1" type="text" class="input-tel" disabled>-
						<input id="mbrTelno2" type="text" class="input-tel" disabled>-
						<input id="mbrTelno3" type="text" class="input-tel" disabled>
					</td>
					<th>이메일</th>
					<td>
						<input id="mbrEmlAddr" class="text-input" disabled>
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap 가맹점주 정보 -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	
	<!-- cont: 해당 단가  설명 -->
	<div class="cont amt-dtl">
		<!-- table-wrap 단가 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>단가 정보</div>
					<div class="btn-wrap">
						<button type="button" class="btn btn-danger" id="lastAmt">최근 단가 삭제</button>
					</div> 
			</div>
			<div class="bar"></div>
			<div class="crow d-flex">
			<div class="chart-wrap" style="flex: 0 0 500px;">
			  <canvas id="amtChart" width="500" height="300"></canvas>
			</div>
			    <div class="check-table" style="flex : 1;">
					<table class="table-default table-amt table-check"
						   style="table-layout: fixed; width: 100%;">
						<thead>
							<tr>
								<th class="center" style="width: 20%">순번</th>
								<th class="center" style="width: 50%">변경일</th>
								<th class="center" style="width: 30%">단가</th>
							</tr>
						</thead>
						<tbody id="table-body-amt">
						</tbody>
					</table>
			    </div>
			</div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
</div>
<!-- wrap 끝 -->


