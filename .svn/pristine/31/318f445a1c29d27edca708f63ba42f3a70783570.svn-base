<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%--
    @fileName    : selectFrcsNetProfitList.jsp
    @programName : 가맹점 매출 관리
    @description : 가맹점 순수익 조회 페이지 + 수정
    @author      : 송예진
    @date        : 2024. 10. 14
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/frcs/js/netProfit.js"></script>
<sec:authentication property="principal.MemberVO" var="user" />
<style>
.btn-active:disabled{
	background-color: var(--btn--disabled);
    color: var(--text--placeholder);
}
.btn-active:disabled:hover {
	background-color: var(--btn--disabled);
    color: var(--text--placeholder);
}
</style>
<script type="text/javascript">
let bzentNo = '${user.bzentNo}';
let sort = 'slsYm';
let orderby = 'desc';
let currentPage = 1;
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

$(function() {
	
	selectProfitAjax();
	
	$('.search-reset').on('click', function() {
		$('#year').val('');
		$('#month').val('');
		
		 $('.select-selected').text('전체');
		$('#dateSummary').text('전체');
		
		selectProfitAjax();
	});
	
	$('.search-toggle').on('click', function() {
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
		
		let year = $('#year').val();                     
		let month = $('#month').val();                     
		
		if(year==''){
			$('#dateSummary').text('전체');
		}else {
			$('#dateSummary').text(year);
		}
		
		if(month==''){
			$('#monthSummary').text('전체');
		}else {
			$('#monthSummary').text(month);
		}
	});
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		//console.log(currentPage);
		selectProfitAjax();
	})
	
	//검색
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    selectProfitAjax();
	});
	////////////////////////정렬  ////////////////////////////////
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
	      selectProfitAjax();
	})
	$(document).on('click','.profixDtl', function(){
		let slsYm = $(this).data("ym")
		location.href="/frcs/netProfitDtl?slsYm="+slsYm;
	})
	$('#insertSls').on('click', function(){
		Swal.fire({
			  title: "확인",
			  html: "등록하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "등록",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				insertSls();
			  }
			});
	})
});

</script>

<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">순이익 현황</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="search-section">
		<form id="searchForm">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 조회 연도 검색조건 -->
				<div class="search-cont">
					<p class="search-title">년도</p>
					<div class="select-custom" style="width:100px;">
						<select id="year" name="year">
							<option value="" selected>전체</option>
							<option value="2023">2023</option>
							<option value="2024">2024</option>
						</select>
					</div> 
				</div>
				<!-- 조회 월 검색조건 -->
				<div class="search-cont">
					<p class="search-title">월</p>
					<div class="select-custom" style="width:100px;">
						<select id="month" name="month">
							<option value="" selected>전체</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</div> 
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">년도<span class="summary" id="dateSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">월<span class="summary" id="monthSummary">전체</span></p>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
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
					<button class="btn btn-default search" type="button" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
		<!-- /.검색 버튼 영역 -->
		</form>
		<!-- /.search-section: 검색어 영역 -->
	</div>
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div data-type="" class="tap-cont active">
						<span class="tap-title">전체</span> <span class="bge bge-default" id="tap-all"></span>
					</div>
				</div>
				<div class="btn-wrap">
					<button class="btn-active" id="insertSls" <c:if test="${cnt==0}">disabled="disabled"</c:if>>등록</button>
				</div>
			</div>
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center sort active" data-sort="slsYm">년월
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="pureAmt">순이익(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="slsGramt">매출액(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="royalty">로열티(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="sumPoAmt">납품금액(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="mngAmt">관리비(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="hireAmt">고용비(원)
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
					</tr>
				</thead>
				<tbody class="table-error" id="table-body">

				</tbody>
			</table>
			<!-- pagination-wrap -->
				<div class="pagination-wrap">
					<div class="pagination">
					</div>
				</div>
			<!-- pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
</div>
