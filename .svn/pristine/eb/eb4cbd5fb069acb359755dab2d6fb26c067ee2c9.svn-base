<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/resources/com/css/main.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/com/js/stockAjmt.js"></script>
<!-- <sec:authentication property="principal.MemberVO" var="user"/> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(function(){
    // 첫 번째 라인 차트
    const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July'];
    const data = {
      labels: labels,
      datasets: [
        {
          label: 'Dataset 1',
          data: [10, 30, 39, 20, 25, 34, -10],
          borderColor: 'red',  // 기본 색상 설정
          backgroundColor: 'rgba(255, 99, 132, 0.2)', // 투명도 설정
        },
        {
          label: 'Dataset 2',
          data: [18, 33, 22, 19, 11, 39, 30],
          borderColor: 'blue', // 기본 색상 설정
          backgroundColor: 'rgba(54, 162, 235, 0.2)', // 투명도 설정
        }
      ]
    };

    // 첫 번째 차트 생성
    var myChart = new Chart(
        document.getElementById('myChart'),
        {
          type: 'line',
          data: data,
          options: {
            responsive: true,
            plugins: {
              title: {
                display: true,
                text: '매출 및 정산 금액'
              }
            },
            scales: {
              y: {
                suggestedMin: 0, // 최소값 설정
                suggestedMax: 50, // 최대값 설정
              }
            }
          }
        }
    );
    
    // 두 번째 도넛 차트
    const data2 = {
        labels: ['A', 'B', 'C', 'D', 'F'],
        datasets: [
            {
                label: 'Dataset 1',
                data: [10, 20, 30, 40, 50],  // 직접 데이터 설정
                backgroundColor: ['red', 'orange', 'yellow', 'green', 'blue'],  // 배경색 설정
            }
        ]
    };

    const config2 = {
        type: 'doughnut',
        data: data2,
        options: {
        	responsive: false,  // 크기를 고정하기 위해 responsive 옵션을 false로 설정
            maintainAspectRatio: false, // 캔버스의 비율을 유지하지 않음
            plugins: {
            	legend: {
                    display: false  // 범례 숨기기
                },
                title: {
                    display: false
//                     text: 'Chart.js Doughnut Chart'
                }
            }
        },
    };  

    // 두 번째 차트 생성
    var myChart2 = new Chart(
        document.getElementById('checkChart'),
        config2
    );
});
</script>
<div class="wrap">

<!-- cont 시작 -->
<div class="chart-clcln cont spar">
	<!-- cont-title시작 -->
	<div class="cont-title">
		<!-- clcln-wrap시작 -->
		<div class="clcln-wrap">
			<!-- clcln-cont시작 -->
			<div class="clcln-cont">
				<div class="clcln-icon">
					<span class="material-symbols-outlined">send_money</span>
				</div>
				<div class="clcln-dtl">
					<div class="clcln-title">총 매출</div>
					<div class="clcln-cn">1,000,000,000</div>
				</div>
			</div>
			<!-- clcln-cont 끝 -->
			
			<!-- clcln-cont시작 -->
			<div class="clcln-cont">
				<div class="clcln-icon">
					<span class="material-symbols-outlined">send_money</span>
				</div>
				<div class="clcln-dtl">
					<div class="clcln-title">정산금액</div>
					<div class="clcln-cn">1,000,000,000</div>
				</div>
			</div>
			<!-- clcln-cont 끝 -->
			
		</div>
		<!-- clcln-wrap 끝 -->
		
		<div class="radio">
			<div class="form_toggle row-vh d-flex flex-row" style="gap:var(--gap--s);">
				<div class="form_radio_btn radio_male">
					<input id="radio-1" type="radio" name="clclnDate" value="day" checked>
					<label for="radio-1">일간</label>
				</div>
				<div class="form_radio_btn">
					<input id="radio-2" type="radio" name="clclnDate" value="year">
					<label for="radio-2">년간</label>
				</div>
			</div>
		</div>
		
	</div>
	<!-- cont-title -->
	
	<div class="clcln-chart">
		<div data-v-409fe714="" class="chart-view">
			<canvas id="myChart" style="display: block; box-sizing: border-box;height: 150px; width: 800px;">
			</canvas>
		</div>
	</div>
</div>
<!-- cont 끝 -->



<div class="amt-wrap">
	<!-- amt-col시작 -->
	<div class="amt-col">
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					총 매출
				</div>
				<div class="amt-dtl">
					<p class="amt-amt">100,000,000</p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt">toll</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
		
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					정산 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt">100,000,000</p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt">send_money</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
	</div>
	<!-- amt-col끝 -->
	
	<!-- amt-col시작 -->
	<div class="amt-col">
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					상품 판매 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt">100,000,000</p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt" style="color: var(--bge--active)">trending_up</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
		
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					상품 구매 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt">100,000,000</p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt" style="color: var(--bge--danger)">trending_down</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
	</div>
	<!-- amt-col끝 -->
	<div class="chart">
		차트?
	</div>
</div>
<!-- amt-wrap끝 -->




<div class="cnt-wrap">
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">person</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">상담 대기</div>
	</div>
	
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">person</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">문의 답변대기</div>
	</div>

	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">package_2</span>
		</div>
		<div class="cnt-num">
			60
		</div>
		<div class="cnt-title">배송확정 대기</div>
	</div>
			
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">payments</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">발주 정산</div>
	</div>
		
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">payments</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">판매승인 대기</div>
	</div>
		
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">payments</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">폐업 대기</div>
	</div>
		
	<div class="cnt-cont">
		<div class="cnt-icon">
			<span class="material-symbols-outlined icon-cnt">payments</span>
		</div>
		<div class="cnt-num">
			100
		</div>
		<div class="cnt-title">점검 필요</div>
	</div>
</div>

<div class="check-wrap">
	<div data-v-409fe714="" class="chart-view">
		<canvas id="checkChart" width="200" height="200" style="display: block; box-sizing: border-box;height: 200px; width: 200px;">
		</canvas>
	</div>

</div>



</div>
<!-- wrap끝 -->