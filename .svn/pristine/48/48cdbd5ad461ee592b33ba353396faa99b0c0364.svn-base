<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.buff.util.Telno" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src="/resources/hdofc/js/gds.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let bzentNo = 'HO0001';
let gdsCode = '';
let mbrId = '<c:out value="${user.mbrId}"/>';
let ntslType = '';
let urlParams = new URLSearchParams(window.location.search);
let currentPage = 1; // ajmt
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	select2Custom();
	if (urlParams.has('gdsCode')) { // 상세
		gdsCode = urlParams.get('gdsCode');  
		$('.gds-insert').hide();
		selectGdsDtlAjax();
		selectStockAjmtAjax(gdsCode);
	} else{ // 추가
		$('.gds-dtl').hide();
		$('#mbrId').val(mbrId);
		$('#mbrNm').val('<c:out value="${user.mbrNm}"/>');
		$('#mbrEmlAddr').val('<c:out value="${user.mbrEmlAddr}"/>');
		let telno = '<c:out value="${user.mbrTelno}"/>'
		let telnoArr = splitTel(telno);
		$('#mbrTelno1').val(telnoArr[0]);
		$('#mbrTelno2').val(telnoArr[1]);
		$('#mbrTelno3').val(telnoArr[2]);
	}
	// 더보기
	$(document).on('click', '.moreView', function(){
		currentPage++;
		selectStockAjmtAjax(gdsCode);
	})
	
	////////// 수정 ////////////////
	$('#gdsUpdate').on('click', function(){
		let amt = $('#amt').val();
		let sfStockQty = $('#sfStockQty').val();
		console.log(amt);
		if(amt==0 && amt!=''){
			Swal.fire({
				  icon: "error",
				  title: "입력오류",
				  text: "단가를 0보다 큰 값을 입력해주세요",
				  showConfirmButton: true,
				  confirmButtonText: "확인"
				});
			return;
		}
		
		if(ntslType=='GDNT01'){
			let htmlString = `<p>해당 상품을 수정하시겠습니까?</p>`;
			if (amt !== '' || sfStockQty != '') {
			  htmlString += `<p style='color:red;'>단가나 안전 재고수량을 입력하시는 경우,</p><p style='color:red;'>더이상 상품 정보를 수정/삭제할 수 없습니다</p>`;
			}
			if(amt || sfStockQty){ // 단가와 안전재고 삽입하는 경우
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
						  updateGds();
						  updateAmt();
							Swal.fire({
							  icon: "success",
							  title: "상품 수정이 완료되었습니다",
							  showConfirmButton: false,
							  timer: 1000
							});
					  }
				});// swal끝
			} else{  // amt와 sfStockQty가 없을 떄
				updateGds();
				Swal.fire({
				  icon: "success",
				  title: "상품 수정이 완료되었습니다",
				  showConfirmButton: false,
				  timer: 1000
				});
			}
		} else {// GDNT01가 아닐때
			updateAmt();
			Swal.fire({
				  icon: "success",
				  title: "변경이 완료되었습니다",
				  showConfirmButton: false,
				  timer: 2000
			});
		}
	})
	/////////////////////// 추가 /////////////////////////////
	$('#insertGds').on('click',function(){
		let gdsNm = $('#gdsNm').val();
		let gdsType= $('#gdsType').val();
		let unitNm= $('#unitNm').val();
		let mbrId= $('#mbrId').val();
		if(!gdsNm || !gdsType || !unitNm || !mbrId){
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
		  htmlString += `<p style='color:red;'>단가를 입력할 경우, 상품 정보를 수정/삭제할 수 없습니다</p>`;
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
					Swal.fire({
					  icon: "success",
					  title: "상품 등록이 완료되었습니다",
					  showConfirmButton: false,
					  timer: 1000
					});
			  }
			});
	})
	
	$('#resetBtn').on('click', function(){
		$('.input-reset').val('');
		$('.select-selected').text('미선택');
	})
	/////////////////////////////////////////////////// 삭제
	$('#gdsDelete').on('click', function(){
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
	})
	
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
})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/gds/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 gds-dtl">상품 상세</h1>
	        <h1 class="m-0 gds-insert">상품 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default gds-insert" id="resetBtn">초기화</button>
			<button type="button" class="btn-active gds-insert" id="insertGds">등록 <span class="icon material-symbols-outlined">East</span></button>
			<button type="button" class="btn-default gds-dtl" onclick="selectGdsDtlAjax()">초기화</button>
			<button type="button" class="btn-danger gds-dtl gds-update" id="gdsDelete">삭제</button>
			<button type="button" class="btn-active gds-dtl gds-update" id="gdsUpdate">저장 <span class="icon material-symbols-outlined">East</span></button>
			<button type="button" class="btn-active gds-dtl amt-update" onclick="updateAmt()">저장 <span class="icon material-symbols-outlined">East</span></button>
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
		<div class="table-wrap" style="overflow-x: inherit;">
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
						<div class="select-custom w-200">
							<select name="gdsType" id="gdsType" class="input-reset input-gds">
								<option value="" disabled selected>미선택</option>
								<option value="FD01" class="fd">축산 </option>
								<option value="FD02" class="fd">농산물 </option>
								<option value="FD03" class="fd">유제품</option>
								<option value="FD04" class="fd">베이커리</option>
								<option value="FD05" class="fd">조미료/소스</option>
								<option value="FD06" class="fd">냉동식품</option>
								<option value="FD07" class="fd">기타</option>
								<option value="SM01" class="sm">매장 소모품</option>
								<option value="SM02" class="sm">조리 용품</option>
								<option value="SM03" class="sm">위생 용품</option>
								<option value="PM01" class="pm">일회 용품</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>단위  <span class="es gds-insert">*</span></th>
					<td>
						<input id="unitNm" type="text" class="text-input input-reset input-gds">
					</td>
					<th>단가</th>
					<td>
						<input id="amt" type="number" class="input-reset"> 원
					</td>
				</tr>
				<tr class="gds-dtl">
					<th>등록일자</th>
					<td id="regYmd"></td>
					<th>판매유형</th>
					<td id="ntslTypeTd">
						<div class="select-custom w-100">
						<select name="ntslType" id="ntslType">
							<option value="GDNT02">미판매</option>
							<option value="GDNT03">판매중</option>
						</select>
						</div>
					</td>
				</tr>
				<tr class="gds-dtl">
					<th>수량</th>
					<td id="qty"></td>
					<th>안전재고수량</th>
					<td><input type="number" id="sfStockQty"/></td>
				</tr>
			</table>
			<div></div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
	<!-- cont시작 !!!!!!!등록자-->
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
	<div class="cont gds-dtl">
		<!-- table-wrap 단가 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>본사 단가 정보</div> 
					<div class="btn-wrap">
						<button type="button" class="btn btn-danger" id="lastAmt">최근 단가 삭제</button>
					</div>
			</div>
			<div class="bar"></div>
			<div class="row table-error" id="amtInfo" style="width: 100%;">
			<div class="chart-wrap">
			  <canvas id="myChart" width="500" height="300"></canvas>
			</div>
			    <div class="check-table">
					<table class="table-blue table-amt table-check">
						<thead>
							<tr>
								<th class="center" style="width: 20%">순번</th>
								<th class="center" style="width: 50%">변경일</th>
								<th class="center" style="width: 30%">단가</th>
							</tr>
						</thead>
						<tbody id="table-body-amt" class="table-error">
						</tbody>
					</table>
			    </div>
			</div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
		<!-- cont: 해당 단가  설명 -->
	<div class="cont gds-dtl">
		<!-- table-wrap 단가 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>최저가 단가 정보</div> 
			</div>
			<div class="bar"></div>
			<div class="row table-error" id="minInfo" style="width: 100%;">
			<div class="chart-wrap">
			  <canvas id="myChart2" width="500" height="300"></canvas>
			</div>
			    <div class="check-table">
					<table class="table-blue table-amt table-check">
						<thead>
							<tr>
								<th class="center" style="width: 20%">순번</th>
								<th class="center" style="width: 50%">변경일</th>
								<th class="center" style="width: 30%">단가</th>
							</tr>
						</thead>
						<tbody id="table-body-min" class="table-error">
						</tbody>
					</table>
			    </div>
			</div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
		<!-- cont: 해당 단가  설명 -->
	<div class="cont gds-dtl">
		<!-- table-wrap 단가 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>조정 내역</div> 
					<div class="btn-wrap">
						<button class="btn-default" onclick="location.href='/hdofc/stockAjmt/regist?gdsCode=${param.gdsCode}'">조정 등록  <span class="icon material-symbols-outlined">East</span></button>
					</div>
			</div>
			<div class="bar"></div>
				<table class="table-blue">
					<thead>
						<tr>
						<th class="center" style="width: 5%;">번호</th>
						<th class="center" style="width: 10%;">조정일자
						</th>
						<th class="center" style="width: 10%;">조정유형
						</th>
						<th class="center" style="width: 10%;">수량
						</th>
						<th class="center" style="width: 10%;">단위
						</th>
						<th class="center" style="width: 10%;">조정사유
						</th>
						<th class="center" style="width: 10%;">삭제</th>
					</thead>
					<tbody id="table-body-ajmt" class="table-error">
					</tbody>
					<tfoot class="ajmtAdd">
					</tfoot>
				</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
</div>
<!-- wrap 끝 -->

<!-- --------------------------------------- 모달 시작 ---------------------------------------------------- -->


