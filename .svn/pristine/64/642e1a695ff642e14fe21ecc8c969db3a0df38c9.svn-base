<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/resources/hdofc/css/qsDetail.css">
<script src="/resources/js/jquery-3.6.0.js"></script>

<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript">
$(document).ready(function() {
	$("#div2").hide();  // div2 숨기기
	//목록으로 버튼 클릭 시 selectFaqList 페이지로 이동
	$("#backToListBtn").on("click", function() {
		// 공지사항 목록으로 복귀
		window.location.href = "/hdofc/qs/selectQsList";  // 목록 페이지로 이동
	});
	
	// 원래 데이터를 저장할 객체
	let originalData = {};
	
	// 수정 모드 버튼 클릭 시 동작
	$("#submitModeBtn").on("click", function() {
		// div1을 숨기고 div2를 보여줌
		$("#div1").hide();  // div1 숨기기
		$("#div2").show();  // div2 보이기

		// 현재 입력된 값을 저장 (수정 취소 시 복원할 데이터)
		originalData = {
			"ansCn": $("#ansCn").val()
		};

		// 댓글내용에 disabled 속성 제거
		$("#ansCn").removeAttr("disabled");
	});
	
	// 취소 버튼 클릭 시 수정 모드 종료
	$("#cancleBtn").on("click", function() {
		// div2을 숨기고 div1를 보여줌
		$("#div2").hide();  // div1 숨기기
		$("#div1").show();  // div2 보이기
		
		// 저장해둔 원래 데이터로 복원
		$("#ansCn").val(originalData.ansCn);

		// 댓글내용에 다시 disabled 속성 추가
		$("#ansCn").attr("disabled", true);
	});
	
	$("#submitBtn").on("click", function() {
		console.log("업데이트한다!");
		
		let qsSeq = $("#qsSeq").val();
		let mngrId = $("#mngrId").val();
		let ansDt = $("#ansDt").val();
		let ansCn = $("#ansCn").val();
		
		let data = {
			"qsSeq":qsSeq, 
			"mngrId":mngrId, 
			"ansDt":ansDt, 
			"ansCn":ansCn 
		};
		
		$.ajax({
			url:"/hdofc/qs/updateQsDetailAns",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				
				if (result === 1) {
					Swal.fire({
	 					icon: "success",
						title: "답글 등록에 성공하였습니다",
						showConfirmButton: false,
	  					timer: 5000  // 5초 동안 알림창 유지
					});
					Swal.fire({
	                    icon: "success",
	                    title: "답글 등록에 성공하였습니다",
	                    showConfirmButton: true,  // 확인 버튼을 활성화
	                    confirmButtonText: "확인"
	                }).then((result) => {
	                    // 확인 버튼을 눌렀을 때 페이지 이동 또는 새로고침
	                    if (result.isConfirmed) {
	                    	// div2 숨기고 div1 보여주기
	                        $("#div2").hide();   // div2 (수정 버튼이 있는 부분) 숨김
	                        $("#div1").show();   // div1 (수정 모드로 전환 버튼이 있는 부분) 보임
	                     	// 모든 input 태그 및 textarea 다시 비활성화
	                        $("textarea").attr("disabled", true);
	                     	// 페이지 새로고침
	                        location.reload();   // 새로고침하여 변경된 내용을 다시 로드
	                    }else {
	                    	// 확인버튼 말고 모달밖 다른쪽을 클릭해도 동일하게
	                    	// div2 숨기고 div1 보여주기
	                        $("#div2").hide();   // div2 (수정 버튼이 있는 부분) 숨김
	                        $("#div1").show();   // div1 (수정 모드로 전환 버튼이 있는 부분) 보임
	                     	// 모든 input 태그 및 textarea 다시 비활성화
	                        $("textarea").attr("disabled", true);
	                     	// 페이지 새로고침
	                        location.reload();   // 새로고침하여 변경된 내용을 다시 로드
	                    }
	                });
                } else {
                    alert("문의사항 댓글 수정에 실패했습니다.");
                }
			},
            error: function(xhr, status, error) {
                console.log("문의사항 댓글 수정 오류: " + error);
                alert("문의사항 댓글 수정 중 문제가 발생했습니다.");
            }
		});
		
	});
	
	$("#deleteBtn").on("click", function() {
		console.log("삭제한다!");
		
		let qsSeq = $("#qsSeq").val();
		
		$.ajax({
			url:"/hdofc/qs/deleteQs",
			contentType:"application/json;charset=utf-8",
			data:qsSeq,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				
				if (result === 1) {
					Swal.fire({
	                    icon: "success",
	                    title: "삭제에 성공하였습니다",
	                    showConfirmButton: true,  // 확인 버튼을 활성화
	                    confirmButtonText: "확인"
	                }).then((result) => {
	                    // 확인 버튼을 눌렀을 때 페이지 이동 또는 새로고침
	                    if (result.isConfirmed) {
	                        window.location.href = "/hdofc/qs/selectQsList";  // 목록 페이지로 이동
	                    }else {
	                    	// 확인버튼 말고 모달밖 다른쪽을 클릭해도 동일하게
	                    	window.location.href = "/hdofc/qs/selectQsList";  // 목록 페이지로 이동
	                    }
	                });
                } else {
                    alert("문의사항 삭제에 실패했습니다.");
                }
			},
            error: function(xhr, status, error) {
                console.log("문의사항 삭제 오류: " + error);
                alert("문의사항 삭제 중 문제가 발생했습니다.");
            }
		});
		
	});
	
	
	
});

//파일 다운로드
$(document).on('click','#downloadBtn',function(){
	fileSaveLocate = $(this).data('fileLocate');
	console.log(fileSaveLocate);
	fileDownloadAjax(fileSaveLocate);
});

function getCsrfTokens() {
    const csrfToken = $("meta[name='_csrf']").attr("content");
    const csrfHeader = $("meta[name='_csrf_header']").attr("content");
    return { csrfToken, csrfHeader };
}

function fileDownloadAjax(fileSaveLocate){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	
	console.log("ajax=>",fileSaveLocate);
	
	const link = document.createElement('a');
	link.href = `/download?fileName=${qsVO.fileDetailVOList[0].fileSaveLocate}`;  // 서버에서 전달받은 다운로드 경로
	link.download = fileSaveLocate; // 다운로드할 파일 이름 설정
	document.body.appendChild(link);
	link.click(); // 클릭하여 다운로드 시작
	document.body.removeChild(link); // 링크 제거
	
	/*
	$.ajax({
		url: "/download",
		type: "GET",
		data: {fileName : fileSaveLocate},
		dataType: "text",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res) {
			alert("파일 다운로드 성공" + res);
			
			// 파일 다운로드를 위해 링크를 동적으로 생성
			const link = document.createElement('a');
			link.href = `/download?fileName=${qsVO.fileDetailVOList[0].fileSaveLocate}`;  // 서버에서 전달받은 다운로드 경로
			link.download = fileSaveLocate; // 다운로드할 파일 이름 설정
			document.body.appendChild(link);
			link.click(); // 클릭하여 다운로드 시작
			document.body.removeChild(link); // 링크 제거
			
		},
		error: function(jqXHR, textStatus, errorThrown) {
	        console.error('AJAX 요청 실패:', textStatus, errorThrown);
	        Swal.fire({
			  icon: "error",
			  title: "다운로드 실패",
			  text: "다시 시도해주세요",
		  	  showConfirmButton: false,
	  		  timer: 3000 //3초간 유지
			});
    	} // error
	});
	*/
}
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<button type="button" class="btn btn-default mr-3" id="backToListBtn">
					<span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로
				</button>
				<h1 class="m-0">문의사항 상세</h1>
			</div>
			<div class="btn-wrap">
				<button type="button" class="btn-danger" id="deleteBtn">삭제</button>
			</div>
		</div><!-- /.row -->
	</div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">playlist_add</span>문의사항 상세</div>
			</div>
			<table class="table-blue">
				<tbody>
					<tr>
						<th>작성자</th>
						<td>
							${qsVO.memberVO.mbrNm}
							<input type="hidden" id="qsSeq" value="${qsVO.qsSeq}">
						</td>
						<th>등록일자</th>
						<td>
						    <c:set var="formattedWrtrDt" value="${fn:substring(qsVO.wrtrDt, 0, 10)}" />
						    ${formattedWrtrDt}
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${qsVO.qsTtl}</td>
						<th>문의 유형</th>
						<td>
							<c:forEach var="qs" items="${qs}">
								<c:if test="${qsVO.qsType == qs.comNo}">
									${qs.comNm}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea id="qsCn" rows="8" cols="1" spellcheck="false" disabled>${qsVO.qsCn}</textarea>
						</td>
					</tr>
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
<!-- 					<tr> -->
<!-- 						<th>사진</th> -->
<!-- 						<td> -->
<%-- 							<c:if test="${not empty qsVO.fileDetailVOList}"> --%>
<%-- 					            <c:forEach var="file" items="${qsVO.fileDetailVOList}"> --%>
<%-- 					                <img src="${file.fileSaveLocate}" alt="이미지" style="width: 600px; height: auto;"> --%>
<%-- 					            </c:forEach> --%>
<%-- 					        </c:if> --%>
<%-- 					        <c:if test="${empty qsVO.fileDetailVOList}"> --%>
<!-- 					            <p>이미지가 없습니다.</p> -->
<%-- 					        </c:if> --%>
<!-- 				        </td> -->
<!-- 					</tr> -->
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
					<!-- 이미지파일 미리보기를 원하면 주석풀고 원하지않으면 주석해! -->
					<tr>
						<th>첨부파일</th>
						<td colspan="5">
							<span class="img-info">${qsVO.fileDetailVOList[0].fileOriginalName}</span>
							<button type="button" class="btn btn-download" id="downloadBtn" data-file-locate="${qsVO.fileDetailVOList[0].fileSaveLocate}"
							 	<c:if test="${empty qsVO.fileDetailVOList}">disabled</c:if>>
							 	다운로드<span class="icon material-symbols-outlined">Download</span> 
							</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
	
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자 답글</div>
				<div id="div1" class="btn-wrap">
					<button type="button" id="submitModeBtn" class="btn-active">수정</button>
				</div>
				<div id="div2" class="btn-wrap">
					<button type="button" id="cancleBtn" class="btn-default">취소</button>
					<button type="button" id="submitBtn" class="btn-active">수정</button>
				</div>
			</div>
			<table class="table-blue">
				<tbody>
					<tr>
						<th>관리자</th>
						<td>
							<input id="mngrNm" type="text" class="text-input" placeholder="입력해주세요" value="${qsVO.mngrVO.mbrNm}" disabled>
							<input type="hidden" id="mngrId" value="${qsVO.mngrId}">
						</td>
						<th>답변일자</th>
						<c:set var="formattedDate" value="${fn:substring(qsVO.ansDt, 0, 10)}" />
						<td>
						    <input id="ansDt" type="text" class="text-input" placeholder="입력해주세요" value="${formattedDate}" disabled>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea id="ansCn" rows="8" cols="1" spellcheck="false" disabled>${qsVO.ansCn}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
</div>