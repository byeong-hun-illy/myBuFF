<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="/resources/js/jquery-3.6.0.js"></script>

<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<%--
	@fileName    : frcsPoDetauk.jsp
	@programName : 가맹점 발주 내역 상세 화면
	@description : 가맹점의 발주 내역 상세 보기 화면
	@author      : 김 현 빈
	@date        : 2024. 09. 25
--%>

<script type="text/javascript">
function goBackToList() {
    // 현재 URL에서 쿼리 파라미터를 가져옴
    const queryString = window.location.search;

    // 발주 관리 페이지 경로에 쿼리 파라미터를 추가하여 이동
    window.location.href = "/frcs/frcsPoList" + queryString;
}
</script>

<style>
.event-menu-table tbody {
	display: block; /* 가로세로 조절 가능 */
	max-height: 461px; /* 보여주고 싶은 만큼 세로값 입력 */
	overflow-y: scroll; /* 스크롤 만듦 */
}
.event-menu-table thead, 
.event-menu-table tbody tr {
	display: table;
	width: 100%; 
}
</style>

<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="goBackToList()">
	      		<span class="icon material-symbols-outlined">keyboard_backspace</span> 
	      		목록으로
	      	</button>
	        <h1 class="m-0">발주 상세</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-active" id="submitBtn">수정</button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="cont">
		<div class="table-wrap">
			<table class="table-default event-menu-table">
				<thead>
					<tr>
						<th class="center">발주 순서</th>
			            <th class="center">상품 유형</th>
			            <th class="center">상품 명</th>
			            <th class="center">상품 수량</th>
			            <th class="center">상품 가격</th>
			            <th class="center">상품 총 가격</th>
			            <th class="center">상품 단위</th>
			            <th class="center">배송 일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gdsVO" items="${gdsVOList}">
						<tr>
							<td class="center">${gdsVO.rnum}</td>
			                <c:forEach var="comVO" items="${gd}">
			                	<c:if test="${comVO.comNo eq gdsVO.gdsType}">
			                		<td class="center">${comVO.comNm}</td>
			                	</c:if>
			                </c:forEach>
			                <td class="center">${gdsVO.gdsNm}</td>
			                <td class="center">${gdsVO.stockVOList[0].stockPoVOList[0].qty}</td>
			                <td class="center">${gdsVO.stockVOList[0].stockPoVOList[0].gdsAmt}</td>
			                <td class="center"><c:out value="${gdsVO.stockVOList[0].stockPoVOList[0].qty * gdsVO.stockVOList[0].stockPoVOList[0].gdsAmt}"/></td>
			                <td class="center">${gdsVO.unitNm}</td>
			                <td class="center">
			                    <fmt:parseDate var="parsedDate" value="${gdsVO.stockVOList[0].stockPoVOList[0].spmtYmd}" pattern="yyyyMMdd" />
			                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
			                </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
</div>