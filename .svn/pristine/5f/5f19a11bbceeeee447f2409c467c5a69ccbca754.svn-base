<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/global/layout.css" />
<script src="/resources/com/js/nav.js"></script>
<style>
/* 셀렉트 디자인 */
#navSearch.select2-custom + .select2-container--default .select2-selection--single { /* navSearch에만 적용 */ /*화살표 기본 css 없애기*/
	/* 화살표 커스텀 */
  	background: url(/resources/images/common/search.png) no-repeat 97% 50% !important;
  	background-size: 20px 20px !important;
  	width: 500px; /* width 값 500px로 설정 */
}
</style>
<script>
let navType = ''
function logoutSubmit() {
  document.getElementById('logoutForm').submit();
}
$(function(){
	select2Custom();
	
	<sec:authorize access="hasRole('ROLE_HDOFC')">
	navType = "HDOFC";
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_CNPT')">
	navType = "CNPT";
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_FRCS')">
	navType = "FRCS";
	</sec:authorize>
	
	getNavOption();
	
	$('#navSearch').on('change', function(){
		location.href = $('#navSearch').val();
	})
})
</script>
<%--
 	@programName : 헤더 화면
 	@description : 권한 시큐리티를 통해 권한에 따라 헤더를 다르게 보여준다.
 	@author      : 정기쁨
 	@date        : 2024. 09. 13
--%>
<nav class="main-header navbar navbar-expand navbar-white navbar-light justify-content-between">
	<!-- Left navbar links -->
	<ul class="navbar-nav align-items-center">
		<li class="nav-item"><a class="nav-link mt-2" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a></li>
		<li>
			<div class="search-cont">
				<div class="search-input-btn">
<!-- 					<span type="submit" class="search-btn"></span>				 -->
<!-- 					<input type="text" placeholder="검색어를 입력해주세요" class="search-input"/> -->
						<select class="select2-custom" id="navSearch">
							<option value="">검색어를 입력해주세요</option>
						</select>
				</div>
			</div>
		</li>
	</ul>
		
		<!-- Right navbar links -->
		<ul class="navbar-nav navbar-nav-right">
			<sec:authorize access="isAuthenticated()">
			<li>
				<div class="user-info">
					<sec:authentication property="principal.memberVO" var="user"/>
					<div class="user-name">${user.mbrNm}</div>
				</div>
			</li>
			</sec:authorize>
			<li>
				<span class="icon material-symbols-outlined" onclick="window.location.href='/buff/home'">autorenew</span>
			</li>
			<li>
				<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm">
					<span class="icon material-symbols-outlined" onclick="logoutSubmit()">logout</span>
	        		<sec:csrfInput/>
          		</form>
			</li>
		</ul>
</nav>



