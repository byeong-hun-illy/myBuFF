<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 가맹점주 추가 모달 창 -->
<div class="modal fade" id="mbrModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header row align-items-center justify-content-between">
			<div>
				<h4 class="modal-title">가맹점주 추가</h4>
			</div>
			<div>
			  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
   		</div>
      <div class="modal-body">
      <div id="selectMbr" class="wrap">
      <!-- 가맹점주 선택 -->
      	<div class="cont">
			<!-- 검색 조건 시작 -->
			<div class="search-wrap">
			<!-- 희망 지역 -->
				<div class="search-cont w-200">
					<p>희망지역</p>
					<select name="rgnNo" id="rgn-mbr" class="select2-custom">
						<option value="">전체</option>
						<c:forEach var="rgn" items="${rgn}">
							<option value="${rgn.comNo}">${rgn.comNm}</option>
						</c:forEach>
					</select>
				</div>
			
			<!-- 검색어 -->
				<div class="search-cont">
					<p>검색어</p>
					<div class="search-input-btn">
						<div class="select-custom w-100"> <!-- div 감싸주기 시작 -->
						<select name="mbrGubun" id="mbrGubun">
							<option value="">전체</option>
							<option value="mbrNm">이름</option>
							<option value="mngrId">아이디</option>
						</select>
						</div>
						<input name="mbrKeyword" id="mbrKeyword" type="text" placeholder="입력해주세요" class="search-input"/>
						<button type="button" id="submit-mbr" class="search-btn"></button>				
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
						<span class="bge bge-default" id="tap-all-mbr"></span>
					</div>
				</div>
			<!-- 테이블 분류 끝 -->
		<!-- 테이블 시작 -->
		<table class="table-default">
					<thead>
						<tr>
							<th class="center">번호</th>
							<th class="center sort sort-mbr" data-sort="mbrId">
								아이디
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-mbr" data-sort="mbrNm">
								이름
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-mbr active" data-sort="dscsn">
								상담일자
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc active">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center">전화번호</th>
							<th class="center sort sort-mbr" data-sort="rgnNo">
								희망지역
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-mbr" class="table-error">
					</tbody>
				</table>
				<div class="pagination-wrap">
					<div class="pagination" id="mbrpage">
					</div>
				</div>
			</div>
		<!-- 테이블 끝 -->
		</div>
      	</div>
      	<!-- 선택 끝 -->
      	
      	<!-- 사유 보기 -->
      	<div id="dsDtl" class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title">상담 내용</div> 
					<button class="btn btn-default mr-3" id="back"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
			</div>
			<input id="dscsnCode" type="text" hidden>
			<table class="table-blue">
				<tr>
					<th>아이디</th>
					<td><input id="mmbrId" type="text" readonly="readonly"/></td>
					<th>이름</th>
					<td><input id="mmbrNm" type="text" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input id="mmbrTelno1" type="text" class="input-tel" readonly="readonly"/>-
						<input id="mmbrTelno2" type="text" class="input-tel" readonly="readonly"/>-
						<input id="mmbrTelno3" type="text" class="input-tel" readonly="readonly"/>
					</td>
					<th>이메일</th>
					<td><input id="mmbrEml" type="text" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>상담일</th>
					<td><input id="mmPlan" type="date" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>상담 내용</th>
					<td colspan="3"><textarea id="mmCn" readonly="readonly" rows="5" cols="1" spellcheck="false"></textarea></td>
				</tr>
			</table>
		</div>
		<!-- table-wrap -->
				<div style="text-align: right;">
					<div class="warning"></div>
					<div class="btns">
					        <button type="button" id="mbrUpdate" class="btn btn-active">확인</button>
	        				<button type="button" class="btn btn-secondary modal-close" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
			<!-- form-cont끝 -->
      	</div>
		<!-- 사유 -->
      </div>
<!--       <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
<!-- 가맹점주 모달창 끝 -->