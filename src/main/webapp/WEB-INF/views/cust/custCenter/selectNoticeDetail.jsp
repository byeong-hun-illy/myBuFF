<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%--
 	@fileName    : selectNoticeDetail.jsp
 	@programName : 공지사항 상세 조회
 	@description : 사용자가  공지사항 항목을 상세 조회하는 화면
 	@author      : 서윤정
 	@date        : 2024. 09. 18
--%>



<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<link href="/resources/cust/css/selectEventDtl.css" rel="stylesheet">


<style>
.notice-cont {
    background: whitesmoke;
    padding: 50px;
    border-radius: 12px;
    line-height: 34px;
    display: flex;
    flex-direction: column;
    gap: var(--gap--s);
}

</style>

<div class="wrap menu-wrap">
	
	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="eventDtl-title">
			<span class="icon-backspace material-symbols-outlined" onclick="window.location.href='/center/selectBoard'">keyboard_backspace</span>
			<div class="event-nm">${noticeVO.ntcTtl}</div>
			<div class="event-date">${noticeVO.wrtrDt}</div>
		</div>
		<!-- /.wrap-title -->
						
		<!-- 메뉴 영역 -->
	 	<div class="eventDtl-content">
	 		<div class="content-cont notice-cont">
	 			<p>${noticeVO.ntcCn}</p>
	 		</div>
	 	</div>
	 	<!-- /.event-content -->
	 	
	 	<div class="view-more">
	 		<div class="more-btn" onclick="window.location.href='/center/selectBoard'">
       			<span class="material-symbols-outlined">add</span>목록으로
       		</div>
		</div>
		<!-- /.view-more -->
		
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>











