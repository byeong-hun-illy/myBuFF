<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 관리자 추가 모달 창 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">관리자 추가</h4>
			</div>
			<div>
			  	<button type="button" class="btn btn-danger frcs-insert" id="deleteMngr" data-dismiss="modal">삭제</button>
			  	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="document.getElementById('customBackdrop').style.display = 'none';">취소</button>
			</div>
   		</div>
      <div class="modal-body wrap">
      <div class="cont">
      <!-- 관리자 검색 -->
			<!-- 검색 조건 시작 -->
			<div class="search-wrap">
				<div class="search-cont w-200">
						<p>지역</p>
<!-- 						<div class="select-custom"> div 감싸주기 시작 -->
					<select name="rgnNo" id="rgn-mngr" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
<!-- 					</div> -->
				</div>	
					
				<div class="search-cont">
					<p>검색어</p>
					<div class="search-input-btn">
						<div class="select-custom w-100"> <!-- div 감싸주기 시작 -->
						<select name="gubun" id="gubun">
							<option value="">전체</option>
							<option value="mbrNm">이름</option>
							<option value="mngrId">아이디</option>
						</select>
						</div>
						<input name="keyword" id="keyword" type="text" placeholder="입력해주세요" class="search-input"/>
						<button type="button" id="submit-mngr" class="search-btn"></button>				
					</div>
				</div>
			</div>
      </div>
		<!-- 검색 조건 끝 -->
		<!-- 테이블 분류 시작 -->
		<div class="cont">
		<div class="table-wrap">
				<div class="tap-wrap">
					<div class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all-mngr"></span>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
		<!-- 테이블 시작 -->
		<table class="table-default">
					<thead>
						<tr>
							<th class="center">번호</th>
							<th class="center sort sort-mngr" data-sort="mngrId">
								아이디
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-mngr" data-sort="mngrNm">
								이름
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center">전화번호</th>
							<th class="center sort sort-mngr" data-sort="rgnNo">
								지역
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-mngr active" data-sort="jncmp">
								입사일자
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc active">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-body-mngr" class="table-error">
					</tbody>
				</table>
				<div class="pagination-wrap">
					<div class="pagination" id="mngrPage">
					</div>
				</div>
			</div>
		<!-- 테이블 끝 -->
		</div>
		</div>
      </div>
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 관리자 모달 끝 -->