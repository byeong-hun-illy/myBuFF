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
				<div class="btn-wrap modifing" style="display:none;">
					<button type="button" class="btn-default cancle-btn">취소</button>
					<button type="button" class="btn-active save-btn">저장 <span class="icon material-symbols-outlined">East</span></button>
				</div>
				<div class="btn-wrap modify">
					<button type="button" class="btn-default">수정</button>
				</div>
			</div>
			<table class="table-blue mngr-info">
				<tbody>
					<tr>
						<th>담당자명</th>
						<td>${mngrVO.memberVO.mbrNm} (${mngrVO.mngrId})</td>
						<th>관리자 유형</th>
						<td>
							<span class="bge bge-active">
								<c:if test="${mngrVO.mngrType == 'HM01'}">일반관리자</c:if>
								<c:if test="${mngrVO.mngrType == 'HM02'}">최상위관리자</c:if>
							</span>
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
							<div class="tel-wrap">
								<input id="mbrTelno1" type="text" class="input-tel" value="${fn:substring(mngrVO.memberVO.mbrTelno, 0, 3)}" disabled="disabled">-
								<input id="mbrTelno2" type="text" class="input-tel" value="${fn:substring(mngrVO.memberVO.mbrTelno, 3, 7)}" disabled="disabled">-
								<input id="mbrTelno3" type="text" class="input-tel" value="${fn:substring(mngrVO.memberVO.mbrTelno, 7, 12)}" disabled="disabled">
							</div>
						</td>
						<th>이메일</th>
						<td>${mngrVO.memberVO.mbrEmlAddr}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
							<div class="addr-zip-wrap">
								<div class="addr-wrap">
									<input id="bzentZip" class="input-zip" disabled="disabled" type="text" value="${mngrVO.memberVO.mbrZip}" disabled="disabled">
									<button class="btn-default btn-disabled" style="height:44px;" id="openHomeSearch" type="button">우편번호 검색</button>
								</div>
								<div class="addr-wrap">
									<input id="bzentAddr" class="input-addr" disabled="disabled" type="text" value="${mngrVO.memberVO.mbrAddr}" disabled="disabled">
									<input id="bzentDaddr" placeholder="상세주소" class="input-addr" type="text" value="${mngrVO.memberVO.mbrDaddr}" disabled="disabled">
								</div>
							</div>
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
					<button type="button" class="btn-danger">삭제</button>
					<button type="button" class="btn-active">추가</button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
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
				                <td class="error-info" colspan="5">
				                    <span class="icon material-symbols-outlined">error</span>
				                    <div class="error-msg">검색 결과가 없습니다</div>
				                </td>
				            </tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="bzent" items="${bzentList}" varStatus="idx">
							<c:choose>
								<c:when test="${bzent.bzentType == 'BZ_F01'}">
									<tr onclick="window.location='/hdofc/frcs/list/dtl?frcsNo=${bzent.bzentNo}'">
										<td class="center">${idx.count}</td>
										<td  class="left">${bzent.bzentNm}</td>
										<td class="left">${bzent.bzentAddr} ${bzent.bzentDaddr}</td>
										<td class="center">${bzent.memberVO.mbrNm}</td>
										<td class="center"><span class="bge bge-info">가맹점</span></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr onclick="window.location='/hdofc/cnpt/dtl?bzentNo=${bzent.bzentNo}'">
										<td class="center">${idx.count}</td>
											<td  class="left">${bzent.bzentNm}</td>
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/hdofc/js/mngrDtl.js"></script>
<script src='/resources/js/global/value.js'></script>






