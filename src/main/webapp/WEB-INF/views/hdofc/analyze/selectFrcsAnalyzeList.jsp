<%--
	@fileName    : selectFrcsAnalyzeList.jsp
	@programName : 가맹점 별 매출 분석 리스트 조회 화면
	@description : 가맹점 별 매출 분석 리스트 조회 화면
	@author      : 정 기 쁨
	@date        : 2024. 10. 10
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/hdofc/css/analyze.css">
<link rel="stylesheet" href="/resources/css/global/common.css">

<!-- 
로그인 안했을 때 principal.MemberVO 에서 오류 발생
 -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>


<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<h1 class="m-0">가맹점 매출 분석</h1>
			</div>
		</div><!-- /.row -->
	</div><!-- /.container-fluid -->
</div>

<div class="wrap">
		
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				
				<!-- 지역 검색조건 -->
				<div class="search-cont">
					<p class="search-title">대분류</p>
					<select class="select2-custom" name="rgnNo" id="rgnNo">
						<option value="">지역을 선택해주세요</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
				
				<!-- 가맹점 검색조건 -->
				<div class="search-cont">
					<p class="search-title">중분류</p>
					<select class="select2-custom" name="bzentNo" id="bzentNo">
						<!-- 가맹점 리스트 ajax 될 영역 -->
					</select> 
				</div>
				
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">분석 기간</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd" value="${param.bgngYmd}"> 
							~ 
						<input type="date" id="expYmd" name="expYmd" value="${param.expYmd}">
					</div>
				</div>
				
				<!-- 지역 검색조건 -->
				<div class="search-cont">
					<p class="search-title">기간 선택</p>
					<div>
						<button class="btn-default date">일간</button>
						<button class="btn-default date">월간</button>
						<button class="btn-default date">연간</button>
					</div>
				</div>
				
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">지역 <span class="summary" id="rgnNoSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">가맹점 <span class="summary" id="bzentNoSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">분석 기간 <span class="summary" id="dateSummary">전체</span></p>
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
	
	<div class="chart-wrap">
		<div class="cont chart">
			<div id="chartTitle" class="cont-title">
		        <span class="material-symbols-outlined title-icon">bar_chart</span><p id="month-text">가맹점 매출 현황</p>
		    </div>
			<canvas id="myChart"></canvas>
		</div>
	
		<div class="cont table">
			<!-- table-wrap -->
			<div class="table-wrap">
				<div class="tap-wrap">
					<div data-type="" class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all"></span>
					</div>
				</div>
				<table class="table-default">
					<thead>
						<tr>
							<th class="center">번호</th>
							<th class="center">지역</th>
							<th class="center">가맹점명</th>
							<th class="center sort active" data-sort="salesSum">매출 금액
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc active">▼</span>
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
					<!-- 페이징 처리 될 영역 -->
					</div>
				</div>
			</div>
			<!-- table-wrap -->
		</div>
	</div>	
</div>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="/resources/hdofc/js/analyze.js"></script>
















