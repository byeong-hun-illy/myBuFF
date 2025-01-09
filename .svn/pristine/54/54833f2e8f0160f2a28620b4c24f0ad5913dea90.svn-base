<%--
 	@fileName    : insertQS.jsp
 	@programName : 고객 문의 제출
 	@description : 고객이 문의 사항을 남길 수 있는 화면 , 리스트로 나올 예정
 	@author      : 서윤정
 	@date        : 2024. 09. 11
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- <link href="/resources/cust/css/selectBoard.css" rel="stylesheet"> -->

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="user" />
</sec:authorize>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
	let mbrId = "${user.mbrId}";

	$(function() {

		$(document).ready(function() {
			$("#div2").hide();

			// 원래 데이터를 저장할 객체
			let originalData = {};

			// 수정 모드 버튼 클릭 시 동작
			$("#modeBtn").on("click", function() {
				// 수정 버튼 숨기고 확인, 취소, 삭제 버튼 보이기
				$("#div1").hide(); // div1 숨기기
				$("#div2").show(); // div2 보이기

				// 수정 전 데이터 저장 
				originalData = {
					"qsTtl" : $(".qs-ttl").text(),
					"qsCn" : $(".qs-cn").text()
				};
				console.log("Original Data:", originalData);
			}); // modeBtn 끝

			// 취소 버튼 클릭 시 수정 모드 종료
			$("#cancleBtn").on("click", function() {
				// 확인, 취소,삭제 버튼 숨기고 수정 버튼 보이기
				$("#div2").hide();
				$("#div1").show();

				// 저장해둔 원래 데이터로 복원
				$("#qsTtl").text(originalData.qsTtl);
				$("#qsCn").text(originalData.qsCn);

				console.log("Restored Data:", originalData);
			}); // cancleBtn 끝

		}); // 전체 끝

	});
</script>

<!-- 문의 수정 폼 시작  ////////////////////////////////////////////////////////////////////////////////////////////-->
<div class="image">
	<c:if test="${not empty qsVO.fileDetailVOList}">
		<c:forEach var="file" items="${qsVO.fileDetailVOList}">
			<img src="${file.fileSaveLocate}" alt="이미지"
				style="width: 600px; height: auto;">
		</c:forEach>
	</c:if>
	<c:if test="${empty qsVO.fileDetailVOList}">
		<p>이미지가 없습니다.</p>
	</c:if>
</div>
<div id="qsInsert">
	<div class="con_tit1">
		<div>
			<p>1:1 문의</p>
		</div>
	</div>
	<!-- /.con_tit1  -->
	<div class="bdr_box">
		<form id="inquiryForm">
			<div class="write_tbl">
				<table>
					<colgroup>
						<col width="15%">
						<col width="85%">
						<col>
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th>문의유형</th>
							<td colspan="2">
								<div class="form-group">
									<div class="select-custom" style="width: 200px;">
										<select id="category" name="category" required>
											<option value="" selected disabled>선택해주세요</option>
											<option value="QS01">구매</option>
											<option value="QS02">매장이용</option>
											<option value="QS03">채용</option>
											<option value="QS04">가맹점</option>
											<option value="QS05">기타</option>
										</select>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="2">
								<div class="form-group">
									<input class="input_type1" type="text" style="width: 100%;"
										name="title" id="qa_subject" size="50" maxlength="255"
										placeholder="제목을 입력해주세요.">
								</div>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="2">
								<div class="form-group">
									<textarea name="cont" rows="5" cols="50" spellcheck="false"
										placeholder="내용을 입력해주세요" required></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<th>파일</th>
							<td colspan="2">
								<div class="form-group">
									<input type="file" id="uploadFile">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- /.write_tbl -->

			<div class="btn_area mt45">
				<button id="btn_cancle">취소</button>
				<button type="submit" id="btn_submit" class="_btn co_btn w_160">등록</button>
			</div>
			<!-- /.btn_area -->
		</form>
	</div>
	<!-- /.bdr_box -->
</div>
<!-- /.qsInsert -->


<!-- 문의 수정 폼 끝  ////////////////////////////////////////////////////////////////////////////////////////////-->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>