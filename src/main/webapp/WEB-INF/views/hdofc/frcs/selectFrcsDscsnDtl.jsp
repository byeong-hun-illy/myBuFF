<%--
 	@fileName    : selectFrcsDscsn.jsp
 	@programName : 가맹점 상담조회
 	@description : 가맹점 상담 조회나 싱세를 위한 페이지
 	@author      : 송예진
 	@date        : 2024. 09. 23
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/frcs.js"></script>
<script src="/resources/hdofc/js/frcsDscsn.js"></script>
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script type="text/javascript">
let currentPage = 1;
let dscsnType = '';
let sort = 'dscsnYmd';
let orderby = 'desc';
let urlParams = new URLSearchParams(window.location.search);
let dscsnCode =urlParams.get('dscsnCode');  
let mbrId = '<c:out value="${user.mbrId}" />';
let mbrNm = '<c:out value="${user.mbrNm}" />';
let mbrTelno = '<c:out value="${user.mbrTelno}" />';
let date = false; // 상담일자 이후인지
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	selectFrcsDscsnDtlAjax();
	select2Custom();
	var modal = new bootstrap.Modal(document.getElementById('staticBackdrop'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	//////////////////////////// 관리자 ////////////////////////////////////////
	// 관리자 모달 실행
	$('.update-mngr').on('click', function(){
		modal.show();
		 // 정렬 초기값
		 sort = "jncmp";
		 orderby = 'asc';
		 selectMngrAjax();
	})
	
	///// 관리자 검색 시작/////
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-mngr').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      
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
		
		$('#dscsn-mngrId').val(mngrId)
		$('#dscsn-mngrNm').val(mbrNm);
		$('#dscsn-mngrTelno1').val(mbrTelArr[0]);
		$('#dscsn-mngrTelno2').val(mbrTelArr[1]);
		$('#dscsn-mngrTelno3').val(mbrTelArr[2]);
		
		modal.hide();
		$('#customBackdrop').css('display', 'none');
	})
	
	$('#deleteMngr').on('click',function(){
		$('#dscsn-mngrId').val('')
		$('#dscsn-mngrNm').val('');
		$('#dscsn-mngrTelno1').val('');
		$('#dscsn-mngrTelno2').val('');
		$('#dscsn-mngrTelno3').val('');
	})
	
	////////////////////////////////////////////////////// 승인
	$('#okAprv').on('click', function(){
		updateFrcsDscsnAjax('DSC03');
	})
	
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
// 			    console.log("입력한 값: " + inputValue);
			    $('#dscsn-dscsnCn').val(inputValue);
			    updateFrcsDscsnAjax('DSC02');
			  }
			});
	})
	
	$('#updateDscsn').on('click',function(){
		if(dscsnType=='DSC02'){
		    updateFrcsDscsnAjax('DSC02');
		} else if(!date && dscsnType=='DSC03'){
		    updateFrcsDscsnAjax('DSC03');
		} else{
		    updateFrcsDscsnAjax('DSC04');
		}
	})
	
	$('#updateDscsnCancel').on('click', function(){
		Swal.fire({
			  html: `<p>개업을 포기하시겠습니까?</p><p>해당 건은 상담취소로 변경됩니다</p>`,
			  showCancelButton: true,
			  confirmButtonText: "확인",
			  cancelButtonText: "취소",
			  confirmButtonColor: "#E73940",
			  cancelButtonColor: "#7F9CAB",
			}).then((result) => {
			  /* Read more about isConfirmed, isDenied below */
				 if (result.isConfirmed) {
					 updateFrcsDscsnAjax('DSC02');
				 } else{
				 	Swal.fire("변경되지 않았습니다", "", "info");
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
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/frcs/dscsn/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">상담 상세</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-danger dscsn-dsc01" id="noAprv" style="display: none;">미승인</button>
			<button type="button" class="btn-active dscsn-dsc01" id="okAprv" style="display: none;">승인</button>
			<button type="button" class="btn-danger dscsn-dsc03" id="updateDscsnCancel" style="display: none;">개업포기</button>
			<button type="button" class="btn-active dscsn-save" id="updateDscsn" style="display: none;">저장  <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<div class="wrap">
	      	<div class="cont">
      	<!-- table-wrap 가맹점주 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>가맹점주 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th style="width:15%;">이름</th>
					<td id="dscsn-mbrNm">
					</td>
					<th style="width:15%;">아이디</th>
					<td id="dscsn-mbrId">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td id="dscsn-mbrTelno">
					</td>
					<th>이메일</th>
					<td id="dscsn-mbrEmlAddr">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	
      	<!-- /. cont끝 -->
      	
      	<div class="cont">
      	<!-- table-wrap 관리자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자 정보</div> 
			</div>
			<table class="table-blue modal-table">
					<tr>
						<th style="width:15%;">이름</th>
						<td>
							<div class="input-wrapper">
								<input id="dscsn-mngrNm" type="text">
								<input id="dscsn-mngrId" type="text" hidden>
								<button type="button" class="update-btn update-mngr"></button>
							</div>
						</td>
						<th style="width:15%;">전화번호</th>
						<td>
							<div class="tel-wrap">
								<input disabled id="dscsn-mngrTelno1" type="text" class="input-tel">-
								<input disabled id="dscsn-mngrTelno2" type="text" class="input-tel">-
								<input disabled id="dscsn-mngrTelno3" type="text" class="input-tel">
							</div>
						</td>
					</tr>
			</table>
		</div>
<!-- 		/.table-wrap -->
		</div>
		<!-- /. cont끝 -->
		
      	<div class="cont">
      	<!-- table-wrap 관리자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>상담 정보</div> 
			</div>
			<table class="table-blue modal-table">
					<tr>
						<th style="width:15%;">상담유형</th>
						<td id="dscsn-dscsnType"></td>
						<th style="width:15%;">개업여부</th>
						<td id="dscsn-frcs"></td>
					</tr>
					<tr>
						<th>희망지역</th>
						<td>
							<select name="rgnNo" id="dscsn-rgnNm" class="select2-custom">
								<option value="">전체</option>
								<c:forEach var="rgn" items="${rgn}">
									<option value="${rgn.comNo}">${rgn.comNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>상담일자</th>
						<td>
							<input type="date" id="dscsn-dscsnPlanYmd">
						</td>
					</tr>
					<tr class="modal-dsc" style="display:none;">
						<th>내용</th>
						<td colspan="3">
							<textarea id="dscsn-dscsnCn" rows="" cols=""></textarea>
						</td>
					</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	<!-- /. cont끝 -->
</div>
<!-- wrap 끝 -->	
    
<!-- 관리자 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/mngrModal.jsp" />
    