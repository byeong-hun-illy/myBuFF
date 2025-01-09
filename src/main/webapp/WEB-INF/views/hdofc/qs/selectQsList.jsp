<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="/resources/js/jquery-3.6.0.js"></script>

<!-- 
로그인 안했을 때 principal.MemberVO 에서 오류 발생
 -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<%--
	@fileName    : selectFaqList.jsp
	@programName : Faq 전체 리스트 조회 화면
	@description : Faq 전체 리스트 조회 화면
	@author      : 김 현 빈
	@date        : 2024. 09. 30
--%>

<script type="text/javascript">
$(document).ready(function() {
	// 이벤트 위임을 사용하여 tap-cont 클릭 시 처리
	$(".tap-wrap").on("click", ".tap-cont", function() {
		// 모든 탭에서 active 클래스를 제거
        $(".tap-cont").removeClass("active");

        // 클릭한 탭에만 active 클래스를 추가
        $(this).addClass("active");

        // 선택된 문의 유형을 가져와 셀렉트 박스 값 변경
        let selectedQsType = $(this).data("type");
        $("#qsType").val(selectedQsType);
        
     	// localStorage에 클릭된 탭의 정보를 저장
        localStorage.setItem('selectedQsType', selectedQsType);

        // 폼 자동 제출 (새로고침 방식)
        $("#searchForm").submit();
	});
	
	$("#searchBtn").on("click",function(event){
		let qsType = $("#qsType").val();
		let qsTtl = $("#qsTtl").val();
// 		let qsCn = $("#qsCn").val();
		let bgngYmd = $("#bgngYmd").val();
		let expYmd = $("#expYmd").val();
		
		let data = {
			"qsType":qsType,
			"qsTtl":qsTtl,
// 			"qsCn":qsCn, 
			"bgngYmd":bgngYmd, 
			"expYmd":expYmd 
		};
		
		console.log("qsType : ", qsType);
		console.log("qsTtl: ", qsTtl);
// 		console.log("qsCn: ", qsCn);
		console.log("bgngYmd: ", bgngYmd);
		console.log("expYmd: ", expYmd);
		
		$("#searchForm").submit();
	});
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('.select-selected').text('전체');
		$('#qsType').val('');
		$('#bgngYmd').val('');
		$('#expYmd').val('');
		$('#qsTtl').val('');
// 		$('#qsCn').val('');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		// 새로고침하여 링크로 이동
	    window.location.href = "/hdofc/qs/selectQsList";
	})
	//.search-reset
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function(){
		console.log('요약보기 버튼 클릭됨');
		
	   	if ($(this).hasClass('active')){
	   		$(this).removeClass('active');
	   		$('.search-toggle').html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
	   		$('.search-original').slideDown(300);
	   		$('.search-summary').slideUp(300);
	   	} else {
	   		$(this).addClass('active');
	   		$('.search-toggle').html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
	   		$('.search-original').slideUp(300);
	   		$('.search-summary').slideDown(300);
	   	} 
		
	   	/* 아래 부분은 구현하는 페이지에 맞춰서 작성해주세요!! */
		// 인풋 데이터 가져오기
		let qsTypeSearch = $('#qsType option:selected').text();
		let bgngYmdSearch = $('#bgngYmd').val();
		let expYmdSearch = $('#expYmd').val();
		let qsTtlSearch = $('#qsTtl').val();
// 		let qsCnSearch = $('#qsCn').val();
		
		dateStr = `\${bgngYmdSearch} ~ \${expYmdSearch}`;
		
		// 문의 유형 데이터 입력
		if(qsTypeSearch==''){
			$('#qsTypeSummary').text('전체');
		}else {
			$('#qsTypeSummary').text(qsTypeSearch);
		}
		// 고객 작성 일자 데이터 입력
		if(bgngYmdSearch == '' && expYmdSearch == ''){
			$('#dateSummary').text('전체');
		}else {
			$('#dateSummary').text(dateStr);
		}
		// 제목 데이터 입력
		if(qsTtlSearch==''){
			$('#qsTtlSummary').text('전체');
		}else {
			$('#qsTtlSummary').text(qsTtlSearch);
		}
		// 내용 데이터 입력
// 		if(qsCnSearch==''){
// 			$('#qsCnSummary').text('전체');
// 		}else {
// 			$('#qsCnSummary').text(qsCnSearch);
// 		}
	});
	
});

//파일 다운로드
// $(document).on('click','#downloadBtn',function(){
// 	fileSaveLocate = $(this).data('fileLocate');
// 	console.log(fileSaveLocate);
// 	fileDownloadAjax(fileSaveLocate);
// });

// function getCsrfTokens() {
//     const csrfToken = $("meta[name='_csrf']").attr("content");
//     const csrfHeader = $("meta[name='_csrf_header']").attr("content");
//     return { csrfToken, csrfHeader };
// }

// function fileDownloadAjax(fileSaveLocate){
	
// 	const { csrfToken, csrfHeader } = getCsrfTokens();
	
// 	console.log("ajax=>",fileSaveLocate);
	
// 	const link = document.createElement('a');
// 	link.href = "/download?fileName=" + fileSaveLocate;  // 서버에서 전달받은 다운로드 경로
// 	link.download = fileSaveLocate; // 다운로드할 파일 이름 설정
// 	document.body.appendChild(link);
// 	link.click(); // 클릭하여 다운로드 시작
// 	document.body.removeChild(link); // 링크 제거
	
	
	/*
	$.ajax({
		url: "/download",
		type: "GET",
		data: {fileName : fileSaveLocate},
		dataType: "text",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res) {
			alert("파일 다운로드 성공");
			// 파일 다운로드를 위해 링크를 동적으로 생성
			const link = document.createElement('a');
			link.href = `/download?fileName=${qsVOList.fileDetailVOList[0].fileSaveLocate}`;  // 서버에서 전달받은 다운로드 경로
			link.download = fileSaveLocate; // 다운로드할 파일 이름 설정
			document.body.appendChild(link);
			link.click(); // 클릭하여 다운로드 시작
			document.body.removeChild(link); // 링크 제거
		},
		error: function(jqXHR, textStatus, errorThrown) {
	        console.error('AJAX 요청 실패:', textStatus, errorThrown);
	        Swal.fire({
			  icon: "error",
			  title: "다운로드 실패",
			  text: "다시 시도해주세요",
		  	  showConfirmButton: false,
	  		  timer: 3000 //3초간 유지
			});
    	} // error
	});
	*/

</script>

<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<h1 class="m-0">문의사항</h1>
      	</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>

<div class="wrap">
	<form id="searchForm" name="searchForm" action="/hdofc/qs/selectQsList" method="get">
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">문의 유형</p>
					<div class="select-custom" style="width:150px">
						<select name="qsType" id="qsType">
							<option value="">전체</option>
							<option value="QS01"
								<c:if test="${param.qsType == 'QS01'}">selected</c:if>>구매</option>
							<option value="QS02"
								<c:if test="${param.qsType == 'QS02'}">selected</c:if>>매장이용</option>
							<option value="QS03"
								<c:if test="${param.qsType == 'QS03'}">selected</c:if>>채용</option>
							<option value="QS04"
								<c:if test="${param.qsType == 'QS04'}">selected</c:if>>가맹점</option>
							<option value="QS05"
								<c:if test="${param.qsType == 'QS05'}">selected</c:if>>기타</option>
						</select>
					</div>
				</div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">고객 작성 일자</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd" value="${param.bgngYmd}"> 
							~ 
						<input type="date" id="expYmd" name="expYmd" value="${param.expYmd}">
					</div>
				</div>
				<!-- 제목 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목</p>
					<input type="text" id="qsTtl" name="qsTtl" placeholder="검색어를 입력하세요" value="${param.qsTtl}"> 
				</div>
				<!-- 내용 검색조건 -->
<!-- 				<div class="search-cont"> -->
<!-- 					<p class="search-title">내용</p> -->
<%-- 					<input type="text" id="qsCn" name="qsCn" placeholder="검색어를 입력하세요" value="${param.qsCn}">  --%>
<!-- 				</div> -->
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">문의 유형 <span class="summary" id="qsTypeSummary">전체</span></p>
				</div>
<!-- 				<div class="divide-border"></div> -->
				<div class="divide-border"></div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">고객 작성 일자 <span class="summary" id="dateSummary">전체</span></p>
				</div>
<!-- 				<div class="divide-border"></div> -->
				<div class="divide-border"></div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목 <span class="summary" id="qsTtlSummary">제목</span></p>
				</div>
<!-- 				<div class="divide-border"></div> -->
				<!-- 텍스트 검색조건 -->
<!-- 				<div class="search-cont"> -->
<!-- 					<p class="search-title">내용 <span class="summary" id="qsCnSummary">제목</span></p> -->
<!-- 				</div> -->
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- 검색 버튼 영역 -->
		<div class="search-control">
			<div class="search-control-btns">
				<div class="search-toggle">
					요약보기<span class="icon material-symbols-outlined">Add</span>
				</div>
				<div class="search-reset">
					초기화<span class="icon material-symbols-outlined">restart_alt</span>
				</div>
				<div>
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
		<!-- /.검색 버튼 영역 -->
		<!-- /.search-section: 검색어 영역 -->
	</div>
	</form>
	
	<div class="cont">
		<div class="table-wrap">
			<div class="tap-wrap">
				<div data-type="" class="tap-cont ${param.qsType == null || param.qsType == '' ? 'active' : ''}">
					<span class="tap-title">전체</span>
					<span class="bge bge-default" id="tap-all">${tapMaxTotal.TAPALL}</span>
				</div>
				<div data-type="QS01" class="tap-cont ${param.qsType == 'QS01' ? 'active' : ''}">
					<span class="tap-title">구매</span>
					<span class="bge bge-info" id="tap-waiting">${tapMaxTotal.TAPWAITING}</span>
				</div>
				<div data-type="QS02" class="tap-cont ${param.qsType == 'QS02' ? 'active' : ''}">
					<span class="tap-title">매장이용</span>
					<span class="bge bge-active" id="tap-progress">${tapMaxTotal.TAPPROGRESS}</span>
				</div>
				<div data-type="QS03" class="tap-cont ${param.qsType == 'QS03' ? 'active' : ''}">
					<span class="tap-title">채용</span>
					<span class="bge bge-warning" id="tap-scheduled">${tapMaxTotal.TAPSCHEDULED}</span>
				</div>
				<div data-type="QS04" class="tap-cont ${param.qsType == 'QS04' ? 'active' : ''}">
					<span class="tap-title">가맹점</span>
					<span class="bge bge-danger" id="tap-completed">${tapMaxTotal.TAPCOMPLETED}</span>
				</div>
				<div data-type="QS05" class="tap-cont ${param.qsType == 'QS05' ? 'active' : ''}">
					<span class="tap-title">기타</span>
					<span class="bge bge-danger" id="tap-cancelled">${tapMaxTotal.TAPCANCELLED}</span>
				</div>
			</div>
	
			<table class="table-default">
				<thead>
					<tr>
<!-- 						<th class="right" style="width: 50px"> -->
<!-- 							<input type="checkbox" class="check-btn all" id="chkBox" name="chkBox"> -->
<!-- 					       	<label for="chkBox"><span></span></label> -->
<!-- 						</th> -->
						<th class="center" style="width: 60px">번호</th>
						<th class="" style="width: 300px">제목</th>
						<th class="center" style="width: 100px">작성자</th>
<!-- 						<th class="center sort active" data-sort="wrtrDtSort" id="wrtrDtSort" style="width: 100px" onclick=""> -->
<!-- 							작성일자 -->
<!-- 							<div class="sort-icon"> -->
<!-- 								<div class="sort-arrow"> -->
<!-- 								  <span class="sort-asc active">▲</span> -->
<!-- 								  <span class="sort-desc">▼</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</th> -->
						<th class="center" style="width: 100px">작성일자</th>
						<th class="center" style="width: 100px">답변인</th>
						<th class="center" style="width: 100px">문의 유형</th>
<!-- 						<th class="center" style="width: 100px">첨부파일</th> -->
					</tr>
				</thead>
				<c:choose> 
					<c:when test="${empty articlePage.content}">
						<tbody id="table-body" class="table-error">
							<tr>
								<td class="error-info" colspan="6">
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
						</tbody>
					</c:when>
					
					<c:otherwise>
						<tbody id="table-body">
							<c:forEach var="qsVOList" items="${articlePage.content}" varStatus="stat">
								<tr>
<!-- 									<td></td> -->
									<td class="center">${qsVOList.rnum}</td>
									<td class=""><a href="/hdofc/qs/selectQsDetail?qsSeq=${qsVOList.qsSeq}">${qsVOList.qsTtl}</a></td>
									<td class="center">${qsVOList.memberVO.mbrNm}</td>
									<td class="center">
										${fn:substring(qsVOList.wrtrDt, 0, 10)}
									</td>
									<td class="center">
										<c:choose>
											<c:when test="${not empty qsVOList.mngrVO.mbrNm}">
												${qsVOList.mngrVO.mbrNm}
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td class="center">
										<c:forEach var="qs" items="${qsType}">
											<c:if test="${qsVOList.qsType == qs.comNo}">
												${qs.comNm}
											</c:if>
										</c:forEach>
									</td>
<!-- 									<td class="center py-10"> -->
<%-- 										<button type="button" class="btn btn-download" id="downloadBtn" data-file-locate="${qsVOList.fileDetailVOList[0].fileSaveLocate}"> --%>
<!-- 										 	다운로드<span class="icon material-symbols-outlined">Download</span>  -->
<!-- 										</button> -->
<!-- 									</td> -->
								</tr>
							</c:forEach>
						</tbody>
					</c:otherwise>
				</c:choose>
			</table>
			<!-- pagination-wrap -->
			<c:if test="${not empty articlePage.content}">
				<div class="pagination-wrap">
					<div class="pagination">
						<c:if test="${articlePage.startPage gt 5}">
							<a href="/hdofc/qs/selectQsList?qsType=${param.qsType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&qsTtl=${param.qsTtl}}&currentPage=${articlePage.startPage-5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<!-- 선택한 페이지만 class="active"가 설정되게 한다 -->
						<c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
							<a href="/hdofc/qs/selectQsList?qsType=${param.qsType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&qsTtl=${param.qsTtl}&currentPage=${pNo}" class="page-link 
		        				<c:if test="${pNo == articlePage.currentPage}">active</c:if>">
		        				${pNo}
		    				</a>
						</c:forEach>
						<!-- endPage < totalPages일때만 [다음] 활성 -->
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a href="/hdofc/qs/selectQsList?qsType=${param.qsType}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&qsTtl=${param.qsTtl}&currentPage=${articlePage.startPage+5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<!-- pagination-wrap -->
		</div>
	</div>
</div>