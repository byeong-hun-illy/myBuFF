<%--
 	@fileName    : selectEventList.jsp
 	@programName : 이벤트 목록 조회
 	@description : 이벤트 조회나 추가를 위한 페이지
 	@author      : 정기쁨
 	@date        : 2024. 09. 18
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="/resources/hdofc/css/event.css"/>

<script type="text/javascript">
let currentPage = 1;
let eventType = '';

$(function(){
	
	// 셀렉트 디자인 라이브러리
	select2Custom();
	
	// 이벤트 목록 조회
	selectEventAjax();
	
	// 검색 조건 결과
	$('#searchBtn').on('click',function(){
		currentPage=1;
		
		$('.tap-cont').removeClass('active');
		eventType = $('#eventType').val();
	    switch (eventType) {
        case 'EVT01':
        case 'EVT02':
        case 'EVT03':
        case 'EVT04':
        case 'EVT05':
        	$('.tap-cont[data-type="' + eventType + '"]').addClass('active');
            break;
        default:
        	eventType = '';
        	$('.tap-cont[data-type="' + eventType + '"]').addClass('active');
            break;
    	}
		
	    selectEventAjax();
	})
	
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    
	    let eventTypeValue = $(this).data('type');
	    switch (eventTypeValue) {
	        case 'EVT01':
	        case 'EVT02':
	        case 'EVT03':
	        case 'EVT04':
	        case 'EVT05':
	        	eventType = eventTypeValue;
	        	$('#eventType').val(eventTypeValue);
	            break;
	        default:
	        	eventType = '';
	        	$('#eventType').val('');
	            break;
	    }
	    
	    var selectedOptionText = $('#eventType option:selected').text();
		$('#eventType').parent().find('.select-selected').text(selectedOptionText);
	    
	    selectEventAjax();
	})
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectEventAjax();
	})
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('.select-selected').text('전체');
		let eventType= $('#eventType').val('');
		let bgngYmd= $('#bgngYmd').val('');
		let expYmd= $('#expYmd').val('');
		let couponGubun= $('#couponGubun').val('').trigger('change');
		let mbrNm = $('#mbrNm').val('').trigger('change');
		let eventTtl = $('#eventTtl').val('');
		$('#typeSummary').text('전체');
		$('#dateSummary').text('미선택');
		$('#couponSummary').text('미선택');
		$('#mbrSummary').text('미선택');
		$('#ttlSummary').text('미선택');
		
		$('.tap-cont').removeClass('active');
		$('.tap-cont[data-type=""]').addClass('active');
		
		currentPage = 1
		selectEventAjax();
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
		let eventType= $('#eventType').val();
		let bgngYmd= $('#bgngYmd').val();
		let expYmd= $('#expYmd').val();
		let couponGubun= $('#couponGubun').val();
		let mbrNm = $('#mbrNm').val();
		let eventTtl = $('#eventTtl').val();
		
		// 이벤트 타입 데이터 입력
	    switch (eventType) {
        case 'EVT01': $('#typeSummary').text('대기'); break;
        case 'EVT02': $('#typeSummary').text('취소'); break;
        case 'EVT03': $('#typeSummary').text('예정'); break;
        case 'EVT04': $('#typeSummary').text('진행'); break;
        case 'EVT05': $('#typeSummary').text('종료'); break;
        default: $('#typeSummary').text('전체'); break;
    	}
	 	// 이벤트 기간 데이터 입력
		dateStr = `\${bgngYmd} ~ \${expYmd}`;
	    // 제목 데이터 입력
	    $('#ttlSummary').text(eventTtl === '' ? '미입력' : eventTtl);
	    setSummary('#dateSummary', (bgngYmd === '' && expYmd === '') ? '미선택' : dateStr);
	    // 쿠폰 데이터 입력
	    setSummary('#couponSummary', couponGubun);
	    // 담당자 데이터 입력
	    setSummary('#mbrSummary', mbrNm);
	})
	
	// 상세 페이지 이동
	$(document).on('click','.eventDtl',function(){
		evnetNo = $(this).data('eventNo');
		window.location.href="/hdofc/event/selectEventDetail?eventNo="+evnetNo;
	})	
	
})
</script>

<sec:authentication property="principal.memberVO" var="user"/>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">이벤트 관리</h1>
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
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">진행상태</p>
					<div class="select-custom" style="width:200px;">
						<select name="eventType" id="eventType">
							<option value="" selected>전체</option>
							<option value="EVT01">대기</option>
							<option value="EVT04">진행</option>
							<option value="EVT03">예정</option>
							<option value="EVT05">종료</option>
							<option value="EVT02">취소</option>
						</select>
					</div>
				</div>
				<!-- 이벤트 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd"> 
							~ 
						<input type="date" id="expYmd" name="expYmd">
					</div>
				</div>
				<!-- 쿠폰 검색조건 -->
				<div class="search-cont">
					<p class="search-title">쿠폰</p>
					<div class="search-coupon-wrap">
						<select class="select2-custom" id="couponGubun" name="couponGubun">
							<option value="" selected>전체</option>
							<c:forEach var="couponGroupVO" items="${couponGroupVOList}">
								<option value="${couponGroupVO.couponNm}">${couponGroupVO.couponNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<!-- 담당자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자</p>
					<select class="select2-custom" name="mbrNm" id="mbrNm">
						<option value="" selected>전체</option>
						<c:forEach var="mngrVO" items="${mngrVOList}">
							<option value="${mngrVO.memberVO.mbrNm}">${mngrVO.memberVO.mbrNm}</option>
						</c:forEach>
					</select>
				</div>
				<!-- 제목 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목</p>
					<input type="text" id="eventTtl" name="eventTtl" placeholder="검색어를 입력하세요"> 
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">진행상태 <span class="summary" id="typeSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 이벤트 기간 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간 <span class="summary" id="dateSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 쿠폰 검색조건 -->
				<div class="search-cont">
					<p class="search-title">쿠폰 <span class="summary" id="couponSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 담당자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자 <span class="summary" id="mbrSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 제목 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목 <span class="summary" id="ttlSummary"></span></p>
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
	
	<!-- cont: 이벤트 목록 -->
	<div class="cont">
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div data-type=''  class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all">${all}</span>
					</div>
					<div data-type='EVT01' class="tap-cont">
						<span class="tap-title">대기</span>
						<span class="bge bge-info" id="tap-waiting">${waiting}</span>
					</div>
					<div data-type='EVT04'  class="tap-cont">
						<span class="tap-title">진행</span>
						<span class="bge bge-active" id="tap-progress">${progress}</span>
					</div>
					<div data-type='EVT03'  class="tap-cont">
						<span class="tap-title">예정</span>
						<span class="bge bge-warning" id="tap-scheduled">${scheduled}</span>
					</div>
					<div data-type='EVT05'  class="tap-cont">
						<span class="tap-title">종료</span>
						<span class="bge bge-danger" id="tap-completed">${completed}</span>
					</div>
					<div data-type='EVT02'  class="tap-cont">
						<span class="tap-title">취소</span>
						<span class="bge bge-danger" id="tap-cancelled">${cancelled}</span>
					</div>
				</div>
				<c:if test="${user.mngrType == 'HM01'}">
					<div class="btn-wrap">
						<button class="btn-active" onclick="window.location.href='/hdofc/event/selectEventDetail'">등록 <span class="icon material-symbols-outlined">East</span></button>
					</div>
				</c:if>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="center" style="width: 100px">번호</th>
						<th style="width: 20%">제목</th>
						<th class="center" style="width: 100px">담당자</th>
						<th style="width: 200px">이벤트 쿠폰</th>
						<th class="center" style="width: 400px">이벤트 기간</th>
						<th class="center" style="width: 100px">등록일자</th>
						<th class="center" style="width: 100px">진행상태</th>
					</tr>
				</thead>
				<tbody id="table-body" class="table-error">
					<!-- selectEventAjax()를 통해 나타날 영역 -->
				</tbody>
			</table>
			<div class="pagination-wrap">
				<div class="pagination">
					<!-- selectEventAjax()를 통해 나타날 영역 -->
				</div>
			</div>
		</div>
	</div>
	<!-- /.cont: 이벤트 목록 -->
	
</div>
<!-- /.wrap -->


<script type="text/javascript" src="/resources/hdofc/js/event.js"></script>