<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 발주시 상품을 선택하면 그 상품을 유통하는 거래처 조회 -->
<div class="modal fade" id="cnptGdsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">거래처 선택</h4>
			</div>
			<div>
			  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
   		</div>
      <div class="modal-body">
      <div class="wrap" style="flex-direction:row;">
			<div class="cont" style="width: 50%; height: 600px;">
			<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>최저가 정보</div> 
			<div class="bar"></div>
				<div class="chart-wrap">
				  <canvas id="myChart2" style="width:500px;"></canvas>
				</div>
			</div>
			<!-- cont끝 -->
			
			<div class="cont" style="width: 50%;">
			<!-- 테이블 분류 시작 -->
			<div class="table-wrap">
					<div class="tap-wrap">
						<div class="tap-cont active">
							<span class="tap-title">전체</span>
							<span class="bge bge-default" id="tap-cnpt"></span>
						</div>
					</div>
				<!-- 테이블 분류 끝 -->
			<!-- 테이블 시작 -->
			<table class="table-default table-cnpt-gds">
						<thead>
							<tr>
								<th class="center" style="width:20%";>번호</th>
								<th class="center" style="width:30%";>거래처명</th>
								<th class="center" style="width:20%";>보유수량</th>
								<th class="center" style="width:30%";>단가</th>
							</tr>
						</thead>
						<tbody id="table-modal" class="table-error">
						</tbody>
					</table>
				</div>
			<!-- 테이블 끝 -->
			</div>
			<!-- cont끝 -->
      	</div>
      	<!-- 선택 끝 -->
      </div>
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 가맹점주 모달창 끝 -->