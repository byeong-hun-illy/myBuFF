<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.buff.util.Telno" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/frcs/css/profit.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src="/resources/frcs/js/netProfit.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let urlParams = new URLSearchParams(window.location.search);
let bzentNo = '<c:out value="${user.bzentNo}"/>';
let slsYm =urlParams.get('slsYm');
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	selectSlsDtl();

	/////////////////////// 추가 /////////////////////////////
	$('#slsUpdate').on('click',function(){
		Swal.fire({
			  title: "확인",
			  html: "수정하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "수정",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  updateSls();
					Swal.fire({
					  icon: "success",
					  title: "수정이 완료되었습니다",
					  showConfirmButton: false,
					  timer: 1000
					});
			  }
			});
	})

})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/frcs/netProfitList'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">순수익 상세</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default" onclick="selectSlsDtl();">초기화</button>
			<button type="button" class="btn-active" id="slsUpdate">수정</button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명 -->
	<div class="card-con">
		<div class="bill" style="mask-image: radial-gradient(circle at 50% 13px, transparent 13px, red 13.5px); mask-position: 50% -13px; mask-size: 50px 100%;">
				<div class="cont-title" id="slsYm"></div>
			<div class="cont-wrap plus">
				<div class="cont-wrap-title">총 매출액 <span class="plus">(+)</span></div>
				<div class="cont-wrap-cn" id="slsGramt"></div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">로열티 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn" id="royalty"></div>
			</div>
			<div class="cont-wrap plus">
				<div class="cont-wrap-title">할인금액 <span class="plus">(+)</span></div>
				<div class="cont-wrap-cn" id="dscntAmt"></div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">정산 체납 금액 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn" id="npmntAmt"></div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">발주금액 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn" id="poAmt"></div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">발주 체납 금액 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn" id="poNpmntAmt"></div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">관리 금액 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn-input">
					<input id="mngAmt" class="amtInput" onchange="changePureAmt()" type="number">
				</div>
			</div>
			<div class="cont-wrap minus">
				<div class="cont-wrap-title">고용 금액 <span class="minus">(-)</span></div>
				<div class="cont-wrap-cn-input">
					<input id="hireAmt" class="amtInput" onchange="changePureAmt()" type="number">
				</div>
			</div>
			<div class="bar"></div>
			<div class="cont-wrap">
				<div class="cont-wrap-title">순 이익</div>
				<div class="cont-wrap-cn" id="pureAmt"></div>
			</div>
		</div>
		<!-- bill 끝 -->
	</div>
	<!-- card-con끝 -->
</div>
<!-- wrap 끝 -->


