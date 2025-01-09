/*******************************************
  @fileName    : sls.js
  @author      : 이병훈
  @date        : 2024. 10. 07
  @description : 거래처 매출 관련 코드
********************************************/

/*******************************************
  해당 거래처 매출 데이터 가져오기
********************************************/
// 매출 데이터 로드 함
function selectSalesData(){
	const period = $('input[name="period"]:checked').val();
	console.log("period : ", period);
	
	let data = {
			currentPage : currentPage,
			startMonth  : $("#startMonth").val(),
			endMonth : $("#endMonth").val(),
			selectedYear : $("#selectedYear").val(),
			bzentNo : bzentNo,
			period : period
	};
	
	$.ajax({
		url : "/cnpt/sls/selectSalesAjax",
		data : data,
		type : "GET",
		beforeSend : function(xhr){
			// CSRF 헤더와 토큰을 설정
			xhr.setRequestHeader(csrfHeader, csrfToken); 
		},
		success : function(res){
			// 테이블과 페이징네이션 업데이트
			selectSalesTable(res.articlePage.content, res.articlePage);
			selectSalesChart(res.chartData, period);
			// AJAX 호출 이후 총 매출 금액 업데이트
            updateTotalSalesAmount(data);
		}, 
		error : function(xhr, status, error){
			console.error("에러가 발생하였습니다.", error);
		}
		
	// ajax 끝	
	});
	
	// 차트를 위한 별도의 AJAX 요청 (전체 데이터를 가져오기 위해)
	$.ajax({
		url : "/cnpt/sls/selectChartDataAjax", // 차트 데이터 전용 요청
		data : data, // 검색 조건에 맞는 전체 데이터 가져오기
		type : "GET",
		beforeSend : function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken); 
		},
		success : function(res){
			// 차트 데이터 업데이트
			selectSalesChart(res.chartData, period);
		},
		error : function(xhr, status, error){
			console.error("차트 데이터 로딩 중 에러 발생", error);
		}
	});
	
	
// selectSalesData 함수 끝	
}
/*******************************************
  검색되는 period(기간)에 따른 x축 데이터 생성
********************************************/
function generateLabels(period, startMonth, endMonth) {
    if (period === 'year') {
        // 연 단위일 때는 고정된 12개월 레이블을 반환
        return ['1월', '2월', '3월', '4월', '5월', '6월', 
                '7월', '8월', '9월', '10월', '11월', '12월'];
    } else {
        // 기간 검색일 경우: startMonth부터 endMonth까지의 레이블을 생성
        const start = parseInt(startMonth.substring(4)); // 202401 -> 1 (월)
        const end = parseInt(endMonth.substring(4));     // 202407 -> 7 (월)
        let labels = [];
        for (let i = start; i <= end; i++) {
            labels.push(`${i}월`);
        }
        return labels;
    }
}
/*******************************************
  왼쪽 구역 테이블 설정 및 페이지네이션 처리
********************************************/
// 테이블 및 페이징네이션 업데이트 함수
function selectSalesTable(data, articlePage){
	let strTbl = '';
	
	console.log("articlePage : ", articlePage);
	
	if(data.length === 0){
		strTbl += `<tr>
						<td class="error-info center" colspan="3"> 
							<span class="error-icon material-symbols-outlined">error</span>
							<div class="error-msg">검색 결과가 없습니다</div>
						</td>
					</tr>`;
	} else {
		data.forEach(item => {
			// 날짜 형식 변환
			let clclnYmd = strToDate(item.clclnYmd);
			
		
			strTbl += `<tr>
							<td class="center">${item.rnum}</td>
							<td class="center">${clclnYmd}</td>
							<td class="right">${item.clclnAmt.toLocaleString()}</td>
					  </tr>`;		
		});
		
	}
	$('#table-body').html(strTbl);
	
	// 페이지 처리
	let page = '';
	
	if (articlePage.startPage > articlePage.blockSize) {
        page += `<a href="#page" class="page-link" data-page="${articlePage.startPage - articlePage.blockSize}">
                    <span class="icon material-symbols-outlined">chevron_left</span></a>`;
    }
    for (let pnum = articlePage.startPage; pnum <= articlePage.endPage; pnum++) {
        if (articlePage.currentPage === pnum) {
            page += `<a href="#page" class="page-link active" data-page="${pnum}">${pnum}</a>`;
        } else {
            page += `<a href="#page" class="page-link" data-page="${pnum}">${pnum}</a>`;
        }
    }
    if (articlePage.endPage < articlePage.totalPages) {
        page += `<a href="#page" class="page-link" data-page="${articlePage.startPage + articlePage.blockSize}">
                    <span class="icon material-symbols-outlined">chevron_right</span></a>`;
    }

    $('.pagination').html(page);
	
// selectSalesTable 함수 끝	
}

/*******************************************
 선택한 파라미터에 따른 차트 업데이트 함수 
********************************************/
function selectSalesChart(slsData, period) {
    let data = {
        selectedYear: $("#selectedYear").val(),
        startMonth: $("#startMonth").val(),
        endMonth: $("#endMonth").val(),
        bzentNo: bzentNo
    };
    
    $.ajax({
        url: "/cnpt/sls/selectChartDataAjax",
        data: data,
        type: "GET",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function(res) {
            const chartData = res.chartData;

            // 차트에 데이터를 반영하는 부분
            const labels = generateLabels(period, data.startMonth, data.endMonth);
            const amounts = chartData.map(item => item.total);

            // 차트 생성 또는 업데이트
            let ctx = document.getElementById('salesChart').getContext('2d');
            if (window.monthSalesChart) {
                window.monthSalesChart.destroy();
            }

            window.monthSalesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '매출 현황',
                        data: amounts,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: '매출 현황 차트',
                            font: { size: 18, weight: 'bold' }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        }
                    }
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("차트 데이터를 가져오는 중 에러 발생: ", error);
        }
    });
}
/*******************************************
  일간 데이터 가져오기
********************************************/
// 일간 데이터 가져오기 함수
function selectDailySalesData(){
	
	// 선택한 날짜 가져오기
	let selectedDate = $("#selectedDate").val();
	if(selectedDate){
		// 날짜 형식 변환, "-"를 제거 
		selectedDate = selectedDate.replace(/-/g, '');
	}
	
	let data = {
			currentPage : currentPage,
			selectedDate : selectedDate
	};
	
	console.log("selectedDate : ", data.selectedDate);
	
	$.ajax({
		url : "/cnpt/sls/selectDailySalesAjax",
		data : data,
		type : "GET",
		beforeSend : function(xhr){
			// CSRF 헤더와 토큰 설정
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success : function(res){
			console.log("응답 데이터 : ", res);
			console.log("일간 데이터 : ", res.articlePage.content);
			// 테이블과 차트 업데이트
			if (res.articlePage.content && res.articlePage.content.length > 0) {
                // 테이블과 차트 업데이트
                selectDailySalesTable(res.articlePage.content);
                selectDailySalesChart(res.articlePage.content);
            } else {
                // 데이터가 없을 때 처리 -> 빈 배열 전달:
                selectDailySalesTable([]); 
            }
		},
		error : function(xhr, status, error){
			console.error("에러가 발생했습니다. ", error);
		}
		
	// ajax 끝	
	});
	
// selectDailySalesData 함수 끝	
}

/*******************************************
  일간 매출 테이블 데이터 업데이트
********************************************/
// 일간 매출 테이블 데이터 업데이트 함수
function selectDailySalesTable(data){
	let tableBody = $('#table-body');
	// 기존 데이터 지우기
	tableBody.empty();
	
	// 데이터가 없을 경우 메시지 표시
	if(!data || data.length === 0){
		tableBody.append(`<tr>
							<td class="error-info center" colspan="3"> 
								<span class="error-icon material-symbols-outlined">error</span>
								<div class="error-msg">검색 결과가 없습니다</div>
							</td>
						</tr>`);
		return;
	}
	// 중복 제거를 위한 Set 사용
    let seen = new Set();

    data.forEach(item => {
        // 정산일자
        let clclnYM = strToDate(item.clclnYmd);

        // 중복된 항목인지 확인
        if (!seen.has(item.clclnYmd)) {
            seen.add(item.clclnYmd);  // 이미 본 항목으로 추가

            // 중복되지 않은 항목만 추가
            let row = `<tr>
				<td class="center">${item.rnum}</td>
				<td class="center">${clclnYM}</td>
				<td class="center">${item.clclnAmt.toLocaleString()} 원</td>
			</tr>`;
            tableBody.append(row);
        }
    });
// selectDailySalesTable 함수 끝
}
/*******************************************
   YYYYMMDD 형식을 YYYY-MM-DD로 변환하는 함수
********************************************/
function strToDate(dateString) {
    if (!dateString || dateString.length !== 8) return dateString; // 유효성 검사
    const year = dateString.substring(0, 4);
    const month = dateString.substring(4, 6);
    const day = dateString.substring(6, 8);
    return `${year}-${month}-${day}`;
}

/*******************************************
  일간 매출 차트 데이터 업데이트
********************************************/

// 일간 매출 차트 업데이트 함수
function selectDailySalesChart(data){
	let chartData = {
			labels : [],
			datasets : [{
				label : '상품 별 일간 매출량',
				data : [],
				backgroundColor: [
	                // 각 데이터 항목에 대한 색상
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                // 각 데이터 항목에 대한 테두리 색상
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
				
			}]
		};
	// 차트 데이터 구성
	data.forEach(item => {
		console.log("item: " , item);	
		
	   if (!item.gdsNm) {
        console.warn("상품명이 없습니다.");
        return;
        }
		
		const index = chartData.labels.indexOf(item.gdsNm);
		if(index === -1) {
			// 새로운 상품인 경우 추가
			chartData.labels.push(item.gdsNm);
			chartData.datasets[0].data.push(item.clclnAmt);
		} else {
			// 이미 존재하는 상품일 경우, 금액 누적
			chartData.datasets[0].data[index] += item.clclnAmt;
		}
		
	});
	
	// 데이터 확인
	console.log("차트 데이터 : ", chartData);
	
	// 기존 차트를 삭제하고 새로운 차트 생성
	let ctx = document.getElementById('salesChart').getContext('2d');
	
	 // 기존 차트가 있을 경우 제거
    if (window.dailySalesChart) {
        window.dailySalesChart.destroy();
    }
	window.dailySalesChart = new Chart(ctx, {
		type : 'doughnut',
		data : chartData,
		options: {
            responsive: true,
            plugins: {
                datalabels: {
                    color: '#fff',
                    formatter: (value, context) => {
                        const label = context.chart.data.labels[context.dataIndex];
                        const percentage = ((value / context.chart._metasets[0].total) * 100).toFixed(1);
                        return `${label}\n${percentage}%`;  // 상품명과 비율 표시
                    },
                    font: {
                        weight: 'bold',
                        size: 12
                    },
                    align: 'center',
                    anchor: 'center'
                },
                legend: {
                    position: 'top',
                    labels: {
                        font: {
                            size: 14
                        }
                    }
                },
                tooltip: {
                    callbacks: {
                        label: (tooltipItem) => {
                            let value = tooltipItem.raw.toLocaleString();
                            return `${tooltipItem.label}: ${value} 원`;
                        }
                    }
                }
            }
        }
    });
	
// selectDailySalesChart 함수 끝	
}

/*******************************************
  검색 조건에 따라 총 매출 금액 비동기 업데이트
********************************************/
// 검색조건에 따라 총 매출 금액 비동기 업데이트
function updateTotalSalesAmount(data){
	let selectedDate = $("#selectedDate").val();
	
	// selectedDate가 있을 경우 '-'를 제거하여 '20241017' 형식으로 변환
	if (selectedDate) {
		selectedDate = selectedDate.replace(/-/g, ''); // '2024-10-17' -> '20241017'
	}
	data.selectedDate = selectedDate; // 변환된 값을 data에 넣음
	
	console.log("data.selectedDate", data.selectedDate);
	
	// 비동기 ajax로 총 금액 업데이트
	$.ajax({
		url : '/cnpt/sls/selectSalesAmountAjax',
		type : 'GET',
		data : data,
		beforeSend : function(xhr){
			// csrf 헤더와 토큰을 설정
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success : function(res) {
			//	총 금액 업데이트
			$('#clclnTotal').text(res.toLocaleString());
			
		},
		error : function(xhr, status, error){
			console.error("검색에 따른  총 금액 가져오는 데 오류 발생 : ", error);
		}
	// ajax 끝	
	});
// updateTotalSalesAmount 함수 끝	
}
