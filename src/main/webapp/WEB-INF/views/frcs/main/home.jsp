<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/frcs/css/frcsPoList.css">
<link rel="stylesheet" href="/resources/css/global/common.css">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src='/resources/frcs/js/main.js'></script>
<link href="/resources/frcs/css/main.css" rel="stylesheet">
<!-- 
로그인 안했을 때 principal.MemberVO 에서 오류 발생
 -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(isAuthenticated()) 사용자 정보 -->
	<sec:authentication property="principal.MemberVO" var="user"/>
</sec:authorize>

<%--
	@fileName    : home.jsp
	@programName : 영업분석 메뉴 리스트 조회 화면
	@description : 영업분석 메뉴 리스트 조회 화면
	@author      : 김 현 빈, 정 현 종
	@date        : 2024. 10. 11
--%>
<script>
let bzentNo = '${user.bzentNo}';
let mbrId = '${user.mbrId}';

const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	$('#ordr').on('click', function(){
		updateOrdrAjax(); 
	})
});

$(document).ready(function() {
	
	// 기본적으로 공지사항을 보이게 설정
    $('#div1').show();
    $('#div2').hide();

    // 공지 버튼 클릭 시
    $('#showNotices').on('click', function() {
        $('#div1').show(); // 공지사항 보이기
        $('#div2').hide(); // 이벤트 숨기기
        $(this).addClass('active'); // 클릭한 요소에 active 클래스 추가
        $('#showEvents').removeClass('active'); // 이벤트 버튼에서 active 클래스 제거
    });

    // 이벤트 버튼 클릭 시
    $('#showEvents').on('click', function() {
        $('#div1').hide(); // 공지사항 숨기기
        $('#div2').show(); // 이벤트 보이기
        $(this).addClass('active'); // 클릭한 요소에 active 클래스 추가
        $('#showNotices').removeClass('active'); // 공지 버튼에서 active 클래스 제거
    });
	
	// 가맹점 인기메뉴 3개 출력 Ajax
	$.ajax({
		url:"/frcs/selectMenuQtyDesc",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(인기메뉴 3가지) : ", result);
			
			// 메뉴 리스트를 반복하면서 데이터를 동적으로 추가
			$("#descMenuList").empty(); // 기존 내용을 비움
			
			$.each(result, function(index, menuVO) {
				let menuHtml = '<div class="info-wrap" onclick="location.href=\'/frcs/menuSlsList\'">';
				    menuHtml += '<div class="info-title">' + menuVO.menuNm + '</div>';
				    menuHtml += '<div class="info-cont"><img src="' + menuVO.menuImgPath + '" alt="' + menuVO.menuNm + '" /></div>';
				    menuHtml += '</div>';
				$("#descMenuList").append(menuHtml);
			});
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	// 가맹점 비인기메뉴 3개 출력 Ajax
	$.ajax({
		url:"/frcs/selectMenuQtyAsc",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(비인기메뉴 3가지) : ", result);
			
			// 메뉴 리스트를 반복하면서 데이터를 동적으로 추가
			$("#ascMenuList").empty(); // 기존 내용을 비움
			
			$.each(result, function(index, menuVO) {
				let menuHtml = '<div class="info-wrap" onclick="location.href=\'/frcs/menuSlsList\'">';
				    menuHtml += '<div class="info-title">' + menuVO.menuNm + '</div>';
				    menuHtml += '<div class="info-cont"><img src="' + menuVO.menuImgPath + '" alt="' + menuVO.menuNm + '" /></div>';
				    menuHtml += '</div>';
				$("#ascMenuList").append(menuHtml);
			});
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	// 오늘 매출액
	$.ajax({
		url:"/frcs/selectDailysales",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(오늘 매출액) : ", result);
// 			if (result !== null) {
	            let formattedAmt = new Intl.NumberFormat().format(result); // 숫자를 #,### 형식으로 변환
	            $("#menuAmt").text(formattedAmt);
// 	        } else {
// 	            $("#menuAmt").text(""); // result가 null일 경우 0을 출력
// 	        }
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	// 오늘 판매량
	$.ajax({
		url:"/frcs/selectDailysalesCnt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(오늘 판매량) : ", result);
// 			if (result !== null) {
	            let formattedQty = new Intl.NumberFormat().format(result); // 숫자를 #,### 형식으로 변환
	            $("#menuQty").text(formattedQty);
// 	        } else {
// 	            $("#menuQty").text(""); // result가 null일 경우 0을 출력
// 	        }
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	// 최근 점검 현황
	$.ajax({
		url:"/frcs/selectStoreGrade",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(최근 점검 점수) : ", result);
			$("#storeGrade").text(result + "점");
			if (result == null) {
	            // 점검 정보가 없을 경우, 아무 내용도 출력하지 않음
	            $('.circle').removeClass('circle-active circle-warning circle-danger circle-info circle-default');
	            $('.totalScore').text('없음'); // 점수 텍스트도 비움
	        } else if (result >= 90) {
	            $('.totalScore').text('A');
	            $('.circle').removeClass('circle-warning circle-danger circle-info circle-default').addClass('circle-active');
	        } else if (result >= 80) {
	            $('.totalScore').text('B');
	            $('.circle').removeClass('circle-active circle-danger circle-info circle-default').addClass('circle-warning');
	        } else if (result >= 70) {
	            $('.totalScore').text('C');
	            $('.circle').removeClass('circle-active circle-danger circle-info circle-default').addClass('circle-warning');
	        } else if (result >= 60) {
	            $('.totalScore').text('D');
	            $('.circle').removeClass('circle-active circle-warning circle-info circle-default').addClass('circle-danger');
	        } else {
	            $('.totalScore').text('F');
	            $('.circle').removeClass('circle-active circle-warning circle-danger circle-default').addClass('circle-info');
	        }
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	// 가맹점 경고 횟수 Ajax
	$.ajax({
		url:"/frcs/selectStoreWarningCnt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(경고횟수) : ", result);
			$("#storeWarningCnt").text("경고 횟수 : " + result + "회");
			if(result >= 3){
				// 폐업조치 알림 표시
				$('#warningThree').show();
				$('.clsbiz').addClass("alarm-warning");
			}
		}
	});
	
	// 가맹점 점검 내역 Ajax
	$.ajax({
		url:"/frcs/selectStoreCheckList",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(점검 내역) : ", result);
			
			// 테이블 바디를 먼저 비움 (id="storeCheck" 사용)
	        const $tableBody = $("#storeCheck");
	        $tableBody.empty();

	        // result가 비어있을 경우, '데이터 없음' 메시지를 출력
// 	        if (result.length === 0) {
// 	            $tableBody.append(`
// 	                <tr>
// 	                    <td colspan="4" class="center">점검 내역이 없습니다.</td>
// 	                </tr>
// 	            `);
// 	            return;
// 	        }

	        // result를 반복하면서 각 데이터를 테이블에 추가
	        $.each(result, function(index, frcsCheckVO) {
	        	// chckYmd가 YYYYMMDD 형식이라서 YYYY-MM-DD로 변경
	            let chckYmdFormatted = frcsCheckVO.chckYmd.substring(0, 4) + '-' +
	                                   frcsCheckVO.chckYmd.substring(4, 6) + '-' +
	                                   frcsCheckVO.chckYmd.substring(6, 8);
				
				// 총점수에 따른 스타일 적용 (총점수가 60 미만이면 빨간글씨로 출력된다!)
	            let totScrClass = (frcsCheckVO.totScr < 60) ? 'red-text' : '';
	        	
	        	let rowHtml = '<tr>';
	            rowHtml += '<td class="center">' + chckYmdFormatted + '</td>';
	            rowHtml += '<td class="right">' + frcsCheckVO.clenScr + '</td>';
	            rowHtml += '<td class="right">' + frcsCheckVO.srvcScr + '</td>';
				// 60점 이상일 때도 총점수를 출력하도록 수정
				rowHtml += '<td class="right ' + totScrClass + '">' + frcsCheckVO.totScr + '</td>';
	            rowHtml += '</tr>';
	            
	            $tableBody.append(rowHtml);
	        });
		}
	});
	// 일간 매출 금액
	$.ajax({
		url:"/frcs/selectDayAmt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(일간 매출 금액) : ", result);
			let formattedDayAmt = new Intl.NumberFormat().format(result); // 숫자를 #,### 형식으로 변환
	        $("#dayAmt").text(formattedDayAmt);
		}
	});
	// 월간 매출 금액
	$.ajax({
		url:"/frcs/selectMonthAmt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(월간 매출 금액) : ", result);
			let formattedMonthAmt = new Intl.NumberFormat().format(result); // 숫자를 #,### 형식으로 변환
	        $("#monthAmt").text(formattedMonthAmt);
		}
	});
	// 연간 매출 금액
	$.ajax({
		url:"/frcs/selectYearAmt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(연간 매출 금액) : ", result);
			let formattedYearAmt = new Intl.NumberFormat().format(result); // 숫자를 #,### 형식으로 변환
	        $("#yearAmt").text(formattedYearAmt);
		}
	});
	// 기본적으로 연간 데이터만 보이도록 설정
    $('#monthAmt, #dayAmt').hide();

    // 라디오 버튼 클릭 시 해당하는 div만 보여주고 나머지는 숨김
    $('input[name="period"]').on('change', function() {
        // 모든 amt div 숨기기
        $('#dayAmt, #monthAmt, #yearAmt').hide();

        // 선택된 period에 따라 보여줄 div 선택
        if ($(this).val() === 'day') {
            $('#dayAmt').show();
        } else if ($(this).val() === 'month') {
            $('#monthAmt').show();
        } else if ($(this).val() === 'year') {
            $('#yearAmt').show();
        }
    });
    
    
	// 기본적으로 연간 데이터만 보이도록 설정
    $('#dayAmtContainer, #monthAmtContainer').hide();
    $('#yearAmtContainer').show();
    
    let hourSalesChart; // 전역 변수로 차트 선언
    let dailySalesChart; // 전역 변수로 차트 선언
    let monthlySalesChart; // 전역 변수로 차트 선언
    
    // 오늘 시간당 매출 차트 생성 함수
    function createHourSalesChart(data) {
    	const hourSalesDate = {
    		labels: data.map(item => item.orderHour), // 시간당 데이터 (00, 01, 02 등)
    		datasets: [
    			{
    				label: '시간당 매출', 
    				data: data.map(item => item.sumOrdrAmt), // 매출 금액 데이터
					borderColor: 'red',
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					pointStyle: 'circle',
					pointRadius: 5,
					pointHoverRadius: 10
    			}
    		]
    	};
    	
    	const hourSalesConfig = {
	    	type: 'line',
	    	data: hourSalesDate,
	    	options: {
	    		responsive: true,
	    		maintainAspectRatio: false, // 비율을 유지하지 않고, 부모 요소에 맞춤
	    		scales: {
	                y: {
	                    beginAtZero: true, // Y축이 0부터 시작
	                    min: 0           // 최소값을 0으로 설정
	                }
	            },
	    		plugins: {
	    			title: {
	    				display: true,
	    			}
	    		}
	    	}	
    	};
    	if (hourSalesChart) {
    		hourSalesChart.destroy(); // 기존 차트를 지움
		}
    	
    	// 전역 변수를 이용해 차트 객체를 저장
		hourSalesChart = new Chart(document.getElementById('myChartHour'), hourSalesConfig);
		// 차트가 생성된 후 로그 출력
		console.log("hour Sales Chart 생성됨:", hourSalesChart);
    }
    
	// 이번 달 일간 매출 차트 생성 함수
    function createDailySalesChart(data) {
		const dailySalesData = {
			labels: data.map(item => item.orderDate), // 일자 데이터 (Day 1, Day 2 등)
			datasets: [
				{
					label: '일간 매출',
					data: data.map(item => item.sumOrdrAmt), // 매출 금액 데이터
					borderColor: 'red',
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					pointStyle: 'circle',
					pointRadius: 5,
					pointHoverRadius: 10
				}
			]
		};

		const dailySalesConfig = {
			type: 'line',
			data: dailySalesData,
			options: {
				responsive: true,
				maintainAspectRatio: false, // 비율을 유지하지 않고, 부모 요소에 맞춤
				scales: {
	                y: {
	                    beginAtZero: true, // Y축이 0부터 시작
	                    min: 0           // 최소값을 0으로 설정
	                }
	            },
				plugins: {
					title: {
						display: true,
					}
				}
			}
		};
		
		if (dailySalesChart) {
			dailySalesChart.destroy(); // 기존 차트를 지움
		}
		
		// 전역 변수를 이용해 차트 객체를 저장
		dailySalesChart = new Chart(document.getElementById('myChartDay'), dailySalesConfig);
		// 차트가 생성된 후 로그 출력
		console.log("Daily Sales Chart 생성됨:", dailySalesChart);
	}
    
    
	// 이번 연도의 월간 매출 차트 생성 함수
	function createMonthlySalesChart(data) {
		const monthlySalesData = {
			labels: data.map(item => item.orderMonth), // 월 데이터 (January, February 등)
			datasets: [
				{
					label: '월간 매출',
					data: data.map(item => item.sumOrdrAmt), // 매출 금액 데이터
					borderColor: 'blue',
					backgroundColor: 'rgba(54, 162, 235, 0.2)',
					pointStyle: 'rect',
					pointRadius: 5,
					pointHoverRadius: 10
				}
			]
		};
		
		const monthlySalesConfig = {
			type: 'line',
			data: monthlySalesData,
			options: {
				responsive: true,
				maintainAspectRatio: false, // 비율을 유지하지 않고, 부모 요소에 맞춤
				scales: {
	                y: {
	                    beginAtZero: true, // Y축이 0부터 시작
	                    min: 0           // 최소값을 0으로 설정
	                }
	            },
				plugins: {
					title: {
						display: true,
					}
				}
			}
		};
		
		if (monthlySalesChart) {
			monthlySalesChart.destroy(); // 기존 차트를 지움
		}
		
		// 전역 변수에 차트 객체를 저장
		monthlySalesChart = new Chart(document.getElementById('myChartMonth'), monthlySalesConfig);
		// 차트가 생성된 후 로그 출력
		console.log("Monthly Sales Chart 생성됨:", monthlySalesChart);
	}
	
	// 차트 업데이트 함수
	function updateChartVisibility() {
		// 모든 차트 컨테이너 숨기기
		$('#dayAmtContainer, #monthAmtContainer, #yearAmtContainer').hide();
		
		// 선택된 period에 따라 차트를 보이도록 함
		const selectedPeriod = $('input[name="period"]:checked').val();
		
		if (selectedPeriod === 'day') {
			$('#dayAmtContainer').show();
			if (hourSalesChart) hourSalesChart.update();
		} else if (selectedPeriod === 'month') {
			$('#monthAmtContainer').show();
			if (dailySalesChart) dailySalesChart.update();
		} else if (selectedPeriod === 'year') {
			$('#yearAmtContainer').show();
			if (monthlySalesChart) monthlySalesChart.update();
		}
	}
	
	// 라디오 버튼 클릭 시 차트 업데이트
	$('input[name="period"]').on('change', function() {
		updateChartVisibility();
	});
	
	// 당일 시간당 매출 데이터 Ajax
	$.ajax({
		url:"/frcs/selectHourOrderAmt",
		contentType:"application/json;charset=utf-8",
		data:bzentNo,
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result(시간당 매출) : ", result);
			createHourSalesChart(result);  // 성공 시 차트 생성 함수 호출
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
	
	// 이번달 일간 매출데이터 Ajax
	$.ajax({
		url: "/frcs/selectDayOrderAmt",  // 서버의 일간 매출 데이터를 가져오는 경로
		contentType: "application/json;charset=utf-8",
		data:bzentNo,
		type: "post",
		dataType: "json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success: function(result) {
			console.log("result(일간 매출) : ", result);
			createDailySalesChart(result);  // 성공 시 차트 생성 함수 호출
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
    
    // 이번년도 월간 매출데이터 Ajax
	$.ajax({
		url: "/frcs/selectMonthOrderAmt",  // 서버의 월간 매출 데이터를 가져오는 경로
		contentType: "application/json;charset=utf-8",
		data:bzentNo,
		type: "post",
		dataType: "json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success: function(result) {
			console.log("result(월간 매출) : ", result);
			createMonthlySalesChart(result);  // 성공 시 차트 생성 함수 호출
		},
		error: function(error) {
			console.log("Error:", error);
		}
	});
    
	// 차트 생성 확인
	console.log("Hour Sales Chart: ", hourSalesChart);
	console.log("Daily Sales Chart: ", dailySalesChart);
	console.log("Monthly Sales Chart: ", monthlySalesChart);
});
</script>

<div class="wrap home-wrap">
	<div class="frow">
		<!-- 인기 메뉴 -->
		<div class="main-cont fcol main-info w-350">
			<div class="main-info-title">이달의 인기메뉴</div>
			<div class="main-info-cont" id="descMenuList">
				<!-- 인기메뉴가 들어올곳 Ajax처리 -->
			</div>
		</div>
		<!-- 비인기 메뉴 -->
<!-- 		<div class="main-cont fcol main-info w-250"> -->
<!-- 			<div class="main-info-title">이달의 비인기메뉴</div> -->
<!-- 			<div class="main-info-cont" id="ascMenuList"> -->
<!-- 				비인기메뉴가 들어올곳 Ajax처리 -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		<div class="main-cont fcol">
			<div class="cont-title">발주 관리</div>
			<div class="btnBox-wrap">
			<!-- fcol시작 -->
				<div class="fcol">
					<div class="frow btnBox-cont" onclick="location.href='/frcs/deal/list'">
						<div class="btnBox-dtl">
							<div class="btnBox-title">승인대기 건</div>
							<div class="btnBox-num">
								<!-- 승인대기 건수가 들어올곳 -->
								${map.TAPWAITING}
							</div>
						</div>
						<div class="btnBox-icon">
							<span class="material-symbols-outlined icon-cnt">sell</span>
						</div>
					</div>
					
					<div class="frow btnBox-cont">
						<div class="btnBox-dtl">
							<div class="btnBox-title">배송중 건</div>
							<div class="btnBox-num" onclick="location.href='/frcs/deal/list'">
								<!-- 배송중 건수가 들어올곳 -->
								${map.TAPPROGRESS}
							</div>
						</div>
						<div class="btnBox-icon">
							<span class="material-symbols-outlined icon-cnt">gavel</span>
						</div>
					</div>
					
				</div>
				<!-- fcol끝 -->
			
			<!-- fcol시작 -->
				<div class="fcol">
					<div class="frow btnBox-cont" onclick="location.href='/frcs/deal/list'">
						<div class="btnBox-dtl">
							<div class="btnBox-title">미승인 건</div>
							<div class="btnBox-num">
								<!-- 미승인 건수가 들어올곳 -->
								${map.TAPCOMPLETED}
							</div>
						</div>
						<div class="btnBox-icon">
							<span class="material-symbols-outlined icon-cnt">paid</span>
						</div>
					</div>
				
					<div class="frow btnBox-cont" onclick="location.href='/frcs/deal/list'">
						<div class="btnBox-dtl">
							<div class="btnBox-title">배송완료 건</div>
							<div class="btnBox-num">
								<!-- 배송완료 건수가 들어올곳 -->
								${map.TAPSCHEDULED}
							</div>
						</div>
						<div class="btnBox-icon">
							<span class="material-symbols-outlined icon-cnt">quick_reorder</span>
						</div>
					</div>
					
				</div>
			</div>
			<!-- fcol끝 -->
		</div>
		
		
		<!--  알림 시작 -->
		<div class="main-cont main-alarm-cont" style="flex-grow: 1; flex-direction: column;">
			<div class="cont-title" style="color: white;">알림</div>
			<div class="alarm-wrap">
				<c:if test="${clsbiz!=null}">
					<div class="alarm-cont" style="cursor: default;">
						<span class="icon check_box"></span>
						<div>
							<p id="warningThree" class="alarm-warning" style="display: none;">경고 횟수 3회 이상으로 폐업 조치되었습니다</p>
							<p class="clsbiz">${clsbiz}까지 영업하며 이후엔 폐업됩니다.</p>
						</div>
					</div>
				</c:if>
				<div class="alarm-cont
					<c:choose>
						<c:when test="${frcsClclnCnt!=0}">
							blank
						</c:when>
						<c:otherwise>
							check
						</c:otherwise>
					</c:choose>
				" onclick="location.href='/frcs/frcsClcln/list'">
					<span class="chk-box"></span>
					정산하지 않은 월간 정산 ${frcsClclnCnt}건이 있습니다.
				</div>
				<div class="alarm-cont
					<c:choose>
						<c:when test="${poCnt!=0}">
							blank
						</c:when>
						<c:otherwise>
							check
						</c:otherwise>
					</c:choose>
				" onclick="location.href='/frcs/deal/list'">
					<span class="chk-box"></span>
					정산하지 않은 발주 정산 ${poCnt}건이 있습니다.
				</div>
				<div class="alarm-cont
					<c:choose>
						<c:when test="${stockCnt!=0}">
							blank
						</c:when>
						<c:otherwise>
							check
						</c:otherwise>
					</c:choose>
				" onclick="location.href='/frcs/deal/regist'">
					<span class="chk-box"></span>
					구매가 필요한 상품이 ${stockCnt}건이 있습니다.
				</div>
				<div class="alarm-cont
					<c:choose>
						<c:when test="${profitCnt!=0}">
							blank
						</c:when>
						<c:otherwise>
							check
						</c:otherwise>
					</c:choose>
				" onclick="location.href='/frcs/netProfitList'">
					<span class="chk-box"></span>
					등록이 필요한 순이익 정보 ${profitCnt}건이 있습니다.
				</div>
			</div>
		</div>
		<!-- 알림 끝 -->
		
		<!-- 최근 점검 현황 시작 -->
		<div class="main-cont fcol">
			<div class="cont-title">최근 점검 현황</div>
			<div class="storeScore-wrap">
				<div class="" id="storeWarningCnt"></div>
				<div class="circle">
					<span class="totalScore"></span><span class="circle-title">등급</span>
				</div>
			</div>
		</div>
		<!-- 최근 점검 현황  -->
		
	</div>
	<!-- 첫번째 줄 끝! -->
	
	<!-- 두번째줄 시작 -->
	<div class="frow">
	
		<!-- 오늘 매출 &amp; 판매량 시작  -->
		<div class="fcol main-cont back-red w-350">
			<div class="cont-title">오늘 매출 &amp; 판매량</div>
			
			<div class="sale-wrap">
				<button type="button" class="btn-default" id="ordr">주문출고 처리하기</button>
				<!-- amt-cont시작 -->
				<div class="amt-cont">
					<div class="amt-cont-dtl">
						<div class="amt-title">
							매출액
						</div>
						<div class="amt-dtl">
							<p class="amt-amt" id="menuAmt">
								<!-- 매출액이 들어올곳 Ajax처리 -->
							</p>
							<p>원</p>
						</div>
					</div>
					<!-- amt-cont-dtl끝 -->
					<div class="amt-icon">
						<span class="material-symbols-outlined icon-amt" style="color: var(--bge--warning)">send_money</span>
					</div>
				</div>
				<!-- amt-cont끝 -->
				<!-- amt-cont시작 -->
				<div class="amt-cont">
					<div class="amt-cont-dtl">
						<div class="amt-title">
							판매량
						</div>
						<div class="amt-dtl">
							<p class="amt-amt" id="menuQty">
								<!-- 판매량이 들어올곳 Ajax처리 -->
							</p>
							<p>개</p>
						</div>
					</div>
					<!-- amt-cont-dtl끝 -->
					<div class="amt-icon">
						<span class="material-symbols-outlined icon-amt" style="color: var(--bge--warning)">send_money</span>
					</div>
				</div>
				<!-- amt-cont끝 -->
			</div>	
			
		</div>
		<!-- 오늘 매출 &amp; 판매량 끝 -->
	
		<!-- 매출 차트 시작!!! -->
		<div class="main-cont sls-chart frow">
			<div class="fcol chart-wrap">
				<!-- cont-title시작 -->
				<div class="cont-title">
					<!-- sls-wrap시작 -->
					<div class="clcln-wrap">
						<!-- sls-cont시작 -->
						<div class="clcln-cont">
							<div class="clcln-icon">
								<span class="material-symbols-outlined">send_money</span>
							</div>
							<div class="clcln-dtl">
								<div class="clcln-title">기간별 매출</div>
								<div class="clcln-cn" id="dayAmt"></div>
								<div class="clcln-cn" id="monthAmt"></div>
								<div class="clcln-cn" id="yearAmt"></div>
							</div>
						</div>
						<!-- sls-cont 끝 -->
						<!-- 상품별 매출 +radio -->
						<div class="fcol">
							<div class="radio">
								<div class="form_toggle row-vh d-flex flex-row" style="gap:var(--gap--s);">
									<div class="form_radio_btn radio_male">
										<input id="radio-day" type="radio" name="period" value="day">
										<label for="radio-day">일간</label>
									</div>
									<div class="form_radio_btn">
										<input id="radio-month" type="radio" name="period" value="month">
										<label for="radio-month">월간</label>
									</div>
									<div class="form_radio_btn">
										<input id="radio-year" type="radio" name="period" value="year" checked>
										<label for="radio-year">년간</label>
									</div>
								</div>
							</div>
						</div>
						<!-- radio끝 -->
					</div>
					<!-- sls-wrap 끝 -->
				</div>
				
				<!-- cont-title -->
				
				<div class="clcln-chart">
					<div class="ordr-chart" id="dayAmtContainer" style="display: none;">
						<canvas id="myChartHour" style="display: block; box-sizing: border-box; width: 100%;">
						</canvas>
					</div>
					<div class="ordr-chart" id="monthAmtContainer" style="display: none;">
						<canvas id="myChartDay" style="display: block; box-sizing: border-box; width: 100%;">
						</canvas>
					</div>
					<div class="ordr-chart" id="yearAmtContainer" style="display: block;">
				        <canvas id="myChartMonth" style="display: block; box-sizing: border-box; width: 100%;">
						</canvas>
				    </div>
				</div>	
			</div>
			
			
		</div>
		<!-- 매출 차트 끝!!! -->
	</div>
	<!-- 두번째줄 끝 -->
	
	<!-- 세번째줄 시작 -->
	<div class="frow">
			
		<!-- 공지사항 리스트 시작 -->
		<div class="main-container" style="flex-grow: 1;">
			<div class="main-wrapper">
				<ul class="main-content main-cont">
					<li id="contact" class="active">
						<div class="table-wrap" style="width: 100%;">
							<div class="table-title">
								<div class="cont-title">공지사항</div> 
								<div class="btn-wrap">
									<button type="button" class="btn-active" onclick="location.href='/center/selectBoard'">더보기 <span class="icon material-symbols-outlined">East</span></button>
								</div>
							</div>
							<table class="table-default eventCheck-table">
								<thead>
									<tr>
										<th class="center" style="width: 20%;">번호</th>
										<th class="center" style="width: 80%;">제목</th>
									</tr>
								</thead>
								<tbody class="table-error">
									<c:forEach var="noticeVOList" items="${noticeVOList}" varStatus="stat">
										<tr onclick="location.href='/center/selectNoticeDetail?ntcSeq=${noticeVOList.ntcSeq}'">
											<td class="center" style="width: 20%;">${noticeVOList.rnum}</td>
											<td style="width: 80%;">${noticeVOList.ntcTtl}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>		
					</li>
				</ul>
			</div>
		</div>
		<!-- 공지사항 리스트 끝 -->
		
		<!-- 공지사항 리스트 시작 -->
		<div class="main-container" style="flex-grow: 1;">
			<div class="main-wrapper">
				<ul class="main-content main-cont">
					<li id="contact" class="active">
						<div class="table-wrap" style="width: 100%;">
							<div class="table-title">
								<div class="cont-title">진행 중인 이벤트</div> 
								<div class="btn-wrap">
									<button type="button" class="btn-active" onclick="location.href='/buff/selectEvent'">더보기 <span class="icon material-symbols-outlined">East</span></button>
								</div>
							</div>
							<table class="table-default eventCheck-table">
								<thead>
									<tr>
										<th class="center" style="width: 20%;">번호</th>
										<th class="center" style="width: 80%;">제목</th>
									</tr>
								</thead>
								<tbody class="table-error">
									<c:forEach var="eventVOList" items="${eventVOList}" varStatus="stat">
										<tr onclick="location.href='/buff/insertEventCoupon?eventNo=${eventVOList.eventNo}'">
											<td class="center" style="width: 20%;">${eventVOList.rnum}</td>
											<td style="width: 80%;">${eventVOList.eventTtl}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>		
					</li>
				</ul>
			</div>
		</div>
		<!-- 공지사항 리스트 끝 -->
		
	</div>
	<!-- 세번째줄 끝 -->
	
</div>
<!-- <div class="wrap"> 끝! -->