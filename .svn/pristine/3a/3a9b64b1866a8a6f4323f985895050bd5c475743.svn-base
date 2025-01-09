<%--
 	@fileName    : selectNoticeAjax
 	@programName : 공지사항 조회, (모달: 상세조회, 등록, 수정, 삭제)
 	@description : 공지사항 CRUD 하는 방법
 	@author      : 정기쁨
 	@date        : 2024. 09. 25
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="/resources/hdofc/css/notice.css"/>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">

<script type="text/javascript">
var ntcTtl= '';
var ntcCn= '';
var mngrNm = '';
var mngrId = '';
var fixdSeq = '';
let sort = 'wrtrDtSort'; 
let orderby = 'desc';
let currentPage = 1;
var selectedArr = [];
var fileSaveLocate = '';
var fileOriginalName = '';
$(function(){
	
	// 셀렉트 디자인 라이브러리
	select2Custom();
	
	// 공지사항 목록 조회****************************************************************************/
	selectNoticeAjax();
	
	// 검색
	$('#searchBtn').on('click',function(){
		currentPage=1;
	    selectNoticeAjax();
	})
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		selectNoticeAjax();
	})
	
	// 정렬 기능
	$('.sort').on('click',function(){
	      currentPage=1; // 1페이지 부터 시작
	      
	      $('.sort').removeClass('active');
	      $(this).addClass('active');

	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
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
	      selectNoticeAjax();
	})
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		// 검색어 가져오기
		ntcTtl= $('#ntcTtl').val('');
		ntcCn= $('#ntcCn').val('');
		mngrId = $('#mngrId').val('');
		startWrtrDt= $('#startWrtrDt').val('');
		endWrtrDt= $('#endWrtrDt').val('');
		$('#ttlSummary, #cnSummary, #mngrSummary, #startWrtSummary, #endWrtSummary').text('미선택');
		
		// 정렬 조건 색상 변경
		$('.sort').removeClass('active');		
		originSort = $('.sort[data-sort="wrtrDtSort"]');
		originSort.addClass('active');
		
		// 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	    var sortAsc = $('.sort-arrow', originSort).find('.sort-asc');
	    var sortDesc = $('.sort-arrow', originSort).find('.sort-desc');
		
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
		
		selectNoticeAjax();
	})
	
	// 상세조건 변화
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
		
		// 인풋 데이터 가져오기
		ntcTtl= $('#ntcTtl').val();
		ntcCn= $('#ntcCn').val();
		mngr = $('#select2-mngrId-container').text();
		startWrtrDt= $('#startWrtrDt').val();
		endWrtrDt= $('#endWrtrDt').val();
		
	    // 제목 데이터 입력
	    $('#ttlSummary').text(ntcTtl === '' ? '미입력' : ntcTtl);
	    // 내용 데이터 입력
	    $('#cnSummary').text(ntcCn === '' ? '미입력' : ntcCn);
	    // 담당자 데이터 입력
	    $('#mngrSummary').text(mngr === '' ? '미선택' : mngr);
	 	// 공지사항 기간 데이터 입력
		dateStr = `\${startWrtrDt} ~ \${endWrtrDt}`;
	    $('#wrtSummary').text((startWrtrDt === '' && endWrtrDt === '') ? '미선택' : dateStr);
	})
	
	// 공지사항 목록 조회****************************************************************************/
	
	// 공지글 삭제하기
	$('#updateFixd').on('click', function() {
	    // 체크된 체크박스 값을 배열에 추가
	    $('.check-btn:checked').not('.check-btn.all').each(function() {
    		selectedArr.push($(this).val());
	    });
	    
	    console.log("selectedArr => ",selectedArr);

	    // 배열이 비어 있지 않으면 AJAX 호출
	    if (selectedArr.length > 0) {
	    	updateFixd(selectedArr);
	    } else {
	    	var Toast = Swal.mixin({
    		  toast: true,
    		  position: 'top-end',
    		  showConfirmButton: false,
    		  timer: 3000 //3초간 유지
    		});
    		
    		Toast.fire({
    			icon:'error',
    			title:'항목을 선택해주세요'
    		});
	    }
	});
	
	// 전체 선택 체크박스
	$('.check-btn.all').on('click',function(){
		if($(this).is(":checked")){
			$('.check-btn').prop("checked", true);
		}else {
			$('.check-btn').prop("checked", false);
		}
	})
	
	// 파일 다운로드
	$(document).on('click','#downloadBtn',function(){
		fileSaveLocate = $(this).data('fileLocate');
		fileOriginalName = $(this).data('fileName');
		console.log(fileSaveLocate);
		console.log(fileOriginalName);
		fileDownloadAjax(fileSaveLocate, fileOriginalName);
	})
})
</script>

<sec:authentication property="principal.memberVO" var="user"/>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">공지사항 관리</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap -->
<div class="wrap">
	
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 제목 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목</p>
					<input type="text" id="ntcTtl" name="ntcTtl" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 내용 검색조건 -->
				<div class="search-cont">
					<p class="search-title">내용</p>
					<input type="text" id="ntcCn" name="ntcCn" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 담당자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자</p>
					<select class="select2-custom" name="mngrId" id="mngrId" data-mbr-nm="">
						<!-- selectNoticeAjax() 출력 -->
					</select>
				</div>
				<!-- 등록일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">등록일자</p>
					<div class="search-date-wrap">
						<input type="date" id="startWrtrDt" name="startWrtrDt"> 
							~ 
						<input type="date" id="endWrtrDt" name="endWrtrDt">
					</div>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<div class="search-cont">
					<p class="search-title">제목 <span class="summary" id="ttlSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">내용 <span class="summary" id="cnSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">담당자 <span class="summary" id="mngrSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">등록일자 <span class="summary" id="wrtSummary"></span></p>
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
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
		<!-- /.검색 버튼 영역 -->
	</div>
	<!-- /.search-section -->
	
	<!-- cont: 공지사항 목록 -->
	<div class="cont">
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div data-type=''  class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all"><!-- selectNoticeAjax()로 출력 --></span>
					</div>
				</div>
				<div class="btn-wrap">
					<button class="btn-default" id="updateFixd">고정해체</button>
					<button class="btn-active" onclick="window.location.href='/hdofc/notice/selectNoticeDetail'">등록 <span class="icon material-symbols-outlined">East</span></button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="right" style="width: 50px">
							<input type="checkbox" class="check-btn all" id="chkBox" name="chkBox" value="" />
					       	<label for="chkBox"><span></span></label>
						</th>
						<th class="center" style="width: 60px">번호</th>
						<th style="width: 300px">제목</th>
						<th class="center" style="width: 200px">담당자</th>
						<th class="center sort active" data-sort="wrtrDtSort" style="width: 100px" >
							등록일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc active">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort"  data-sort="intCntSort" style="width: 100px" >
							조회수
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
					<!-- selectNoticeAjax()로 출력 될 영역  -->
				</tbody>
			</table>
			<div class="pagination-wrap">
				<div class="pagination">
					<!-- selectNoticeAjax()를 통해 나타날 영역 -->
				</div>
			</div>
		</div>
	</div>
	<!-- /.cont: 공지사항 목록 -->
	
</div>
<!-- /.wrap -->


<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/hdofc/js/notice.js"></script>
