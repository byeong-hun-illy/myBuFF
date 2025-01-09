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
<link href="/resources/cnpt/css/stock.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/cnpt/js/gds.js"></script>
<script src="/resources/cnpt/js/stock.js"></script>
<script src='/resources/js/global/value.js'></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let bzentNo = "${user.bzentNo}";
console.log("bzentNo : ", bzentNo);

let mbrId = '<c:out value="${user.mbrId}"/>';
// let urlParams = new URLSearchParams(window.location.search);
//let gdsCode = urlParams.get('gdsCode');
let gdsCode = '${param.gdsCode}';
let stockVO;
let stockAjmtVO;
let gdsNm = '${gdsNm}';
console.log("gdsNm : ", gdsNm);

const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

console.log("gdsCode", gdsCode);

$(function(){
	select2Custom();
	
	// 페이지 로드 시 저장 버튼 비활성화
    $("#saveBtn").prop("disabled", true).removeClass("btn-active").addClass("btn-default");
	
	// gdsNm 값을 다시 설정하지 않도록 주의
    if (!$('#gdsNm').val()) {
        $('#gdsNm').val('${gdsNm}');
    }
	
	$('#mbrId').val(mbrId);
	$('#mbrNm').val('<c:out value="${user.mbrNm}"/>');
	$('#mbrEmlAddr').val('<c:out value="${user.mbrEmlAddr}"/>');
	let telno = '<c:out value="${user.mbrTelno}"/>'
	let telnoArr = splitTel(telno);
	$('#mbrTelno1').val(telnoArr[0]);
	$('#mbrTelno2').val(telnoArr[1]);
	$('#mbrTelno3').val(telnoArr[2]);
	
	if (gdsCode) { // 재고 조정 - 파라미터로 넘어온 gdsCode가 있으면
		$("#gdsNm").val(gdsNm);
		$("#gdsNm").attr("disabled", true);
		
		// 사용자가 저장 버튼을 클릭했을 때, insertStockQty() 함수 호출
		$("#saveBtn").on("click", function(){
			// 기본 동작 방지
			insertStockQty();		
		});
	} else{ 
		// gdsCode가 없으면 재고리스트를 보여줌 -> 추후에 같은 틀에 상품만 선택할수 있게 
		$("#gdsNm").removeAttr("disabled").on("click", function(){
			console.log("gdsNm 영역 클릭됨.");
			$("#gdsModal").modal("show");
			openGdsModal();
		});
		
	}	
	
	// 모달 닫기 버튼 클릭시 이벤트
	$(".modal-close").on("click", function(){
		$("#gdsModal").modal("hide");
	})
	
	 // 필수 입력 필드 변화 시마다 validateInputs() 호출
    $('#qty, #stockAjmtType').on('input change', function() {
        validateInputs();
    });

	// 저장 버튼 클릭시 이벤트 핸들러
	$("#saveBtn").on("click", function(){ 
	    insertStockQty();
	});
	
	
})

	
</script>
<div class="content-header">
  <div class="container-fluid">
    <div class="crow mb-2 justify-content-between">
      	<div class="crow align-items-center">
      		<button type="button" onclick="location.href='/cnpt/stockAjmt/list'" 
      				class="btn btn-default mr-3"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 gds-qty">재고 조정</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-active gds-qty" id="saveBtn" 
					>저장 <span class="icon material-symbols-outlined">East</span></button>
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
						<c:if test="${empty gdsCode}">
						    <!-- gdsCode가 없을 때 처리할 내용 -->
						    <input id="gdsNm" type="text" class="text-input input-reset input-gds" placeholder="상품을 선택하세요" />
						</c:if>
						<c:if test="${not empty gdsCode}">
						    <!-- gdsCode가 있을 때 처리할 내용 -->
						    <input id="gdsNm" type="text" class="text-input input-reset input-gds" value="${gdsNm}" disabled />
						</c:if>
						<input type="hidden" id="bzentNo" value="${bzentNo}" />	   
					</td>
					<th>조정 유형<span class="es gds-insert">*</span></th>
					<td style="width: 37%" class="stockAjmtType">
						<div class="select-custom" style="width:200px;">
							<select name="stockAjmtType" id="stockAjmtType" class="input-reset input-gds">
								<option value="" selected>미선택</option>
								<option value="AJMT01" class="ajmt" selected>입고 </option>
								<option value="AJMT02" class="ajmt">폐기</option>
							</select>
						</div>	
					</td>
				</tr>
				<tr>
					<th>수량 <span class="es gds-insert">*</span></th>
					<td>
						<input id="qty" type="text" class="text-input input-reset input-gds">
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
	
	<div class="cont">
		<!-- table-wrap 등록자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>등록자 정보  <span class="es gds-insert">*</span></div> 
			</div>
			<table class="table-blue">
				<tr>
					<th>이름</th>
					<td>
						<div class="input-wrapper">
							<input id="mbrNm" disabled>
						</div>
					</td>
					<th class="gds-insert">아이디</th>
					<td class="gds-insert">
						<input id="mbrId" disabled class="text-input">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input id="mbrTelno1" type="text" class="input-tel" disabled>-
						<input id="mbrTelno2" type="text" class="input-tel" disabled>-
						<input id="mbrTelno3" type="text" class="input-tel" disabled>
					</td>
					<th>이메일</th>
					<td>
						<input id="mbrEmlAddr" class="text-input" disabled>
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap 가맹점주 정보 -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
</div>
<!-- wrap 끝 -->


<!-- 상품 리스트 모달 -->
<div class="modal fade" id="gdsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-large modal-dialog-centered">
			<div class="modal-content">
<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상품 리스트</h4>
					<button type="button" class="modal-close" data-bs-dismiss="modal">닫기</button>
				</div>
<!-- Modal body -->
				<div class="modal-body">
					<div class="table-wrap">
						<table class="table-blue">
				            <thead class="gds-modal-table">
				                <tr class="modal-tr gds-modal-table">
				                    <th class="modal-th" style="width:255px;">상품 명</th>
				                    <th class="modal-th">단위</th>
				                </tr>
				            </thead>
				            <tbody id="gdsModalTableBody" style="width:182%;">
				                <!-- 상품 리스트가 여기에 동적으로 채워짐 -->
				            </tbody>
				        </table>
				    </div>    
				</div>
			</div>
		</div>
<!-- modal창 끝--> 
</div>








