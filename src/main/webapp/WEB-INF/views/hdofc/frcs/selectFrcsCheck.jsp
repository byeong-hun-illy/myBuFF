<%--
 	@fileName    : selectFrcsCheck.jsp
 	@programName : 가맹점 점검 조회
 	@description : 가맹점 점검 조회나 점검 추가를 위한 페이지
 	@author      : 송예진
 	@date        : 2024. 09. 16
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/frcs.js"></script>
<script src="/resources/hdofc/js/frcsCheck.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
let currentPage = 1;
let sort = 'chckYmd';
let orderby = 'desc';

let frcsNo = '';
let chckSeq = '';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	selectFrcsCheckAjax();
	select2Custom();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#bgngYmd').val('');
		$('#endYmd').val('');
		$('#rgnNo').val('').trigger('change');
		$('#mngrId').val('').trigger('change');
		$('#bzentNm').val('');
		$('#mbrNm').val('');
		$('#frcsType').val('');
		$('#warnCnt').val('');
		$('#totScr').val('');
		$('#insctrNm').val('');
		
		$('.select-selected').text('전체');
		
		$('#mbrSummary').text('전체');
		$('#frcsSummary').text('전체');
		$('#typeSummary').text('전체');
		$('#chkSummary').text('전체');
		$('#rgnSummary').text('전체');
		$('#mngrSummary').text('전체');
		$('#warnSummary').text('전체');
		$('#scrSummary').text('전체');
		$('#insctrSummary').text('전체');
		selectFrcsCheckAjax();
	})
	//.search-reset
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function(){
	   	if ($(this).hasClass('active')){
	   		$(this).removeClass('active');
	   		$('.search-toggle').html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
	   		$('.search-original').slideDown(300);
	   		$('.search-summary').slideUp(300);
	   	} else {
	   		$(this).addClass('active');
	   		$('.search-toggle').html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
	   		$('.search-original').slideUp(300);
	   		$('.search-summary').slideDown(300);
	   	} 
		
	   	/* 아래 부분은 구현하는 페이지에 맞춰서 작성해주세요!! */
		// 인풋 데이터 가져오기
		let bgngYmd= $('#bgngYmd').val();
		let endYmd= $('#endYmd').val();
		let rgnNo= $('#rgnNo option:selected').text();
		let mngrId = $('#mngrId option:selected').text();
		let mbrNm = $('#mbrNm').val();
		let bzentNm = $('#bzentNm').val();
		let insctrNm = $('#insctrNm').val();
		let frcsType = $('#frcsType option:selected').text();
		let warnCnt = $('#warnCnt option:selected').text();
		let totScr = $('#totScr option:selected').text();

		dateStr = `\${bgngYmd} ~ \${endYmd}`;
		
		if(bgngYmd=='' & endYmd==''){
			$('#chkSummary').text('전체');
		}else {
			$('#chkSummary').text(dateStr);
		}
		
		if(rgnNo==''){
			$('#rgnSummary').text('전체');
		}else {
			$('#rgnSummary').text(rgnNo);
		}
		// 담당자 데이터 입력
		if(mngrId==''){
			$('#mngrSummary').text('전체');
		}else {
			$('#mngrSummary').text(mngrId);
		}
		// 담당자 데이터 입력
		if(mbrNm==''){
			$('#mbrSummary').text('전체');
		}else {
			$('#mbrSummary').text(mbrNm);
		}
		// 담당자 데이터 입력
		if(insctrNm==''){
			$('#insctrSummary').text('전체');
		}else {
			$('#insctrSummary').text(insctrNm);
		}
		// 담당자 데이터 입력
		if(bzentNm==''){
			$('#frcsSummary').text('전체');
		}else {
			$('#frcsSummary').text(bzentNm);
		}
		// 담당자 데이터 입력
		if(frcsType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(frcsType);
		}
		// 담당자 데이터 입력
		if(frcsType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(frcsType);
		}
		// 담당자 데이터 입력
		if(warnCnt==''){
			$('#warnSummary').text('전체');
		}else {
			$('#warnSummary').text(frcsType);
		}
		// 담당자 데이터 입력
		if(totScr==''){
			$('#scrSummary').text('전체');
		}else {
			$('#scrSummary').text(totScr);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    selectFrcsCheckAjax(); 
	});
	
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectFrcsCheckAjax(); 
	})
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		//console.log(currentPage);
		selectFrcsCheckAjax(); 
	})
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      $('.sort').removeClass('active');
	      $(this).addClass('active');
	      
	      sort = $(this).data('sort');
	      
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectFrcsCheckAjax(); 
	})
	
	var checkModal = new bootstrap.Modal(document.getElementById('frcsInfoModal'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	
	// 클릭 상세 모달 나오기
	$(document).on('click', '.frcsChkDtl', function(){
		frcsNo = $(this).data("no");
		chckSeq = $(this).data("seq");
		// console.log(frcsNo, chckSeq);
		frcsCheckDtlAjax();
		checkModal.show();
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
})
</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">점검 현황</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->
<div class="wrap">
	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<sec:authentication property="principal.MemberVO" var="user"/>
				<!-- 운영 검색조건 -->
				<div class="search-cont w-150">
					<p class="search-title">상태</p>
					<div class="select-custom"> <!-- div 감싸주기 시작 -->
					<select name="frcsType" id="frcsType">
						<option value="">전체</option>
						<option value="FRS01">운영</option>
						<option value="FRS03">폐업예정</option>
						<option value="FRS02">폐업</option>
					</select>
					</div>
				</div>
				<!-- 지역 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">지역</p>
					<select name="rgnNo" id="rgnNo" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont w-300">
					<p class="search-title">가맹점명</p>
					<input type="text" id="bzentNm" name="bzentNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">가맹점주명</p>
					<input type="text" id="mbrNm" name="mbrNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">점검자명</p>
					<input type="text" id="insctrNm" name="insctrNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 관리자 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">관리자</p>
						<select name="mngrId" id="mngrId" class="select2-custom">
							<option value="" selected>전체</option>
							<c:forEach var="mngr" items="${mngr}">
								<option 
								value="${mngr.mbrId}">
<%-- 								<c:if test="${user.mbrId==mngr.mbrId}">selected</c:if>> --%>
								${mngr.mbrNm}(${mngr.mbrId})</option>
							</c:forEach>
						</select>
				</div>
				<!-- 관리자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">점수</p>
						<div class="select-custom w-100">
						<select name="totScr" id="totScr">
							<option value="" selected>전체</option>
							<option value="90">A</option>
							<option value="80">B</option>
							<option value="70">C</option>
							<option value="60">D</option>
							<option value="1">F</option>
						</select>
						</div>
				</div>
				<!-- 관리자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">누적경고횟수</p>
						<div class="select-custom w-100">
						<select name="warnCnt" id="warnCnt">
							<option value="" selected>전체</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
						</div>
				</div>
				<!-- 폐업 일자 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">점검일자</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd"> 
							~ 
						<input type="date" id="endYmd" name="endYmd">
					</div>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상태 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">지역 <span class="summary" id="rgnSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">가맹점명 <span class="summary" id="frcsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">가맹점주명 <span class="summary" id="mbrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">점검자명 <span class="summary" id="insctrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">관리자 <span class="summary" id="mngrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">총점수 <span class="summary" id="scrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">누적경고횟수 <span class="summary" id="warnSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 담당자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">점검일자 <span class="summary" id="chkSummary">점검일자</span></p>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 접기 영역 -->
		
		<!-- 검색 버튼 영역 -->
		<div class="search-control">
			<div class="search-control-btns">
				<div class="search-toggle">
					요약보기<span class="icon material-symbols-outlined">Add</span>
				</div>
				<div class="search-reset">
					초기화<span class="icon material-symbols-outlined">restart_alt</span>
				</div>
				<div>
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
		<!-- /.search-section: 검색어 영역 -->
	</div>
	<!-- /.search-section -->
	
	
		<!-- 테이블 디자인 1 -->
		<div class="cont">
			<div class="table-wrap">
			<!-- 테이블 분류 시작 -->
				<div class="tap-btn-wrap">
					<div class="tap-wrap">
						<div data-type='' class="tap-cont active">
							<span class="tap-title">전체</span>
							<span class="bge bge-default" id="tap-all"></span>
						</div>
					</div>
					<div class="btn-wrap">
						<button class="btn-active" onclick="location.href='/hdofc/frcs/check/regist'">등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%">번호</th>
							<th class="center sort sort-frcs" style="width: 15%" data-sort="bzentNm">가맹점 이름
							<div class="sort-icon" >
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" style="width: 10%" data-sort="warnCnt">누적경고횟수
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" style="width: 10%" data-sort="mbrNm">가맹점주명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" style="width: 10%" data-sort="mngrNm">관리자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							<th class="center sort sort-frcs" style="width: 10%" data-sort="insctrNm">점검자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs active" style="width: 10%" data-sort="chckYmd">점검일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" style="width: 5%" data-sort="totScr">총점수
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" style="width: 10%" data-sort="rgnNo">지역
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-frcs" style="width: 10%" data-sort="frcsType">상태
							<div class="sort-icon" >
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-body" class="table-error">
					</tbody>
				</table>
				<div class="pagination-wrap">
					<div class="pagination">
					</div>
			</div>
		<!-- table-wrap -->
		</div>
	<!-- /테이블 디자인 1 -->
	</div>
	<!-- cont 끝 -->
</div>
<!-- wrap 끝 -->	
<!-- --------------------------------------- 모달 2 시작 ---------------------------------------------------- -->

<!-- 가맹점 점검 상세 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/frcsInfoModal.jsp" />
    