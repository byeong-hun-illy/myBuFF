<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html class>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>buff</title>

	<!-- tiles에서 기본적으로 적용하는 링크 모음 -->	
	<!-- Google Font: Source Sans Pro -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/fontawesome-free/css/all.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<!-- Tempusdominus Bootstrap 4 -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
	<!-- iCheck -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
	<!-- JQVMap -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/jqvmap/jqvmap.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="/resources/adminlte3/dist/css/adminlte.min.css">
	<!-- overlayScrollbars -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
	<!-- Daterange picker -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/daterangepicker/daterangepicker.css">
	<!-- summernote -->
	<link rel="stylesheet" href="/resources/adminlte3/plugins/summernote/summernote-bs4.min.css">
	  
	<!-- buff 자체 링크 모음 -->  
	<!-- 나눔스퀘어 웹폰트 적용 -->
	<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
	<!-- 프로젝트 공통 css 적용 -->
	<link href="/resources/css/global/common.css" rel="stylesheet">
	<!-- 구글 아이콘 적용 -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<!-- 프로젝트 공통 css 적용 -->
	<link href="/resources/cust/custGlobal/custCommon.css" rel="stylesheet">
	
</head>
<body class="hold-transition sidebar-mini layout-fixed">

<!-- -------------------- body 시작 -------------------- -->
<tiles:insertAttribute name="body" />
<!-- -------------------- body 끝 -------------------- -->

<!-- jQuery -->
<script src="/resources/adminlte3/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/adminlte3/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="/resources/adminlte3/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/resources/adminlte3/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="/resources/adminlte3/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="/resources/adminlte3/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="/resources/adminlte3/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="/resources/adminlte3/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="/resources/adminlte3/plugins/moment/moment.min.js"></script>
<script src="/resources/adminlte3/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/adminlte3/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="/resources/adminlte3/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="/resources/adminlte3/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/adminlte3/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<!-- <script src="/resources/adminlte3/dist/js/demo.js"></script> -->
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!-- <script src="/resources/adminlte3/dist/js/pages/dashboard.js"></script> -->
</body>
</html>
