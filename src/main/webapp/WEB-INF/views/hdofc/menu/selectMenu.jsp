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
<link href="/resources/hdofc/css/menu.css" rel="stylesheet"> 
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
let currentPage = 1;
let menuType = '';
let sort = 'rlsYmd';
let orderby = 'desc';

$(function(){
	select2Custom();
	selectMenuAjax();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#sregYmd').val('');
		$('#eregYmd').val('');
		$('#srlsYmd').val('');
		$('#erlsYmd').val('');
		$('#menuNm').val('');
		$('#ntslType').val('');
		$('#menuType').val('');
		$('#mngrId').val('').trigger('change');
		$('.select-selected').text('전체');
		
		$('#menTypeSummary').text('전체');
		$('#ntslTypeSummary').text('전체');
		$('#mngrSummary').text('전체');
		$('#regSummary').text('전체');
		$('#rlsSummary').text('전체');
		$('#menuNmSummary').text('전체');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		menuType = '';
		
		selectMenuAjax();
	})
	//.search-reset
	
	// 요약보기[+] 버튼 클릭 시 이벤트
	$('.search-toggle').on('click', function() {
		// 상세조건 토글 이벤트 호출
		searchToggle(this);
		
		/* 아래 부분은 구현하는 페이지에 맞춰서 작성해주세요!! */
		// 인풋 데이터 가져오기
		let menuType= $('#menuType option:selected').text();
		let ntslType = $('#ntslType option:selected').text();
		let mngrId = $('#mngrId option:selected').text();
		let menuNm = $('#menuNm').val();
		let sregYmd= $('#sregYmd').val();
		let eregYmd= $('#eregYmd').val();
		let srlsYmd= $('#srlsYmd').val();
		let erlsYmd= $('#erlsYmd').val();
		
		dateregStr = `\${sregYmd} ~ \${eregYmd}`;
		dateregStr2 = `\${srlsYmd} ~ \${erlsYmd}`;
		
		// 담당자 데이터 입력
		if(mngrId==''){
			$('#mngrSummary').text('전체');
		}else {
			$('#mngrSummary').text(mngrId);
		}
		if(sregYmd=='' & eregYmd==''){
			$('#regSummary').text('전체');
		}else {
			$('#regSummary').text(dateregStr);
		}
		
		if(srlsYmd=='' & erlsYmd==''){
			$('#rlsSummary').text('전체');
		}else {
			$('#rlsSummary').text(dateregStr);
		}
		
		if(menuType==''){
			$('#menuTypeSummary').text('전체');
		}else {
			$('#menuTypeSummary').text(menuType);
		}
		// 담당자 데이터 입력
		if(ntslType==''){
			$('#ntslTypeSummary').text('전체');
		}else {
			$('#ntslTypeSummary').text(ntslType);
		}
		// 담당자 데이터 입력
		if(menuNm==''){
			$('#menuNmSummary').text('전체');
		}else {
			$('#menuNmSummary').text(menuNm);
		}
	});

	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    menuType = $('#menuType').val();
	    selectMenuAjax(); 
	 // 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	 
	    if(menuType=='MENU01'){
	    	 $('#tap-menu01').parent().addClass('active');
	    } else if(menuType=='MENU02'){
	    	 $('#tap-menu02').parent().addClass('active');
	    } else if(menuType=='MENU03'){
	    	 $('#tap-menu03').parent().addClass('active');
	    } else if(menuType=='MENU04'){
	    	 $('#tap-menu04').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectMenuAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    menuType = $(this).data('type');
 		$('#menuType').val(menuType);
 		var selectedOptionText = $('#menuType option:selected').text();
 		$('#menuType').parent().find('.select-selected').text(selectedOptionText);
		selectMenuAjax();
	})
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectMenuAjax();
	})
	// 가맹점 상세로 이동
	$(document).on('click','.menuDtl',function(){
		let menuNo = $(this).data('no');
 		location.href='/hdofc/menu/dtl?menuNo='+menuNo;
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
	      selectMenuAjax();
	})
})
</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">판매 메뉴 현황</h1>
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
				<!-- 유형 검색조건 -->
				<div class="search-cont">
					<p class="search-title">유형</p>
					<div class="select-custom w-100">
					<select name="menuType" id="menuType">
							<option value="" selected>전체</option>
							<c:forEach var="menu" items="${menu}">
								<option value="${menu.comNo}">
								${menu.comNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<!-- 판매유형 검색조건 -->
				<div class="search-cont">
					<p class="search-title">판매 유형</p>
						<div class="select-custom w-100">
						<select name="ntslType" id="ntslType">
							<option value="" selected>전체</option>
							<c:forEach var="ntsl" items="${ntsl}">
								<option value="${ntsl.comNo}">
								${ntsl.comNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">메뉴명</p>
					<input type="text" id="menuNm" name="menuNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 관리자명 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">등록자</p>
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
				<!-- 출시일자 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">출시일자</p>
					<div class="search-date-wrap">
						<input type="date" id="srlsYmd" name="srlsYmd"> 
							~ 
						<input type="date" id="erlsYmd" name="erlsYmd">
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
					<p class="search-title">유형 <span class="summary" id="menuTypeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">지역 <span class="summary" id="ntslTypeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">거래처명 <span class="summary" id="menuNmSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록자 <span class="summary" id="mngrSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록일자 <span class="summary" id="regSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">출시일자 <span class="summary" id="rlsSummary">전체</span></p>
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
						<div data-type='MENU01' class="tap-cont" >
							<span class="tap-title">세트</span>
							<span class="bge bge-active" id="tap-menu01"></span>
						</div>
						<div data-type='MENU02' class="tap-cont" >
							<span class="tap-title">단품</span>
							<span class="bge bge-warning" id="tap-menu02"></span>
						</div>
						<div data-type='MENU03' class="tap-cont" >
							<span class="tap-title">사이드</span>
							<span class="bge bge-danger" id="tap-menu03"></span>
						</div>
						<div data-type='MENU04' class="tap-cont" >
							<span class="tap-title">음료</span>
							<span class="bge bge-info" id="tap-menu04"></span>
						</div>
					</div>
					<div class="btn-wrap">
						<button class="btn-active" onclick="location.href='/hdofc/menu/regist'">등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%;">번호</th>
							<th class="center" style="width: 5%;">사진</th>
							<th class="center sort sort-cnpt" data-sort="menuNm" style="width: 15%;">메뉴명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="menuType" style="width: 10%;">유형
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="menuAmt" style="width: 8%;">금액(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="mngrNm" style="width: 11%;">등록자명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="regYmd" style="width: 10%;">등록일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt active" data-sort="rlsYmd" style="width: 8%;">출시일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-cnpt" data-sort="ntslQty" style="width: 10%;">판매수량(개)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-cnpt" data-sort="ntslType" style="width: 10%;">판매유형
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

    