<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/com/js/stockAjmt.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
// let bzentNo = "${user.bzentNo}";
let bzentNo = 'HO0001';
// console.log("bzentNo : ", bzentNo);

let mbrId = '<c:out value="${user.mbrId}"/>';
let urlParams = new URLSearchParams(window.location.search);

let currentPage = 1;
let sort = '';
let orderby = '';
let max = 0; // 원래 있던 재고보다 높지 않은지 체크
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	select2Custom();

	if(urlParams.has('gdsCode')){
		let gdsCode = urlParams.get('gdsCode');
		sort = 'gdsNm';
		orderby = 'asc';
		selectGdsParamAjax(gdsCode);
	}
	
	var gdsModal = new bootstrap.Modal(document.getElementById('gdsModal'));
	
	$('#gdsAdd').on('click', function(){
		sort = 'gdsNm';
		orderby = 'asc';
		currentPage = 1;
		selectGdsAjax();
		gdsModal.show();
	})
	// 검색어
	$('#searchBtn').on('click', function(){
		currentPage=1;
		selectGdsAjax();
	})
	// 상품 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		selectGdsAjax();
	})
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-gds').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      
	      $('.sort-gds').removeClass('active');
	      $(this).addClass('active');
	      
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-gds .sort-arrow .sort-asc, .sort-gds .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-gds .sort-arrow .sort-asc, .sort-gds .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectGdsAjax();
	})
	//// 상품 선택
	$(document).on('click', '.gdsDtl', function(){
		let gdsNm = $(this).data("nm");
		let gdsCode = $(this).data("no");
		let unit = $(this).data("unit");
		max = $(this).data("max");
		
		let unitNm = "("+unit+")";
		$('#unitNm').text(unitNm);
		$('#gdsCode').val(gdsCode);
		$('#gdsNm').val(gdsNm);
		
		gdsModal.hide();
	})
	
})



	
</script>
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
      		<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/stockAjmt/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 gds-qty">재고 조정 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-active gds-qty" onclick="insertStockAjmtAjax()">저장 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap" style="overflow-x: inherit !important;">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">package_2</span>상품 정보</div> 
					<div class="gds-insert" style="margin-left: var(--gap--l)"><span class="es">*</span> 표기된 항목은 필수입력 항목입니다.</div>
			</div>
			<table class="table-blue">
				<tr>
					<th>상품명  <span class="es gds-insert">*</span></th>
					<td>
					    <div class="input-wrapper">
							<input disabled id="gdsNm">
							<input hidden id="gdsCode">
							<button type="button" class="update-btn" id="gdsAdd"></button>
						</div>
					</td>
					<th>조정 유형 <span class="es">*</span></th>
					<td style="width: 37%" class="stockAjmtType">
						<div class="select-custom" style="width:200px;">
							<select name="stockAjmtType" id="stockAjmtType" class="input-reset input-gds">
<!-- 								<option value="" selected>미선택</option> -->
<!-- 								<option value="AJMT01" class="ajmt">입고 </option> -->
								<option value="AJMT02" class="ajmt" selected>폐기</option>
							</select>
						</div>	
					</td>
				</tr>
				<tr>
					<th>수량 <span id="unitNm"></span><span class="es gds-insert">*</span></th>
					<td>
						<input id="qty" type="number" class="text-input input-reset input-gds">
					</td>
					<th>조정 일자 <span class="es gds-insert">*</span></th>
					<td>
						<c:set var="now" value="<%=new java.util.Date()%>" />
					    <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
				<tr class="gds-dtl">
					<th>조정 사유</th>
					<td colspan="3">
						<textarea id="ajmtRsn" class="text-input" rows="4" style="width: 100%;"></textarea>
					</td>
				</tr>
			</table>
			<div></div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
</div>
<!-- wrap 끝 -->

<jsp:include page="/WEB-INF/views/com/bzentGdsModal.jsp" />








