<%--
 	@fileName    : selectFrcs.jsp
 	@programName : 가맹점 조회
 	@description : 가맹점 조회나 추가를 위한 페이지
 	@author      : 송예진
 	@date        : 2024. 09. 12
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet"> 
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/cnpt.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
let currentPage = 1;
let bzentType = '';
let sort = 'regYmd';
let orderby = 'desc';

$(function(){
	select2Custom();
	selectCnptAjax();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#bgngYmd').val('');
		$('#endYmd').val('');
		$('#rgnNo').val('').trigger('change');
		$('#mngrId').val('').trigger('change');
		$('#sregYmd').val('');
		$('#eregYmd').val('');
		$('#bzentNm').val('');
		$('#mbrNm').val('');
		$('#bzentType').val('');
		$('.select-selected').text('전체');
		
		$('#rgnSummary').text('전체');
		$('#mngrSummary').text('전체');
		$('#mbrSummary').text('전체');
		$('#cnptSummary').text('전체');
		$('#typeSummary').text('전체');
		$('#regSummary').text('전체');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		bzentType = '';
		
		selectCnptAjax();
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
		let rgnNo= $('#rgnNo option:selected').text();
		let mngrId = $('#mngrId option:selected').text();
		let mbrNm = $('#mbrNm').val();
		let bzentNm = $('#bzentNm').val();
		let bzentType = $('#bzentType option:selected').text();
		let sregYmd= $('#sregYmd').val();
		let eregYmd= $('#eregYmd').val();
		
		dateregStr = `\${sregYmd} ~ \${eregYmd}`;
		
		if(sregYmd=='' & eregYmd==''){
			$('#regSummary').text('전체');
		}else {
			$('#regSummary').text(dateregStr);
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
		if(bzentNm==''){
			$('#cnptSummary').text('전체');
		}else {
			$('#cnptSummary').text(bzentNm);
		}
		// 담당자 데이터 입력
		if(bzentType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(bzentType);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    bzentType = $('#bzentType').val();
	    selectCnptAjax(); 
	 // 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	    if(bzentType=='BZ_C01'){
	    	 $('#tap-c01').parent().addClass('active');
	    } else if(bzentType=='BZ_C02'){
	    	 $('#tap-c02').parent().addClass('active');
	    } else if(bzentType=='BZ_C03'){
	    	 $('#tap-c03').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectCnptAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
 		bzentType = $(this).data('type');
 		$('#bzentType').val(bzentType);
 		var selectedOptionText = $('#bzentType option:selected').text();
 		$('#bzentType').parent().find('.select-selected').text(selectedOptionText);
		selectCnptAjax();
	})
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectCnptAjax();
	})
	// 가맹점 상세로 이동
	$(document).on('click','.cnptDtl',function(){
		let bzentNo = $(this).data('no');
		location.href='/hdofc/cnpt/dtl?bzentNo='+bzentNo;
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
	      selectCnptAjax();
	})
})
</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">거래처 조회</h1>
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
				<div class="search-cont">
					<p class="search-title">유형</p>
					<div class="select-custom w-100">
					<select name="bzentType" id="bzentType">
						<option value="">전체</option>
						<option value="BZ_C01">식품</option>
						<option value="BZ_C02">부자재</option>
						<option value="BZ_C03">포장재</option>
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
				<div class="search-cont">
					<p class="search-title">거래처명</p>
					<input type="text" id="bzentNm" name="bzentNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자명</p>
					<input type="text" id="mbrNm" name="mbrNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 관리자명 검색조건 -->
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
				<!-- 등록일자 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록일자</p>
					<div class="search-date-wrap">
						<input type="date" id="sregYmd" name="sregYmd"> 
							~ 
						<input type="date" id="eregYmd" name="eregYmd">
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
					<p class="search-title">유형 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">지역 <span class="summary" id="rgnSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">거래처명 <span class="summary" id="cnptSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자명 <span class="summary" id="mbrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">관리자 <span class="summary" id="mngrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록일자 <span class="summary" id="regSummary">전체</span></p>
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
						<div data-type='BZ_C01' class="tap-cont" >
							<span class="tap-title">식품</span>
							<span class="bge bge-active" id="tap-c01"></span>
						</div>
						<div data-type='BZ_C02' class="tap-cont">
							<span class="tap-title">부자재</span>
							<span class="bge bge-warning" id="tap-c02"></span>
						</div>
						<div data-type='BZ_C03' class="tap-cont">
							<span class="tap-title">포장재</span>
							<span class="bge bge-danger" id="tap-c03"></span>
						</div>
					</div>
					<div class="btn-wrap">
						<button class="btn-active" onclick="location.href='/hdofc/cnpt/regist'">등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%;">번호</th>
							<th class="center sort sort-cnpt" data-sort="bzentNm" style="width: 25%;">거래처명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="mbrNm" style="width: 10%;">담당자명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="mngrNm" style="width: 10%;">관리자명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt active" data-sort="regYmd" style="width: 10%;">등록일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="rgnNo" style="width: 15%;">지역
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center" style="width: 15%;">전화번호

							</th>
						<th class="center sort sort-cnpt" data-sort="bzentType" style="width: 10%;">유형
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

    