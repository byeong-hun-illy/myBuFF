<!-- 점검할 가맹점의 목록들의 모달창 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 가맹점 추가 모달 창 -->
<div class="modal fade" id="bzentInsert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">업체 선택</h4>
			</div>
			<div>
			  	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
   		</div>
      <div class="modal-body wrap">
				<!-- 기본 태그 -->
	<div class="cont">
			<!-- 검색 조건 시작 -->
			<div class="search-wrap">
				<div class="search-cont">
					<p>업체유형</p>
					<div class="select-custom select-bzentType" style="width: 100px;">
						<select name="bzentType" id="bzentType">
							<option value="" selected>전체</option>
							<option value="BZ_F">가맹점</option>
							<option value="BZ_C">거래처</option>
						</select>
					</div>
				</div>
				<div class="search-cont">
					<p>지역</p>
					<select name="rgnNo" id="rgnNo" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
				<div class="search-cont">
					<p>업체명</p>
					<input type="text" id="bzentNm" name="bzentNm" placeholder="검색어를 입력하세요" />
				</div>
			</div>
		</div>
		<!-- 검색 조건 끝 -->

		<!-- 테이블 디자인 1 -->
		<div class="cont">
			<div class="table-wrap">
			<!-- 테이블 분류 시작 -->
				<div class="tap-btn-wrap">
					<div class="tap-wrap">
						<div data-bzent-type='' class="tap-cont active">
							<span class="tap-title">전체</span>
							<span class="bge bge-default" id="tap-all"></span>
						</div>
						<div data-bzent-type='BZ_F' class="tap-cont" >
							<span class="tap-title">가맹점</span>
							<span class="bge bge-info" id="tap-frcs"></span>
						</div>
						<div data-bzent-type='BZ_C' class="tap-cont">
							<span class="tap-title">거래처</span>
							<span class="bge bge-warning" id="tap-cntp"></span>
						</div>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default bzent-list">
					<thead>
						<tr>
							<th class="center" style="width: 147px;">번호</th>
							<th class="left sort sort-frcs active" style="width: 290px;" data-sort="bzentNm">업체명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc active">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center" style="width: 147px;">지역</th>
							<th class="center" style="width: 237px;">담당자명</th>
							<th class="center">업체유형</th>
						</tr>
					</thead>
					<tbody id="table-body" class="table-errorn bzent-list-tbody">
					</tbody>
				</table>
			</div>
		<!-- table-wrap -->
		</div>
	<!-- /테이블 디자인 1 -->
	</div>
	<!-- cont 끝 -->

      </div>
      <!-- modal-body 끝 -->
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
<!-- 가맹점주 모달창 끝 -->

