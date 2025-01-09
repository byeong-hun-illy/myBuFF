<!-- 
	고객페이지에 권한이없는 사람이 접근한 경우
 -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/global/error.css">
<sec:authentication property="principal.MemberVO" var="user"/>
<div class="wrap">
	<div class="error-wrap">
		<div class="error-icon">
			<span class="material-symbols-outlined">warning</span>
		</div>
		<div class="error-cont">
			<div class="error-title">요청한 기능을 실행할 수 있는 권한이 없습니다.</div>
			<div class="error-cn">
			</div>
			
			<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm" class="admin">
				<button class="btn-active" type="button" onclick="location.href='/buff/home'">고객페이지 <span class="material-symbols-outlined icon">east</span></button>
				<button type="submit" class="btn btn-default">로그아웃</button>
			     		<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>

