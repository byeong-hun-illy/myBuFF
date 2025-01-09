<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="/resources/com/css/frcsClcln.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/com/js/frcsClcln.js"></script>
<c:set value="${amt}" var="amt"/>
<sec:authentication property="principal.MemberVO" var="user"/>
<script type="text/javascript">
let currentPage = 1;
let clclnYn = ''; // 구분을 위해 필요함
let frcsNo = '<c:out value="${user.bzentNo}"/>'; // 가맹점일 땐 가맹점의 bzentNo를 넣을것
let sort = 'regYmd';
let orderby = 'desc';
let stDay = "<c:out value='${amt.stDay}'/>"; // 정산 추가시 clclnYm을 구하기위해 꺼냄
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	select2Custom();
	selectFrcsClclnAjax();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#bgngYmd').val('');
		$('#endYmd').val('');
		$('#sregYmd').val('');
		$('#eregYmd').val('');
		$('#bzentNm').val('');
		$('#clclnYn').val('');
		$('.select-selected').text('전체');
		
		$('#clSummary').text('전체');
		$('#frcsSummary').text('전체');
		$('#typeSummary').text('전체');
		$('#regSummary').text('전체');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		clclnYn = '';
		
		selectFrcsClclnAjax();
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
		let sregYmd= $('#sregYmd').val();
		let eregYmd= $('#eregYmd').val();
		let bzentNm = $('#bzentNm').val();
		let clclnYn = $('#clclnYn option:selected').text();

		dateStr = `\${bgngYmd} ~ \${endYmd}`;
		dateregStr = `\${sregYmd} ~ \${eregYmd}`;
		
		if(bgngYmd=='' & endYmd==''){
			$('#clSummary').text('전체');
		}else {
			$('#clSummary').text(dateStr);
		}
		
		if(sregYmd=='' & eregYmd==''){
			$('#regSummary').text('전체');
		}else {
			$('#regSummary').text(dateregStr);
		}
		// 가맹점 이름 데이터 입력
		if(bzentNm==''){
			$('#frcsSummary').text('전체');
		}else {
			$('#frcsSummary').text(bzentNm);
		}
		// 담당자 데이터 입력
		if(clclnYn==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(clclnYn);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    selectFrcsClclnAjax(); 
	    clclnYn = $('#clclnYn').val();
	    
	 // 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	    if(clclnYn=='Y'){
	    	 $('#tap-y').parent().addClass('active');
	    } else if(clclnYn=='N'){
	    	 $('#tap-n').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectFrcsClclnAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    clclnYn = $(this).data('type');
 		$('#clclnYn').val(clclnYn);
 		var selectedOptionText = $('#clclnYn option:selected').text();
	 	// view창에 담을 text를 담는 변수
	 	$('#clclnYn').parent().find('.select-selected').text(selectedOptionText);
		selectFrcsClclnAjax();
	})
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		//console.log(currentPage);
		selectFrcsClclnAjax();
	})
	// 상세로 이동
	$(document).on('click','.frcsDtl',function(){
		let frcsNo = $(this).data('no');
		let clclnYm = $(this).data('ym');
		location.href='/hdofc/frcsClcln/dtl?frcsNo='+frcsNo+'&clclnYm='+clclnYm;
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
	      selectFrcsClclnAjax();
	})
	
	//////////////////////// 정산 추가
	
	$('#insertFrcsClcln').on('click', function(){
	    const date = new Date(stDay);  // stDay 값을 Date 객체로 변환
	    const nextMonth = new Date(date.getFullYear(), date.getMonth() + 1, 1);  // 다음 달의 첫 날로 설정
	    const year = nextMonth.getFullYear();
	    const month = (nextMonth.getMonth() + 1).toString().padStart(2, '0');  // 월을 2자리로 맞춤
	    let clclnYm = year+month;
	    
	    let htmlStr = "<p>"+year+"년 "+month+"월의 정산 정보를 등록하시겠습니까?</p>"
	    
	    Swal.fire({
	    	  title : "확인",
	    	  icon : "warning",
			  html: htmlStr,
			  showCancelButton: true,
			  confirmButtonText: "확인",
			  cancelButtonText: "취소",
			  confirmButtonColor: "#E73940",
			  cancelButtonColor: "#7F9CAB",
			}).then((result) => {
				 if (result.isConfirmed) {
					 insertFrcsClclnAjax(clclnYm);
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
        <h1 class="m-0">가맹점 정산 현황</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->
    
<div class="wrap">
	
	<div class="row" style="gap: var(--gap--m);"> 
		<div class="cont amt-cont">
			<div class="amt-top">
				<div class="amt-title-sub">
					<div class="amt-title">이번 달 정산 총 금액(원)</div>
					<div class="amt-bot">
						<p class="amt-title-date">${amt.stDay} ~ ${amt.enDay}</p>
					</div>
				</div>
				<div class="amt-title-main" id="clclnTotal">
					<span class="title-bge left">정산예정</span>
					<div class="amt-total">
						<!-- 원래의 total 값 출력 -->
						<fmt:formatNumber value="${amt.total}" type="number" var="numberType" />${numberType} 
					</div>
				</div> 
			</div>
		</div>
		<div class="cont amt-cont">
			<div class="amt-top">
				<div class="amt-title-sub">
					<div class="amt-title">이번 달 정산 총 금액(원)</div>
					<div class="amt-bot">
						<p class="amt-title-date">${amt.stDay} ~ ${amt.enDay}</p>
					</div>
				</div>
				<div class="amt-title-main" id="clclnYTotal">
					<span class="title-bge right">정산완료</span>
					<div class="amt-total">
						<!-- 원래의 total 값 출력 -->
						<fmt:formatNumber value="${amt.clclnY}" type="number" var="numberType" />${numberType}
					</div>
				</div> 
			</div>
		</div>
	</div>

	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<sec:authentication property="principal.MemberVO" var="user"/>
				<!-- 운영 검색조건 -->
				<div class="search-cont w-100">
					<p class="search-title">정산여부</p>
					<div class="select-custom"> <!-- div 감싸주기 시작 -->
					<select name="clclnYn" id="clclnYn">
						<option value="">전체</option>
						<option value="N">정산예정</option>
						<option value="Y">정산완료</option>
					</select>
					</div>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">가맹점명</p>
					<input type="text" id="bzentNm" name="bzentNm" placeholder="키워드를 입력하세요"> 
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
				<!-- 개업일자 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">정산일자</p>
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
					<p class="search-title">정산여부 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">가맹점명 <span class="summary" id="frcsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록일자 <span class="summary" id="regSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">정산일자 <span class="summary" id="clSummary">전체</span></p>
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
						<div data-type='N' class="tap-cont" >
							<span class="tap-title">정산예정</span>
							<span class="bge bge-danger" id="tap-n"></span>
						</div>
						<div data-type='Y' class="tap-cont">
							<span class="tap-title">정산완료</span>
							<span class="bge bge-active" id="tap-y"></span>
						</div>
					</div>
					<div class="btn-wrap">
						<button class="btn-active" id="insertFrcsClcln"
						    <c:if test="${isLastMonth}">
						        disabled
						    </c:if>
						>등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%;">번호</th>
							<th class="center sort sort-frcs" data-sort="clclnYm" style="width: 10%;">년월
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="bzentNm" style="width: 20%;">가맹점명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs active" data-sort="regYmd" style="width: 10%;">등록일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="royalty" style="width: 10%;">로열티
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="dscntAmt" style="width: 10%;">할인금액
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="clclnYmd" style="width: 10%;">정산일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-frcs" data-sort="clclnYn" style="width: 10%;">정산여부
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