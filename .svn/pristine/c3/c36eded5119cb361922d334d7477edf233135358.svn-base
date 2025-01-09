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
	@fileName    : selectMemberDetail.jsp
	@programName : 회원관리 상세 화면
	@description : 회원관리 상세 화면
	@author      : 김 현 빈
	@date        : 2024. 10. 10
--%>

<script type="text/javascript">
$(document).ready(function() {
	//목록으로 버튼 클릭 시 selectMemberList 페이지로 이동
	$("#backToListBtn").on("click", function() {
		// 공지사항 목록으로 복귀
		window.location.href = "/hdofc/member/selectMemberList";  // 목록 페이지로 이동
	});
});
</script>

<style>
/* 테이블 기본 스타일 */
.mbr-info {
    width: 100%;
    border-collapse: collapse;
}
.mbr-info tr th {
    width: 10%; 
}
.mbr-info tr td {
    width: 40%; 
}
</style>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 align-items-center">
			<button type="button" class="btn btn-default mr-3" id="backToListBtn">
				<span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로
			</button>
			<h1 class="m-0">회원 관리</h1>
		</div><!-- /.row -->
	</div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title">
					<span class="material-symbols-outlined title-icon">person</span>
					회원 정보
				</div>
			</div>
			<table class="table-blue mbr-info">
				<tbody>
				<tr>
					<th>회원명</th>
					<td>${memberVO.mbrNm} (${memberVO.mbrId})</td>
					<th>가입일자</th>
					<td>${fn:substring(memberVO.joinYmd, 0, 4)}-${fn:substring(memberVO.joinYmd, 4, 6)}-${fn:substring(memberVO.joinYmd, 6, 8)}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${fn:substring(memberVO.mbrBrdt, 0, 4)}-${fn:substring(memberVO.mbrBrdt, 4, 6)}-${fn:substring(memberVO.mbrBrdt, 6, 8)}</td>
					<th>전화번호</th>
					<td>${fn:substring(memberVO.mbrTelno, 0, 3)}-${fn:substring(memberVO.mbrTelno, 3, 7)}-${fn:substring(memberVO.mbrTelno, 7, 11)}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${memberVO.mbrEmlAddr}</td>
					<th>탈퇴여부</th>
					<td>
						<c:choose>
							<c:when test="${memberVO.delYn == 'N'}">
								<span class="bge bge-active">가입</span>
							</c:when>
							<c:when test="${memberVO.delYn == 'Y'}">
								<span class="bge bge-danger">탈퇴</span>
							</c:when>
							<c:otherwise>
								<span class="bge">미확인</span> <!-- 예외 처리용 (optional) -->
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">${memberVO.mbrZip}, ${memberVO.mbrAddr} ${memberVO.mbrDaddr}</td>
				</tr>
			</tbody></table>
		</div>
		<!-- table-wrap -->
	</div>
</div>