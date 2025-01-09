<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<script src="/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/resources/hdofc/css/menuAnalyze.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 
로그인 안했을 때 principal.MemberVO 에서 오류 발생
 -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<%--
	@fileName    : selectAnalyzeList.jsp
	@programName : 영업분석 메뉴 리스트 조회 화면
	@description : 영업분석 메뉴 리스트 조회 화면
	@author      : 김 현 빈
	@date        : 2024. 10. 05
--%>

<script type="text/javascript">
$(document).ready(function() {
	// 날짜 관련 함수들
    function getToday() {
        let today = new Date();
        let yyyy = today.getFullYear();
        let mm = String(today.getMonth() + 1).padStart(2, '0');
        let dd = String(today.getDate()).padStart(2, '0');
        return yyyy + '-' + mm + '-' + dd;
    }

    function getYesterday() {
        let yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        let yyyy = yesterday.getFullYear();
        let mm = String(yesterday.getMonth() + 1).padStart(2, '0');
        let dd = String(yesterday.getDate()).padStart(2, '0');
        return yyyy + '-' + mm + '-' + dd;
    }

    function getThisMonth() {
        let today = new Date();
        let yyyy = today.getFullYear();
        let mm = String(today.getMonth() + 1).padStart(2, '0');
        let firstDay = yyyy + '-' + mm + '-01';
        let lastDay = new Date(yyyy, today.getMonth() + 1, 0).getDate();
        let lastDayFormatted = yyyy + '-' + mm + '-' + String(lastDay).padStart(2, '0');
        return { firstDay: firstDay, lastDay: lastDayFormatted };
    }

    function getThisYear() {
        let today = new Date();
        let yyyy = today.getFullYear();
        return { firstDay: yyyy + '-01-01', lastDay: yyyy + '-12-31' };
    }
    
	// 버튼 클릭 시 날짜만 설정 (검색 폼 제출 없이)
    $("#dailyBtn").on("click", function() {
        $("#bgngYmd").val(getYesterday());
        $("#expYmd").val(getToday());
    });

    $("#monthlyBtn").on("click", function() {
        let thisMonth = getThisMonth();
        $("#bgngYmd").val(thisMonth.firstDay);
        $("#expYmd").val(thisMonth.lastDay);
    });

    $("#yearlyBtn").on("click", function() {
        let thisYear = getThisYear();
        $("#bgngYmd").val(thisYear.firstDay);
        $("#expYmd").val(thisYear.lastDay);
    });

    // 사용자가 직접 날짜를 수정하면 버튼이 선택된 상태에서 풀림
    $("#bgngYmd, #expYmd").on("change", function() {
        // 원하는 기능을 여기에 추가할 수 있습니다 (버튼 리셋 등)
    });
	
	
	// 이벤트 위임을 사용하여 tap-cont 클릭 시 처리
	$(".tap-wrap").on("click", ".tap-cont", function() {
		// 모든 탭에서 active 클래스를 제거
        $(".tap-cont").removeClass("active");

        // 클릭한 탭에만 active 클래스를 추가
        $(this).addClass("active");

        // 선택된 문의 유형을 가져와 셀렉트 박스 값 변경
        let selectedmenuType = $(this).data("type");
        $("#menuType").val(selectedmenuType);
        
     	// localStorage에 클릭된 탭의 정보를 저장
        localStorage.setItem('selectedmenuType', selectedmenuType);

        // 폼 자동 제출 (새로고침 방식)
        $("#searchForm").submit();
	});
	
	$("#searchBtn").on("click",function(event){
		let menuType = $("#menuType").val();
		let menuSearch = $("#menuSearch").val();
		let bgngYmd = $("#bgngYmd").val();
		let expYmd = $("#expYmd").val();
		
		let data = {
			"menuType":menuType,
			"menuSearch":menuSearch,
			"bgngYmd":bgngYmd,
			"expYmd":expYmd
		};
		
		console.log("menuType: ", menuType);
		console.log("menuSearch: ", menuSearch);
		console.log("bgngYmd: ", bgngYmd);
		console.log("expYmd: ", expYmd);
		
		$("#searchForm").submit();
	});
	
	// 검색 인풋 필드에서 Enter 키가 눌릴 때 폼 제출 방지
    $("#menuSearch").on("keypress", function(event) {
        if (event.which === 13) { // Enter 키가 눌렸을 때 동작
            event.preventDefault();  // 기본 동작 방지
            $("#searchBtn").click(); // 검색 버튼 클릭 이벤트 호출
        }
    });

    // 전체 폼에서 Enter 키 눌렸을 때 기본 제출 방지
    $(document).on("keypress", function(event) {
        if (event.which === 13) { // Enter 키가 눌렸을 때
            event.preventDefault(); // 기본 폼 제출 동작 방지
        }
    });
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('.select-selected').text('전체');
		$('#menuType').val('');
		$('#menuSearch').val('');
		$('#bgngYmd').val('');
		$('#expYmd').val('');
		
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		// 새로고침하여 링크로 이동
	    window.location.href = "/hdofc/analyze/selectAnalyzeList";
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
		
		// 인풋 데이터 가져오기
		let menuTypeSearch = $('#menuType option:selected').text();
		let menuSearchSearch = $('#menuSearch').val();
		let bgngYmdSearch = $('#bgngYmd').val();
		let expYmdSearch = $('#expYmd').val();
		
		dateStr = `\${bgngYmdSearch} ~ \${expYmdSearch}`;
		
		// 메뉴 유형 데이터 입력
		if(menuTypeSearch==''){
			$('#menuTypeSummary').text('전체');
		}else {
			$('#menuTypeSummary').text(menuTypeSearch);
		}
		// 메뉴 데이터 입력
		if(menuSearchSearch==''){
			$('#menuSearchSummary').text('전체');
		}else {
			$('#menuSearchSummary').text(menuSearchSearch);
		}
		// 영업분석일자 데이터 입력
		if(bgngYmdSearch=='' && expYmdSearch==''){
			$('#dateSummary').text('전체');
		}else {
			$('#dateSummary').text(dateStr);
		}
	});
	
	//JSP에서 메뉴명, 판매량, 매출액 데이터를 JavaScript로 전달
	// 메뉴 이름 데이터
	const menuNmData = [
		<c:forEach var="menuVOList" items="${articlePage.content}" varStatus="stat">
			'${menuVOList.menuNm}'<c:if test="${!stat.last}">,</c:if>
		</c:forEach>
	];
	// 판매량 데이터
	const qtyData = [
		<c:forEach var="menuVOList" items="${articlePage.content}" varStatus="stat">
			${menuVOList.frcsMenuVOList[0].ordrDtlVOList[0].ordrQtySum}<c:if test="${!stat.last}">,</c:if>
		</c:forEach>
	];
	// 매출액 데이터
	const amtData = [
		<c:forEach var="menuVOList" items="${articlePage.content}" varStatus="stat">
			${menuVOList.frcsMenuVOList[0].ordrDtlVOList[0].ordrAmtSum / 10000}<c:if test="${!stat.last}">,</c:if>
		</c:forEach>
	];
	
	// 차트 데이터를 생성
	const data = {
		labels: menuNmData, // 메뉴명이 x축 레이블로 사용됩니다.
		datasets: [{
			type: 'line', // 막대 그래프로 판매량을 표시
			label: '판매량',
			backgroundColor: 'rgba(255, 99, 132, 0.5)', // 막대 그래프 색상
			borderColor: 'rgb(255, 99, 132)',
			data: qtyData, // 판매량 데이터
		}, {
			type: 'bar', // 선 그래프로 매출액을 표시
			label: '매출액',
			backgroundColor: 'rgba(75, 192, 192, 0.5)', // 선 그래프 색상
			borderColor: 'rgb(75, 192, 192)',
			fill: false, // 선 그래프 채우기 여부 (false는 채우지 않음)
			data: amtData, // 매출액 데이터
		}]
	};
	
	// 차트 설정
	const config = {
		type: 'bar', // 기본 차트 타입을 bar로 설정
		data: data,
		options: {
			responsive: true, // 차트를 화면 크기에 맞게 자동으로 조정
			maintainAspectRatio: false, // 비율을 고정하지 않고, 컨테이너 크기에 맞춤
			plugins: {
// 				title: {
// 					text: '판매량 및 매출액 분석', // 차트 제목
// 					display: true,
// 					font: {
// 					size: 20 // 원하는 크기로 텍스트 크기를 조정 (예: 24)
// 					}
// 				}
			},
			scales: {
				x: {
					type: 'category', // x축의 타입 (카테고리)
					display: true,
					title: {
						display: true,
					}, 
					ticks: {
						font: {
							size: 8
						}
					}
				},
				y: {
					beginAtZero: true, // y축이 0에서 시작
					title: {
						display: true,
					}
				}
			}
		}
	};
	
	// 차트를 생성
	const ctx = document.getElementById('salesChart').getContext('2d');
	const salesChart = new Chart(ctx, config);
	
	console.log(menuNmData);
	console.log(qtyData);
	console.log(amtData);
	
});


</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<h1 class="m-0">메뉴 매출 분석</h1>
			</div>
		</div><!-- /.row -->
	</div><!-- /.container-fluid -->
</div>

<div class="wrap">

	<div class="menu-wrap"> 
		<div class="cont menu-cont">
			<div class="amt-title-sub">
				<div class="menu-title">최고 판매량</div>
			</div>
			<div class="menu-title-main" id="clclnTotal">
				<span class="title-bge best">Best</span>
				<div class="menu-total">
					${bestMenu.menuNm}
				</div>
			</div> 
		</div>
		<div class="cont menu-cont">
			<div class="menu-title-sub">
				<div class="menu-title">최고 매출액(원)</div>
			</div>
			<div class="menu-title-main" id="clclnYTotal">
				<span class="title-bge best">Best</span>
				<div class="menu-total">
					<fmt:formatNumber value="${bestMenu.frcsMenuVOList[0].ordrDtlVOList[0].ordrAmtSum}" pattern="#,###"/>
				</div>
			</div> 
		</div>
		<div class="cont menu-cont">
			<div class="menu-title-sub">
				<div class="menu-title">분석 기간 합계 매출액(원)</div>
			</div>
			<div class="menu-title-main" id="clclnTotal">
				<span class="title-bge total">total</span>
				<div class="menu-total">
					<fmt:formatNumber value="${totalAmt.frcsMenuVOList[0].ordrDtlVOList[0].ordrAmtSum}" pattern="#,###"/>
				</div>
			</div> 
		</div>
		<div class="cont menu-cont">
			<div class="menu-title-sub">
				<div class="menu-title">최다 판매일</div>
			</div>
			<div class="menu-title-main" id="clclnYTotal">
				<span class="title-bge top">top</span>
				<div class="menu-total">
					${bestDay.frcsMenuVOList[0].ordrDtlVOList[0].ordrVO.bestDay}
				</div>
			</div> 
		</div>
		<div class="cont menu-cont">
			<div class="menu-title-sub">
				<div class="menu-title">최다 판매시간</div>
			</div>
			<div class="menu-title-main" id="clclnYTotal">
				<span class="title-bge top">top</span>
				<div class="menu-total">
					${bestTime.frcsMenuVOList[0].ordrDtlVOList[0].ordrVO.bestTime}
				</div>
			</div> 
		</div>
	</div>
	<form id="searchForm" name="searchForm" action="/hdofc/analyze/selectAnalyzeList" method="get">
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">메뉴 유형</p>
					<div class="select-custom" style="width:150px">
						<select name="menuType" id="menuType">
							<option value="">전체</option>
							<option value="MENU01"
								<c:if test="${param.menuType == 'MENU01'}">selected</c:if>>세트</option>
							<option value="MENU02"
								<c:if test="${param.menuType == 'MENU02'}">selected</c:if>>햄버거</option>
							<option value="MENU03"
								<c:if test="${param.menuType == 'MENU03'}">selected</c:if>>사이드</option>
							<option value="MENU04"
								<c:if test="${param.menuType == 'MENU04'}">selected</c:if>>음료</option>
						</select>
					</div>
				</div>
				
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">메뉴 검색</p>
					<input type="text" id="menuSearch" name="menuSearch" placeholder="검색어를 입력하세요" value="${param.menuSearch}"> 
				</div>
				
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">분석 기간</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd" value="${param.bgngYmd}"> 
							~ 
						<input type="date" id="expYmd" name="expYmd" value="${param.expYmd}">
					</div>
				</div>
				
				<div class="search-cont">
				    <p class="search-title">현재 연월일</p>
				    <div>
				        <button class="btn-default" type="button" id="dailyBtn" class="date-btn">일간</button>
				        <button class="btn-default" type="button" id="monthlyBtn" class="date-btn">월간</button>
				        <button class="btn-default" type="button" id="yearlyBtn" class="date-btn">연간</button>
				    </div>
				</div>
				
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">문의 유형 <span class="summary" id="menuTypeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">메뉴 <span class="summary" id="menuSearchSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">분석 기간 <span class="summary" id="dateSummary">전체</span></p>
				</div>
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
	<!-- 그래프 영역 -->
	<div class="cont">
		<canvas id="salesChart" width="800" height="200"></canvas>
	</div>
	
	<div class="cont">
		<div class="cont-title">분석 리스트</div> 
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-wrap">
				<div data-type="" class="tap-cont ${param.menuType == null || param.menuType == '' ? 'active' : ''}">
					<span class="tap-title">전체</span>
					<span class="bge bge-default" id="tap-all">${tapMaxTotal.TAPALL}</span>
				</div>
				<div data-type="MENU01" class="tap-cont ${param.menuType == 'MENU01' ? 'active' : ''}">
					<span class="tap-title">세트</span>
					<span class="bge bge-info" id="tap-waiting">${tapMaxTotal.TAPWAITING}</span>
				</div>
				<div data-type="MENU02" class="tap-cont ${param.menuType == 'MENU02' ? 'active' : ''}">
					<span class="tap-title">햄버거</span>
					<span class="bge bge-active" id="tap-progress">${tapMaxTotal.TAPPROGRESS}</span>
				</div>
				<div data-type="MENU03" class="tap-cont ${param.menuType == 'MENU03' ? 'active' : ''}">
					<span class="tap-title">사이드</span>
					<span class="bge bge-warning" id="tap-scheduled">${tapMaxTotal.TAPSCHEDULED}</span>
				</div>
				<div data-type="MENU04" class="tap-cont ${param.menuType == 'MENU04' ? 'active' : ''}">
					<span class="tap-title">음료</span>
					<span class="bge bge-danger" id="tap-completed">${tapMaxTotal.TAPCOMPLETED}</span>
				</div>
			</div>
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">메뉴</th>
						<th class="center">메뉴유형</th>
						<th class="center">판매량</th>
						<th class="center">매출</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${empty articlePage.content}">
						<tbody id="table-body" class="table-error">
							<tr>
								<td class="error-info" colspan="5">
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
						</tbody>
					</c:when>
					<c:otherwise>
						<tbody>
							<c:forEach var="menuVOList" items="${articlePage.content}" varStatus="stat">
								<tr class="po-row">
									<td class="center">${menuVOList.rnum}</td>
									<td class="">${menuVOList.menuNm}</td>
									<td class="center">${menuVOList.menuTypeNm}</td>
									<td class="center">
									    <fmt:formatNumber value="${menuVOList.frcsMenuVOList[0].ordrDtlVOList[0].ordrQtySum}" pattern="#,###"/>
									</td>
									<td class="center">
									    <fmt:formatNumber value="${menuVOList.frcsMenuVOList[0].ordrDtlVOList[0].ordrAmtSum}" pattern="#,###"/>
									</td>
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
							<a href="/hdofc/analyze/selectAnalyzeList?menuType=${param.menuType}&menuSearch=${param.menuSearch}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${articlePage.startPage-5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<!-- 선택한 페이지만 class="active"가 설정되게 한다 -->
						<c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
							<a href="/hdofc/analyze/selectAnalyzeList?menuType=${param.menuType}&menuSearch=${param.menuSearch}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${pNo}" class="page-link 
		        				<c:if test="${pNo == articlePage.currentPage}">active</c:if>">
		        				${pNo}
		    				</a>
						</c:forEach>
						<!-- endPage < totalPages일때만 [다음] 활성 -->
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a href="/hdofc/analyze/selectAnalyzeList?menuType=${param.menuType}&menuSearch=${param.menuSearch}&bgngYmd=${param.bgngYmd}&expYmd=${param.expYmd}&currentPage=${articlePage.startPage+5}" class="page-link">
								<span class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<!-- pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
<!-- 	</div> -->
</div>