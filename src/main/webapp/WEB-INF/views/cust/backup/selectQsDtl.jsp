<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<link href="/resources/cust/css/selectQsDtl.css" rel="stylesheet">

<div class="wrap menu-wrap">
	
	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="qsDtl-title">
			<span class="icon-backspace material-symbols-outlined" onclick="window.location.href='/backup/selectEvent'">keyboard_backspace</span>
			<div class="qs-ttl">	단체 주문이 가능하나요?</div>
			<div class="qs-info">
				<div class="qs-type">
					<span class="bge bge-warning">구매</span>
				</div>
				<div class="qs-date">2024-11-01</div>
			</div>
		</div>
		<!-- /.wrap-title -->
						
		<!-- 문의 영역 -->
	 	<div class="qsDtl-content">
	 		<div class="content-cont">
	 			<!-- 문의 내용 -->
	 			<div class="qs-cn">
	 				안녕하세요,저희는 다가오는 행사에서 단체로 식사를 하려고 계획 중입니다. 이와 관련하여 단체 주문이 가능한지 문의드립니다. 예상 인원은 약 50명에서 70명 정도이고, 매장에서 식사를 하거나 포장할 예정입니다. 만약 단체 주문이 가능하다면, 미리 예약을 해야 하는지, 그리고 주문 가능한 메뉴는 어떻게 선택할 수 있는지 궁금합니다.
					또한, 단체 주문 시 할인 혜택이 있는지도 알려주시면 감사하겠습니다. 행사 날짜가 얼마 남지 않아 빠른 답변 부탁드립니다. 마지막으로, 혹시 배달 서비스도 제공하고 있는지 궁금한데, 단체 주문을 할 경우 배달 범위와 관련된 제한 사항이 있다면 알려주세요.
					감사합니다. 좋은 하루 되세요!
	 			</div>
	 			<!-- /.qs-cn -->
	 			
	 			<!-- 문의 파일 -->
	 			<div class="qs-file">
	 				<div class="file-title">문의 관련 파일</div>
	 				<button class="btn btn-default">다운로드</button>
	 			</div>
	 			<!-- /.qs-file -->
	 		</div>
	 		<!-- /.content-cont -->

			<!-- 답변 내용 -->
			<div class="ans-cont">
				<div class="ans-title">문의 답변</div>
				<div class="ans-yes">
					<div class="ans-cn">
						안녕하세요 고객님, 저희 매장을 이용해 주셔서 감사합니다. 단체 주문은 가능합니다! 사전에 예약을 주시면 주문량에 맞춰 준비할 수 있으며, 메뉴는 매장 내 전 메뉴 선택이 가능합니다. 또한, 50인 이상 주문 시 소정의 할인 혜택도 제공되며, 배달 서비스도 가능하나, 배달 가능 지역은 매장별로 상이하니 해당 매장에 직접 문의 부탁드립니다.
					</div>
					<div class="ans-dt">2024-11-02</div>
				</div>
				<div class="ans-no">
					문의 답변 대기 중
				</div>
			</div>	
			<!-- /.ans-cont -->
					
	 	</div>
	 	<!-- /.qsDtl-content -->
	 	
	 	<div class="view-more">
	 		<div class="more-btn" onclick="window.location.href='/backup/selectEvent'">
       			<span class="material-symbols-outlined">add</span>목록으로
       		</div>
		</div>
		<!-- /.view-more -->
		
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>










