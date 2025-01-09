<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--
 	@fileName    : selectFaq.jsp
 	@programName : faq 조회
 	@description : 사용자가  faq를 조회하는 화면
 	@author      : 서윤정
 	@date        : 2024. 09. 13
--%>


<script>

//@methodName  : toggleAccordion(element) {
//@author      : 서윤정
//@date        :  2024. 09. 13
//@param       : onclick="toggleAccordion(this)
//@return      : 없음
//@description : 해당 faq를 클릭하면 아코디언이 열리면서 답변을 볼 수 있음
	function submitForm() {
		document.getElementById('faqForm').submit();
	}

	function toggleAccordion(element) {
		var collapseRow = element.nextElementSibling;
		var isVisible = collapseRow.classList.contains('show');

		// Hide all open rows
		document.querySelectorAll('.accordion-collapse').forEach(function(row) {
			row.classList.remove('show');
		});

		// Toggle the clicked row
		if (!isVisible) {
			collapseRow.classList.add('show');
		}
	}
</script>

<style>
/* 고객센터 제목 */
h1 {
    font-size: 2.2rem; /* 더 큰 사이즈로 설정 */
    font-weight: 700;
    color: var(--text--primary); /* 강조된 텍스트 색상 */
    text-align: center; /* 중앙 정렬 */
    margin-bottom: 20px;
}

/* 상단 메뉴 (공지사항 등) */
.menu {
    display: flex;
    justify-content: center;
    gap: var(--gap--m);
    padding: 10px 0;
}

/* 상단 메뉴 (공지사항 등) */
.page-menu {
    display: flex;
    justify-content: right;
    gap: var(--gap--m);
    padding: 10px 0;
}

.menu-item {
	font-size: var(- -accent--size);
	font-weight: var(- -container--title--weight);
	padding: var(- -pd--s) var(- -pd--m);
	color: var(- -text--primary);
}

.menu-item.active {
	border-bottom: 3px solid var(- -red--5);
	color: var(- -red--5);
}

.menu-item:hover {
	color: var(- -red--5);
}

/* 검색 영역 스타일 */
.search-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: var(- -gap--m);
	padding: var(- -pd--m);
	background-color: var(- -gray--05);
	border-radius: var(- -radius--m);
}

.search-input-btn {
	position: relative;
	width: 100%;
	max-width: 600px;
}

.search-input {
	width: 100%;
	padding: 15px;
	border: 1px solid var(- -border--primary);
	border-radius: var(- -radius--m);
	font-size: var(- -primary--size);
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
}

.search-btn {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	background: url('/resources/images/common/search.png') no-repeat center;
	background-size: 20px 20px;
	width: 40px;
	height: 40px;
	cursor: pointer;
}

/* 테이블 영역을 고정 크기로 설정 */
.table-responsive {
	max-height: 400px;
	overflow-y: auto;
	border: 1px solid var(- -border--primary);
}

/* 테이블 셀 내용 overflow 방지 */
.table-default th, .table-default td {
	text-align: center;
	word-wrap: break-word;
	max-width: 200px;
}

/* 아코디언 컨텐츠 스타일 */
.accordion-collapse {
	display: none;
	padding: var(- -pd--s);
	background-color: var(- -gray--1);
	border-top: 1px solid var(- -border--primary);
}

.accordion-collapse.show {
	display: table-row;
}

.accordion-item {
	cursor: pointer;
}

/* 기본 라디오 버튼 숨기기 */
.search_category input[type="radio"] {
	display: none;
}

/* 라디오 버튼 레이블 스타일 */
.search_category label.faq_category {
	display: inline-block;
	padding: 10px 20px;
	margin: 0 5px;
	border-radius: var(- -radius--m);
	border: 1px solid var(- -border--primary);
	background-color: var(- -gray--0);
	color: var(- -text--secondary);
	cursor: pointer;
	font-size: var(- -primary--size);
	transition: background-color 0.3s, color 0.3s;
}

/* 선택된 라디오 버튼 스타일 */
.search_category input[type="radio"]:checked+span {
	background-color: var(- -btn--active);
	color: var(- -text--white);
	border: 1px solid var(- -btn--active);
}

/* 호버 상태에서 선택된 상태 스타일을 유지하도록 */
.search_category input[type="radio"]:checked+span:hover {
	background-color: var(- -btn--active); /* 선택된 상태 유지 */
	color: var(- -text--white);
}

/* 선택 불가능 상태 (선택 사항) */
.search_category label.faq_category.disabled {
	background-color: var(- -gray--2);
	color: var(- -text--placeholder);
	cursor: not-allowed;
}
</style>

<div class="location-wrap">
	<div class="location-container">
		<div class="page_navi">
			<a href="/buff/home"><span>HOME</span></a> > <span>고객센터</span> > <span>FAQ</span>
		</div>
		 <div class="page-menu">
            <div class="menu-item active">
                <a href="/center/selectNotice"><span>공지사항</span></a>
            </div>
            <div class="menu-item">
                <a href="/center/selectFaq"><span>FAQ</span></a>
            </div>
            <div class="menu-item">
                <a href="/center/insertQs"><span>문의</span></a>
            </div>
        </div>
    </div>
</div>

<div class="cont">
	<div class="cont-wrap">
		<div class="search-wrap">
			<form id="faqForm" method="GET" action="/center/selectFaq">
				<div class="search_category">
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="" checked="checked" onclick="submitForm()" /> <span>전체</span>
					</label> 
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="QS01" onclick="submitForm()" /> <span>구매</span>
					</label> 
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="QS02" onclick="submitForm()" /> <span>매장이용</span>
					</label> 
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="QS03" onclick="submitForm()" /> <span>채용</span>
					</label> 
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="QS04" onclick="submitForm()" /> <span>가맹점</span>
					</label> 
					<label class="faq_category"> 
						<input type="radio" name="faqCategory" value="QS05" onclick="submitForm()" /> <span>기타</span>
					</label>
				</div>
			</form>
		</div>

		<div class="cont-table">
			<div class="table-responsive">
				<table class="table-default">
					<thead>
						<tr>
							<th class="center">구분</th>
							<th class="center">제목</th>
						</tr>
					</thead>
					<tbody id="table-body">
						<c:forEach var="faqVO" items="${faqVOList}">
							<tr class="accordion-item" onclick="toggleAccordion(this)">
								<td>
									<c:choose>
										<c:when test="${faqVO.qsType == 'QS01'}">구매</c:when>
										<c:when test="${faqVO.qsType == 'QS02'}">매장이용</c:when>
										<c:when test="${faqVO.qsType == 'QS03'}">채용</c:when>
										<c:when test="${faqVO.qsType == 'QS04'}">가맹점</c:when>
										<c:when test="${faqVO.qsType == 'QS05'}">기타</c:when>
										<c:otherwise>알 수 없음</c:otherwise>
									</c:choose>
								</td>
								<td>${faqVO.faqTtl}</td>
							</tr>
							<tr class="accordion-collapse">
								<td colspan="3">
									<div class="accordion-body" style="overflow: auto;">
										${faqVO.faqCn}</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
