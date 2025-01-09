<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%-- <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="user"/>
</sec:authorize> --%>

<nav class="header">

	<div class="header-wrap login">
		<!-- 로고 -->
		<div class="header-cont logo" onclick="window.location.href='/buff/home'" style="cursor:pointer;">
			<img alt="로고이미지" src="/resources/images/common/logo.png" class="logo-img">
			<div class="logo-title">Buff</div>
		</div>
		
		<!-- 메뉴 -->
		<ul class="header-cont category login">
			<li>
				<a href="/buff/selectMenu" class="nav-menu login">
					<span class="material-symbols-outlined">lunch_dining</span> 메뉴 소개
				</a>
			</li>
			<li>
				<a href="/buff/selectStore" class="nav-menu login">
					<span class="material-symbols-outlined">location_on</span> 매장 소개
				</a>
			</li>
			<li>
				<a href="/center/selectBoard" class="nav-menu login">
					<span class="material-symbols-outlined">support_agent</span> 고객센터
				</a>
			</li>
		</ul>
		
	</div>
</nav>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/resources/cust/js/custHeader.js"></script>



