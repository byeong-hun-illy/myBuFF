<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="/resources/common/css/select.css"  rel="stylesheet"/>
<link href="/resources/cust/custGlobal/custCommon.css" rel="stylesheet">

<div class="hme-wrap">
	<!-- 고객 페이지 -->
	<div class="wrap-cont cust">
		<div class="bg"></div>
		<div class="cont-inner">
			<div class="title-sub">Hompage</div>
			<div class="title-main">Buff</div>
			<div class="line"></div>
			<div class="site-info">버프 브랜드</div>
			<div class="site-cn">
				새로운 메뉴부터 매장안내, <br> 
				이벤트 등 다양한 버프버거의 <br>
				최신 소식을 살펴보세요!
			</div>
			<div class="go-btn" onclick="window.location.href='/buff/home'">바로가기</div>
		</div>
	</div>
	<!-- /.cust -->
	
	<!-- 사업체 페이지 -->
	<div class="wrap-cont bzent">
		<div class="bg"></div>
		<div class="cont-inner">
			<div class="title-sub">Partner</div>
			<div class="title-main">Buff</div>
			<div class="line"></div>
			<div class="site-info">버프 관리자</div>
			<div class="site-cn">
				창업과 거래처 관리까지, <br> 
				든든한 버프와 함께라면  <br>
				사업 관리가 쉽고 효율적입니다!
			</div>
			<div class="go-btn" onclick="window.location.href='/admin/login'">바로가기</div>
		</div>
	</div>
	<!-- /.bzent -->
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
$(document).ready(function() {
	// 업체 영역 배경 추가
    $('.bzent').hover(
        function() {
            $('.bzent .bg').addClass('bzent-effect');
        }, 
        function() {
            $('.bzent .bg').removeClass('bzent-effect');
        }
    );
 	// 고객 영역 배경 추가
    $('.cust').hover(
        function() {
            $('.cust .bg').addClass('cust-effect');
        }, 
        function() {
            $('.cust .bg').removeClass('cust-effect');
        }
    );
});
</script>