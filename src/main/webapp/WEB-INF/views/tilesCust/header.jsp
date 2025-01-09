<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="/resources/com/js/nav.js"></script>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<style>
/* 셀렉트 디자인 */
#navSearch.select2-custom + .select2-container--default .select2-selection--single { /* navSearch에만 적용 */ /*화살표 기본 css 없애기*/
	/* 화살표 커스텀 */
  	background: url(/resources/images/common/search.png) no-repeat 97% 50% !important;
  	background-size: 20px 20px !important;
  	width: 400px; /* width 값 400px로 설정 */
}
</style>
<script>
let navType = 'ALL'
	$(function(){
		select2Custom();
		getNavOption();
		
		$('#navSearch').on('change', function(){
			location.href = $('#navSearch').val();
		})
	})

</script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="user"/>
</sec:authorize>

<nav class="header">

	<div class="header-wrap top">
		<!-- 로고 -->
		<div class="header-cont logo" onclick="window.location.href='/buff/home'" style="cursor:pointer;">
			<img alt="로고이미지" src="/resources/images/common/logo.png" class="logo-img">
			<div class="logo-title">Buff</div>
		</div>
		<!-- 사용자 -->
		<div class="header-cont">
	        <ul class="top-quick">
	        	<!-- 로그인 전 -->
	        	<sec:authorize access="!isAuthenticated()">
	            <li class="menu-item">
	               <span class="login-info">로그인 후 이용해주세요!</span> <a href="/login" class="login-user">로그인</a>
	            </li>
	            </sec:authorize>
	        	<!-- 로그인 후 -->
				<sec:authorize access="isAuthenticated()">
		            <li class="menu-item">
		                반갑습니다! <a href="/custPage/selectMyPage" class="login-user">${user.mbrNm}</a>님
		            </li>
		            <li class="menu-item login-cont">
			            <sec:authorize access="!hasRole('ROLE_FRCS') && !hasRole('ROLE_CNPT') && !hasRole('ROLE_HDOFC')">
			                <form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm">
			                	<span onclick="logoutSubmit()" class="logout">로그아웃</span>
				        		<sec:csrfInput/>
			          		</form>
			            </sec:authorize>
			            <sec:authorize access="hasRole('ROLE_FRCS')">
			                <a href="/frcs/main" class="mode-change color">파트너 모드</a>
			            	<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm">
			                	<span onclick="logoutSubmit()" class="logout">로그아웃</span>
				        		<sec:csrfInput/>
			          		</form>
			            </sec:authorize>
			            <sec:authorize access="hasRole('ROLE_CNPT')">
			                <a href="/cnpt/main" class="mode-change color">파트너 모드</a>
			            	<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm">
			                	<span onclick="logoutSubmit()" class="logout">로그아웃</span>
				        		<sec:csrfInput/>
			          		</form>
			            </sec:authorize>
			            <sec:authorize access="hasRole('ROLE_HDOFC')">
			                <a href="/hdofc/main" class="mode-change color">파트너 모드</a>
			            	<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm">
			                	<span onclick="logoutSubmit()" class="logout">로그아웃</span>
				        		<sec:csrfInput/>
			          		</form>
			            </sec:authorize>
		            </li>
				</sec:authorize>
	        </ul>
		</div>
	</div>
		
	<div class="header-wrap bom">
		<!-- 메뉴 -->
		<ul class="header-cont category">
			<li><a href="/cust/ordr/regist" class="nav-menu">메뉴 주문</a></li>
			<li><a href="/buff/selectMenu" class="nav-menu">메뉴 소개</a></li>
			<li><a href="/buff/selectStore" class="nav-menu">매장 소개</a></li>
			<li><a href="/buff/selectEvent" class="nav-menu">이벤트</a></li>
			<li><a href="/buff/insertDscsn" class="nav-menu">가맹점 문의</a></li>
		</ul>
		<!-- 마이 페이지 -->
		<div class="header-cont">
	        <div class="bom-quick">
	            <div class="menu-item">
	                <div class="search-input-btn">
	                	<select class="select2-custom" id="navSearch">
							<option value="">검색어를 입력해주세요</option>
						</select>
<!-- 						<button type="submit" class="search-btn"></button>				 -->
<!-- 						<input type="text" placeholder="검색어를 입력해주세요" class="search-input"> -->
					</div>
	            </div>
	            <div class="menu-item">
	                <a href="/center/selectBoard"><span class="quick-icon2 material-symbols-outlined">support_agent</span></a>
	            </div>
	        </div>
		</div>
	</div>
</nav>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/resources/cust/js/custHeader.js"></script>



