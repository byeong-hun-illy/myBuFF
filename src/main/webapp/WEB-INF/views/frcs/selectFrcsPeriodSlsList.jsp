<%--
    @fileName    : selectFrcsPeriodSlsList.jsp
    @programName : 가맹점 매출 관리
    @description : 가맹점 기간별 매출 조회 페이지
    @author      : 정현종
    @date        : 2024. 10. 03
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src='/resources/js/global/value.js'></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user" />
<link rel="stylesheet" type="text/css" href="/resources/frcs/css/selectFrcsPeriodSlsList.css">
 
<!-- Chart.js 라이브러리 추가 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
let date = ''; // 매출 조회시 사용
let bzentNo = '${user.bzentNo}';
let myChart; // 전역 변수로 선언

$(document).ready(function() {
	
	// 초기 차트 설정
    updateChartTitle('일간'); 
	loadDataAndUpdateChart()
	
	$('.search-reset').on('click', function() {
		window.location.href = "/frcs/periodSlsList";  // 페이지 이동
	})
	
	$('.search-toggle').on('click', function() {
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
		
		let startYmd = $('#startYmd').val();    
	    let endYmd = $('#endYmd').val();   
	    
	    if (startYmd === '' && endYmd === '') {
	        $('#dateSummary').text('전체');
	    } else {
	        $('#dateSummary').text(startYmd + "~" + endYmd);
	    }
	    
	});
	
	// 제목 업데이트 함수
    function updateChartTitle(periodType) {
        let titleText = '';
        if (periodType === '일간') {
            titleText = '일간 매출 현황 차트';
        } else if (periodType === '월간') {
            titleText = '월간 매출 현황 차트';
        } else if (periodType === '연간') {
            titleText = '연간 매출 현황 차트';
        }
        $('#chart-title-text').text(titleText);
    }
	
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
        return {
            firstDay: firstDay,
            lastDay: lastDayFormatted
        };
    }

    function getThisYear() {
        let today = new Date();
        let yyyy = today.getFullYear();
        return {
            firstDay: yyyy + '-01-01',
            lastDay: yyyy + '-12-31'
        };
    }

    function loadDataAndUpdateChart() {

    	$.ajax({
            url: "/frcs/getAmt", // 서버의 URL
            type: "POST",
            data: { date: date },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); // CSRF 설정
            },
            success: function(res) {
            	console.log(res);
                updateChart(res); // 데이터를 받아서 차트 업데이트
            },
            error: function(xhr, status, error) {
                console.error('Error:', status, error); // 오류 처리
            }
        });
    }

    function updateChart(res) {
        // 응답이 배열인지 확인
        if (!Array.isArray(res)) {
            console.error('Expected an array but got:', res);
            return; // 데이터가 배열이 아닐 경우 함수 종료
        }

        // 라벨과 데이터 초기화
        const labels = [];
        const totalAmtData = [];

        // 데이터 처리
        res.forEach(item => {
            // ordtDtlVOList에서 첫 번째 항목을 가져옴
            const orderDetail = item.ordrDtlVOList[0];
            if (orderDetail) {
                labels.push(orderDetail.period); // 기간 추가
                totalAmtData.push(orderDetail.ordrAmtSum); // 매출 금액 추가
            }
        });

        // 차트 데이터 설정
        const data = {
            labels: labels,
            datasets: [{
                label: '총 금액(원)',
                data: totalAmtData,
                borderColor: 'rgba(245, 176, 179, 1)',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                fill: false
            }]
        };

        // 차트 생성
        var ctx = document.getElementById('myChart').getContext('2d');

        // 차트가 이미 존재한다면 삭제 후 새로 생성
        if (myChart) {
            myChart.destroy();
        }

        	myChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: false,
                scales: {
                    y: {
                        suggestedMin: 0,
                        suggestedMax: Math.max(...totalAmtData) + 10, // 최대값 자동 설정
                        grid: {
                            drawBorder: false,
                            color: 'rgba(0, 116, 52, 0.2)'
                        },
                        ticks: {
                            color: '#999',
                            font: {
                                family: 'NanumSquare, sans-serif',
                                size: 12,
                                weight: 'bold'
                            }
                        }
                    },
                    x: {
                        ticks: {
                            color: '#000000',
                            font: {
                                family: 'NanumSquare, sans-serif',
                                size: 15,
                                weight: 'bold'
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        labels: {
                            color: '#000',
                            font: {
                                family: 'NanumSquare, sans-serif',
                                size: 15,
                                weight: 'bold'
                            }
                        }
                    }
                }
            }
        });
        	
      	// 차트 리사이즈
      	myChart.resize();	
    }

 // 버튼 클릭 시 분석 기간 자동 설정
    $(".btn-default.date").on("click", function(e) {
        e.preventDefault();
        let periodType = $(this).text().trim(); // 버튼 텍스트 가져오기

        if (periodType === '일간') {
            date = 'day'; // 기간 타입 설정
            $("#startYmd").val(getYesterday());
            $("#endYmd").val(getToday());
        } else if (periodType === '월간') {
            date = 'month'; // 기간 타입 설정
            let thisMonth = getThisMonth();
            $("#startYmd").val(thisMonth.firstDay);
            $("#endYmd").val(thisMonth.lastDay);
        } else if (periodType === '연간') {
            date = 'year'; // 기간 타입 설정
            let thisYear = getThisYear();
            $("#startYmd").val(thisYear.firstDay);
            $("#endYmd").val(thisYear.lastDay);
        }
    });

    $("#searchBtn").on("click", function(e) {
        e.preventDefault();
        
        // 현재 선택된 기간 타입이 없으면 폼 제출
        if (date === 'year' || date === 'month' || date === 'day') {
            // 차트 업데이트
            updateChartTitle(date === 'day' ? '일간' : date === 'month' ? '월간' : '연간');
            loadDataAndUpdateChart(); // 차트 업데이트 호출
        } else {
            // 폼 제출
            $("#searchForm").submit();
        }
    });

});
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<h1 class="m-0">기간별 매출 조회</h1>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</div>

<div class="wrap">
	<div class="amt-wrap">
		<div class="cont amt-cont">
			<div class="amt-top">
				<div class="amt-title-sub">
					<div class="amt-title">기간별 합계 매출액(원)</div>
					<p class="amt-title-date">
						<c:choose>
							<c:when
								test="${not empty param.startYmd and not empty param.endYmd}">
			                    ${param.startYmd} ~ ${param.endYmd}
			                </c:when>
							<c:otherwise>전체 기간</c:otherwise>
						</c:choose>
					</p>
				</div>
				<div class="amt-title-main" id="clclnTotal">
					<span class="title-bge best">total</span>
					<div class="amt-total">
						<fmt:formatNumber value="${totalOrdrAmt}" pattern="#,###" />
					</div>
				</div> 
			</div>
		</div>
		<div class="cont amt-cont">
			<div class="amt-top">
				<div class="amt-title-sub">
					<div class="amt-title">당일 합계 매출액(원)</div>
				</div>
				<div class="amt-title-main" id="clclnTotal">
					<span class="title-bge total">total</span>
					<div class="amt-total">
						<fmt:formatNumber value="${dailySales}" pattern="#,###" />
					</div>
				</div> 
			</div>
		</div>
		<div class="cont amt-cont">
			<div class="amt-top">
				<div class="amt-title-sub">
					<div class="amt-title">최고 일일 매출액(원)</div>
				</div>
				<div class="amt-title-main" id="clclnTotal">
					<span class="title-bge top">top</span>
					<div class="amt-total">
						<fmt:formatNumber value="${maxDailySales}" pattern="#,###" />
					</div>
				</div> 
			</div>
		</div>
	</div>
	
	<!-- 검색영역 -->
	<div class="search-section">
		<form id="searchForm">
			<div class="cont search-original">
				<div class="search-wrap">
					<!-- 매출 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">매출 일자</p>
						<div class="search-date-wrap">
							<input type="date" id="startYmd" name="startYmd"
								value="${param.startYmd}"> ~ <input type="date"
								id="endYmd" name="endYmd" value="${param.endYmd}">
						</div>
					</div>
					<!-- 일간, 월간, 연간 -->
					<div class="search-cont">
						<p class="search-title">기간 선택</p>
						<div>
							<button class="btn-default date">일간</button>
							<button class="btn-default date">월간</button>
							<button class="btn-default date">연간</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- cont:  검색 접기 영역 -->
			<div class="cont search-summary">
				<div class="search-wrap">
					<!-- 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							매출 일자 <span class="summary" id="dateSummary">전체</span>
						</p>
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
						<button class="btn btn-default search" id="searchBtn">
							검색 <span class="icon material-symbols-outlined">search</span>
						</button>
					</div>
				</div>
			</div>
			<!-- /.검색 버튼 영역 -->
		</form>
		<!-- /.search-section: 검색어 영역 -->
	</div>

	<!-- 그래프 영역 -->
	<div class="chart-wrap">
		<div class="cont chart">
			<div class="table-title">
				<div class="cont-title chart-title">
			        <span class="material-symbols-outlined title-icon">bar_chart</span><p id="chart-title-text"></p>
			    </div>
			</div>
			<canvas id="myChart"></canvas>
		</div>

		<div class="cont table">
			<div class="table-wrap">
				<div class="tap-wrap">
					<div data-type='' class="tap-cont active">
						<span class="tap-title">전체</span> <span class="bge bge-default"
							id="tap-all">${articlePage.total}</span>
					</div>
				</div>
				<table class="table-default">
					<thead>
						<tr>
							<th class="center">번호</th>
							<th class="center">매출 일자</th>
							<th class="center">매출 금액</th>
						</tr>
					</thead>
					<c:if test="${articlePage.total == 0}">
						<tbody id="table-body" class="table-error">
							<tr>
								<td class="error-info" colspan="3"><span
									class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div></td>
							</tr>
						</tbody>
					</c:if>
					<tbody>
						<c:forEach var="ordrVO" items="${articlePage.content}">
							<tr>
								<td class="center">${ordrVO.rnum}</td>
								<td class="center"><fmt:formatDate value="${ordrVO.ordrDt}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td class="right"><fmt:formatNumber
										value="${ordrVO.ordrDtlVOList[0].ordrQty * ordrVO.ordrDtlVOList[0].ordrAmt}"
										pattern="#,###" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${articlePage.total > 0}">
					<div class="pagination-wrap">
						<div class="pagination">
							<c:if test="${articlePage.startPage gt 5}">
								<a
									href="/frcs/periodSlsList?&startYmd=${param.startYmd}&endYmd=${param.endYmd}&currentPage=${articlePage.startPage - 5}"
									class="page-link"> <span
									class="icon material-symbols-outlined">chevron_left</span>
								</a>
							</c:if>
							<c:forEach var="pNo" begin="${articlePage.startPage}"
								end="${articlePage.endPage}">
								<a
									href="/frcs/periodSlsList?&startYmd=${param.startYmd}&endYmd=${param.endYmd}&currentPage=${pNo}"
									class="page-link <c:if test="${pNo == articlePage.currentPage}">active</c:if>">
									${pNo} </a>
							</c:forEach>
							<c:if test="${articlePage.endPage lt articlePage.totalPages}">
								<a
									href="/frcs/periodSlsList?&startYmd=${param.startYmd}&endYmd=${param.endYmd}&currentPage=${articlePage.startPage + 5}"
									class="page-link"> <span
									class="icon material-symbols-outlined">chevron_right</span>
								</a>
							</c:if>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>

