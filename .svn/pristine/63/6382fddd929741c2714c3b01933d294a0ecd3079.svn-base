<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="/resources/js/jquery-3.6.0.js"></script>

<!-- 
로그인 안했을 때 principal.MemberVO 에서 오류 발생
 -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<%--
	@fileName    : selectStockAjmtList.jsp
	@programName : 판매 상품 소모량 전체 리스트 조회 화면
	@description : 판매 상품 소모량 전체 리스트 조회 화면
	@author      : 김 현 빈
	@date        : 2024. 10. 04
--%>

<script type="text/javascript">

</script>

<div class="wrap">
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">진행상태</p>
					<div class="select-custom" style="width:150px">
						<select name="eventType" id="eventType">
							<option value="">전체</option>
							<option value="EVT01" selected="">대기</option>
							<option value="EVT04">진행</option>
							<option value="EVT03">예정</option>
							<option value="EVT05">완료</option>
							<option value="EVT02">취소</option>
						</select>
					</div>
				</div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd"> 
							~ 
						<input type="date" id="expYmd" name="expYmd">
					</div>
				</div>
				<!-- 텍스트 검색조건 -->
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
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간 <span class="summary" id="dateSummary">이벤트기간</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">쿠폰 <span class="summary" id="couponSummary">쿠폰</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목 <span class="summary" id="ttlSummary">제목</span></p>
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
		<!-- /.search-section: 검색어 영역 -->
	</div>

	<div class="cont">
		<div class="cont-title">진행탭 예시</div> 
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-wrap">
				<div data-type="" class="tap-cont">
					<span class="tap-title">전체</span>
					<span class="bge bge-default" id="tap-all">1021</span>
				</div>
				<div data-type="EVT01" class="tap-cont active">
					<span class="tap-title">대기</span>
					<span class="bge bge-info" id="tap-waiting">1021</span>
				</div>
				<div data-type="EVT04" class="tap-cont">
					<span class="tap-title">진행</span>
					<span class="bge bge-active" id="tap-progress">1021</span>
				</div>
				<div data-type="EVT03" class="tap-cont">
					<span class="tap-title">예정</span>
					<span class="bge bge-warning" id="tap-scheduled">1021</span>
				</div>
				<div data-type="EVT05" class="tap-cont">
					<span class="tap-title">완료</span>
					<span class="bge bge-danger" id="tap-completed">1021</span>
				</div>
				<div data-type="EVT02" class="tap-cont">
					<span class="tap-title">취소</span>
					<span class="bge bge-danger" id="tap-cancelled">1021</span>
				</div>
			</div>
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">상품 이름</th>
						<th class="center">소모 수량</th>
						<th class="center">단위</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gdsVOList" items="${articlePage.content}" varStatus="stat">
						<tr>
							<td class="center">${gdsVOList.rnum}</td>
							<td class="center">${gdsVOList.gdsNm}</td>
							<td class="center">${gdsVOList.stockVOList[0].stockAjmtVOList[0].qty}</td>
							<td class="center">${gdsVOList.unitNm}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- pagination-wrap -->
			<c:if test="${not empty articlePage.content}">
				<div class="pagination-wrap">
					<div class="pagination">
						<c:if test="${articlePage.startPage gt 5}">
							<a href="/hdofc/stockAjmt/selectStockAjmtList?currentPage=${articlePage.startPage-5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<!-- 선택한 페이지만 class="active"가 설정되게 한다 -->
						<c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
							<a href="/hdofc/stockAjmt/selectStockAjmtList?currentPage=${pNo}" class="page-link 
		        				<c:if test="${pNo == articlePage.currentPage}">active</c:if>">
		        				${pNo}
		    				</a>
						</c:forEach>
						<!-- endPage < totalPages일때만 [다음] 활성 -->
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a href="/hdofc/stockAjmt/selectStockAjmtList?currentPage=${articlePage.startPage+5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<!-- pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
</div>

