<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%--
    @fileName    : selectNotice.jsp
    @programName : 고객센터_ 공지사항 화면
    @description : 모든 회원이   buff 공지사항을 조회할 수 있음
    @author      : 서윤정
    @date        : 2024.09.13
--%>

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

/* 기본 라디오 버튼 숨기기 */
.search_category input[type="radio"] {
    display: none;
}

/* 라디오 버튼 레이블 스타일 */
.search_category label.faq_category {
    display: inline-block;
    padding: 10px 20px;
    margin: 0 5px;
    border-radius: var(--radius--m);
    border: 1px solid var(--border--primary);
    background-color: var(--gray--0);
    color: var(--text--secondary);
    cursor: pointer;
    font-size: var(--primary--size);
    transition: background-color 0.3s, color 0.3s;
}

/* 선택된 라디오 버튼 스타일 */
.search_category input[type="radio"]:checked+span {
    background-color: var(--btn--active);
    color: var(--text--white);
    border: 1px solid var(--btn--active);
}

/* 호버 상태에서 선택된 상태 스타일을 유지하도록 */
.search_category input[type="radio"]:checked+span:hover {
    background-color: var(--btn--active); /* 선택된 상태 유지 */
    color: var(--text--white);
}

/* 검색 영역 스타일 */
.search-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: var(--gap--m);
    padding: var(--pd--m);
    background-color: var(--gray--05); /* 배경색 추가 */
    border-radius: var(--radius--m);
}

.search-input-btn {
    position: relative;
    width: 100%;
    max-width: 600px; /* 검색창의 적당한 너비 */
}

.search-input {
    width: 100%;
    padding: 15px;
    border: 1px solid var(--border--primary);
    border-radius: var(--radius--m);
    font-size: var(--primary--size);
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
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
</style>

<div class="location-wrap">
    <div class="location-container">
        <div class="page_navi">
            <a href="/buff/home"><span>HOME</span></a> > <span>고객센터</span> > <span>공지사항</span>
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
        <form id="noticeForm" method="get" action="/center/selectNotice">
            <div class="search-wrap">
                <div class="search-cont">
                	<label for="category">검색 대상 선택</label>
                	<select id="category" name="noticeCategory">
                		<option value="" selected>전체</option>
                		<option value="ntcTtl"
                			<c:if test="${param.noticeCategory=='ntcTtl'}">selected</c:if>
                		>제목</option>
                		<option value="ntcCn" <c:if test="${param.noticeCategory=='ntcCn'}">selected</c:if>
                		>내용</option>
                	</select>
                    <div class="search-input-btn">
                        <input type="text" name="keyword" placeholder="제목과 내용을 입력해주세요"  class="search-input" style="width: 500px;" value="${param.keyword}"/>
                        <button type="submit" class="search-btn"></button>
                    </div>
                </div>
            </div>
        </form>

        <table class="table-default">
            <thead>
                <tr>
                    <th class="center">번호</th>
                    <th class="left">제목</th>
<!--                     <th class="center">등록일자</th> -->
                    <th class="center">조회수</th>
                </tr>
            </thead>
            <tbody id="table-body">
                <c:forEach var="noticeVO" items="${noticeVOList}">
                    <tr>
                        <td style="text-align: center;">${noticeVO.ntcSeq}</td>
                        <td><a href="/center/selectNoticeDetail?ntcSeq=${noticeVO.ntcSeq}">${noticeVO.ntcTtl}</a></td>
<%--                         <td style="text-align: center;"><fmt:formatDate value="${noticeVO.wrtrDt}" pattern="yy/MM/dd" /></td> --%>
                        <td style="text-align: center;">${noticeVO.inqCnt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
