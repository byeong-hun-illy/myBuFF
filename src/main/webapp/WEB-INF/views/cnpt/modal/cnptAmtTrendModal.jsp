<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<script src="/resources/js/jquery-3.6.0.js"></script>    
<!-- 상품 단가 변동 추이 모달 -->
 <div class="modal fade" id="amtTrendModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상품 단가 변동 추이</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal">닫기</button>
				</div>
<!-- Modal body -->
				<div class="modal-body">
					<!-- 그래프를 그릴 캔버스 -->
					<canvas id="priceChart"></canvas>
				</div>
<!-- Modal footer -->
			</div>
		</div>
<!-- modal창 끝--> 
</div>
 