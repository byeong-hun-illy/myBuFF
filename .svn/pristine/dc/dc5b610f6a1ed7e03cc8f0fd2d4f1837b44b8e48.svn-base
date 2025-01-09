/*******************************************
  @fileName    : main.js
  @author      : 이병훈
  @date        : 2024. 10. 12
  @description : 거래처 메인 관련 코드
********************************************/

/*******************************************
  처음 화면 데이터 가져오기 함수
********************************************/
function loadSalesData(){
	const period = $('input[name="period"]:checked').val();
	$.ajax({
		url : '/cnpt/main/getSalesData',
		type : 'POST',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify({ period : period }),
		beforeSend : function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success : function(data){
			console.log("data 먼저 보자 : ", data);
			console.log("data.totalAmount : ", data.totalAmount);
			
			// 총 매출 금액이 있는 경우 업데이트
		    if (data.totalAmount !== undefined) {
		        console.log("DOM 업데이트 중: ", data.totalAmount);
		        updateTotalAmount(data.totalAmount);  // 이 부분을 다시 점검
		    } else {
		        console.warn("총 매출 금액이 없습니다.");
		        $('#totalAmt').text('0 원');
		    }	
		    
			if (!data.chartData || data.chartData.length === 0) {
			    console.log("차트 데이터가 없습니다.");
			    updateChart([], period);  // 빈 데이터로 차트 그리기
			    return;
			}
			
			data.chartData.forEach((item) => {
				console.log("item.period : ", item.period);
			});
			
			// List로 들어오는 chartData이기 때문에 labels와 data를 분리해서 chartData를 전달
			const labels = data.chartData.map(item => item.period);
            const chartValues = data.chartData.map(item => item.clclnAmt);
			
			console.log("여기 체크 period : ", period);
			
			updateChart(data.chartData, period);
		},
		error :function(xhr, status, error){
			console.error("에러 발생 : ", error);
		}
	// ajax 끝	
	});
// loadSalesData 함수 끝
}

/*******************************************
  매출 현황 차트 그리기 함수
********************************************/
function updateChart(data, period){
	const ctx = document.getElementById('myChart').getContext('2d');
	
	// 기존 차트가 있으면 파괴
	if(window.salesChart) {
		window.salesChart.destroy();
	}
	
    // 동적 레이블 생성
    let labels = generateLabels(period, data);
	
	console.log("들어오는 data : ", data);
	
	// 데이터가 없거나 null/undefined일 경우 기본 차트 생성
	if (!Array.isArray(data) || data.length === 0) {
		   console.log("차트 데이터가 없습니다.");
        // 기본적으로 차트가 없을 때 X, Y축만 표시
        window.salesChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], // 기본 X축 레이블 (연간 기준)
                datasets: [{
                    label: '매출 데이터 없음',
                    data: new Array(12).fill(0), // 12개의 값이 0인 배열
                    borderColor: 'rgba(75, 192, 192, 1)',
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: '매출 데이터가 없습니다' // 상단에 문구 표시
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: '기간'
                        },
                        ticks: {
                            autoSkip: false,
                            maxRotation: 45,
                            minRotation: 0
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: '매출 금액 (원)'
                        },
                        ticks: {
                            stepSize: 1 // 최소 단계
                        }
                    }
                }
            }
        });
        return;
	}

    // 데이터 매핑 로직 (기간에 따른 총액 계산)
    const chartValues = labels.map(label => {
        if (period === 'year') {
            const month = label.replace('월', '').padStart(2, '0');
            const totalForMonth = data
                .filter(item => item.clclnYmd && item.clclnYmd.startsWith(`2024${month}`))  // clclnYmd가 undefined인지 확인
                .reduce((sum, item) => sum + (item.clclnAmt || 0), 0);  // clclnAmt가 undefined인 경우 0으로 처리
            return totalForMonth;
        } else if (period === 'month') {
            const day = label.replace('일', '').padStart(2, '0');
            const totalForDay = data
                .filter(item => item.clclnYmd && item.clclnYmd.endsWith(day))  // clclnYmd가 undefined인지 확인
                .reduce((sum, item) => sum + (item.clclnAmt || 0), 0);  // clclnAmt가 undefined인 경우 0으로 처리
            return totalForDay;
        } else if (period === 'day') {
            const hour = label.replace('시', '').padStart(2, '0');
            const totalForHour = data
                .filter(item => item.clclnYmd && item.clclnYmd.endsWith(hour))  // clclnYmd가 undefined인지 확인
                .reduce((sum, item) => sum + (item.clclnAmt || 0), 0);  // clclnAmt가 undefined인 경우 0으로 처리
            return totalForHour;
        }
    });
    
	// x축 레이블 생성
    const xAxisLabel = period === 'year' 
        ? '월별 매출' 
        : period === 'month' 
        ? '일별 매출' 
        : '시간별 매출';

	
	window.salesChart = new Chart(ctx, {
		type : 'line',
		data : {
			labels : labels,
			datasets : [{
				data : chartValues,
				borderColor : 'rgba(75, 192, 192, 1)'
			}]
		},
		options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                    position: 'top',
                },
                title: {
                    display: false
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: xAxisLabel
                    },
                     ticks: {
                        autoSkip: false, 
                        maxRotation: 45, 
                        minRotation: 0,
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '매출 금액 (원)'
                    }
                }
            }
        }
	});
// updateChart 함수 끝	
}

/*******************************************
  검색 조건에 따른 상품 매출 차트함수
********************************************/
function loadProductSalesData(period){
	console.log("검색 기간 : ", period);
	
	$.ajax({
		url : '/cnpt/main/getProductSalesData',
		type : 'GET',
		data : { period:period },
		beforeSend : function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success : function(res){
			console.log("성공 :", res);
			console.log("productData :", res.productSalesData);
			
			
			// 상품별 차트 업데이트
			updateProductChart(res.productSalesData);
			
			// 총 매출 금액 업데이트
			updateTotalAmount(res.total);
		},
		error : function(xhr, status, error){
			console.error("오류 발생 : ", error);
		}
	// ajax 끝	
	});
// loadProductSalesData 함수 끝	
}

/*******************************************
  검색조건에 따른 상품 매출 차트 업데이트 함수
********************************************/
function updateProductChart(productSalesData){
	
	 const chartElement = document.getElementById('gdsChart');
    
    // chartElement가 존재하는지 확인
    if (!chartElement) {
        console.error("차트를 렌더링할 엘리먼트를 찾을 수 없습니다.");
        return;
    }
    
    const ctx = chartElement.getContext('2d');

    // 기존 차트가 있다면 제거
    if(window.productChart){
        window.productChart.destroy();
    }

    // 데이터가 없을 경우 '상품 데이터가 없습니다.' 텍스트 표시
    if (!productSalesData || productSalesData.length === 0) {
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);  // 캔버스 지우기
        ctx.font = "20px Arial";
        ctx.textAlign = "center";
        ctx.fillText("상품 데이터가 없습니다.", ctx.canvas.width / 2, ctx.canvas.height / 2);
        return;  // 데이터 없을 경우 함수 종료
    }

    const labels = productSalesData.map(item => item.gdsNm || "Unknown");
    const data = productSalesData.map(item => item.total);

    const chartData = {
        labels: labels,
        datasets: [{
            label: '상품별 매출',
            data: data,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
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

    window.productChart = new Chart(ctx, {
        type: 'doughnut',
        data: chartData,
        options: {
            responsive: true,
            plugins: {
                legend: { display: true, position: 'top' },
                title: { display: true, text: '상품별 매출' }
            }
        }
    });
	
// updateProductChart 함수 끝	
}


/*******************************************
  검색조건에 따른 총 매출액 비동기 업데이트
********************************************/
function updateTotalAmount(totalAmount) {
    console.log("updateTotalAmount 호출됨. 총액:", totalAmount);

    const totalAmtElement = $('#totalAmt');
    if (totalAmtElement.length === 0) {
        console.error("총 매출 금액을 표시할 엘리먼트를 찾을 수 없습니다.");
        return;
    }

    if (typeof totalAmount === 'number' && !isNaN(totalAmount)) {
        totalAmtElement.html(`${totalAmount.toLocaleString()} 원`);
        console.log("DOM 업데이트 완료:", totalAmount);
    } else {
        console.warn("총 매출 금액이 없습니다.");
        totalAmtElement.html('0 원');
    }
}

/*******************************************
  검색되는 period(기간)에 따른 x축 데이터 생성
********************************************/
function generateLabels(period, data) {
    if (period === 'year') {
        return ['1월', '2월', '3월', '4월', '5월', '6월', 
                '7월', '8월', '9월', '10월', '11월', '12월'];
    } else if (period === 'month') {
        const daysInMonth = new Set(
            data.map(item => parseInt(item.clclnYmd.slice(6, 8), 10))
        );
        return Array.from(daysInMonth).sort((a, b) => a - b).map(day => `${day}일`);
    } else {
        return Array.from({ length: 24 }, (_, i) => `${i}시`);
    }
}

/*************************************************************************************
			발주 미승인 건 조회
**************************************************************************************/
function selectDealAjax() {
    let data = {
        deliType: deliType,
        sort: sort,
        orderby: orderby,
        currentPage: currentPage,
        bzentNo: bzentNo,
        type: type
    };

    $.ajax({
        url: "/cnpt/main/selectUnApprove",
        type: "GET",
        data: data,
        success: function (res) {
            console.log(res); // 데이터 확인
			
			let totalPage = res.articlePage.total;
			console.log("total페이지 : ", totalPage);
			
			// total페이지 값 뱃지에 넣기
			$('#tap-deli04').text(`${totalPage}`);
			
            // 데이터가 없을 때 처리
            if (!res.articlePage || res.articlePage.total === 0) {
                $('#table-body').html(`
                    <tr>
                        <td class="error-info" colspan="7">
                            <span class="icon material-symbols-outlined">error</span>
                            <div class="error-msg">검색 결과가 없습니다</div>
                        </td>
                    </tr>
                `);
                $('.pagination').html('');
                return;
            }

            // 데이터가 있을 때 테이블 생성
            let strTbl = '';
            res.articlePage.content.forEach(list => {
            	console.log("list : ", list);
                let deliYmd = list.deliYmd ? list.deliYmd : '-';
                let clclnAmt = list.clclnAmt ? list.clclnAmt.toLocaleString() + '원' : '-';
                let clclnYn = list.clclnYn === 'Y' 
                    ? `<span class='bge bge-active-border'>정산완료</span>` 
                    : `<span class='bge bge-danger-border'>정산미납</span>`;
                let deliTypeStr = `<span class='bge bge-info'>${list.deliTypeNm}</span>`;

                strTbl += `
                    <tr class="dealDtl" data-no="${list.poNo}">
                        <td class="center">${list.rnum}</td>
                        <td class="center">${list.poNo}</td>
                        <td class="center">${list.poClclnVO.clclnAmt}</td>
                        <td class="center">${deliYmd}</td>
                        <td class="center">${clclnYn}</td>
                        <td class="center">${deliTypeStr}</td>
                    </tr>
                `;
            });

            $('#table-body').html(strTbl);

            // 페이지네이션 처리
            let page = '';
            if (res.articlePage.startPage > res.articlePage.blockSize) {
                page += `<a href="#page" class="page-link" data-page="${res.articlePage.startPage - res.articlePage.blockSize}">
                            <span class="icon material-symbols-outlined">chevron_left</span>
                         </a>`;
            }

            for (let pnum = res.articlePage.startPage; pnum <= res.articlePage.endPage; pnum++) {
                page += `<a href="#page" class="page-link ${res.articlePage.currentPage === pnum ? 'active' : ''}" data-page="${pnum}">${pnum}</a>`;
            }

            if (res.articlePage.endPage < res.articlePage.totalPages) {
                page += `<a href="#page" class="page-link" data-page="${res.articlePage.startPage + res.articlePage.blockSize}">
                            <span class="icon material-symbols-outlined">chevron_right</span>
                         </a>`;
            }

            $('.pagination').html(page);
        },
        error: function (err) {
            console.error("AJAX 요청 실패", err);
        }
    });
}
/*************************************************************************************
    재고가 없는 거래처인 경우, 메인화면 시 바로 confirm 뜨고 신규 재고 입력 화면으로 넘어가도록
**************************************************************************************/
function checkStock(){
    let bzentNo = "${user.bzentNo}";
    
    // 해당 거래처의 재고 유무확인
    $.ajax({
    	url : "/cnpt/gds/hasStock",
    	type : "GET",
    	data : { bzentNo:bzentNo },
    	success : function(hasStock){
    		console.log("hasStock 값 : ", hasStock); // hasStock 값 확인
    		
    		if(!hasStock || hasStock === 'false' || hasStock === false){
    			Swal.fire({
				      icon: 'success',
				      title: '신규 거래처이시군요?',
				      text: '재고 등록 페이지로 이동합니다!'
				    });
					
					// 3초 후에 이동
					setTimeout(function(){
						location.href="/cnpt/stock/insertNewStock";
					},3000);
    		}
    	},
    	error : function(xhr, status, error){
    		console.error("재고 확인 중 오류 : ", error);
    	}
    // 재고 유무 ajax 끝	
    });
}



