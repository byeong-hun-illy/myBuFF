<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 가맹점 정보 (폐업, 점검) -->
<div class="modal fade" id="frcsInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
    	<div class="modal-header row align-items-center justify-content-between">
				<div>
					<h4 class="modal-title modal-check">점검 상세</h4>
					<h4 class="modal-title modal-clsbiz">폐업 상세</h4>
				</div>
				<div>
					<button type="button" class="btn btn-danger modal-check" id="deleteFrcsCheck">삭제</button>
				  	<button type="button" class="btn btn-default modal-check" data-dismiss="modal">취소</button>
				  	<button type="button" class="btn btn-danger modal-clsbiz" id="updateClsbiz">폐업</button>
				  	<button type="button" class="btn btn-default modal-clsbiz" data-dismiss="modal">취소</button>
				</div>
      		</div>
      <div class="modal-body wrap">
      	<div class="cont modal-frcs">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>가맹점 정보 <span id="storelink"></span></div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>가맹점 이름</th>
					<td id="modal-bzentNm"></td>
					<th>가맹점 상태</th>
					<td id="modal-frcsType"></td>
				</tr>
				<tr>
					<th>지역</th>
					<td id="modal-rgnNm"></td>
					<th>전화 번호</th>
					<td id="modal-bzentTelno">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
      	<div class="cont modal-frcs">
      	<!-- table-wrap 가맹점주 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>가맹점주 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>이름</th>
					<td id="modal-mbrNm">
					</td>
					<th>전화번호</th>
					<td id="modal-mbrTelno">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	
      	<!-- /. cont끝 -->
      	<div class="cont modal-frcs">
      	<!-- table-wrap 관리자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자 정보</div> 
			</div>
			<table class="table-blue modal-table">
					<tr>
						<th>이름</th>
						<td id="modal-mngrNm">
						</td>
						<th>전화번호</th>
						<td id="modal-mngrTelno">
						</td>
					</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	<!-- /. cont끝 -->
           	<div class="cont modal-check">
      	<!-- table-wrap 점검자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>점검자 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>이름</th>
					<td id="modal-insctrNm">
					</td>
					<th>전화번호</th>
					<td id="modal-insctrTelno">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
      	</div>
      	<!-- /. cont끝 -->
      		<!-- 기본 태그 -->
	<div class="cont modal-check">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>점검 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>점검 일자</th>
					<td id="modal-chckYmd">
					</td>
					<th>총 점수</th>
					<td id="modal-totStr">
					</td>
				</tr>
				<tr>
					<th>위생 점수</th>
					<td id="modal-clenScr">
					</td>
					<th>서비스 점수</th>
					<td id="modal-srvcScr">
					</td>
				</tr>
				<tr>
					<th>점검 내용</th>
					<td colspan="3" id="modal-chckCn">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	<!-- 기본 태그 -->
	<div class="cont modal-clsbiz">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>폐업 정보</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					<th>폐업유형</th>
					<td id="modal-clsbiz"></td>
					<th>승인일자</th>
					<td id="modal-aprvYmd"></td>
				</tr>
				<tr>
					<th>폐업일자</th>
					<td id="modal-clsbizYmd"></td>
					<th>사유유형</th>
					<td id="modal-clsType"></td>
				</tr>
				<tr>
					<th>사유</th>
					<td colspan="3" id="modal-clsbizRsn">
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->

      </div>
      <!-- modal-body 끝 -->
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 가맹점주 모달창 끝 -->
