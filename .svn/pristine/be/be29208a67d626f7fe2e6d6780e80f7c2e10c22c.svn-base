<%--
    @fileName    : selectFrcsStockDetail.jsp
    @programName : 가맹점 쿠폰 사용 내역 조회
    @description : 가맹점에서 사용된 쿠폰 내역을 보기 위한 화면
    @author      : 정현종
    @date        : 2024. 09. 25
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<script src='/resources/js/global/value.js'></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user" />

<script type="text/javascript">
let bzentNo = "${user.bzentNo}";

$(function(){ // 꼭 여기 안에!	
	select2Custom(); // 셀렉트 디자인 라이브러리. common.js에서 호출 됨
})

$(function() {
	$('.search-reset').on('click', function() {
	    // 각 입력 필드 초기화
	    $('.select-selected').text('전체');
	    $('#eventType').val('');    // 이벤트 진행 상태 초기화
	    $('#bgngYmd').val('');      // 쿠폰 사용 기간 시작 일자 초기화
	    $('#expYmd').val('');       // 쿠폰 사용 기간 종료 일자 초기화
	    $('#dscntAmt').val('');     // 쿠폰 금액 초기화
	    $('#menuType').val('');     // 메뉴 유형 초기화
	    $('#menuNm').val('');       // 메뉴 명 초기화

	    // 요약 초기화
	    $('#eventTypeSummary').text('전체');
	    $('#dateSummary').text('전체');
	    $('#dscntAmtSummary').text('전체');
	    $('#menuTypeSummary').text('전체');
	    $('#menuNmSummary').text('전체');
	    
	    window.location.href = "/frcs/couponList";  // 페이지 이동
	});
	//.search-reset

	// 검색영역 요약보기
	$('.search-toggle').on('click',function() {
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
	    let eventType = $('#eventType option:selected').text(); // 이벤트 진행 상태
	    let bgngYmd = $('#bgngYmd').val();                      // 쿠폰 사용 기간 시작 일자
	    let expYmd = $('#expYmd').val();                        // 쿠폰 사용 기간 종료 일자
	    let menuType = $('#menuType option:selected').text();   // 메뉴 유형     
	    let menuNm = $('#menuNm').val();                        // 메뉴 명
	
	    // 이벤트 진행 상태 입력
	    if (eventType === '') {
	        $('#eventTypeSummary').text('전체');
	    } else {
	        $('#eventTypeSummary').text(eventType);
	    }
	
	    // 쿠폰 사용 기간 입력
	    if (bgngYmd === '' && expYmd === '') {
	        $('#dateSummary').text('전체');
	    } else {
	        $('#dateSummary').text(bgngYmd + "~" + expYmd);
	    }
	
	    // 메뉴 유형 데이터 입력
	    if (menuType === '') {
	        $('#menuTypeSummary').text('전체');
	    } else {
	        $('#menuTypeSummary').text(menuType);
	    }
	
	    // 메뉴 명 데이터 입력
	    if (menuNm === '') {
	        $('#menuNmSummary').text('전체');
	    } else {
	        $('#menuNmSummary').text(menuNm);
	    }

	})
	//.search-toggle
	
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function() {

		// 모든 tap-cont에서 active 클래스를 제거
		$('.tap-cont').removeClass('active');

		// 클릭된 tap-cont에 active 클래스를 추가
		$(this).addClass('active');
		eventType = $(this).data('type');
		$('#eventType').val(eventType);
		var selectedOptionText = $('#eventType option:selected').text();
		$('#eventType').parent().find('.select-selected').text(selectedOptionText);
		
		$("#searchForm").submit();
	})
});
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">쿠폰 사용 내역 조회</h1>
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="search-section">
		<form id="searchForm">
			<!-- cont: 검색 영역 -->
			<div class="cont search-original">
				<div class="search-wrap">
					<!-- 이벤트 진행상태 검색조건 -->
					<div class="search-cont w-150">
						<p class="search-title">이벤트 진행상태</p>
						<div class="select-custom">
							<select name="eventType" id="eventType">
								<option value="">전체</option>
								<option value='EVT04'
									<c:if test="${param.eventType == 'EVT04'}">selected</c:if>>진행</option>
								<option value='EVT05'
									<c:if test="${param.eventType == 'EVT05'}">selected</c:if>>종료</option>
							</select>
						</div>
					</div>
					<!-- 쿠폰 사용 기간 검색조건 -->
					<div class="search-cont">
						<p class="search-title">쿠폰 사용 기간</p>
						<div class="search-date-wrap">
							<input type="date" id="bgngYmd" name="bgngYmd"
								value="${param.bgngYmd}"> ~ <input type="date"
								id="expYmd" name="expYmd" value="${param.expYmd}">
						</div>
					</div>

					<!-- 메뉴 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 유형</p>
						<div class="select-custom w-150">
							<select id="menuType" name="menuType">
								<option value="">전체</option>
								<c:forEach var="menu" items="${menu}">
									<option value="${menu.comNo}"
										<c:if test="${param.menuType == menu.comNo}">selected</c:if>>${menu.comNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 메뉴 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 명</p>
						<input type="text" id="menuNm" name="menuNm"
							placeholder="키워드를 입력하세요" value="${param.menuNm}">
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
						<p class="search-title">
							이벤트 진행상태 <span class="summary" id="eventTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>
					<!-- 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							쿠폰 사용 기간<span class="summary" id="dateSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>
					<!-- 셀렉트 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 유형<span class="summary" id="menuTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>
					<!-- 텍스트 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 명<span class="summary" id="menuNmSummary">전체</span>
						</p>
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
						<button class="btn btn-default search" id="searchBtn">
							검색 <span class="icon material-symbols-outlined">search</span>
						</button>
					</div>
				</div>
			</div>
			<!-- /.검색 버튼 영역 -->
		</form>
		<!-- /.search-section: 검색어 영역 -->
	</div>

	<!-- cont: 이벤트 목록 -->
	<div class="cont">
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div class="tap-btn-wrap">
					    <div class="tap-wrap">
					        <div data-type='' class="tap-cont <c:if test="${param.eventType == ''}">active</c:if>">
					            <span class="tap-title">전체</span> <span class="bge bge-default" id="tap-all">${all}</span>
					        </div>
					        <div data-type='EVT04' class="tap-cont <c:if test="${param.eventType == 'EVT04'}">active</c:if>">
					            <span class="tap-title">진행</span> <span class="bge bge-active" id="tap-progress">${progress}</span>
					        </div>
					        <div data-type='EVT05' class="tap-cont <c:if test="${param.eventType == 'EVT05'}">active</c:if>">
					            <span class="tap-title">종료</span> <span class="bge bge-danger" id="tap-completed">${completed}</span>
					        </div>
					    </div>
					</div>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">이벤트 진행 상태</th>
						<th class="center">쿠폰 사용 날짜</th>
						<th class="center">쿠폰 명</th>
						<th class="center">쿠폰 금액(원)</th>
						<th class="center">메뉴 유형</th>
						<th class="center">메뉴 명</th>
						<th class="center">회원 아이디</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${articlePage.total == 0}">
						<tbody id="table-body" class="table-error">
							<tr>
								<td class="error-info" colspan="8"><span
									class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div></td>
							</tr>
						</tbody>
					</c:when>
					<c:otherwise>
						<tbody>
							<c:forEach var="EventVO" items="${articlePage.content}">
								<tr>
									<td class="center">${EventVO.rnum}</td>
									<td class="center"><c:choose>
											<c:when test="${EventVO.eventType == 'EVT04'}">
												<span class="bge bge-active">진행</span>
											</c:when>
											<c:when test="${EventVO.eventType == 'EVT05'}">
												<span class="bge bge-danger">종료</span>
											</c:when>
										</c:choose></td>
									<td class="center"><c:set var="useYmd"
											value="${EventVO.couponGroupVOList[0].couponVOList[0].useYmd}" />
										${fn:substring(useYmd, 0, 4)}-${fn:substring(useYmd, 4, 6)}-${fn:substring(useYmd, 6, 8)}
									</td>
									<td>${EventVO.couponGroupVOList[0].couponNm}</td>
									<td class="right"><fmt:formatNumber
											value="${EventVO.couponGroupVOList[0].dscntAmt}"
											pattern="#,###" /></td>
									<td class="center"><c:choose>
											<c:when
												test="${EventVO.couponGroupVOList[0].menuVO.menuType == 'MENU02'}">단품</c:when>
											<c:when
												test="${EventVO.couponGroupVOList[0].menuVO.menuType == 'MENU01'}">세트</c:when>
											<c:when
												test="${EventVO.couponGroupVOList[0].menuVO.menuType == 'MENU03'}">사이드</c:when>
											<c:when
												test="${EventVO.couponGroupVOList[0].menuVO.menuType == 'MENU04'}">음료</c:when>
										</c:choose></td>
									<td>${EventVO.couponGroupVOList[0].menuVO.menuNm}</td>
									<td><c:set var="mbrId"
											value="${EventVO.couponGroupVOList[0].couponVOList[0].ordrVO.mbrId}" />
										${fn:substring(mbrId, 0, 3)}<c:out
											value="${fn:substring('************', 0, fn:length(mbrId) - 3)}" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</c:otherwise>
				</c:choose>
			</table>

			<!-- pagination-wrap -->
			<c:if test="${articlePage.total > 0}">
				<div class="pagination-wrap">
					<div class="pagination">
						<c:if test="${articlePage.startPage gt 5}">
							<a
								href="/frcs/couponList?eventType=${param.eventType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&dscntAmt=${param.dscntAmt}&menuType=${param.menuType}&menuNm=${param.menuNm}&currentPage=${articlePage.startPage - 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<c:forEach var="pNo" begin="${articlePage.startPage}"
							end="${articlePage.endPage}">
							<a
								href="/frcs/couponList?eventType=${param.eventType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&dscntAmt=${param.dscntAmt}&menuType=${param.menuType}&menuNm=${param.menuNm}&currentPage=${pNo}"
								class="page-link 
						                    <c:if test="${pNo == articlePage.currentPage}">active</c:if>">
								${pNo} </a>
						</c:forEach>
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a
								href="/frcs/couponList?eventType=${param.eventType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&dscntAmt=${param.dscntAmt}&menuType=${param.menuType}&menuNm=${param.menuNm}&currentPage=${articlePage.startPage + 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<!-- pagination-wrap -->
</div>
<!-- table-wrap -->