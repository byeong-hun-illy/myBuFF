<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="/resources/cust/css/selectQsDtl.css" rel="stylesheet">
<link href="/resources/cust/css/selectBoard.css" rel="stylesheet">

<sec:authorize access="isAuthenticated()"> 
    <sec:authentication property="principal.memberVO" var="user" />
</sec:authorize> 



<div class="wrap menu-wrap">

	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">

		<!-- 공통 타이틀 영역 -->
		<div class="qsDtl-title">
			<span class="icon-backspace material-symbols-outlined" onclick="window.location.href='/center/selectBoard?tap=qsTap'">keyboard_backspace</span>
			
			<div class="qs-ttl" id="qsTtl">${qsVO.qsTtl}</div>
			<div class="qs-info">
				<div class="qs-type">
					<span class="bge bge-warning">
						<c:choose>
                        <c:when test="${qsVO.qsType == 'QS01'}">구매</c:when>
                        <c:when test="${qsVO.qsType == 'QS02'}">매장이용</c:when>
                        <c:when test="${qsVO.qsType == 'QS03'}">채용</c:when>
                        <c:when test="${qsVO.qsType == 'QS04'}">가맹점</c:when>
                        <c:when test="${qsVO.qsType == 'QS05'}">기타</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                     </c:choose>
					</span>
				</div>
				<div class="qs-date">${qsVO.wrtrDt}</div>
			</div>
		</div>
		<!-- /.wrap-title -->
						
		<!-- 문의 영역 -->
	 	<div class="qsDtl-content">
	 		<div class="content-cont">
	 			<!-- 문의 내용 -->
	 			<div class="qs-cn" id="qsCn">
	 				${qsVO.qsCn}
	 			</div>
	 			<!-- /.qs-cn -->
	 		
	 			<!-- 문의 파일 -->
	 			
	 			
	 			<%-- <div class="qs-file">
	 				<div class="file-title">문의 관련 파일</div>
					<button class="btn btn-default" id="downloadBtn" data-file-locate="${qsVO.fileDetailVOList[0].fileSaveLocate}" data-file-name="${qsVO.fileDetailVOList[0].fileOriginalName}">다운로드</button>

	 			</div> --%>
	 			
	 			<div class="image">
	 				<c:if test="${not empty qsVO.fileDetailVOList}">
			            <c:forEach var="file" items="${qsVO.fileDetailVOList}">
			                  <img src="${qsVO.fileDetailVOList[0].fileSaveLocate}" alt="이미지 미리보기" style="width: 200px; height: auto;">
                              <p>${qsVO.fileDetailVOList[0].fileOriginalName}</p>
			            </c:forEach>
			        </c:if>
			        <c:if test="${empty qsVO.fileDetailVOList}">
			            <p>업로드된 파일이 없습니다.</p>
			        </c:if>
	 			</div>
	 			
	 			
	 			<!-- /.qs-file -->
	 		</div>
	 		<!-- /.content-cont -->

			<!-- 답변 내용 -->
			<div class="ans-cont">
				<div class="ans-title">문의 답변</div>
				
				 <c:if test="${qsVO.ansCn != 'N'}">
                    <div class="ans-yes">
						<div class="ans-cn">
							${qsVO.ansCn}
						</div>
         				<div class="ans-dt">${qsVO.ansDt}</div>  
					</div>
                 </c:if>
                 <c:if test="${qsVO.ansCn == 'N'}">
                    <div class="ans-no">
						문의 답변 대기 중
					</div>
                 </c:if>
			</div>	
			<!-- /.ans-cont -->
					
	 	</div>
	 	<!-- /.qsDtl-content -->
	 	
	 	<div class="view-more">
	 		<div class="more-btn" onclick="window.location.href='/center/selectBoard?tap=qsTap'">
       			<span class="material-symbols-outlined">add</span>목록으로
       		</div>
		</div>
		<!-- /.view-more -->
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>










