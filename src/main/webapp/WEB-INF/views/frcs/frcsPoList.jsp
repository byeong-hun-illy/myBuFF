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
<%--
	@fileName    : frcsPoList.jsp
	@programName : 가맹점 발주 리스트 화면
	@description : 가맹점의 발주 내역 정보 화면
	@author      : 김 현 빈
	@date        : 2024. 09. 22
--%>
<script type="text/javascript">
function goToHomePage() {
    window.location.href = "/frcs/main"; // 경로에 맞게 이동
}
$(document).ready(function(){
	select2Custom();
	
	$('#deli').select2({
        width: '180px', // width 속성 설정
    });
	
	// 배송 유형 선택 값 초기화
    let selectedDeli = "${param.deli}";
 
    // 배송 유형 선택 값이 존재하면 해당 값으로 선택 상태 유지
    if(selectedDeli !== "") {
        $("#deli").val(selectedDeli);
    }
    
 // 이벤트 위임을 사용하여 tap-cont 클릭 시 처리
    $(".tap-wrap").on("click", ".tap-cont", function() {
        // 모든 tap-cont에서 active 클래스를 제거
        $(".tap-cont").removeClass("active");
        
        // 클릭된 요소에 active 클래스 추가
        $(this).addClass("active");

        // 선택된 유형의 data-type 값 얻기
        let selectedType = $(this).data("type");

        // 셀렉트박스의 값을 data-type에 맞춰 변경
        $("#deli").val(selectedType);

        // 폼 자동 제출 (새로고침)
        $("#searchForm").submit();
    });
	
	$("#searchBtn").on("click",function(event){
		//1. 배송 유형
		let deli = $("#deli").val();
		
		//2. 이벤트 기간 시작일
		let bgngYmd = $("#bgngYmd").val();
		
		//3. 이벤트 기간 종료일
		let expYmd = $("#expYmd").val();
		
		//4. JSON 오브젝트로 처리
		let data = {
			"deli":deli,
			"bgngYmd":bgngYmd,
			"expYmd":expYmd
		};
		
		//5. data의 데이터를 확인(오브젝트는 ,로 확인)
		console.log("data : ", data);
		console.log("bgngYmd: ", bgngYmd);
		console.log("expYmd: ", expYmd);
		
		$("#searchForm").submit();
		
		//6. 조건들 + 검색버튼을 포함하는 <form id="searchForm" name="searchForm" action="/frcs/frcsPoList" method="get">을 구성
		//  검색 버튼 : submit버튼
		//  sec:csrfInput 처리
		
		//7. Controller에서 RequestParam(value="deli" 및 bgngYmd와 expYmd도 처리하기
	});
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#deli').text('전체');
		$('#bgngYmd').val('');
		$('#expYmd').val('');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
	})
	//.search-reset
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function(){
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
		let deliSearch = $('#deli option:selected').text();
		let bgngYmdSearch = $('#bgngYmd').val();
		let expYmdSearch = $('#expYmd').val();

		dateStr = `\${bgngYmdSearch} ~ \${expYmdSearch}`;
		
		// 배송유형 데이터 입력
		if(deli==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(deliSearch);
		}
		// 배송일자 데이터 입력
		if(bgngYmd=='' & expYmd==''){
			$('#dateSummary').text('전체');
		}else {
			$('#dateSummary').text(dateStr);
		}
	})
	
});
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<button type="button" class="btn btn-default mr-3" onclick="goToHomePage()">
					<span class="icon material-symbols-outlined">keyboard_backspace</span>
					메인페이지
				</button>
				<h1 class="m-0">발주 관리</h1>
			</div>
		</div>
	</div>
</div>
<!-- /.content-header -->
<div class="wrap">
<form id="searchForm" name="searchForm" action="/frcs/frcsPoList" method="get">
<div class="search-section">
	<!-- cont: 검색 영역 -->
	<div class="cont search-original">
		<div class="search-wrap">
			<!-- 진행상태 검색조건 -->
			<div class="search-cont">
				<p class="search-title">배송 유형</p>
				<!-- 
				model.addAttribute("deli", this.comMapper.selectCom("DELI"));
				
				deli : List<ComVO>
				[
					ComVO(comNo=DELI01, comNm=승인대기), 
					ComVO(comNo=DELI02, comNm=배송중), 
					ComVO(comNo=DELI03, comNm=배송완료), 
					ComVO(comNo=DELI04, comNm=미승인)
				]
				 -->
				<select class="select2-custom w-150" name="deli" id="deli">
					<option value="" ${param.deli == null || param.deli == '' ? 'selected' : ''}>전체</option>
					<c:forEach var="comVO" items="${deli}">
						<!-- 옵션의 value는 comNo, 표시되는 텍스트는 comNm -->
						<option value="${comVO.comNo}" ${param.deli == comVO.comNo ? 'selected' : ''}>
							${comVO.comNm}
						</option>
					</c:forEach>
				</select>
			</div>
			<!-- 일자 검색조건 -->
			<div class="search-cont">
				<p class="search-title">배송 일자</p>
				<div class="search-date-wrap">
					<!-- param : ?deli=&bgngYmd=2023-05-01&expYmd=2023-05-31 -->
					<input type="date" id="bgngYmd" name="bgngYmd" value="${param.bgngYmd}" /> 
						~ 
					<input type="date" id="expYmd" name="expYmd" value="${param.expYmd}" />
				</div>
			</div>
		</div>
		<!-- /.search-wrap -->
	</div>
	<!-- /.cont: 검색 영역 -->
	
	<!-- cont:  검색 접기 영역 -->
	<div class="cont search-summary" style="display: none;">
		<div class="search-wrap">
			<!-- 일자 검색조건 -->
			<div class="search-cont">
				<p class="search-title">배송 유형 <span class="summary" id="typeSummary">전체</span></p>
			</div>
			<div class="divide-border"></div>
			<!-- 셀렉트 검색조건 -->
			<div class="search-cont">
				<p class="search-title">배송 일자 시작 <span class="summary" id="dateSummary">전체</span></p>
			</div>
		</div>
		<!-- /.search-wrap -->
	</div>
	<!-- /.cont: 검색 영역 -->
	
	<!-- 검색 버튼 영역 -->
	<div class="search-control">
		<div class="search-control-btns">
			<div class="search-toggle">요약보기<span class="icon material-symbols-outlined">Add</span></div>
			<div class="search-reset">
				초기화<span class="icon material-symbols-outlined">restart_alt</span>
			</div>
			<div>
				<button type="submit" class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
			</div>		
		</div>
	</div>
	<!-- /.검색 버튼 영역 -->
	<!-- /.search-section: 검색어 영역 -->
</div>
</form>

<div class="cont">
	<div class="cont-title">발주 내역 조회</div> 
	<div class="table-wrap">
		<div class="tap-btn-wrap">
			<div class="tap-wrap">
			    <!-- 전체 탭 -->
			    <div data-type="" class="tap-cont ${param.deli == null || param.deli == '' ? 'active' : ''}">
			        <span class="tap-title">전체</span>
			        <span class="bge bge-default" id="tap-all">${tapMaxTotal.TAPALL}</span>
			    </div>
			    <!-- 승인 대기 탭 -->
			    <div data-type="DELI01" class="tap-cont ${param.deli == 'DELI01' ? 'active' : ''}">
			        <span class="tap-title">승인 대기</span>
			        <span class="bge bge-info" id="tap-waiting">${tapMaxTotal.TAPWAITING}</span>
			    </div>
			    <!-- 배송 중 탭 -->
			    <div data-type="DELI02" class="tap-cont ${param.deli == 'DELI02' ? 'active' : ''}">
			        <span class="tap-title">배송 중</span>
			        <span class="bge bge-active" id="tap-progress">${tapMaxTotal.TAPPROGRESS}</span>
			    </div>
			    <!-- 배송 완료 탭 -->
			    <div data-type="DELI03" class="tap-cont ${param.deli == 'DELI03' ? 'active' : ''}">
			        <span class="tap-title">배송 완료</span>
			        <span class="bge bge-warning" id="tap-scheduled">${tapMaxTotal.TAPSCHEDULED}</span>
			    </div>
			    <!-- 미승인 탭 -->
			    <div data-type="DELI04" class="tap-cont ${param.deli == 'DELI04' ? 'active' : ''}">
			        <span class="tap-title">미승인</span>
			        <span class="bge bge-danger" id="tap-completed">${tapMaxTotal.TAPCOMPLETED}</span>
			    </div>
			</div>
			<div class="btn-wrap">
				<button class="btn-active">등록</button>
			</div>
		</div>
		<table class="table-default">
			<thead>
				<tr>
					<th class="center">こんにちは</th>
					<th class="center">발주 번호</th>
					<th class="center">배송 일자</th>
					<th class="center">배송 유형</th>
				</tr>
			</thead>
				<!-- 리스트가 없을때 공용 css으로 없다고 표시 -->
				<c:choose>
					<c:when test="${empty articlePage.content}">
						<tr>
							<td class="error-info" colspan="4"> 
								<span class="icon material-symbols-outlined">error</span>
								<div class="error-msg">검색 결과가 없습니다</div>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="poVO" items="${articlePage.content}" varStatus="stat">
							<tr class="po-row" onclick="window.location='frcsPoList/detail?poNo=${poVO.poNo}&deli=${param.deli}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${articlePage.currentPage}'">
								<td class="center">${poVO.rnum}</td>
								<td class="center">${poVO.poNo}</td>
								<td class="center">
									<!-- YYYYMMDD를 YYYY-MM-DD로 변환 -->
									<fmt:parseDate var="parsedDate" value="${poVO.deliYmd}" pattern="yyyyMMdd" />
									<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
								</td>
								<td class="center">${poVO.deliTypeNm}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
		</table>
		<!-- 리스트가 없을때 공용 css으로 없다고 표시 -->
		<c:if test="${not empty articlePage.content}">
			<div class="pagination-wrap">
				<div class="pagination">
					<c:if test="${articlePage.startPage gt 5}">
						<a href="/frcs/frcsPoList?deli=${param.deli}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${articlePage.startPage-5}" class="page-link">
							<span class="icon material-symbols-outlined">chevron_left</span>
						</a>
					</c:if>
					<!-- 선택한 페이지만 class="active"가 설정되게 한다 -->
					<c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
						<a href="/frcs/frcsPoList?deli=${param.deli}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${pNo}" class="page-link 
	        				<c:if test="${pNo == articlePage.currentPage}">active</c:if>">
	        				${pNo}
	    				</a>
					</c:forEach>
					<!-- endPage < totalPages일때만 [다음] 활성 -->
					<c:if test="${articlePage.endPage lt articlePage.totalPages}">
						<a href="/frcs/frcsPoList?deli=${param.deli}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${articlePage.startPage+5}" class="page-link">
							<span class="icon material-symbols-outlined">chevron_right</span>
						</a>
					</c:if>
				</div>
			</div>
		</c:if>
	</div>
	<!-- table-wrap -->
</div>
</div>


