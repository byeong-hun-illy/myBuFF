/*******************************************
  @fileName    : gds.js
  @author      : 송예진
  @date        : 2024. 09. 25
  @description : 상품관리
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");
 function selectGdsAjax(){
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let gdsType = $('#gdsType').val();
	let gdsNm = $('#gdsNm').val();
	let sfStockQty = $('#sfStockQty').val();
	let ntslType = $('#ntslType').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (gdsType) {
	    data.gdsType = gdsType;
	}
	if (gdsNm) {
	    data.gdsNm = gdsNm;
	}
	if (sfStockQty) {
	    data.sfStockQty = sfStockQty;
	}
	if (ntslType) {
	    data.ntslType = ntslType;
	}
	if (sregYmdDt) {
	    data.sregYmd = dateToStr(sregYmdDt);
	}
	if (eregYmdDt) {
	    data.eregYmd = dateToStr(eregYmdDt);
	}
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.gdsClass = gdsClass;
	data.bzentNo = bzentNo;
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-fd').text(res.fd);
			$('#tap-sm').text(res.sm);
			$('#tap-pm').text(res.pm);
			
			//console.log(res);
			// 테이블 처리
			let strTbl = '';
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="9"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.articlePage.content.forEach(list => {
				// 등록 일자
				let reg = strToDate(list.regYmd);
				// 판매 유형
				let ntsl = `<span class='bge ${
				    list.stockVOList[0].ntslType=='GDNT01' ? 'bge-info-border' 
				    : list.stockVOList[0].ntslType=='GDNT02' ? 'bge-danger-border' 
				    : 'bge-active-border'}'>${list.stockVOList[0].ntslTypeNm}</span>`;
				// 유형
				let type = `<span class='bge ${
				    list.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsTypeNm}</span>`;
				
				let red = `${list.stockVOList[0].qty<list.stockVOList[0].sfStockQty ? 'style="color:red;"': ''}`;
				
	    		strTbl += `
				    <tr class="gdsDtl" data-no="${list.gdsCode}">
				        <td class="center">${list.rnum}</td>
				        <td>${list.gdsNm}</td>
				        <td class="right" ${red}>${list.stockVOList[0].qty.toLocaleString()}</td>
				        <td class="right">${list.stockVOList[0].sfStockQty.toLocaleString()}</td>
				        <td class="center">${list.unitNm}</td>
				        <td class="right">${list.stockVOList[0].gdsAmtVOList[0].amt!=0 ? list.stockVOList[0].gdsAmtVOList[0].amt.toLocaleString() : '-'}</td>
				        <td class="center">${reg}</td>
				        <td class="center">${ntsl}</td>
				        <td class="center">${type}</td>
				    </tr>
				`;
				
				});
				
				// 페이징 처리
				let page = '';
				
				if (res.articlePage.startPage > res.articlePage.blockSize) {
				    page += `
				        <a href="#page" class="page-link" data-page="${res.articlePage.startPage - res.articlePage.blockSize}">
				            <span class="icon material-symbols-outlined">chevron_left</span>
				        </a>
				    `;
				}
				
				// 페이지 번호 링크들 추가
				for (let pnum = res.articlePage.startPage; pnum <= res.articlePage.endPage; pnum++) {
				    if (res.articlePage.currentPage === pnum) {
				        page += `<a href="#page" class="page-link active" data-page="${pnum}">${pnum}</a>`;
				    } else {
				        page += `<a href="#page" class="page-link" data-page="${pnum}">${pnum}</a>`;
				    }
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
			$('#table-body').html(strTbl)
			}
		});			
 }
 
 /*******************************************
			상품 추가
********************************************/
// @methodName  : insertGds
// @author      : 송예진
// @date        : 2024.09.24
// @jsp         : hdofc/cnpt/registAjax
// @description : 가맹점주 수정
function insertGds(){
	let gdsVO = {}; // gdsNm, gdsType, unitNm, mbrId
	
	let gdsAmtVO = {}; // bzentNo, gdsCode, amt
	
	let gdsNm = $('#gdsNm').val();
	let gdsType= $('#gdsType').val();
	let unitNm= $('#unitNm').val();
	let mbrId = $('#mbrId').val();

	// 선택
	let amt = $('#amt').val();
	
	gdsVO.gdsNm = gdsNm;
	gdsVO.gdsType = gdsType;
	gdsVO.unitNm = unitNm;
	gdsVO.mbrId = mbrId;
	
	if(amt){
		gdsAmtVO.amt = amt;
	}
	gdsAmtVO.bzentNo = bzentNo;
	
	console.log(gdsVO);
	console.log(gdsAmtVO);
	
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/registAjax",
		type : "POST",
		data: JSON.stringify({
			gdsVO : gdsVO,
			gdsAmtVO : gdsAmtVO
		}),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			setTimeout(function() {
        		location.href='/hdofc/gds/dtl?gdsCode='+res;
			}, 1000);
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
	
}

 /*******************************************
			상품 상세 조회
********************************************/
// 상세!!!
function selectGdsDtlAjax(){
	let stockVO = {};
	
	stockVO.gdsCode = gdsCode;
	stockVO.bzentNo = bzentNo;
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/dtlAjax",
		type : "POST",
		data: JSON.stringify(stockVO),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			let gds = res.gds;
			console.log(res);
			if(res.chk>0){ // 재고에 이미 있는 경우
				$('.input-gds').prop('disabled', true);
				$('.gds-update').hide();
				let type = `<span class='bge ${
				    gds.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : gds.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${gds.gdsTypeNm}</span>`;
				$('.gdsType').html(type);
			} else { // 없을 때
				$('#gdsType').val(gds.gdsType);
				$('.amt-update').hide();
			}
		
			$('#gdsNm').val(gds.gdsNm);
			
			$('#unitNm').val(gds.unitNm);
			let amt = '';
			if(gds.stockVOList[0].gdsAmtVOList){
				amt = gds.stockVOList[0].gdsAmtVOList[gds.stockVOList[0].gdsAmtVOList.length-1].amt;
			}
			// 등록 일자
			let reg = strToDate(gds.regYmd);
			$('#regYmd').text(reg);
			
			$('#mbrNm').val(gds.mbrVO.mbrNm);
			$('#mbrId').val(gds.mbrVO.mbrId);
			let mbrTelNo = splitTel(gds.mbrVO.mbrTelno);
			$('#mbrTelno1').val(mbrTelNo[0]);
			$('#mbrTelno2').val(mbrTelNo[1]);
			$('#mbrTelno3').val(mbrTelNo[2]);
		
			$('#mbrEmlAddr').val(gds.mbrVO.mbrEmlAddr);
			
			ntslType = gds.stockVOList[0].ntslType;
			
		// 판매 유형
			let ntsl = `<span class='bge ${
			    gds.stockVOList[0].ntslType=='GDNT01' ? 'bge-info-border' 
			    : gds.stockVOList[0].ntslType=='GDNT02' ? 'bge-danger-border' 
			    : 'bge-active-border'}'>${gds.stockVOList[0].ntslTypeNm}</span>`;
			  let sfStockQty = gds.stockVOList[0].sfStockQty;
			  if(ntslType=='GDNT01'){
			  	sfStockQty = '';
			  	amt = '';
				  $('#ntslTypeTd').html(ntsl);
			  } else{
				  $('#ntslType').val(gds.stockVOList[0].ntslType);
				  $('.select-selected').text(gds.stockVOList[0].ntslTypeNm);
			  }
				$('#amt').val(amt)
			  $('#qty').text(gds.stockVOList[0].qty.toLocaleString());
			  $('#sfStockQty').val(sfStockQty);
			  let mbrType = `<span class='bge bge-default-border'>${gds.mbrVO.mbrTypeNm}</span>`
			  $('#mbrType').html(mbrType);
			  
			  
			  // 차트 
			  ///////////////////// 차트
			var myChart = new Chart(
			    document.getElementById('myChart'),
			    {
			        type: 'line',
			        data: {
			            labels: gds.stockVOList[0].gdsAmtVOList.map(item => {
			                var date = new Date(item.ajmtDt);
			                return date.toLocaleDateString('ko-KR', { year: '2-digit', month: '2-digit', day: '2-digit' });
			            }),
			            datasets: [{
			                label: '변경일자',
			                data: gds.stockVOList[0].gdsAmtVOList.map(item => item.amt),
			                fill: false,
			                borderColor: 'rgb(0, 193, 87)',
			                tension: 0.2
			            }]
			        },
			        options: {
			            scales: {
			                xAxes: [{
			                    type: 'category',
			                    ticks: {
			                        autoSkip: true,
			                        maxTicksLimit: 4,
			                        color: '#000000', // X축 폰트 색상
			                        font: { // X축 폰트 스타일
			                            family: 'NanumSquare, sans-serif',
			                            size: 15,
			                            weight: 'bold'
			                        }
			                    }
			                }],
			                yAxes: [{
			                    ticks: {
			                        suggestedMin: Math.min(...gds.stockVOList[0].gdsAmtVOList.map(item => item.amt)) * 0.98,
			                        suggestedMax: Math.max(...gds.stockVOList[0].gdsAmtVOList.map(item => item.amt)) * 1.02,
			                        color: '#999', // Y축 폰트 색상
			                        font: { // Y축 폰트 스타일
			                            family: 'NanumSquare, sans-serif',
			                            size: 12,
			                            weight: 'bold'
			                        }
			                    },
			                    grid: { // Y축 그리드 선 스타일
			                        drawBorder: false,
			                        color: 'rgba(0, 116, 52, 0.2)'
			                    }
			                }]
			            },
			            legend: {
			                display: true,
			                labels: {
			                    color: '#000', // legend 폰트 색상
			                    font: {
			                        family: 'NanumSquare, sans-serif',
			                        size: 12,
			                        weight: 'bold'
			                    }
			                }
			            },
			            tooltips: {
			                callbacks: {
			                    label: function (tooltipItem) {
			                        return tooltipItem.yLabel;
			                    }
			                }
			            },
			            plugins: {
			                datalabels: { // datalabels 플러그인 세팅
			                    formatter: function (value, context) {
			                        return value.toLocaleString() + '%'; // 출력 텍스트
			                    },
			                    align: 'top',
			                    font: {
			                        family: 'NanumSquare, sans-serif',
			                        size: 12,
			                        weight: 'bold'
			                    },
			                    color: '#000' // datalabels 텍스트 색상
			                }
			            }
			        } // options 종료
			    }
			); // 차트 끝

				
				let strTbl = '';
			
			if(gds.stockVOList[0].gdsAmtVOList[0].amt == 0){ // 검색 결과가 0인 경우
				strTbl+= `
								<div class="error-info" >
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">단가 변동 결과가 없습니다</div>
								</div>
				`;
				$('#lastAmt').prop("disabled", true);
				$('#amtInfo').html(strTbl);
				$('#amtInfo').removeClass("row");
			} else{
				gds.stockVOList[0].gdsAmtVOList.forEach(list => {
				// 조정 일자
				let ajmt = dtToStr(list.ajmtDt)
	    		strTbl += `
				    <tr class="frcsChkDtl" data-no="${list.frcsNo}" data-seq="${list.chckSeq}">
				        <td class="center" style="width: 20%">${list.amtSeq}</td>
				        <td class="center" style="width: 50%">${ajmt}</td>
				        <td class="center" style="width: 30%">${list.amt.toLocaleString()}</td>
				    </tr>
				`;
				$('#table-body-amt').html(strTbl);
				
				});
			}// else끝
			
			  ///////////////////// 차트
			var myChart2 = new Chart(
			    document.getElementById('myChart2'),
			    {
			        type: 'line',
			        data: {
			            labels: res.min.map(item => {
			                var date = new Date(item.ajmtDt);
			                return date.toLocaleDateString('ko-KR', { year: '2-digit', month: '2-digit', day: '2-digit' });
			            }),
			            datasets: [{
			                label: '변경일자',
			                data: res.min.map(item => item.amt),
			                fill: false,
			                borderColor: 'rgb(0, 193, 87)',
			                tension: 0.2
			            }]
			        },
			        options: {
			            scales: {
			                xAxes: [{
			                    type: 'category',
			                    ticks: {
			                        autoSkip: true,
			                        maxTicksLimit: 4,
			                        color: '#000000', // X축 폰트 색상
			                        font: { // X축 폰트 스타일
			                            family: 'NanumSquare, sans-serif',
			                            size: 15,
			                            weight: 'bold'
			                        }
			                    }
			                }],
			                yAxes: [{
			                    ticks: {
			                        suggestedMin: Math.min(...res.min.map(item => item.amt)) * 0.98,
			                        suggestedMax: Math.max(...res.min.map(item => item.amt)) * 1.02,
			                        color: '#999', // Y축 폰트 색상
			                        font: { // Y축 폰트 스타일
			                            family: 'NanumSquare, sans-serif',
			                            size: 12,
			                            weight: 'bold'
			                        }
			                    },
			                    grid: { // Y축 그리드 선 스타일
			                        drawBorder: false,
			                        color: 'rgba(0, 116, 52, 0.2)'
			                    }
			                }]
			            },
			            legend: {
			                display: true,
			                labels: {
			                    color: '#000', // legend 폰트 색상
			                    font: {
			                        family: 'NanumSquare, sans-serif',
			                        size: 12,
			                        weight: 'bold'
			                    }
			                }
			            },
			            tooltips: {
			                callbacks: {
			                    label: function (tooltipItem) {
			                        return tooltipItem.yLabel;
			                    }
			                }
			            },
			            plugins: {
			                datalabels: { // datalabels 플러그인 세팅
			                    formatter: function (value, context) {
			                        return value.toLocaleString() + '%'; // 출력 텍스트
			                    },
			                    align: 'top',
			                    font: {
			                        family: 'NanumSquare, sans-serif',
			                        size: 12,
			                        weight: 'bold'
			                    },
			                    color: '#000' // datalabels 텍스트 색상
			                }
			            }
			        } // options 종료
			    }
			); // 차트2 끝

				
				strTbl = '';
			let index = 1;
			if(res.min[0].amt == 0){ // 검색 결과가 0인 경우
				strTbl+= `
								<div class="error-info" >
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">단가 변동 결과가 없습니다</div>
								</div>
				`;
				$('#minInfo').html(strTbl);
				$('#minInfo').removeClass("row");
			} else{
				res.min.forEach(list => {
				// 조정 일자
				let ajmt = dtToStr(list.ajmtDt)
	    		strTbl += `
				    <tr>
				        <td class="center" style="width: 20%">${index++}</td>
				        <td class="center" style="width: 50%">${ajmt}</td>
				        <td class="center" style="width: 30%">${list.amt.toLocaleString()}</td>
				    </tr>
				`;
				$('#table-body-min').html(strTbl);
				
				});
			}// else끝
			
			
		} // success 끝
	});		
}
 /*******************************************
		상품 상세
********************************************/
function selectStockAjmtAjax(gdsCode){
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	
	data.sort = 'ajmtYmd';
	data.orderby = 'desc';
	data.currentPage = currentPage;
	data.ajmtType = '';
	data.bzentNo = bzentNo;
	data.gdsCode = gdsCode;
	data.size = 5;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/com/stockAjmt/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-01').text(res.a01);
			$('#tap-02').text(res.a02);
			$('#tap-03').text(res.a03);
			$('#tap-04').text(res.a04);
			$('#tap-all').text(res.all);
			console.log(res);
			// 테이블 처리
			let strTbl = '';
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="7"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.articlePage.content.forEach(list => {
				// 등록 일자
				let ajmtYmd = strToDate(list.ajmtYmd);
				    
				// 유형
				let type = `<span class='bge ${
				    list.ajmtType == 'AJMT01' ? 'bge-info' 
				    : list.ajmtType == 'AJMT02' ? 'bge-danger' 
				    : list.ajmtType == 'AJMT03' ? 'bge-active' 
				    : 'bge-warning'}'>${list.ajmtTypeNm}</span>`;
				
				let ajmtRsn = '-';
				            // 가맹점 처리
		       	if(list.ajmtRsn && list.ajmtRsn.length > 10) {
		        	ajmtRsn = `
			        		<div style="white-space:nowrqp; overflow:hidden; text-overflow:ellipsis;">
		        				<button type="button" class="tooltip-custom"
									data-bs-toggle="tooltip"
									title="${list.ajmtRsn}">
									<span class="tooltip-icon material-symbols-outlined">info</span>
								</button>
		        				${list.ajmtRsn}
		        			</div>
		        	`;
		        } else if(list.ajmtRsn){
		        	ajmtRsn = list.ajmtRsn;
		        } 
				
	    		strTbl += `
				    <tr>
				        <td class="center">${list.rnum}</td>
				        <td class="center">${ajmtYmd}</td>
				        <td class="center">${type}</td>
				        <td class="right">${list.qty.toLocaleString()}</td>
				        <td class="center">${list.gdsVO.unitNm}</td>
				        <td style="max-width: 100px">${ajmtRsn}</td>
				        <td><button class="btn-default" onclick="deleteStockAjmt(${list.ajmtNo})" ${list.ajmtType=='AJMT01' || list.ajmtType=='AJMT02' ? '' : 'disabled'}>삭제</button></td>
				    </tr>
				`;
				
				});
				
				// 페이징 처리
				let page = '';
				// 'chevron_right' 아이콘 및 다음 페이지 링크 추가
				if (res.articlePage.currentPage < res.articlePage.totalPages) {
				    page = `
				        <tr>
								<td colspan="7" class="moreView"> 
									더보기(${res.total-currentPage*5}) <span class="icon material-symbols-outlined">stat_minus_1</span>
								</td>
							</tr>
				    `;
				}else{
					 page = `
				        ''
				    `;
				}
				$('.ajmtAdd').html(page);
				}
			$('#table-body-ajmt').append(strTbl)
			}
		});			
}

 /*******************************************
			상품 삭제
********************************************/
// 상세!!!
function deleteGdsAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/deleteAjax",
		type : "POST",
		data: { gdsCode : gdsCode },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "상품이 성공적으로 삭제되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
					 location.href="/hdofc/gds/list";
				}
				});
			}
		} // success 끝
	});		
}

 /*******************************************
			상품 수정
********************************************/
function updateGds(){
	let gdsVO = {}; // gdsNm, gdsType, unitNm, mbrId
	
	let gdsNm = $('#gdsNm').val();
	let gdsType= $('#gdsType').val();
	let unitNm= $('#unitNm').val();
	
	gdsVO.gdsNm = gdsNm;
	gdsVO.gdsType = gdsType;
	gdsVO.unitNm = unitNm;
	gdsVO.mbrId = mbrId;
	gdsVO.gdsCode = gdsCode;
	
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/updateAjax",
		type : "POST",
		data: JSON.stringify(gdsVO),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){

		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
}

 /*******************************************
			단가와 안전재고 수량 수정 판매유형
********************************************/
function updateAmt(){
	let stockVO = {}; // bzentNo, gdsCode, sfStockQty, ntslType
	
	let gdsAmtVO = {}; // bzentNo, gdsCode, amt
	
	let sfStockQty = $('#sfStockQty').val();
	let ntslType = $('#ntslType').val();
	
	// 선택
	let amt = $('#amt').val();
	
	if(amt){
		gdsAmtVO.amt = amt;
	}
	gdsAmtVO.bzentNo = bzentNo;
	gdsAmtVO.gdsCode = gdsCode;
	
	
	stockVO.ntslType = ntslType;
	stockVO.bzentNo = bzentNo;
	stockVO.gdsCode = gdsCode;
	stockVO.sfStockQty= sfStockQty;
	
	
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/updateAmtAjax",
		type : "POST",
		data: JSON.stringify({
			stockVO : stockVO,
			gdsAmtVO : gdsAmtVO
		}),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			setTimeout(function() {
        		location.reload();
			}, 1000);
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
	
}
 /*******************************************
		단가 최근거 삭제
********************************************/
function deleteLastAmt(){
	let gdsAmtVO = {}; // bzentNo, gdsCode

	gdsAmtVO.bzentNo = bzentNo;
	gdsAmtVO.gdsCode = gdsCode;
	
	// 서버전송
	$.ajax({
		url : "/hdofc/gds/deleteLastAmt",
		type : "POST",
		data: JSON.stringify(gdsAmtVO),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			setTimeout(function() {
        		location.reload();
			}, 1000);
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
	
}
