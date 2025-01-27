<!-- 점검할 가맹점의 목록들의 모달창 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="frcsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">가맹점 선택</h4>
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
					<p>관리자</p>
					<select name="mngrId" id="mngrId" class="select2-custom">
						<option value="" selected>전체</option>
						<c:forEach var="mngr" items="${mngr}">
							<option value="${mngr.mbrId}">${mngr.mbrNm}(${mngr.mbrId})</option>
						</c:forEach>
					</select>
				</div>
				<div class="search-cont w-150">
					<p>지역</p>
					<select name="rgnNo" id="rgnNo" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
				<div class="search-cont">
					<p>검색어</p>
					<div class="search-input-btn">
					<div class="select-custom w-150">
						<select name="gubun" id="gubun">
							<option value="">전체</option>
							<option value="bzentNm">가맹점명</option>
							<option value="mbrNm">가맹점주명</option>
						</select>
					</div>
						<input name="keyword" id="keyword" type="text" placeholder="입력해주세요" class="search-input"/>
						<button type="button" id="submit" class="search-btn"></button>				
					</div>
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
						<div data-type='' class="tap-cont">
							<span class="tap-title">전체</span>
							<span class="bge bge-default" id="tap-all"></span>
						</div>
						<div data-type='chk' class="tap-cont active" >
							<span class="tap-title">점검 예정</span>
							<span class="bge bge-active" id="tap-check"></span>
						</div>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
			
				<table class="table-default">
					<thead>
						<tr>
							<th class="center" style="width:10%;">번호</th>
							<th class="center sort sort-frcs" data-sort="bzentNm" style="width:25%;">가맹점명
							<div class="sort-icon" >
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="mbrNm" style="width:10%;">가맹점주명
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="mngrNm" style="width:10%;">관리자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs active" data-sort="chckYmd" style="width:15%;">최근 점검일자
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc active">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="totScr" style="width:10%;"> 점수
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
							<th class="center sort sort-frcs" data-sort="rgnNo" style="width:20%;">지역
							<div class="sort-icon">
								<div class="sort-arrow">
								  <span class="sort-asc">▲</span>
								  <span class="sort-desc">▼</span>
								</div>
							</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-body" class="table-error">
					</tbody>
				</table>
				<div class="pagination-wrap">
					<div class="pagination">
					</div>
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
</div>
<!-- 가맹점주 모달창 끝 -->