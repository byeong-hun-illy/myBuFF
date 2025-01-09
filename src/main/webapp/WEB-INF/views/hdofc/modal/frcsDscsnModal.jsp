<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 점검 상세 모달 -->
<div class="modal fade" id="frcsDscsnModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content frcsDscsnModal">
    	<div class="modal-header row align-items-center justify-content-between">
				<div>
					<h4 class="modal-title">상담 상세</h4>
				</div>
				<div>
				  	<button type="button" class="btn btn-danger modal-dsc01" data-dismiss="modal" id="noAprv" style="display: none;">미승인</button>
				  	<button type="button" class="btn btn-active modal-dsc01" id="okAprv" style="display: none;">승인</button>
				  	<button type="button" class="btn btn-danger modal-dsc" id="updateDscsn" style="display: none;">저장</button>
				  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
      		</div>
      <div class="modal-body wrap">
      	<div class="cont">
      	<!-- table-wrap 가맹점주 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>가맹점주 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>이름</th>
					<td id="dscsn-mbrNm">
					</td>
					<th>아이디</th>
					<td id="dscsn-mbrId">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td id="dscsn-mbrTelno">
					</td>
					<th>이메일</th>
					<td id="dscsn-mbrEmlAddr">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	
      	<!-- /. cont끝 -->
      	
      	<div class="cont">
      	<!-- table-wrap 관리자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자 정보</div> 
			</div>
			<table class="table-blue modal-table">
					<tr>
						<th>이름</th>
						<td>
							<div class="input-wrapper">
								<input id="dscsn-mngrNm" type="text">
								<input id="dscsn-mngrId" type="text" hidden>
								<button type="button" class="update-btn update-mngr"></button>
							</div>
						</td>
						<th>전화번호</th>
						<td>
							<div class="tel-wrap">
								<input disabled id="dscsn-mngrTelno1" type="text" class="input-tel">-
								<input disabled id="dscsn-mngrTelno2" type="text" class="input-tel">-
								<input disabled id="dscsn-mngrTelno3" type="text" class="input-tel">
							</div>
						</td>
					</tr>
			</table>
		</div>
<!-- 		/.table-wrap -->
		</div>
		<!-- /. cont끝 -->
		
      	<div class="cont">
      	<!-- table-wrap 관리자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>상담 정보</div> 
			</div>
			<table class="table-blue modal-table">
					<tr>
						<th>상담유형</th>
						<td id="dscsn-dscsnType"></td>
						<th>개업여부</th>
						<td id="dscsn-frcs"></td>
					</tr>
					<tr>
						<th>희망지역</th>
						<td>
							<select name="rgnNo" id="dscsn-rgnNm">
								<option value="">전체</option>
								<c:forEach var="rgn" items="${rgn}">
									<option value="${rgn.comNo}">${rgn.comNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>상담일자</th>
						<td>
							<input type="date" id="dscsn-dscsnPlanYmd">
						</td>
					</tr>
					<tr class="modal-dsc" style="display:none;">
						<th>내용</th>
						<td colspan="3">
							<textarea id="dscsn-dscsnCn" rows="" cols=""></textarea>
						</td>
					</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	<!-- /. cont끝 -->

      </div>
      <!-- modal-body 끝 -->
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 가맹점주 모달창 끝 -->
