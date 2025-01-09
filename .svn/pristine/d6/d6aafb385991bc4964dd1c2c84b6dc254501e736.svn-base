<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>

<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">
$(document).ready(function() {
	//목록으로 버튼 클릭 시 selectFaqList 페이지로 이동
	$("#backToListBtn").on("click", function() {
		// FAQ 목록으로 복귀
		window.location.href = "/hdofc/faq/selectFaqList";  // 목록 페이지로 이동
	});
	
	$("#submitBtn").on("click", function() {
		console.log("등록한다!");
		
		let mbrId = $("#mbrId").val();
		let qsType = $("#qsType").val();
		let faqTtl = $("#faqTtl").val();
		let faqCn = $("#faqCn").val();
		
		let data = {
			"mbrId":mbrId,
			"faqTtl":faqTtl,
			"faqCn":faqCn,
			"qsType":qsType
		};
		
		console.log(data);
		
		$.ajax({
			url:"/hdofc/faq/insertFaqList",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				
				Swal.fire({
 					icon: "success",
					title: "등록에 성공하였습니다",
					showConfirmButton: false,
  					timer: 3000  // 5초 동안 알림창 유지
				});
				// 필드 초기화 (값을 공백으로 설정)
				$("#faqTtl").val('');
				$("#faqCn").val('');
				$("#qsType").val('');
			},
            error: function(xhr, status, error) {
                console.log("FAQ 수정 오류: " + error);
                alert("FAQ 수정 중 문제가 발생했습니다.");
            }
		});
	});
});
</script>
<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<button type="button" class="btn btn-default mr-3" id="backToListBtn">
					<span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로
				</button>
				<h1 class="m-0">FAQ 등록</h1>
			</div>
			<div class="btn-wrap">
				<button type="button" class="btn-active" id="submitBtn">저장</button>
			</div>
		</div><!-- /.row -->
	</div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title">FAQ 등록</div>
			</div>
			<table class="table-blue">
				<tbody>
					<tr>
						<th>작성자</th>
						<td>
							${memberVO.mbrNm}
							<input type="hidden" id="mbrId" value="${mbrId}">
						</td>
						<th>문의 유형</th>
						<td>
							<div class="select-custom" style="width:150px">
								<select name="qsType" id="qsType">
									<c:forEach var="qs" items="${qs}">
										<option value="${qs.comNo}">${qs.comNm}</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" id="faqTtl" class="text-input" placeholder="입력해주세요"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3"><textarea id="faqCn" rows="10" cols="1" spellcheck="false"></textarea></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
</div>