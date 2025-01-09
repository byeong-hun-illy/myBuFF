<%--
 	@fileName    : selectMngrList
 	@programName : 사원 목록 조회
 	@description : 사원 정보 및 담당 업체 조회
 	@author      : 정기쁨
 	@date        : 2024. 09. 30
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="/resources/hdofc/css/mngr.css"/>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">

<sec:authentication property="principal.memberVO" var="user"/>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">사원 관리</h1>
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
				<!-- 담당지 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당자</p>
					<select class="select2-custom select-mngrId" name="mngrId" id="mngrId">
						<!-- selectMngrAjax() 출력 -->
					</select>
				</div>
				<!-- 담당 가맹점 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당 가맹점</p>
					<select class="select2-custom select-frcs" name="frcs" id="frcs">
						<!-- selectMngrAjax() 출력 -->
					</select>
				</div>
				<!-- 담당 가맹점 검색조건 -->
				<div class="search-cont">
					<p class="search-title">담당 거래처</p>
					<select class="select2-custom select-cnpt" name="cnpt" id="cnpt">
						<!-- selectMngrAjax() 출력 -->
					</select>
				</div>
				<!-- 재직여부 검색조건 -->
				<div class="search-cont">
					<p class="search-title">재직여부</p>
					<div class="select-custom" style="width:80px;">
						<select name="hdofYn" id="hdofYn">
							<option value="" selected>전체</option>
							<option value="Y">재직</option>
							<option value="N">퇴직</option>
						</select>
					</div>
				</div>
				<!-- 입사일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">입사일자</p>
					<div class="search-date-wrap">
						<input type="date" id="startJncmpYmd" name="startJncmpYmd"> 
							~ 
						<input type="date" id="endJncmpYmd" name="endJncmpYmd">
					</div>
				</div>
				<!-- 관리자유형 검색조건 -->
				<div class="search-cont">
					<p class="search-title">관리자 유형</p>
					<div class="select-custom" style="width:200px;">
						<select name="mngrType" id="mngrType">
							<option value=""<option selected>전체</option>>전체</option>
							<option value="HM01">일반관리자</option>
							<option value="HM02">최상위관리자</option>
						</select>
					</div>
				</div>
				<!-- 승인여부 검색조건 -->
				<div class="search-cont">
					<p class="search-title">승인 여부</p>
					<div class="select-custom" style="width:200px;">
						<select name="approvedType" id="approvedType">
							<option value=""<option selected>전체</option>>전체</option>
							<option value="yes">승인</option>
							<option value="no">미승인</option>
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
				<div class="search-cont">
					<p class="search-title">담당자 <span class="summary" id="mngrIdSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">담당 가맹점 <span class="summary" id="frcsSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">담당 거래처 <span class="summary" id="cnptSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">재직여부 <span class="summary" id="hdofYnSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">입사일자 <span class="summary" id="jncmpYmdSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">관리자 유형 <span class="summary" id="mngrNmSummary"></span></p>
				</div>
				<div class="divide-border"></div>
				<div class="search-cont">
					<p class="search-title">승인 여부 <span class="summary" id="approvedSummary"></span></p>
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
					<div class="tap-cont active" data-approved="">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all"><!-- selectMngrAjax()로 출력 --></span>
					</div>
					<div class="tap-cont" data-approved="no">
						<span class="tap-title">미승인</span>
						<span class="bge bge-danger" id="tap-approved"><!-- selectMngrAjax()로 출력 --></span>
					</div>
					<div class="tap-cont" data-approved="yes">
						<span class="tap-title">승인</span>
						<span class="bge bge-warning" id="tap-no-approved"><!-- selectMngrAjax()로 출력 --></span>
					</div>
				</div>
				<div class="btn-wrap">
					<button class="btn-active" id="approvedBtn">승인<span class="icon material-symbols-outlined">East</span></button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="right" style="width: 100px">
							<!-- 전체 선택 -->
							<input type="checkbox" class="check-btn all" id="chkBox" name="chkBox" value="" />
				     	<label for="chkBox"><span></span></label>
						</th>
						<th class="center" style="width: 100px">번호</th>
						<th class="center" style="width: 100px">담당자명</th>
						<th class="center" style="width: 150px">아이디</th>
						<th class="left" style="width: 300px;">담당 가맹점</th>
						<th class="left" style="width: 300px;">담당 거래처</th>
						<th class="center" style="width: 100px">재직여부</th>
						<th class="center sort active" data-sort="jncmpYmdSort" style="width: 100px">
							입사일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc active">▼</span>
								</div>
							</div>
						</th>
						<th class="center sort" data-sort="mngrTypeSort" style="width: 200px">
							관리자 유형
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
						</th>
					</tr>
				</thead>
				<tbody id="table-body" class="mngrList-table table-error">
					<!-- selectMngrAjax()로 출력 될 영역  -->
				</tbody>
			</table>
			<div class="pagination-wrap">
				<div class="pagination">
					<!-- selectMngrAjax()를 통해 나타날 영역 -->
				</div>
			</div>
		</div>
	</div>
	<!-- /.cont: 공지사항 목록 -->
	
</div>
<!-- /.wrap -->


<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/hdofc/js/mngr.js"></script>

