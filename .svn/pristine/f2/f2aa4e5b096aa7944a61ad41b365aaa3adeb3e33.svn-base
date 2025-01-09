<%--
 	@fileName    : selectMngrDtl
 	@programName : 사원 상세
 	@description : 사원 정보 조회, 사원담당업체 조회 및 설정
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
<c:set var="mngrVO" value="${mngrMap.mngrVO}" />
<c:set var="bzentList" value="${mngrMap.bzentList}" />

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="window.location='/hdofc/mngr/selectMngrList'">
      		<span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로
    	</button>
        <h1 class="m-0">사원 관리</h1>
      	</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>

<!-- wrap -->
<div class="wrap">
	
	<!-- cont: 사원 정보 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>사원 정보</div>
			</div>
			<table class="table-blue mngr-info">
				<tbody>
					<tr>
						<th>담당자명</th>
						<td>${mngrVO.memberVO.mbrNm} (<span class="mngrId">${mngrVO.mngrId}</span>)</td>
						<th>관리자 유형</th>
						<td>
							<c:if test="${mngrVO.mngrType == 'HM01'}">
								<span class="bge bge-active">일반관리자</span>
							</c:if>
							<c:if test="${mngrVO.mngrType == 'HM02'}">
								<span class="bge bge-info">최상위관리자</span>
							</c:if>
							<c:if test="${mngrVO.mngrType == ''}">
								<span class="bge bge-danger">미승인</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>입사 일자</th>
						<td>${fn:substring(mngrVO.jncmpYmd, 0, 4)}-${fn:substring(mngrVO.jncmpYmd, 4, 6)}-${fn:substring(mngrVO.jncmpYmd, 6, 8)}</td>
						<th>퇴직 일자</th>
						<td>
							<c:if test="${mngrVO.rtrmYmd != null}">
							    ${fn:substring(mngrVO.rtrmYmd, 0, 4)}-${fn:substring(mngrVO.rtrmYmd, 4, 6)}-${fn:substring(mngrVO.rtrmYmd, 6, 8)}
							</c:if>
							<c:if test="${mngrVO.rtrmYmd == null}">
							    -
							</c:if>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							${fn:substring(mngrVO.memberVO.mbrTelno, 0, 3)}-${fn:substring(mngrVO.memberVO.mbrTelno, 3, 7)}-${fn:substring(mngrVO.memberVO.mbrTelno, 7, 12)}
						</td>
						<th>이메일</th>
						<td>${mngrVO.memberVO.mbrEmlAddr}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
							${mngrVO.memberVO.mbrZip}, ${mngrVO.memberVO.mbrAddr} ${mngrVO.memberVO.mbrDaddr}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont: 사원 정보 -->
	
	<!-- cont: 공지사항 목록 -->
	<div class="cont">
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>담당 업체</div>
				<div class="btn-wrap">
					<button type="button" class="btn-danger bzent-delete">삭제</button>
					<button type="button" class="btn-active bzent-insert">추가</button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="right" style="width: 50px">
							<!-- 전체 선택 -->
							<input type="checkbox" class="check-btn all" id="chkBox" name="chkBox" value="" />
						   	<label for="chkBox"><span></span></label>
						</th>
						<th class="center" style="width: 100px">번호</th>
						<th class="left" style="width: 100px">업체명</th>
						<th class="left" style="width: 200px">업체 주소</th>
						<th class="center" style="width: 200px">담당자명</th>
						<th class="center" style="width: 200px">업체유형</th>
					</tr>
				</thead>
				<tbody id="table-body" class="table-error">
					<c:choose>
						<c:when test="${empty bzentList}">
							<tr>
				                <td class="error-info" colspan="6">
				                    <span class="icon material-symbols-outlined">error</span>
				                    <div class="error-msg">검색 결과가 없습니다</div>
				                </td>
				            </tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="bzent" items="${bzentList}" varStatus="idx">
							<c:choose>
								<c:when test="${bzent.bzentType == 'BZ_F01'}">
									<tr>
										<td class="right">
											<input type="checkbox" class="check-btn" id="chkBox${idx.count}" name="chkBox${idx.count}" value="${bzent.bzentNo}" />
								     		<label for="chkBox${idx.count}"><span></span></label>
										</td>
										<td class="center">${idx.count}</td>
										<td  class="left">
								        	<a href="/hdofc/frcs/list/dtl?frcsNo=${bzent.bzentNo}">${bzent.bzentNm}</a>
										</td>
										<td class="left">${bzent.bzentAddr} ${bzent.bzentDaddr}</td>
										<td class="center">${bzent.memberVO.mbrNm}</td>
										<td class="center"><span class="bge bge-info">가맹점</span></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td class="right">
											<input type="checkbox" class="check-btn" id="chkBox${idx.count}" name="chkBox${idx.count}" value="${bzent.bzentNo}" />
								     		<label for="chkBox${idx.count}"><span></span></label>
										</td>
										<td class="center">${idx.count}</td>
										<td  class="left">
											<a href="/hdofc/cnpt/dtl?bzentNo=${bzent.bzentNo}">${bzent.bzentNm}</a>
										</td>
										<td class="left">${bzent.bzentAddr} ${bzent.bzentDaddr}</td>
										<td class="center">${bzent.memberVO.mbrNm}</td>
										<td class="center"><span class="bge bge-warning">거래처</span></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<!-- /.cont: 공지사항 목록 -->
	
</div>
<!-- /.wrap -->

<!-- 관리자 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/bzentListModal.jsp" />

<!-- js 모음 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/hdofc/js/mngrDtl.js"></script>
<script src='/resources/js/global/value.js'></script>
