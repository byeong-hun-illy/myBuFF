<!-- 재고조정을 위해 상품을 출력 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 메뉴에서 상품 추가 -->
<div class="modal fade" id="gdsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">상품 추가</h4>
			</div>
			<div>
<!-- 				<button class="btn btn-default" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button> -->
			  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
   		</div>
      <div class="modal-body">
      <div class="wrap">
      <!-- 가맹점주 선택 -->
      	<div class="cont">
			<!-- 검색 조건 시작 -->
			<div class="search-wrap">
				<!-- 소유형 검색조건 -->
				<div class="search-cont w-200">
					<p class="search-title">유형</p>
					<select name="gdsType" id="gdsTypeModal" class="select2-custom">
						<option value="">전체</option>
						<option value="FD01" class="fd">축산 </option>
						<option value="FD02" class="fd">농산물 </option>
						<option value="FD03" class="fd">유제품</option>
						<option value="FD04" class="fd">베이커리</option>
						<option value="FD05" class="fd">조미료/소스</option>
						<option value="FD06" class="fd">냉동식품</option>
						<option value="FD07" class="fd">기타</option>
					</select>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상품명</p>
					<div class="search-input-btn">
						<input type="text" id="gdsNmModal" name="gdsNmModal" placeholder="키워드를 입력하세요"> 
						<button type="button" id="searchBtn" class="search-btn"></button>
					</div>
				</div>
			</div>
      </div>
		<!-- 검색 조건 끝 -->
		<div class="cont">
		<!-- 테이블 분류 시작 -->
		<div class="table-wrap">
				<div class="tap-wrap">
					<div class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all-gds"></span>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
		<!-- 테이블 시작 -->
		<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width: 10%;">번호</th>
							<th class="center sort sort-gds active" data-sort="gdsNm">
								상품명
								<div class="sort-icon" style="width: 30%;">
									<div class="sort-arrow">
									  <span class="sort-asc active">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-gds" data-sort="qty" style="width: 20%;">
								수량
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-gds" data-sort="unitNm" style="width: 20%;">
								단위
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-gds" data-sort="gdsType" style="width: 20%;">
								유형
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-gds" class="table-error">
					</tbody>
				</table>
				<div class="pagination-wrap">
					<div class="pagination" id="gdspage">
					</div>
				</div>
			</div>
		<!-- 테이블 끝 -->
		</div>
      	</div>
      	<!-- 선택 끝 -->
      </div>
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 가맹점주 모달창 끝 -->