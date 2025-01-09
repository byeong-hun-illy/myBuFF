<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.buff.util.Telno" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<link href="/resources/com/css/frcsClcln.css" rel="stylesheet">
<script src="/resources/com/js/frcsClcln.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let urlParams = new URLSearchParams(window.location.search);
let clclnYm = urlParams.get('clclnYm'); 
let frcsNo = urlParams.get('frcsNo');  
let bzentNo = '<c:out value="${user.bzentNo}"/>'; // 접속한 사람이 가맹점인지 파악하기 위함
let total = 0;
// 가맹점이 결제할 시 사용함
let actno = ''; 
let bankType = '';
let bankTypeNm = '';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	selectFrcsClclnDtlAjax();
	
	$("#billDownload").on('click', function(){
		// 파일 다운로드를 위한 URL을 호출
		var downloadUrl = "/com/frcsClcln/billAjax?clclnYm="+clclnYm+"&frcsNo="+frcsNo+"&"+"&_csrf=" + csrfToken;
		location.href = downloadUrl;
	})
	
	$('#updateClcln').on('click', function(){
		//console.log(bankTypeNm, actno)
		if(actno==''){
			Swal.fire({
				  title: "에러",
				  html: "등록된 계좌정보가 없습니다",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "확인",
				  cancelButtonText: "취소"
				})
				return;
		}
		let htmlStr = "<p>등록된 계좌정보인 "+bankTypeNm+"은행의 "+actno+"에서</p><p>정산의 총 합계만큼 정산처리하시겠습니까?</p><p>정산처리가 될 경우 <span class='es'>환불이 불가능</span>합니다.</p>";
		
		Swal.fire({
			  title: "확인",
			  html: htmlStr,
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "정산",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  updateClclnAjax();
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
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/frcs/frcsClcln/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">정산 상세</h1>
      	</div>
    	<div class="btn-wrap">
    		<button class="btn-default" id="billDownload">영수증 <span class="icon material-symbols-outlined">download</span></button>
			<button type="button" class="btn-active" style="display: none;" id="updateClcln">정산 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
		<!-- cont시작 !!!!!!!담당자-->
		<div class="cont">
			<!-- table-wrap 가맹점주 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>가맹점 정보</div> <!-- 타입에따라 제목 변경 -->
				</div>
				<table class="table-blue">
					<tr>
						<th style="width:15%;">가맹점명</th>
						<td id="bzentNm" style="width:36%;"></td>
						<th style="width:15%;">전화번호</th>
						<td id="bzentTelno"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td id="bzentAddr" colspan="3"></td>
					</tr>
				</table>
			</div>
			<!-- /.table-wrap 가맹점주 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->

	<!-- cont: 해당 영역의 설명 -->
	<div class="cont po-dtl">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>정산 정보</div> 
			</div>
			<table class="table-blue">
				<tr>
					<th style="width:15%;">년월</th>
					<td id="clclnYm"></td>
					<th style="width:15%;">정산여부</th>
					<td id="clclnYn">
					</td>
				</tr>
				<tr>
					<th class="po-dtl">등록일자</th>
					<td class="po-dtl" id="regYmd"></td>
					<th>정산일자</th>
					<td id="clclnYmd">
					</td>
				</tr>
				<tr class="clclnY">
					<th>결제은행</th>
					<td id="bankTypeNm">-</td>
					<th>결제계좌</th>
					<td id="actno">-</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
			<!-- cont: 해당 영역의 설명 -->
			<div class="cont clcln-dtl">
			<!-- table-wrap 정산 정보-->
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>정산 내역</div> 
				</div>
				<table class="table-blue">
				<thead>
					<tr>
						<th width="15%;">로열티</th>
						<td id="royalty"></td>
					</tr>
					<tr>
						<th>할인금액</th>
						<td id="dscntAmt"></td>
					</tr>
					<tr>
						<th>체납금액</th>
						<td id="npmntAmt"></td>
					</tr>
					<tr>
						<th>총 정산 금액</th>
						<td id="totalAmt"></td>
					</tr>
				</thead>
			</table>
			</div>
			<!-- /.table-wrap 관리자 정보 -->
			</div>
			<!-- /.cont: 해당 영역의 설명 -->
</div>
<!-- wrap 끝 -->

<!-- --------------------------------------- 모달 시작 ---------------------------------------------------- -->
<!-- 관리자 추가 모달 창 -->


