<%--
 	@fileName    : selectMenu.jsp
 	@programName : 본사 메뉴 조회
 	@description : 본사의 세트, 사이드, 햄버거 조회가 가능
 	@author      : 서윤정
 	@date        : 2024. 09. 11
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<link href="/resources/cust/css/selectMenu.css" rel="stylesheet">


<%!
	//20230101
	public boolean isNewMenu(String regDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			Date registrationDate = sdf.parse(regDate);
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -30); // 현재 날짜에서 30일 전으로 설정
			Date thirtyDaysAgo = cal.getTime();
			return registrationDate.after(thirtyDaysAgo); // 등록일이 30일 이내인지 확인
		} catch (Exception e) {
			return false; // 오류 발생 시 false 리턴
		}
	}
%>
<script>
$(function(){

    $('.tap-select').on('click', function() {
    	 $('.tap-select').removeClass('active');
    	 $(this).addClass('active');
    	let menuGubun = $(this).data('value');

        // 페이지 리디렉션
        window.location.href = '/buff/selectMenu?menuGubun=' + menuGubun;
    }); // .tap-select 끝
    
    
});
</script>


<div class="wrap menu-wrap">
	
	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">메뉴 소개</div>
		<!-- /.wrap-title -->
		
		<!-- 탭 영역 -->
		<div class="menu-tap">
			<div class="tap-select tap-set ${menuGubun == 'MENU01' ? 'active' : ''}" data-value="MENU01">
				<div class="tap-icon">
					<span class="material-symbols-outlined">fastfood</span>
				</div> 
				<div class="tap-nm">세트</div>
			</div>
			<div class="tap-select tap-set ${menuGubun == 'MENU02' ? 'active' : ''}" data-value="MENU02">
				<div class="tap-icon">
					<span class="material-symbols-outlined">lunch_dining</span>
				</div> 
				<div class="tap-nm">햄버거</div>
			</div>
			<div class="tap-select tap-set ${menuGubun == 'MENU03' ? 'active' : ''}" data-value="MENU03">
				<div class="tap-icon">
					<span class="material-symbols-outlined">icecream</span>
				</div> 
				<div class="tap-nm">사이드</div>
			</div>
			<div class="tap-select tap-set ${menuGubun == 'MENU04' ? 'active' : ''}" data-value="MENU04">
				<div class="tap-icon">
					<span class="material-symbols-outlined">local_cafe</span>
				</div> 
				<div class="tap-nm">음료</div>
			</div>
		</div>
		<!-- /.tap-wrap -->
				
		<!-- 메뉴 영역 -->
	 	<div class="menu-list">
	 		<ul class="list-box">
	 		<c:forEach var="menuVO" items="${menuVOList}">
				<li class="newBox">
					<c:set var="registrationDate" value="${menuVO.rlsYmd}" />
					
					<c:set var="isNewMenu" value="false" /> 
					<div class="img-box">
				    	<span style="background-image: url('${menuVO.menuImgPath}')"></span>
					</div>
					<div id="newBge">
						<%
							String regDate = (String) pageContext.getAttribute("registrationDate");  
							if (isNewMenu(regDate)) {
						%> 
						<span>NEW</span> 
						<%
							}
						%>
					</div>
	               	<div class="list-txt">
	               		${menuVO.menuNm}
	            	</div>
	            	
	               	<div class="list-price">
						<p><fmt:formatNumber value="${menuVO.menuAmt}" pattern="#,###" /><em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			${menuVO.menuExpln}
	        		</div>
	        	</li>
	        	</c:forEach>
	        </ul>
	 	</div>
	 	<!-- /.menu-list -->
		
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>










