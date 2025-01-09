/**
 * 
 */


// 미리 섞어둔 색상 배열
const backgroundColor= [
  'rgba(255, 99, 132, 0.2)',  // 색상 1
  'rgba(54, 162, 235, 0.2)',  // 색상 2
  'rgba(255, 206, 86, 0.2)',  // 색상 3
  'rgba(75, 192, 192, 0.2)',  // 색상 4
  'rgba(153, 102, 255, 0.2)',  // 색상 5
  'rgba(255, 159, 64, 0.2)',  // 색상 6
  'rgba(201, 203, 207, 0.2)',  // 색상 7
  'rgba(102, 255, 153, 0.2)',  // 색상 8
  'rgba(255, 99, 71, 0.2)',   // 색상 9
  'rgba(123, 104, 238, 0.2)',  // 색상 10
  'rgba(240, 128, 128, 0.2)',  // 색상 11
  'rgba(255, 182, 193, 0.2)',  // 색상 12
  'rgba(70, 130, 180, 0.2)',  // 색상 13
  'rgba(32, 178, 170, 0.2)',  // 색상 14
  'rgba(176, 196, 222, 0.2)',  // 색상 15
  'rgba(199, 21, 133, 0.2)',  // 색상 16
  'rgba(0, 206, 209, 0.2)'    // 색상 17
];
const borderColor= [
  'rgba(255, 99, 132, 1)',  // 테두리 색상 1
  'rgba(54, 162, 235, 1)',  // 테두리 색상 2
  'rgba(255, 206, 86, 1)',  // 테두리 색상 3
  'rgba(75, 192, 192, 1)',  // 테두리 색상 4
  'rgba(153, 102, 255, 1)',  // 테두리 색상 5
  'rgba(255, 159, 64, 1)',  // 테두리 색상 6
  'rgba(201, 203, 207, 1)',  // 테두리 색상 7
  'rgba(102, 255, 153, 1)',  // 테두리 색상 8
  'rgba(255, 99, 71, 1)',   // 테두리 색상 9
  'rgba(123, 104, 238, 1)',  // 테두리 색상 10
  'rgba(240, 128, 128, 1)',  // 테두리 색상 11
  'rgba(255, 182, 193, 1)',  // 테두리 색상 12
  'rgba(70, 130, 180, 1)',  // 테두리 색상 13
  'rgba(32, 178, 170, 1)',  // 테두리 색상 14
  'rgba(176, 196, 222, 1)',  // 테두리 색상 15
  'rgba(199, 21, 133, 1)',  // 테두리 색상 16
  'rgba(0, 206, 209, 1)'    // 테두리 색상 17
];

 
 function selectAmtAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/getAmt",
		type : "POST",
		data : {date : date},
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			console.log(res);
			/****************
			// 지역별 매출
			*****************/
			
			$('#rgn-doughnut').remove(); // 기존 캔버스 요소를 제거
    		$('.rgn-chart').append('<canvas id="rgn-doughnut" width="300" height="210"></canvas>'); // 새 캔버스를 추가
			
			// 서버로부터 받은 res.rgn 데이터 처리
			const rgnLabels = res.rgn.map(item => item.rgnNm);  // label은 rgnNm
			const rgnData = res.rgn.map(item => item.total); // data는 totalAmt

			// 데이터 길이에 맞춰 색상 배열을 자르기
			const backgroundColors = backgroundColor.slice(0, rgnData.length);
			const borderColors = borderColor.slice(0, rgnData.length);
			
			// 도넛 차트 데이터 설정
			const doughnutData2 = {
			  labels: rgnLabels,  // rgnNm을 labels로 설정
			  datasets: [{
			    label: "지역별 총 금액",
			    data: rgnData,   // totalAmt를 data로 설정
			    backgroundColor: backgroundColors,  // 랜덤 색상 배열 사용
    			borderColor: borderColors,          // 같은 색을 테두리로 사용
			    borderWidth: 1
			  }]
			};
			
			// 차트 옵션 설정
			const doughnutOptions = {
			  responsive: false,
			  plugins: {
			    legend: {
			      display: true,
			      position: "right",
			      labels: {
			        color: "#333",
			        font: {
			          family: 'NanumSquare, sans-serif', // 폰트 설정
					  size: 18,
					  weight: 'bold'
			        }
			      }
			    }
			  }
			};
			
			// 차트 생성
			var ctx2 = document.getElementById('rgn-doughnut').getContext('2d');
			
			chart2 = new Chart(ctx2, {
			  type: "doughnut",
			  data: doughnutData2,
			  options: doughnutOptions
			});

			
			/****************
			// 전체 매출
			*****************/
			$('#myChart').remove(); // 기존 캔버스 요소를 제거
    		$('.ordr-chart').append('<canvas id="myChart" style="display: block; box-sizing: border-box; height: 300px; width: 100%;"></canvas>'); // 새 캔버스를 추가
			
			// 서버로부터 받은 res 데이터 처리
			const labels = res.ordr.map(item => item.period);  // period를 라벨로 설정
			const totalAmtData = res.ordr.map(item => item.total);  // total_amt를 데이터로 설정
			
			// 차트 데이터 설정
			const data = {
			  labels: labels,
			  datasets: [{
			    label: '총 금액',
			    data: totalAmtData,  // total_amt 데이터를 사용
			    borderColor: 'rgba(245, 176, 179, 1)',  // 선 색상 설정
			    backgroundColor: 'rgba(54, 162, 235, 0.2)',  // 투명도 설정
			    fill: false  // 차트 아래 영역 색칠 여부
			  }]
			};
			
		// 차트 생성
// 차트 생성
var myChart = new Chart(
    document.getElementById('myChart'),
    {
      type: 'line',  // 라인 차트
      data: data,
      options: {
        responsive: false,
        scales: {
          y: { // Y축 관련 설정
            suggestedMin: 0,  // Y축 최소값
            suggestedMax: 50,  // Y축 최대값
            grid: { // Y축 그리드 라인 설정
              drawBorder: false,
              color: 'rgba(0, 116, 52, 0.2)'  // 그리드 라인 색상
            },
            ticks: {
              color: '#999', // Y축 폰트 색상 설정
              font: { // Y축 폰트 스타일 설정
                family: 'NanumSquare, sans-serif',  // 폰트 설정
                size: 12,
                weight: 'bold'
              }
            }
          },
          x: { // X축 관련 설정
            ticks: {
              color: '#000000', // X축 폰트 색상 설정
              font: { // X축 폰트 스타일 설정
                family: 'NanumSquare, sans-serif',  // 폰트 설정
                size: 15,
                weight: 'bold'
              }
            }
          }
        },
        plugins: {
          legend: {
            labels: {
              color: '#000', // legend 폰트 색상 설정
              font: { // legend 폰트 스타일 설정
                family: 'NanumSquare, sans-serif', // 폰트 설정
                size: 15,
                weight: 'bold'
              }
            }
          }
        }
      }
    }
);

			
			
			// 서버로부터 받은 res.ordr 데이터 처리
			const totalAmtSum = res.ordr.reduce((sum, item) => sum + item.total, 0);  // total의 합계 계산
			
			// 합계를 #totalAmt 요소에 넣음 (toLocaleString()을 사용하여 포맷팅)
			$('#totalAmt').text(totalAmtSum.toLocaleString());
		} // success 끝
	});			
 }
 