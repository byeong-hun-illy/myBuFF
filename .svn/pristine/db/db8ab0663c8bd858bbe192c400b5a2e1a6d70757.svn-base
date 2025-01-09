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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/hdofc/js/gds.js"></script>
<script type="text/javascript">
let currentPage = 1;
let gdsClass = '';
let sort = 'regYmd';
let orderby = 'desc';
let bzentNo = 'HO0001'
$(function(){
	select2Custom();
	selectGdsAjax();
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#sregYmd').val('');
		$('#eregYmd').val('');
		$('#gdsClass').val('');
		$('#gdsType').val('').trigger('change');
		$('#gdsNm').val('');
		$('#sfStockQty').val('');
		$('#ntslType').val('');
		$('.select-selected').text('전체');
		
		$('#regSummary').text('전체');
		$('#typeSummary').text('전체');
		$('#clsSummary').text('전체');
		$('#sfSummary').text('전체');
		$('#gdsSummary').text('전체');
		$('#ntslSummary').text('전체');
		$('#sfSummary').text('전체');
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		gdsClass = '';
		$('.fd').show();
		$('.sm').show();
		$('.pm').show();
		selectGdsAjax();
	})
	//.search-reset
	
	
	// 소유형 선택시
	$('#gdsType').on('change', function(){
		let selectedOption = $(this).find('option:selected'); // 선택된 option 요소
		 let className = selectedOption.attr('class'); // 선택된 option의 클래스 이름
		if(className=='fd'){
			$('#gdsClass').val("FD");
		} else if(className=='sm'){
			$('#gdsClass').val("SM");
		} else if(className=='pm'){
			$('#gdsClass').val("PM");
		}
		var selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
	})
	
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
		let gdsClasss = $('#gdsClass option:selected').text();
		let gdsType= $('#gdsType option:selected').text();
		let gdsNm = $('#gdsNm').val();
		let sfStockQty = $('#sfStockQty option:selected').text();
		let ntslType= $('#ntslType option:selected').text();
		let sregYmd= $('#sregYmd').val();
		let eregYmd= $('#eregYmd').val();
		
		dateregStr = `\${sregYmd} ~ \${eregYmd}`;
		
		if(sregYmd=='' & eregYmd==''){
			$('#regSummary').text('전체');
		}else {
			$('#regSummary').text(dateregStr);
		}
		
		if(gdsType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(gdsType);
		}
		// 담당자 데이터 입력
		if(gdsClasss==''){
			$('#clsSummary').text('전체');
		}else {
			$('#clsSummary').text(gdsClasss);
		}
		// 담당자 데이터 입력
		if(gdsNm==''){
			$('#gdsSummary').text('전체');
		}else {
			$('#gdsSummary').text(gdsNm);
		}
		// 담당자 데이터 입력
		if(ntslType==''){
			$('#ntslSummary').text('전체');
		}else {
			$('#ntslSummary').text(ntslType);
		}
		// 담당자 데이터 입력
		if(sfStockQty==''){
			$('#sfSummary').text('전체');
		}else {
			$('#sfSummary').text(sfStockQty);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    gdsClass = $('#gdsClass').val();
	    selectGdsAjax(); 
	    
	 // 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	 
	    if(gdsClass=='FD'){
	    	 $('#tap-fd').parent().addClass('active');
	    } else if(gdsClass=='SM'){
	    	 $('#tap-sm').parent().addClass('active');
	    } else if(gdsClass=='PM'){
	    	 $('#tap-pm').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectGdsAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
 		gdsClass = $(this).data('type');
 		$('#gdsClass').val(gdsClass);
	 	var selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
		selectGdsAjax();
	})
	
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectGdsAjax();
	})
	// 가맹점 상세로 이동
	$(document).on('click','.gdsDtl',function(){
		let gdsCode = $(this).data('no');
		location.href='/hdofc/gds/dtl?gdsCode='+gdsCode;
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
	      selectGdsAjax();
	})
	
})
</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">상품 현황</h1>
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
				<!-- 대유형 검색조건 -->
				<div class="search-cont">
					<p class="search-title">대유형</p>
					<div class="select-custom w-100">
					<select name="gdsClass" id="gdsClass">
						<option value="">전체</option>
						<option value="FD">식품</option>
						<option value="SM">부자재</option>
						<option value="PM">포장재</option>
					</select>
					</div>
				</div>
				<!-- 소유형 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">소유형</p>
					<select name="gdsType" id="gdsType" class="select2-custom">
						<option value="">전체</option>
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
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상품명</p>
					<input type="text" id="gdsNm" name="gdsNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 안전 재고 검색조건 -->
				<div class="search-cont">
					<p class="search-title">안전재고</p>
					<div class="select-custom w-100">
					<select name="sfStockQty" id="sfStockQty">
						<option value="">전체</option>
						<option value="down">미만</option>
						<option value="up">이상</option>
					</select>
					</div>
				</div>
				<!-- 등록 재고 검색조건 -->
				<div class="search-cont">
					<p class="search-title">판매여부</p>
					<div class="select-custom w-100">
					<select name="ntslType" id="ntslType">
						<option value="">전체</option>
						<option value="GDNT01">입고전</option>
						<option value="GDNT02">미판매</option>
						<option value="GDNT03">판매중</option>
					</select>
					</div>
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
					<p class="search-title">대유형 <span class="summary" id="clsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">소유형 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상품명 <span class="summary" id="gdsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">안전재고 <span class="summary" id="sfSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">판매여부 <span class="summary" id="ntslSummary">전체</span></p>
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
						<div data-type='FD' class="tap-cont" >
							<span class="tap-title">식품</span>
							<span class="bge bge-active" id="tap-fd"></span>
						</div>
						<div data-type='SM' class="tap-cont">
							<span class="tap-title">부자재</span>
							<span class="bge bge-warning" id="tap-sm"></span>
						</div>
						<div data-type='PM' class="tap-cont">
							<span class="tap-title">포장재</span>
							<span class="bge bge-danger" id="tap-pm"></span>
						</div>
					</div>
					<div class="btn-wrap">
						<button class="btn-active" onclick="location.href='/hdofc/gds/regist'">등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 5%;">번호</th>
							<th class="center sort sort-gds" data-sort="gdsNm" style="width: 20%;">상품명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-gds" data-sort="qty" style="width: 10%;">수량
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-gds" data-sort="sfStockQty" style="width: 10%;">안전재고
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-gds" data-sort="unitNm" style="width: 10%;">단위
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-gds" data-sort="amt" style="width: 10%;">단가(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-gds active" data-sort="regYmd" style="width: 10%;">등록일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-gds" data-sort="ntslType" style="width: 10%;">판매유형
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						<th class="center sort sort-gds" data-sort="gdsType" style="width: 10%;">유형
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc active">▲</span>
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

    