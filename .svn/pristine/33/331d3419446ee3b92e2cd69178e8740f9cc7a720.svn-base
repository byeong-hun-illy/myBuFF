<%--
    @fileName    : selectFrcsStockDetail.jsp
    @programName : 가맹점 재고 상세
    @description : 가맹점 재고 상세를 보기 위한 화면
    @author      : 정현종
    @date        : 2024. 09. 24
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Bootstrap CSS 먼저 로드 -->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css" href="/resources/frcs/css/selectFrcsStockDetail.css">

<!-- jQuery는 Bootstrap보다 먼저 로드 -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<sec:authentication property="principal.MemberVO" var="user" />

<script type="text/javascript">

let bzentNo = "${user.bzentNo}";

let originalSafetyStockValue; // 원래 안전 재고 값을 저장할 변수
let originalAdjustStockQty; // 원래 조정 수량 값을 저장할 변수
let originalAdjustStockReason; // 원래 조정 사유 값을 저장할 변수

//현재 재고 수량을 가져옵니다.
const currentStockQty = parseFloat("${gdsVO.stockVOList[0].qty}");

function stockAdjustCheck() {
    const adjustStockQty = parseFloat(document.getElementById("adjustStockQty").value);
    const warningDiv = document.getElementById("stockWarning");

    if (adjustStockQty > currentStockQty) {
        warningDiv.style.display = "block"; // 경고 메시지 표시
    } else {
        warningDiv.style.display = "none"; // 경고 메시지 숨김
    }
}

// 안전 재고 설정 버튼 클릭시...
function enableSafetyStock() {
    const safetyStockInput = document.getElementById("safetyStockInput");
    originalSafetyStockValue = safetyStockInput.value; // 원래 값을 저장
    safetyStockInput.disabled = false;

    // 버튼들 숨기기
    document.getElementById("safetyStockButton").style.display = 'none';
    document.getElementById("stockAdjustmentButton").style.display = 'none';

    // 취소 및 저장 버튼 보이기
    document.getElementById("cancelButton").style.display = 'inline-block';
    document.getElementById("saveButton").style.display = 'inline-block';
}

// 안전 재고 설정 -> 취소 버튼 클릭시...
function cancelEdit() {
    const safetyStockInput = document.getElementById("safetyStockInput");
    safetyStockInput.disabled = true;
    safetyStockInput.value = originalSafetyStockValue; // 원래 값으로 되돌리기

    // 버튼들 보이기
    document.getElementById("safetyStockButton").style.display = 'inline-block';
    document.getElementById("stockAdjustmentButton").style.display = 'inline-block';

    // 취소 및 저장 버튼 숨기기
    document.getElementById("cancelButton").style.display = 'none';
    document.getElementById("saveButton").style.display = 'none';
}

// 안전 재고 설정 -> 저장 버튼 클릭시...
function saveChanges() {
    const sfStockQty = $("#safetyStockInput").val(); // 안전 재고 수량
    const gdsCode = "${gdsVO.gdsCode}"; // JSP에서 gdsCode 값을 가져옵니다.

    $.ajax({
        url: '/frcs/safeStockFrcsUpdateAjax',
        type: 'POST',
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify({
            gdsCode: gdsCode,
            sfStockQty: sfStockQty
        }),
        dataType: "text",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function (response) {
            Swal.fire({
                title: "안전 재고 설정",
                text: "안전 재고가 설정되었습니다.",
                icon: "success",
                confirmButtonColor: "#00C157",
                confirmButtonText: "확인",
            }).then((result) => {
                cancelEdit(); // 저장 후 편집 취소
                location.reload(); // 페이지 새로고침
            });
        },
        error: function (xhr, status, error) {
            Swal.fire({
                title: "오류",
                text: "안전 재고 설정 중 오류가 발생했습니다: " + error,
                icon: "error",
                confirmButtonColor: "#FF0000",
                confirmButtonText: "확인",
            });
        }
    });
}

// 재고 조정 버튼 클릭시...
function stockAdjust() {
    const adjustStockQty = document.getElementById("adjustStockQty");
    const adjustStockReason = document.getElementById("adjustStockReason");

    // 원래 값을 저장
    originalAdjustStockQty = adjustStockQty.value; // 원래 조정 수량 값
    originalAdjustStockReason = adjustStockReason.value; // 원래 조정 사유 값

    // 입력란 활성화
    adjustStockQty.disabled = false;
    adjustStockReason.disabled = false;

    // 버튼들 숨기기
    document.getElementById("safetyStockButton").style.display = 'none';
    document.getElementById("stockAdjustmentButton").style.display = 'none';

    // 취소 및 저장 버튼 보이기
    document.getElementById("saveButton").style.display = 'none';
    document.getElementById("cancelButton").style.display = 'none';
    document.getElementById("stockAdjustmentSaveButton").style.display = 'inline-block'; // 재고 조정 저장 버튼 보임
    document.getElementById("stockAdjustmentCancelButton").style.display = 'inline-block'; // 재고 조정 취소 버튼 보임
}

// 재고 조정 -> 취소 버튼 클릭시
function cancelStockAdjustment() {
    const adjustStockQty = document.getElementById("adjustStockQty");
    const adjustStockReason = document.getElementById("adjustStockReason");

    // 입력란 비활성화
    adjustStockQty.disabled = true;
    adjustStockReason.disabled = true;

    // 원래 값으로 되돌리기
    adjustStockQty.value = originalAdjustStockQty; // 원래 조정 수량 값 복원
    adjustStockReason.value = originalAdjustStockReason; // 원래 조정 사유 값 복원

    // 버튼들 보이기
    document.getElementById("safetyStockButton").style.display = 'inline-block';
    document.getElementById("stockAdjustmentButton").style.display = 'inline-block';

    // 취소 및 저장 버튼 숨기기
    document.getElementById("cancelButton").style.display = 'none';
    document.getElementById("saveButton").style.display = 'none';
    document.getElementById("stockAdjustmentSaveButton").style.display = 'none'; // 재고 조정 저장 버튼 숨김
    document.getElementById("stockAdjustmentCancelButton").style.display = 'none'; // 재고 조정 취소 버튼 숨김
}

//재고 조정 -> 저장 버튼 클릭시
function saveStockAdjustment() {
    const adjustStockQty = $("#adjustStockQty").val();
    const adjustStockReason = $("#adjustStockReason").val(); // 수정된 부분
    const gdsCode = "${gdsVO.gdsCode}"; // JSP에서 gdsCode 값을 가져옵니다.

    $.ajax({
        url: '/frcs/stockFrcsUpdateAjax',
        type: 'POST',
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify({
            gdsCode: gdsCode,
            bzentNo: bzentNo, 
            qty: adjustStockQty,
            ajmtRsn: adjustStockReason // 수정된 부분
        }),
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); // CSRF 토큰 추가
        },
        success: function (response) {
            Swal.fire({
                title: "재고 조정",
                text: "재고가 조정되었습니다.",
                icon: "success",
                confirmButtonColor: "#00C157",
                confirmButtonText: "확인",
            }).then((result) => {
                closeModal(); // 모달 닫기
                location.reload(); // 페이지 새로고침
            });
        },
        error: function (xhr, status, error) {
            Swal.fire({
                title: "오류",
                text: "재고 조정 중 오류가 발생했습니다: " + error,
                icon: "error",
                confirmButtonColor: "#FF0000",
                confirmButtonText: "확인",
            });
        }
    });
}

//모달 열기
function openModal() {
    $('#stockAdjustmentModal').modal('show');
}

//모달 닫기
function closeModal() {
    // 모달을 숨기기
    $('#stockAdjustmentModal').modal('hide');

    // 입력 필드 초기화
    document.getElementById("adjustStockQty").value = ""; // 조정 수량 초기화
    document.getElementById("adjustStockReason").value = ""; // 조정 사유 초기화

    // 경고 메시지 숨기기
    document.getElementById("stockWarning").style.display = "none";
}

</script>

<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="window.location.href='/frcs/stockList'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">재고 현황 상세</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" id="safetyStockButton" class="btn-default" onclick="enableSafetyStock();">안전 재고 설정</button>
			<button type="button" id="stockAdjustmentButton" class="btn-active" onclick="openModal();">재고 조정</button>
			<button type="button" id="cancelButton" class="btn-danger" style="display: none;" onclick="cancelEdit();">취소</button>
			<button type="button" id="saveButton" class="btn-active" style="display: none;" onclick="saveChanges();">저장</button>
			<button type="button" id="stockAdjustmentCancelButton" class="btn-danger" style="display: none;" onclick="cancelStockAdjustment();">취소</button>
			<button type="button" id="stockAdjustmentSaveButton" class="btn-active" style="display: none;" onclick="saveStockAdjustment();">저장</button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="cont">
		<table class="table-blue">
			<tbody>
				<tr>
					<th>상품 명</th>
					<td>${gdsVO.gdsNm}</td>
					<th>상품 코드</th>
					<td>${gdsVO.gdsCode}</td>
				</tr>
				<tr>
					<th>대유형</th>
					<td><c:choose>
							<c:when
								test="${gdsVO.gdsType == 'FD01' || gdsVO.gdsType == 'FD02' || gdsVO.gdsType == 'FD03' || gdsVO.gdsType == 'FD04' || gdsVO.gdsType == 'FD05' || gdsVO.gdsType == 'FD06'}">
                            	식품
                            </c:when>
							<c:when
								test="${gdsVO.gdsType == 'SM01' || gdsVO.gdsType == 'SM02' || gdsVO.gdsType == 'SM03'}">
                            	부자재
                            </c:when>
							<c:when test="${gdsVO.gdsType == 'PM01'}">
                               	포장재
                            </c:when>
							<c:otherwise>기타</c:otherwise>
						</c:choose></td>
					<th>소유형</th>
					<td><c:choose>
							<c:when test="${gdsVO.gdsType == 'FD01'}">
								<span class="bge bge-active">축산</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'FD02'}">
								<span class="bge bge-active">농산물</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'FD03'}">
								<span class="bge bge-active">유제품</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'FD04'}">
								<span class="bge bge-active">베이커리</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'FD05'}">
								<span class="bge bge-active">조미료/소스</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'FD06'}">
								<span class="bge bge-active">냉동식품</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'PM01'}">
								<span class="bge bge-danger">일회 용품</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'SM01'}">
								<span class="bge bge-warning">매장 소모품</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'SM02'}">
								<span class="bge bge-warning">조리 용품</span>
							</c:when>
							<c:when test="${gdsVO.gdsType == 'SM03'}">
								<span class="bge bge-warning">위생 용품</span>
							</c:when>
							<c:otherwise>기타</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>단위</th>
					<td>${gdsVO.unitNm}</td>
					<th>단가(원)</th>
					<td class="right"><fmt:formatNumber
							value="${gdsVO.stockVOList[0].gdsAmtVOList[0].amt}"
							pattern="#,###" /></td>
				</tr>
				<tr>
					<th>재고 수량</th>
					<td class="right"
						style="<c:choose>
                               <c:when test='${gdsVO.stockVOList[0].qty < gdsVO.stockVOList[0].sfStockQty}'>
                                  color: red;
                               </c:when>
                           </c:choose>">
						${gdsVO.stockVOList[0].qty}</td>
					<th>안전 재고</th>
					<td><input type="text" id="safetyStockInput"
						style="text-align: right;" class="text-input"
						value="${gdsVO.stockVOList[0].sfStockQty}" disabled></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<!-- 모달 구조 -->
<!-- <div class="modal fade" id="stockAdjustmentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true"> -->
<!--     <div class="modal-dialog"> -->
<!--         <div class="modal-content"> -->
<!--         	<div class="modal-header"> -->
<!--         		<div> -->
<!-- 					<h4 class="modal-title">재고 조정</h4> -->
<!-- 				</div> -->
<!--             	<table class="table-blue"> -->
<!--                 	<tbody> -->
<!--                     	<tr> -->
<!--                         	<th class="center">조정 수량</th> -->
<!--                         	<td> -->
<!--                            		<input type="text" id="adjustStockQty" style="text-align:right;" class="text-input" oninput="stockAdjustCheck()"> -->
<!--                            		<div id="stockWarning" style="color: red; display: none;">현재고 수량 초과입니다.</div> -->
<!--                         	</td> -->
<!--                     	</tr> -->
<!--                     	<tr> -->
<!--                         	<th class="center">조정 사유</th> -->
<!--                         	<td><textarea id="adjustStockReason" class="text-input" rows="4" style="width: 100%;"></textarea></td> -->
<!--                     	</tr> -->
<!--                 	</tbody> -->
<!--             	</table> -->
<!--             	<div class="btn-wrap"> -->
<!--                		<button type="button" class="btn-danger" onclick="closeModal()">취소</button> -->
<!--                 	<button type="button" class="btn-active" onclick="saveStockAdjustment()">저장</button> -->
<!--             	</div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->

<!-- 모달 구조 -->
<div class="modal fade" id="stockAdjustmentModal"
	data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">재고 조정</h4>
				<div class="btn-cont">
					<button type="button" class="btn-danger" onclick="closeModal()">취소</button>
					<button type="button" class="btn-active" onclick="saveStockAdjustment()">저장</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="adjustStockQty" class="control-label">조정 수량</label> 
					<input type="text" id="adjustStockQty" style="text-align: right; margin-top:10px;" class="form-control" oninput="stockAdjustCheck()">
					<div id="stockWarning" style="color: red; display: none;">현재고
						수량 초과입니다.</div>
				</div>
				<div class="form-group">
					<label for="adjustStockReason" class="control-label">조정 사유</label>
					<textarea id="adjustStockReason" class="form-control" rows="10" cols="50" style="width: 100%; margin-top:10px;"></textarea>
				</div>
			</div>
		</div>
	</div>
</div>
