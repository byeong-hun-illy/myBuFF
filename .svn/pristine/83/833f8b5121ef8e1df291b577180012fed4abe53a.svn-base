/**
 * 매출 분석 조회
 */
var currentPage = 1;
var sortField = 'salesSum';
var orderby = 'desc';
let rgnNo = '';

function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
    const fields = ['rgnNo', 'bzentNo', 'bgngYmd', 'expYmd'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    // 항상 추가되는 값
    data.sort = sortField;
    data.orderby = orderby;
    data.currentPage = currentPage;

    return data; // data 객체 반환
}
 
 $(document).ready(function() {
 
 	selectBzentList(rgnNo); // 가맹점 목록 조회
	select2Custom(); // 지역 목록 조회
	selectFrcsAnalyzeAjax(); // 테이블 목록 출력 이벤트
		
	// 지역 검색조건 클릭 시 가맹점 목록 변화 이벤트
	$('#rgnNo').on('change',function(){
		let rgnNo = $('#rgnNo').val();
		selectBzentList(rgnNo); // 지역 번호 전달
	})
	
	// 가맹점 셀렉트 박스 목록 조회
	function selectBzentList(rgnNo){
		$.ajax({
			url: "/hdofc/analyze/selectBzentList",
			type: "get",
			data: {rgnNo:rgnNo},
			success: function(res){
				//console.log(res);
				let str = '<option value="">가맹점을 선택해주세요</option>';
				res.forEach( bzentVO => {
					str += `<option value="${bzentVO.bzentNo}">${bzentVO.bzentNm}</option>`;
				})
				$('#bzentNo').html(str);
			}
			// success
		}) 
		//.ajax
	}
	
	// 오늘 날짜 가져오기
	function getToday() {
		let today = new Date();
		let yyyy = today.getFullYear();
		let mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		let dd = String(today.getDate()).padStart(2, '0');
		return yyyy + '-' + mm + '-' + dd;
	}
	
	// 어제 날짜 가져오기
	function getYesterday() {
		let yesterday = new Date();
		yesterday.setDate(yesterday.getDate() - 1); // 하루 전으로 설정
		let yyyy = yesterday.getFullYear();
		let mm = String(yesterday.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		let dd = String(yesterday.getDate()).padStart(2, '0');
		return yyyy + '-' + mm + '-' + dd;
	}

	// 이번 달의 첫날과 마지막 날 가져오기
	function getThisMonth() {
		let today = new Date();
		let yyyy = today.getFullYear();
		let mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1

		// 첫날: 1일, 마지막 날: 해당 달의 마지막 날짜 계산
		let firstDay = yyyy + '-' + mm + '-01';
		let lastDay = new Date(yyyy, today.getMonth() + 1, 0).getDate();
		let lastDayFormatted = yyyy + '-' + mm + '-' + String(lastDay).padStart(2, '0');

		return { firstDay: firstDay, lastDay: lastDayFormatted };
	}

	// 이번 년도의 첫날과 마지막 날 가져오기
	function getThisYear() {
		let today = new Date();
		let yyyy = today.getFullYear();
		let firstDay = yyyy + '-01-01'; // 1월 1일
		let lastDay = yyyy + '-12-31'; // 12월 31일
		return { firstDay: firstDay, lastDay: lastDay };
	}

	// 일간 버튼 클릭
	$(".btn-default:contains('일간')").on("click", function(event) {
		let yesterday = getYesterday(); 
		let today = getToday();
		$("#bgngYmd").val(yesterday);
		$("#expYmd").val(today);
	});

	// 월간 버튼 클릭
	$(".btn-default:contains('월간')").on("click", function(event) {
		let thisMonth = getThisMonth();
		$("#bgngYmd").val(thisMonth.firstDay);
		$("#expYmd").val(thisMonth.lastDay);
	});

	// 연간 버튼 클릭
	$(".btn-default:contains('연간')").on("click", function(event) {
		let thisYear = getThisYear();
		$("#bgngYmd").val(thisYear.firstDay);
		$("#expYmd").val(thisYear.lastDay);
	});
	
	// 검색 버튼 클릭 시
	$("#searchBtn").on("click",function(event){
		selectFrcsAnalyzeAjax()
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
	})
	//.search-reset
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log("currentPage > ",isNaN(currentPage)); // 파라미터가 숫자일 경우 false를 리턴. 문자열인 경우 true 리턴.
		selectFrcsAnalyzeAjax();
	})
	
	// 요약보기[+] 버튼 클릭 시 이벤트
	$('.search-toggle').on('click', function() {
		// 상세조건 토글 이벤트 호출
		searchToggle(this);
		
		// 지역
		let rgnNm = $('#select2-rgnNo-container').text();
		$('#rgnNoSummary').text(rgnNm === '' ? '미선택' : rgnNm);

		// 가맹점
		let bzentNo = $('#select2-bzentNo-container').text();
		$('#bzentNoSummary').text(bzentNo === '' ? '미선택' : bzentNo);
		
	    // 분석기간 요약 업데이트
	    let bgngYmd = $('#bgngYmd').val();
	    let expYmd = $('#expYmd').val();
	    $('#dateSummary').text(bgngYmd === '' ? '미선택' : `${bgngYmd} ~ ${expYmd}`);
	    
	});
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		// 상세조건 초기화
		$('#bgngYmd, #expYmd').val('');
		$('#rgnNo, #bzentNo').val('').trigger('change');
		$('#rgnNoSummary, #bzentNoSummary, #dateSummary').text('미선택');
		
		// 리스트 호출
		selectFrcsAnalyzeAjax();
	})
	
	// th 정렬 기능
	$('.sort').on('click',function(){
		 // 정렬 색상 변경 이벤트 호출
		 thClickEvent($(this));
		 // 리스트 호출
		 selectFrcsAnalyzeAjax();
	})
	
});

// 테이블 목록 출력 이벤트
function selectFrcsAnalyzeAjax(){

	const { csrfToken, csrfHeader } = getCsrfTokens();
	
	let data = getInputData();
	
	console.log("selectFrcsAnalyzeAjax => data",data);
	
	$.ajax({
		url: "/hdofc/analyze/selectFrcsAnalyzeAjax",
		type: "post",
		data: JSON.stringify(data),
		contentType: "application/json",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
	    success: function(res) {
	        console.log("ajax => ",res);
	        
	        let str = '';
	        
	        // 검색 결과 없을 때
	        if (res.empty) {
			    $('#tap-all').text('0');
			    str += `
			    	<tr>
		                <td class="error-info" colspan="4">
		                    <span class="icon material-symbols-outlined">error</span>
		                    <div class="error-msg">검색 결과가 없습니다</div>
		                </td>
		            </tr>
			    `;
			    $('.table-error').html(str);
			    
			    let ctLabel = []; 
				let ctData = [];
				
				 // 차트 업데이트 하기
    			updateChart(ctLabel, ctData);
			} 
			
			// 검색 결과 있을 때
			if(!res.empty) {
				updateTable(res);			
			}			
	    }
	})
	// ajax
}

// 테이블 업데이트
function updateTable(res){

	$('#tap-all').text(res.articlePage.total);
	
	let str = '';
	let ctLabel = []; 
	let ctData = []; 
	
	res.articlePage.content.forEach(list => {
	
        let salesSum = list.salesSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		let bzentNm = list.bzentNm;
		
        str += `
            <tr>
                <td class="center">${list.rnum}</td>						
                <td class="center">${list.rgnNm}</td>						
                <td class="left">${list.bzentNm}</td>						
                <td class="right" style="padding-right: 30px;">${salesSum}</td>						
            </tr>
        `;
        
		// 배열에 값을 푸시
        ctLabel.push(list.bzentNm);
        ctData.push(list.salesSum);
     
    });
    
    // 테이블 업데이트 하기
    $('#table-body').html(str);
    
    // 차트 업데이트 하기
    updateChart(ctLabel, ctData);
    
    // 페이징 처리
    updatePagination(res);
}

// 차트 업데이트 하기
function updateChart(ctLabel, ctData){
	
	// 기존 차트 삭제하기 (기존 차트가 있을 경우에만)
    if (window.myChart instanceof Chart) {
        window.myChart.destroy(); // 기존 차트 삭제
    }
    
	// 차트 업데이트 하기
	let myCt = document.getElementById('myChart');

	window.myChart = new Chart(myCt, {
		type: 'bar',
		data: {
			labels: ctLabel,
			datasets: [
				{
					label: '매출 금액',
		        	data: ctData,
		       		fill: true,
		       		backgroundColor: 'rgba(94, 218, 149, 0.5)',
	      		}
	    	]
  		}, // data
		options: {
			plugins: {
				legend: {
				  display: false
				},
				title: { // [차트 타이틀 지정 실시]
					display: false,
					text: '가맹점 매출차트',
					color: '#333', // [타이틀 폰트 색상]
					font: { // [타이틀 폰트 스타일 변경]
						family: 'NanumSquare, sans-serif',
						size: 18,
						weight: 'bold',
					},
					padding: {top: 0, left: 0, right: 0, bottom: 20}    						
				}
			}, // plugins
			scales: {
				y: { // [y 축 관련 설정] 
					grid: { // [y 축 데이터 시트 배경 선색 표시]
						drawBorder: false,
						color: 'rgba(0, 116, 52, 0.2)'  								
					},
					ticks: {
						color: '#999', // [y 축 폰트 색상 설정]
						font: { // [y축 폰트 스타일 변경]
							family: 'NanumSquare, sans-serif',
							size: 9,
							weight: 'bold',
							lineHeight: 1.5
						} 
					}
				},
				x: { // [x 축 관련 설정] 
					ticks: {
						color: '#000000', // [x 축 폰트 색상 설정]
						font: { // [x축 폰트 스타일 변경]
							family: 'NanumSquare, sans-serif',
							size: 12,
							weight: 'bold',
						} 
					}
				}
			}, // scales  
			interaction: { // 툴팁 추가
			  mode: 'index',
			  intersect: false,
			} // interaction
		} // options
	});	// window.myChart
	
	console.log(ctLabel);
	console.log(ctData);
}



// 페이징 처리 업데이트
function updatePagination(res) {
    let page = '';
    
    // 'chevron_left' 이전 페이지 링크 추가
    if (res.articlePage.startPage > res.articlePage.blockSize) {
        page += `
            <a href="#page" class="page-link" data-page="${res.articlePage.startPage - res.articlePage.blockSize}">
                <span class="icon material-symbols-outlined">chevron_left</span>
            </a>
        `;
    }
    
    // 페이지 번호 링크들 추가
    for (let pnum = res.articlePage.startPage; pnum <= res.articlePage.endPage; pnum++) {
        page += `<a href="#page" class="page-link ${res.articlePage.currentPage === pnum ? 'active' : ''}" data-page="${pnum}">${pnum}</a>`;
    }

    // 'chevron_right' 아이콘 및 다음 페이지 링크 추가
    if (res.articlePage.endPage < res.articlePage.totalPages) {
        page += `
            <a href="#page" class="page-link" data-page="${res.articlePage.startPage + res.articlePage.blockSize}">
                <span class="icon material-symbols-outlined">chevron_right</span>
            </a>
        `;
    }
    
    $('.pagination').html(page);
}

 	
















































