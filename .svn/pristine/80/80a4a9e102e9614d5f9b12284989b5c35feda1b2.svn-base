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
let dscsnCode ='';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	selectFrcsDscsnAjax();
	select2Custom();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#bgngYmd').val('');
		$('#endYmd').val('');
		$('#rgnNo').val('').trigger('change');
		$('#mngrId').val('').trigger('change');
		$('#frcsOpen').val('');
		$('#mbrNm').val('');
		$('#dscsnType').val('');
		dscsnType = '';
		$('#dscsnSummary').text('전체');
		$('#rgnSummary').text('전체');
		$('#mngrSummary').text('전체');
		$('#mbrSummary').text('전체');
		$('#typeSummary').text('전체');
		$('#frcsSummary').text('전체');
		
		$('.select-selected').text('전체');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		selectFrcsDscsnAjax();
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
		let mngrNm = $('#mngrNm').val();
		let mbrNm = $('#mbrNm').val();
		let dscsnType = $('#dscsnType option:selected').text();
		let frcs = $('#frcsOpen option:selected').text();

		dateStr = `\${bgngYmd} ~ \${endYmd}`;
		
		if(bgngYmd=='' & endYmd==''){
			$('#dscsnSummary').text('전체');
		}else {
			$('#dscsnSummary').text(dateStr);
		}
		
		if(rgnNo==''){
			$('#rgnSummary').text('전체');
		}else {
			$('#rgnSummary').text(rgnNo);
		}
		// 담당자 데이터 입력
		if(mngrNm==''){
			$('#mngrSummary').text('전체');
		}else {
			$('#mngrSummary').text(mngrNm);
		}
		// 담당자 데이터 입력
		if(mbrNm==''){
			$('#mbrSummary').text('전체');
		}else {
			$('#mbrSummary').text(mbrNm);
		}
		// 담당자 데이터 입력
		if(dscsnType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(dscsnType);
		}
		
		// 담당자 데이터 입력
		if(frcs==''){
			$('#frcsSummary').text('전체');
		}else {
			$('#frcsSummary').text(frcs);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    dscsnType = $('#dscsnType').val();
	    selectFrcsDscsnAjax(); 
	    
	 // 모든 tap-cont에서 active 클래스를 제거
	   $('.tap-cont').removeClass('active');
	    if(dscsnType=='DSC01'){
	    	 $('#tap-dsc01').parent().addClass('active');
	    } else if(dscsnType=='DSC02'){
	    	 $('#tap-dsc02').parent().addClass('active');
	    } else if(dscsnType=='DSC03'){
	    	 $('#tap-dsc03').parent().addClass('active');
	    } else if(dscsnType=='DSC04'){
	    	 $('#tap-dsc04').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    dscsnType = $(this).data('type');
 		$('#dscsnType').val(dscsnType);
 		var selectedOptionText = $('#dscsnType option:selected').text();
	 	// view창에 담을 text를 담는 변수
	 	$('#dscsnType').parent().find('.select-selected').text(selectedOptionText);
		selectFrcsDscsnAjax();
	})
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectFrcsDscsnAjax();
	})
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort').removeClass('active');
	      $(this).addClass('active');
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
	      selectFrcsDscsnAjax();
	})
	
	$('#frcsOpen').on('change', function(){
		let frcs = $('#frcsOpen').val();
		if(frcs=='x'){
			$('#dscsnType').val('DSC04');
		}
	})
	
	///////////////////////////// 상세 ////////////////////////////////////////////
	var dscsnModal = new bootstrap.Modal(document.getElementById('frcsDscsnModal'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	// 상세로 이동
	$(document).on('click','.dscsnDtl',function(){
		dscsnCode = $(this).data('code');
 		// console.log(dscsnCode);
 		location.href='/hdofc/frcs/dscsn/dtl?dscsnCode='+dscsnCode;
	})
})
</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">상담 현황</h1>
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
				<!-- 운영 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상담유형</p>
					<div class="select-custom w-100">
						<select name="dscsnType" id="dscsnType">
							<option value="">전체</option>
							<c:forEach var="dsc" items="${dsc}">
								<option value="${dsc.comNo}">${dsc.comNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<!-- 운영 검색조건 -->
				<div class="search-cont">
					<p class="search-title">개업여부</p>
					<div class="select-custom w-100 ">
					<select name="frcs" id="frcsOpen">
						<option value="">전체</option>
						<option value="1">개업완료</option>
						<option value="2">개업예정</option>
						<option value="3">해당없음</option>
					</select>
					</div>
				</div>
				<!-- 지역 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">희망지역</p>
					<select name="rgnNo" id="rgnNo" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">회원명</p>
					<input type="text" id="mbrNm" name="mbrNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 관리자명 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">관리자명</p>
						<input type="text" id="mngrNm" name="mngrNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 개업일자 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상담일자</p>
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
					<p class="search-title">상담유형 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">희망지역 <span class="summary" id="rgnSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">회원명 <span class="summary" id="mbrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">관리자명 <span class="summary" id="mngrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상담일자 <span class="summary" id="dscsnSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
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
						<div data-type='DSC01' class="tap-cont" >
							<span class="tap-title">상담대기</span>
							<span class="bge bge-info" id="tap-dsc01"></span>
						</div>
						<div data-type='DSC02' class="tap-cont">
							<span class="tap-title">상담취소</span>
							<span class="bge bge-danger" id="tap-dsc02"></span>
						</div>
						<div data-type='DSC03' class="tap-cont">
							<span class="tap-title">상담예정</span>
							<span class="bge bge-warning" id="tap-dsc03"></span>
						</div>
						<div data-type='DSC04' class="tap-cont">
							<span class="tap-title">상담완료</span>
							<span class="bge bge-active" id="tap-dsc04"></span>
						</div>
					</div>
					<div class="btn-wrap">
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%;">번호</th>
							<th class="center sort sort-dscsn" data-sort="mbrNm" style="width: 10%;">회원명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-dscsn" data-sort="mngrNm" style="width: 10%;">관리자명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-dscsn active" data-sort="dscsnYmd" style="width: 10%;">상담일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
							<th class="center" style="width: 10%;">전화번호</th>
							<th class="center" style="width: 10%;">이메일
							</th>
							<th class="center sort sort-dscsn" data-sort="rgnNo" style="width: 15%;">희망지역
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-dscsn" data-sort="dscsnType" style="width: 10%;">상담유형
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-dscsn" data-sort="frcs" style="width: 10%;">개업여부
							<div class="sort-icon">
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

<!-- 가맹점 폐업 상세 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/frcsDscsnModal.jsp" />
    
<!-- 관리자 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/mngrModal.jsp" />
    