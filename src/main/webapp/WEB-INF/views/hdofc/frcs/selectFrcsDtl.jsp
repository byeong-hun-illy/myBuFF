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
<script src="/resources/hdofc/js/frcs.js"></script>
<script src="/resources/hdofc/js/frcsCheck.js"></script>
<script>
let currentPage = 1;
let frcsNo = '';
let chckSeq = '';
let sort = '';
let orderby = '';
let urlParams = new URLSearchParams(window.location.search);
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
//다음 api
function openHomeSearch(){
	new daum.Postcode({
	    oncomplete: function(data) {
	    	$('#bzentZip').val(data.zonecode);
	    	$('#bzentAddr').val(data.address);
	    	$('#bzentDaddr').val(data.buildingName);
	    	$('#bzentDaddr').focus();
	    }
	}).open();
}
$(function(){
	select2Custom();
	if (urlParams.has('frcsNo')) { // 상세
	    frcsNo = urlParams.get('frcsNo');  
		$('.frcs-insert').hide();
		selectFrcsDtlAjax();
	} else{
		$('.frcs-dtl').hide();
	}
	/////////////////////// 관리자 변경 /////////////////////////////
	
	var modal = new bootstrap.Modal(document.getElementById('staticBackdrop'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	// 관리자 모달 실행
	$('.update-mngr').on('click', function(){
		if (urlParams.has('frcsNo')) { // 상세
		Swal.fire({
			  title: "관리자를 변경/삭제하시겠습니까?",
			  showDenyButton: true,
			  showCancelButton: true,
			  confirmButtonText: "확인",
			  denyButtonText: "삭제",
			  cancelButtonText: "취소",
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#7F9CAB",
			  denyButtonColor: "#E73940"
			}).then((result) => {
			  /* Read more about isConfirmed, isDenied below */
				 if (result.isConfirmed) {
					 modal.show();
					 // 정렬 초기값
					 sort = "jncmp";
					 orderby = 'asc';
					 select2Custom();
					 selectMngrAjax();
				 } else if (result.isDenied) {
						$('#mngrId').val('')
						$('#mngrNm').val('');
						$('#mngrTelno1').val('');
						$('#mngrTelno2').val('');
						$('#mngrTelno3').val('');
						$('#mngrEml').val('');
				 } else{
				 	Swal.fire("변경되지 않았습니다", "", "info");
				 }
			});
		} else{
			modal.show();
			 // 정렬 초기값
			 sort = "jncmp";
			 orderby = 'asc';
			 selectMngrAjax();
		}
	})
	
	// 모달 닫기
	$('.modal-close').on('click',function(){
		$('.warning').text('');
		modal.hide();
		
		mbrModal.hide();
	})
	
	///// 관리자 검색 시작/////
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-mngr').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort-mngr').removeClass('active');
	      $(this).addClass('active');
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-mngr .sort-arrow .sort-asc, .sort-mngr .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectMngrAjax();
	})
	
	// 관리자 검색어 검색 결과
	$('#submit-mngr').on('click',function(){
		currentPage=1;
		selectMngrAjax();
	})
	
	///// 관리자 검색 끝 /////
	
	// 관리자 페이징 처리
	$(document).on('click','.page-mngr',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		selectMngrAjax();
	})
	
	// 관리자 테이블 클릭 시
	$(document).on('click', '.mngrDtl', function(){
		let mngrId = $(this).data('id');
		let mbrNm = $(this).data('nm');
		let mbrTel = $(this).data('tel');
		let mbrTelArr = splitTel(mbrTel);
		let mbrEml = $(this).data('eml');
		$('.warning').text('');
		
		$('#mngrId').val(mngrId)
		$('#mngrNm').val(mbrNm);
		$('#mngrTelno1').val(mbrTelArr[0]);
		$('#mngrTelno2').val(mbrTelArr[1]);
		$('#mngrTelno3').val(mbrTelArr[2]);
		$('#mngrEml').val(mbrEml);
		
		modal.hide();
	})
	
	$('#deleteMngr').on('click',function(){
		$('#mngrId').val('')
		$('#mngrNm').val('');
		$('#mngrTelno1').val('');
		$('#mngrTelno2').val('');
		$('#mngrTelno3').val('');
		$('#mngrEml').val('');
	})
	
	/////////////////////// 가맹점주 변경 /////////////////////////////
	
	// 가맹점 주 모달창
	var mbrModal = new bootstrap.Modal(document.getElementById('mbrModal'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	// 가맹점주 모달 실행
	$('.update-mbr').on('click', function(){
		if (urlParams.has('frcsNo')) { // 상세
		Swal.fire({
			  title: "가맹점주를 변경하시겠습니까?",
			  showDenyButton: true,
			  showCancelButton: false,
			  confirmButtonText: "확인",
			  denyButtonText: "취소",
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#7F9CAB"
			}).then((result) => {
			  /* Read more about isConfirmed, isDenied below */
				 if (result.isConfirmed) {
					 mbrModal.show();
					 $('#selectMbr').show();
					 $('#dsDtl').hide();
					 
					 // 기본 정렬 조건
					 sort = 'dscsn';
					 orderby = 'asc';
					 
					 preFrcsList();
				 } else if (result.isDenied) {
				 	Swal.fire("변경되지 않았습니다", "", "info");
				 }
			});
		} else{
			mbrModal.show();
			 $('#selectMbr').show();
			 $('#dsDtl').hide();
			 
			 // 기본 정렬 조건
			 sort = 'dscsn';
			 orderby = 'asc';
			 
			 preFrcsList();
		}
	})
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-mbr').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort-mbr').removeClass('active');
	      $(this).addClass('active');
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (!sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	orderby = 'asc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-mbr .sort-arrow .sort-asc, .sort-mbr .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      }
	      currentPage=1;
	      preFrcsList();
	})
	
	///// 가맹점주 검색 시작 /////
	$('#submit-mbr').on('click',function(){
		currentPage=1;
		preFrcsList();
	})
	///// 가맹점주 검색 끝 /////
	
	// 가맹점주 페이징 처리
	$(document).on('click','.page-mbr',function(){
		currentPage = $(this).data('page');
		preFrcsList();
	})
	
	// 가맹점 주 클릭
	$(document).on('click', '.mbrDtl', function(){
		let mngrId = $(this).data('id');
		let mbrNm = $(this).data('nm');
		let mbrPlan = $(this).data('plan');
		let mbrCn = $(this).data('cn');
		let mbrEml = $(this).data('eml');
		let mbrTel = $(this).data('tel');
		let dscsnCode = $(this).data('code');
		let mbrTelArr = splitTel(mbrTel);
		
		$('#mmbrId').val(mngrId);
		$('#mmbrNm').val(mbrNm);
		$('#mmbrTelno1').val(mbrTelArr[0]);
		$('#mmbrTelno2').val(mbrTelArr[1]);
		$('#mmbrTelno3').val(mbrTelArr[2]);
		$('#mmbrEml').val(mbrEml);
		$('#mmPlan').val(mbrPlan);
		$('#mmCn').html(mbrCn);
		$('#dscsnCode').val(dscsnCode);
		
		$('#selectMbr').hide();
		$('#dsDtl').show();
	})
	
	$('#back').on('click',function(){
		$('#selectMbr').show();
		$('#dsDtl').hide();
	})
	
	// 가맹점주 수정
	$(document).on('click','#mbrUpdate', function(){
		let mbrId = $('#mmbrId').val();
		let mbrNm = $('#mmbrNm').val();
		let mbrTel1 = $('#mmbrTelno1').val();
		let mbrTel2 = $('#mmbrTelno2').val();
		let mbrTel3 = $('#mmbrTelno3').val();
		let mbrEml = $('#mmbrEml').val();
		
		$('#mbrId').val(mbrId);
		$('#mbrNm').val(mbrNm);
		$('#mbrTelno1').val(mbrTel1);
		$('#mbrTelno2').val(mbrTel2);
		$('#mbrTelno3').val(mbrTel3);
		$('#mbrEml').val(mbrEml);
		
		mbrModal.hide();
	})
	
	////////// 수정 ////////////////
	$('#frcsUpdate').on('click', function(){
		updateFrcs();
		Swal.fire({
			  icon: "success",
			  title: "변경이 완료되었습니다",
			  showConfirmButton: false,
			  timer: 2000
		});
	})
	/////////////////////// 추가 /////////////////////////////
	$('#insertFrcs').on('click',function(){
		let opbizYmd = $('#opbiz').val();
		let mbrId = $('#mbrId').val();
		let bzentNm = $('#bzentNm').val();
		let bzentZip= $('#bzentZip').val();
		let bzentAddr= $('#bzentAddr').val();
		if(!opbizYmd || !mbrId || !bzentNm || !bzentZip || !bzentAddr){
			Swal.fire({
				  title: "입력 오류",
				  text: "필수 항목을 입력해주세요",
				  icon: "error"
			});
			return;
		}
		
		Swal.fire({
			  title: "확인",
			  html: "생성한 가맹점은 삭제가 불가능합니다<br>정말로 등록하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "등록",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  insertFrcs();
					Swal.fire({
					  icon: "success",
					  title: "가맹점 등록이 완료되었습니다",
					  showConfirmButton: false,
					  timer: 1000
					});
			  }
			});
	})
	
	$('#resetBtn').on('click', function(){
		$('input').val('');
	})
	
	
	/// 점검 상세
	
	var checkModal = new bootstrap.Modal(document.getElementById('frcsInfoModal'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	
	// 클릭 상세 모달 나오기
	$(document).on('click', '.frcsChkDtl', function(){
		chckSeq = $(this).data("seq");
		frcsCheckDtlAjax();
		checkModal.show();
		$('.modal-frcs').hide();
		$('.modal-clsbiz').hide();
	})
	
	$(document).on('click', '#deleteFrcsCheck',function(){
		Swal.fire({
			  title: "정말 삭제하시겠습니까?",
			  showCancelButton: true,
			  confirmButtonText: "확인",
			  cancelButtonText: "취소",
			  confirmButtonColor: "#E73940",
			  cancelButtonColor: "#7F9CAB",
			}).then((result) => {
				 if (result.isConfirmed) {
					 deletefrcsCheck();
				 } else{
				 	Swal.fire("변경되지 않았습니다", "", "info");
				 }
			});
	})
	
	$('#autoInput').on('click', function(){
		$('#bzentNm').val('대덕');
		$('#opbiz').val('2024-10-22');
		$('#bzentTelno1').val('042');
		$('#bzentTelno2').val('248');
		$('#bzentTelno3').val('3243');
		$('#bzentZip').val('34908')
		$('#bzentAddr').val('대전광역시 중구 계룡로 846');
		$('#bzentDaddr').val('1층');
	})
})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/frcs/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 frcs-dtl">가맹점 상세</h1>
	        <h1 class="m-0 frcs-insert" id="autoInput">가맹점 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default frcs-insert" id="resetBtn">초기화</button>
			<button type="button" class="btn-active frcs-insert" id="insertFrcs">등록 <span class="icon material-symbols-outlined">East</span></button>
			<button type="button" class="btn-default frcs-dtl" onclick="selectFrcsDtlAjax()">초기화</button>
			<button type="button" class="btn-active frcs-dtl" id="frcsUpdate">저장 <span class="icon material-symbols-outlined">East</span></button>
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
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>가맹점 정보</div> 
					<div class="frcs-insert" style="margin-left: var(--gap--l)"><span class="es">*</span> 표기된 항목은 필수입력 항목입니다.</div>
			</div>
			<table class="table-blue">
				<tr>
					<th style="width: 15%;">가맹점명  <span class="es frcs-insert">*</span></th>
					<td style="width: 35%;"><input id="bzentNm" type="text" class="text-input"></td>
					<th style="width: 15%;">개업 일자  <span class="es frcs-insert">*</span></th>
					<td>
						<!-- 날짜 문자열을 가공하여 원하는 형식으로 변환 -->
<%-- 						<c:set var="opbiz" value="${fn:substring(frcs.opbizYmd, 0, 4)}-${fn:substring(frcs.opbizYmd, 4, 6)}-${fn:substring(frcs.opbizYmd, 6, 8)}" /> --%>
						<input type="date" id="opbiz">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td colspan="3">
						<div class="tel-wrap">
							<input id="bzentTelno1" type="text" class="input-tel">-
							<input id="bzentTelno2" type="text" class="input-tel">-
							<input id="bzentTelno3" type="text" class="input-tel">
						</div>
					</td>
				</tr>
				<tr>
					<th>주소  <span class="es frcs-insert">*</span></th>
					<td colspan="3">
						<div class="addr-zip-wrap">
							<div class="addr-wrap">
								<input id="bzentZip" class="input-zip" readonly="readonly" type="text"/>
								<button class="btn-default" type="button" onclick="openHomeSearch()">우편번호 검색</button>
							</div>
							<div class="addr-wrap">
								<input id="bzentAddr" class="input-addr" readonly="readonly" type="text"/>
								<input id="bzentDaddr" placeholder="상세주소" class="input-addr" type="text"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont frcs-dtl">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">add_business</span>가맹점 상세 정보 </div> 
			</div>
			<table class="table-blue">
				<tr>
					<th style="width: 15%;">상태</th>
					<td style="width: 35%;" id="frcsType"></td>
					<th style="width: 15%;">등록일자</th>
					<td id="regYmd"></td>
				</tr>
				<tr>
					<th>경고횟수</th>
					<td id="warnCnt"></td>
					<th>영업 시간</th>
					<td id="time"> </td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
		<!-- cont시작 !!!!!!!가맹점주-->
		<div class="cont">
			<!-- table-wrap 가맹점주 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>가맹점주 정보  <span class="es frcs-insert">*</span></div> 
				</div>
				<table class="table-blue">
					<tr>
						<th style="width: 15%;">이름</th>
						<td>
							<div class="input-wrapper">
								<input id="mbrNm" disabled>
								<button type="button" class="update-btn update-mbr"></button>
							</div>
						</td>
						<th style="width: 15%;">아이디</th>
						<td>
							<input id="mbrId" disabled class="text-input">
						</td>
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
							<input id="mbrEml" class="text-input" disabled>
						</td>
					</tr>
				</table>
			</div>
			<!-- /.table-wrap 가맹점주 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
			
			<div class="cont">
			<!-- table-wrap 관리자 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자 정보</div> 
				</div>
				<table class="table-blue">
					<tr>
						<th style="width: 15%;">이름</th>
						<td>
							<div class="input-wrapper">
							<input id="mngrNm" disabled>
								<button type="button" class="update-btn update-mngr"></button>
							</div>
						</td>
						<th style="width: 15%;">아이디</th>
						<td>
								<input id="mngrId" disabled class="text-input">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input id="mngrTelno1" type="text" class="input-tel" disabled>-
							<input id="mngrTelno2" type="text" class="input-tel" disabled>-
							<input id="mngrTelno3" type="text" class="input-tel" disabled>
						</td>
						<th>이메일</th>
						<td>
							<input id="mngrEml" class="text-input" disabled>
						</td>
					</tr>
				</table>
			</div>
			<!-- /.table-wrap 관리자 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
		
		<!-- cont: 해당 영역의 설명 -->
	<div class="cont frcs-dtl">
		<!-- table-wrap 점검 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>점검 정보</div> 
			</div>
			<div class="bar"></div>
			<div class="row check">
			<div class="circle">
				<span class="totalScore">A</span><span class="circle-title">등급</span>
		    </div>
			    <div class="check-table">
					<table class="table-default table-check">
						<thead>
							<tr>
								<th class="center" style="width: 15%">번호</th>
								<th class="center" style="width: 20%">점검자</th>
								<th class="center" style="width: 20%">점검일자</th>
								<th class="center" style="width: 15%">총점수</th>
								<th class="center" style="width: 15%">위생</th>
								<th class="center" style="width: 15%">서비스</th>
							</tr>
						</thead>
						<tbody id="table-body-check" class="table-error">
						</tbody>
					</table>
			    </div>
			</div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
		<!-- cont: 해당 영역의 설명 -->
	<div class="cont frcs-dtl">
		<!-- table-wrap 폐업 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>폐업 정보</div> 
			</div>
			<table class="table-blue frcs-clsbiz">
				<tbody class="clsbiz-table">
				<tr>
					<th>폐업유형</th>
					<td id="modal-clsbiz"></td>
					<th>승인일자</th>
					<td id="modal-aprvYmd"></td>
				</tr>
				<tr>
					<th>폐업일자</th>
					<td id="modal-clsbizYmd"></td>
					<th>사유유형</th>
					<td id="modal-clsType"></td>
				</tr>
				<tr>
					<th>사유</th>
					<td colspan="3" id="modal-clsbizRsn">
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
</div>
<!-- wrap 끝 -->

<!-- --------------------------------------- 모달 시작 ---------------------------------------------------- -->
<!-- 관리자 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/mngrModal.jsp" />


<!-- --------------------------------------- 모달 2 시작 ---------------------------------------------------- -->

<!-- 가맹점 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/frcsMbrModal.jsp" />

<jsp:include page="/WEB-INF/views/hdofc/modal/frcsInfoModal.jsp" />
