/*******************************************
  @fileName    : deal.js
  @author      : 송예진
  @date        : 2024. 09. 26
  @description : 발주, 납품
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");
 /*************************************************************************************
			본사 납품 조회  ------------------------------------------- 공통(본사, 거래처)
**************************************************************************************/
 function selectDealAjax(){
 	let bzentNm = $('#bzentNm').val();
 	let clclnYn = $('#clclnYn').val();
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let sdeYmdDt = $('#sdeYmd').val();
	let edeYmdDt = $('#edeYmd').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (bzentNm) {
	    data.bzentNm = bzentNm;
	}
	if (clclnYn) {
	    data.clclnYn = clclnYn;
	}
	if (sregYmdDt) {
	    data.sregYmd = dateToStr(sregYmdDt);
	}
	if (eregYmdDt) {
	    data.eregYmd = dateToStr(eregYmdDt);
	}
	if (sdeYmdDt) {
	    data.sdeYmd = dateToStr(sdeYmdDt);
	}
	if (edeYmdDt) {
	    data.edeYmd = dateToStr(edeYmdDt);
	}
	
	data.deliType = deliType;
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.bzentNo = bzentNo;
	data.type = type;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/com/deal/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			console.log(res);
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-deli01').text(res.deli01);
			$('#tap-deli02').text(res.deli02);
			$('#tap-deli03').text(res.deli03);
			$('#tap-deli04').text(res.deli04);
			
			//console.log(res);
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
				// 배송 일자
				let deli = '-';
				if(list.deliYmd!=null){
					deli = strToDate(list.deliYmd);
				}
				
				let clclnAmt = '-'
				if(list.poClclnVO.clclnAmt!=0){
					clclnAmt = list.poClclnVO.clclnAmt.toLocaleString()+'원';
				}
				// 등록 일자
				let reg = strToDate(list.regYmd);
				
				// 정산 여부
				let clclnYn = !list.poClclnVO.clclnYn ? `<span class='bge bge-default-border'>해당없음</span>` : list.poClclnVO.clclnYn=='Y' ? `<span class='bge bge-active-border'>정산완료</span>` : `<span class='bge bge-danger-border'>정산미납</span>`
				
				// 유형
				let deliTypeStr = list.deliType=='DELI01' ? `<span class='bge bge-info'>${list.deliTypeNm}</span>`
					: list.deliType=='DELI02' && isPastOrToday(list.deliYmd) && type=='po' ? `<span class='bge bge-active-border'>배송확정</span>` 
					: list.deliType=='DELI02' ? `<span class='bge bge-warning'>${list.deliTypeNm}</span>` 
					: list.deliType=='DELI03' ? `<span class='bge bge-active'>${list.deliTypeNm}</span>` : `<span class='bge bge-danger'>${list.deliTypeNm}</span>`;
				
				
	    		strTbl += `
				    <tr class="dealDtl" data-no="${list.poNo}">
				        <td class="center">${list.rnum}</td>
				        <td class="center">${list.poNo}</td>`
				        
				if(bzentNo=='HO0001'){
					strTbl +=`<td>${type=='po' ? list.stockPoVOList[0].bzentVO.bzentNm : list.bzentVO.bzentNm}</td>`;
				}
		       strTbl+= `<td class="right">${clclnAmt}</td>
				        <td class="center">${deli}</td>
				        <td class="center">${clclnYn}</td>
				        <td class="center">${deliTypeStr}</td>
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
 
 /*************************************************************************************
			추가 - 상품 검색  (본사)
**************************************************************************************/
// @methodName  : selectGdsAjax
// @author      : 송예진
// @date        : 2024.09.27
function selectGdsAjax(){
	let gdsType = $('#gdsType').val();
	let gdsNm = $('#gdsNm').val();
	let sfStockQty = $('#sfStockQty').val();
	
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
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.gdsClass = gdsClass;
	data.bzentNo = bzentNo;
	data.size = 5;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
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
				// 유형
				let type = `<span class='bge ${
				    list.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsTypeNm}</span>`;
				
				let red = `${list.stockVOList[0].qty<list.stockVOList[0].sfStockQty ? 'style="color:red;"': ''}`;
				
				// 배열에 이미 담긴 상품인 경우 표시 추가
                let inCart = gdsList.includes(list.gdsCode) ? 
                `<span class="material-symbols-outlined">shopping_cart</span>` : '';
				
				let chk = false;
				
				if(inCart!=''){
					chk=true; // 카드에 담김
				}
				
	    		strTbl += `
				    <tr class="gdsDtl" data-no="${list.gdsCode}" data-nm="${list.gdsNm}"
				    	data-unit="${list.unitNm}" data-type="${type}" data-chk="${chk}"
				    	data-qty="${list.stockVOList[0].sfStockQty - list.stockVOList[0].qty}">
				        <td class="center">${list.rnum}</td>
				        <td class="td-cart ${chk?'active':''}">${list.gdsNm} <span class="cartYn">${inCart}</span></td>
				        <td ${red}>${list.stockVOList[0].qty.toLocaleString()}</td>
				        <td>${list.stockVOList[0].sfStockQty.toLocaleString()}</td>
				        <td class="center">${list.unitNm}</td>
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
			$('#table-body-gds').html(strTbl)
			}
		});			
 }
 
 /*************************************************************************************
			(추가)거래처 조회 본사
**************************************************************************************/
// @methodName  : selectCnptGdsAjax
// @author      : 송예진
// @date        : 2024.09.27
// @description : 가맹점주 수정
function selectCnptGdsAjax(gdsCode){
// 서버전송
	$.ajax({
		url : "/hdofc/deal/cnptGds",
		type : "POST",
		data: { gdsCode : gdsCode },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			//console.log(res);
			//// 상품 상세
			let num = 1;
			let gdsStr= '';
			 ///////////////////// 차트 최저가!!!
			 
			 $('#myChart2').remove(); // 기존 캔버스 요소를 제거
    		$('.chart-wrap').append('<canvas id="myChart2" style="width:500px"><canvas>'); // 새 캔버스를 추가
			
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
				   	 	responsive: false,
					    legend: {
					        display: false
					    },
					    tooltips: {
					        callbacks: {
					           label: function(tooltipItem) {
					                  return tooltipItem.yLabel;
					           }
					        }
					    },
					    plugins: {
			                // 데이터 라벨을 각 점 위에 표시
			                datalabels: { // datalables 플러그인 세팅
					          formatter: function (value, context) {
					            // 출력 텍스트
					            return value.toLocaleString() + '%';
					          },
					          align: 'top', // 도넛 차트에서 툴팁이 잘리는 경우 사용
					        },
			            }
					}// options 종료
				   }
				);// 차트2 끝
			
			res.cnpt.forEach(list => { 
				let bzentNm = `${list.bzentVO.bzentNm}`; // 백틱으로 bzentNm 값 가져오기

				// 10글자 넘는지 확인하고 자르기
				let displayBzentNm = bzentNm.length > 8 ? `${bzentNm.substring(0, 10)}...` : bzentNm;
			
				gdsStr += `<tr class="cnptGdsModal" data-nm="${list.bzentVO.bzentNm}" 
						data-no="${list.bzentNo}" data-amt="${list.gdsAmtVOList[0].amt}" 
						data-qty="${list.qty - list.ntslQty}">
							<td style="text-align:center; width: 20%;">${num++}</td>
							<td style="width: 31%;">${displayBzentNm}</td>
							<td style="text-align:center; width: 20%;">${(list.qty - list.ntslQty).toLocaleString()} / ${list.qty.toLocaleString()}</td>
							<td style="text-align:center; width: 30%;">${list.gdsAmtVOList[0].amt.toLocaleString()}</td>
						</tr>`;
			});
			$('#table-modal').html(gdsStr);
			$('#tap-cnpt').text(num);			
		} // success 끝
	});				
 }

 /*************************************************************************************
			발주 추가(본사 추가)
**************************************************************************************/
function addPoList(poList){
		let poListStr = `
			<tr data-no="${poList.bzentNo}" data-code="${poList.gdsCode}" data-amt="${poList.amt}">
				<td style="text-align:center; width:9%;"><button class="btn btn-default remove" data-no="${poList.gdsCode}">삭제</button></td>
				<td style="width:24%;">${poList.bzentNm}</td>
				<td style="width:23%;">${poList.gdsNm}</td>
				<td style="text-align:center; width:12%;">${poList.gdsType}</td>
				<td style="width:7%;" class="right"><input class="poQty" style="width:120px;" value="${poList.inputQty}" type="number" max="${poList.max}" data-amt="${poList.amt}"></td>
				<td style="text-align:center; width:7%;">${poList.unitNm}</td>
				<td style="width:6%;" class="right">${poList.amt.toLocaleString()}</td>
				<td style="width:12%;" class="right gdsTotal">${(poList.inputQty * poList.amt).toLocaleString()}</td>
			</tr>
		`;
		total+=poList.inputQty * poList.amt;
		$('#clclnAmt').text(total.toLocaleString());
		$('#po-list').append(poListStr);
}


 /*************************************************************************************
			가격 변경  ------------------------------------------- 공통 본사, 가맹점
**************************************************************************************/
// 모든 gdsTotal 값을 합산하여 id="total"에 반영하는 함수
function updateTotal() {
    let total = 0;
    
    // 모든 gdsTotal 값을 순회하여 합산
    $('.gdsTotal').each(function() {
        // gdsTotal의 텍스트 값을 가져와 숫자로 변환하여 합산
        total += parseFloat($(this).text().replace(/,/g, ''));
    });
    
    // id="total"에 총합을 업데이트
    $('#clclnAmt').text(total.toLocaleString());
}

 /*************************************************************************************
			발주 신청 (본사)
*************************************************************************************/
// 추가
function insertPoAjax(bzentNoGroups){
	// 서버전송
	$.ajax({
		url : "/hdofc/deal/registAjax",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(bzentNoGroups), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "발주가 성공적으로 신청되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
					 location.href="/hdofc/deal/list?type=po";
				}
			});
			}
		} // success 끝
	});		
}
 /*************************************************************************************
			발주 상세 조회  ------------------------------------------- 공통
**************************************************************************************/
// 상세!!!
function selectDealDtlAjax(){
	// 서버전송
	$.ajax({
		url : "/com/deal/dtlAjax",
		type : "POST",
		data: { poNo : poNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
		console.log(res);
			let po = res.po;
			$('#poNo').text(poNo);
			
			// 등록 일자
			let reg = strToDate(po.stockPoVOList[0].spmtYmd);
			// 정산 일자
			let clclnYmd = '-';
			if(po.poClclnVO){
				if(po.poClclnVO.clclnYn=='Y'){
					clclnYmd = strToDate(po.poClclnVO.clclnYmd);
				}
			}
			
			// 배송 일자
			let deli = '-';
			if(po.deliYmd!=null){
				deli = strToDate(po.deliYmd);
			}
			
			// 정산 여부
			let clclnYn = !po.poClclnVO.clclnYn ? `<span class='bge bge-default-border'>해당없음</span>` : po.poClclnVO.clclnYn=='Y' ? `<span class='bge bge-active-border'>정산완료</span>` : `<span class='bge bge-danger-border'>정산미납</span>`
			// 유형
			let deliT = po.deliType=='DELI01' ? `<span class='bge bge-info'>${po.deliTypeNm}</span>`
				: po.deliType=='DELI02' && isPastOrToday(po.deliYmd) && type=='po' ? `<span class='bge bge-active-border'>배송확정</span>` 
				: po.deliType=='DELI02' ? `<span class='bge bge-warning'>${po.deliTypeNm}</span>` 
				: po.deliType=='DELI03' ? `<span class='bge bge-active'>${po.deliTypeNm}</span>` : `<span class='bge bge-danger'>${po.deliTypeNm}</span>`;
			
			if(po.deliType=='DELI04'){
				$('.deli04').show();
				$('#rjctRsn').html(po.rjctRsn);
			}
			
			let clclnAmt = po.poClclnVO.clclnAmt.toLocaleString();
			
			// 배송중일 때는 배송 완료 버튼도 추가할 것
			$('#deliType').html(deliT);
			$('#regYmd').text(reg);
			$('#deliYmd').text(deli);
			$('#clclnYn').html(clclnYn);
			$('#clclnYmd').html(clclnYmd);
			
			let bzentNm = '';
			let bzentTelno = '';
			let bzentAddr = '';
			
			if(type=='po'){
				if(po.deliType=='DELI01'){ // 승인 대기중에는 삭제 가능
					$('.po-aprv').show();
				} else if(po.deliType=='DELI02'){
					$('.deli-end').show();
					// 배송일 이상이여야 승인 가능하게 해야하지만 시연을 위해 해제
					//if(isPastOrToday(po.deliYmd)){ 
						$('.deli-end').prop('disabled', false);
					//}
				}
				// 자신의 발주 건인 경우
				bzentNm=po.stockPoVOList[0].bzentVO.bzentNm;
				bzentTelno = telToStr(po.stockPoVOList[0].bzentVO.bzentTelno);
				bzentAddr = `
							<p>(${po.stockPoVOList[0].bzentVO.bzentZip})</p>
							<p>${po.stockPoVOList[0].bzentVO.bzentAddr}, ${po.stockPoVOList[0].bzentVO.bzentDaddr}</p>
							`;
				bzentNo = po.stockPoVOList[0].bzentNo;
				
				if(po.bzentVO.actno){
					actno = po.bzentVO.actno;
					bankType = po.bzentVO.bankType;
					bankTypeNm = po.bzentVO.bankTypeNm;
				}
				
			} else {
				if(po.deliType=='DELI01'){ // 승인 대기중에는 삭제 가능
					$('.cnpt-aprv').show();
				}
				// 납품 건의 경우
				bzentNm=po.bzentVO.bzentNm;
				bzentTelno = telToStr(po.bzentVO.bzentTelno);
				bzentAddr = `
							(${po.bzentVO.bzentZip})<br>
							${po.bzentVO.bzentAddr}, ${po.bzentVO.bzentDaddr}
							`;
			}
			
			$('#bzentNm').text(bzentNm);
			$('#bzentTelno').text(bzentTelno);
			$('#bzentAddr').html(bzentAddr);
			
			let gds = '';
			//// 상품 상세
			po.stockPoVOList.forEach(list => { 
				// 유형
				let gdsType = `<span class='bge ${
				    list.gdsVO.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsVO.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsVO.gdsTypeNm}</span>`;
			
				gds += `<tr data-code="${list.gdsCode}" data-amt="${list.gdsAmt}">
							<td style="text-align:center; width: 10%;">${type=='so' || (type=='po' && po.deliType!='DELI01') ? list.poSeq
								: '<button type="button" class="btn btn-default remove">삭제</button>'}</td>
							<td style="width: 20%;">${list.gdsVO.gdsNm}</td>
							<td style="text-align:center; width: 15%;">${gdsType}</td>
							<td style="width: 16%;" class="right"><input data-amt="${list.gdsAmt}" style="width:120px;" class="poQty" ${ (po.deliType!='DELI01' && type=='po') || type=='so' ? 'disabled' :''} type="number" value="${list.qty}"></td>
							<td style="text-align:center; width: 10%;">${list.gdsVO.unitNm}</td>
							<td style="width: 10%;" class="right">${list.gdsAmt.toLocaleString()}</td>
							<td style="width: 20%;" class="right gdsTotal">${(list.qty * list.gdsAmt).toLocaleString()}</td>
						</tr>`;
			});
			$('#table-body').html(gds);
			
			$('#clclnAmt').text(clclnAmt);
			
			//// 발주 정산 내역
			if(!po.poClclnVO.clclnYn){
				$('.clcln-dtl').hide();
				return;
			}
			
			// 정산 여부
			let npmntYn = !po.poClclnVO.clclnYn ? `<span class='bge bge-default-border'>해당없음</span>` : po.poClclnVO.npmntAmt==0 ? `<span class='bge bge-active-border'>미체납</span>` : `<span class='bge bge-danger-border'>체납</span>`
			
			$('#npmntYn').html(npmntYn);
			
			// 등록 일자
			let regYmd = '-';
			if(po.poClclnVO.regYmd!=null){
				regYmd = strToDate(po.poClclnVO.regYmd);
			}
			$('#clregYmd').text(regYmd);
			
			$('#clclclnAmt').text(!po.poClclnVO.clclnYn ? '-' : po.poClclnVO.clclnAmt.toLocaleString());
			$('#npmntAmt').text(!po.poClclnVO.clclnYn ? '-' : po.poClclnVO.npmntAmt.toLocaleString())
			$('#totalAmt').text(!po.poClclnVO.clclnYn ? '-' : (po.poClclnVO.clclnAmt+po.poClclnVO.npmntAmt).toLocaleString())
			
			$('#bankTypeNm').text(po.poClclnVO.bankTypeNm);
			$('#actno').text(maskActno(po.poClclnVO.actno));
			
			if(po.poClclnVO.clclnYn !='Y'){
				$('.clclnY').hide();
			}
			if(type=='so' || po.poClclnVO.clclnYn =='Y'){
				$('#updateClcln').hide();
			}
			
			//total = po.poClclnVO.clclnAmt;
		} // success 끝
	});		
}

 /*************************************************************************************
			발주 삭제   ------------------------------------------- 공통  본사, 가맹점
**************************************************************************************/
// 상세!!!
function deletePoAjax(boole){
	// 서버전송
	$.ajax({
		url : "/com/deal/deleteAjax",
		type : "POST",
		data: { poNo : poNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "발주 정보가 성공적으로 삭제되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
				 	if(boole){
					 location.href="/hdofc/deal/list?type=po";
				 	} else {
					 location.href="/frcs/deal/list";
				 	}
				}
			});
			} 
		} // success 끝
	});		
}

 /*************************************************************************************
			배송 승인 (본사, 거래처)
**************************************************************************************/
function poAprvAjax(){
	// 현재 날짜 객체 생성
	var today = new Date();
	
	// 하루를 더하기 위해 날짜에 1일 추가
	today.setDate(today.getDate() + 1);
	
	// 날짜를 YYYYMMDD 형식으로 변환
	var nextDay = today.getFullYear().toString() + 
	              (("0" + (today.getMonth() + 1)).slice(-2)) + 
	              (("0" + today.getDate()).slice(-2));

	let poVO = {};
	poVO.deliType = 'DELI02';
	poVO.deliYmd = nextDay;
	poVO.poNo = poNo;

	// 서버전송
	$.ajax({
		url : "/com/deal/poAprv",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(poVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  html: "<p>해당 건이 승인되었습니다.</p><p>재고에서 출고 되었습니다.</p>",
				  icon: "success"
				}).then((result) => {
					 if (result.isConfirmed) {
						 location.reload();
					}
				});
			}
		} // success 끝
	});		
}

 /*************************************************************************************
			배송 미승인 (본사, 거래처)
**************************************************************************************/
function poNoAprvAjax(inputValue){
	let poVO = {};
	poVO.deliType = 'DELI04';
	poVO.rjctRsn = inputValue;
	poVO.poNo = poNo;

	// 서버전송
	$.ajax({
		url : "/com/deal/poNoAprv",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(poVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "해당 건이 미승인 처리되었습니다.",
				  icon: "success"
				}).then((result) => {
					 if (result.isConfirmed) {
						 location.reload();
					}
				});
			} 
		} // success 끝
	});		
}

 /*************************************************************************************
			배송 완료
*************************************************************************************/
function deliEndAjax(){
	let poVO = {};
	poVO.deliType = 'DELI03';
	poVO.poNo = poNo;

	// 서버전송
	$.ajax({
		url : "/com/deal/updateDeliEnd",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(poVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "해당 상품이 입고 처리 되었습니다.",
				  icon: "success"
				}).then((result) => {
					 if (result.isConfirmed) {
						 location.reload();
					}
				});
			} 
		} // success 끝
	});		
}

 /*************************************************************************************
			발주 수정 (수량 조절이나 삭제만 가능)
**************************************************************************************/
function updateStockPoAjax(stockPoVOList){
	console.log(stockPoVOList);
	// 서버전송
	$.ajax({
		url : "/com/deal/updateStockPo",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(stockPoVOList),
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "성공적으로 변경되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
				}
			});
			} 
		} // success 끝
	});		
}

 /*************************************************************************************
			추가 - 상품 검색  (가맹점)
**************************************************************************************/
// @methodName  : selectGdsFrcsAjax
// @author      : 송예진
// @date        : 2024.09.28
function selectGdsFrcsAjax(){
	let gdsType = $('#gdsType').val();
	let gdsNm = $('#gdsNm').val();
	let sfStockQty = $('#sfStockQty').val();
	
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
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.gdsClass = gdsClass;
	data.bzentNo = bzentNo;
	data.size = 5;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/frcs/deal/frcsGdsList",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-fd').text(res.fd);
			$('#tap-sm').text(res.sm);
			$('#tap-pm').text(res.pm);
			
			console.log(res);
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
				// 유형
				let type = `<span class='bge ${
				    list.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsTypeNm}</span>`;
				
				let red = `${list.stockVOList[0].qty<list.stockVOList[0].sfStockQty ? 'style="color:red;"': ''}`;
				
				// 배열에 이미 담긴 상품인 경우 표시 추가
                let inCart = gdsList.includes(list.gdsCode) ? 
                `<span class="material-symbols-outlined">shopping_cart</span>` : '';
				
				let chk = false;
				
				if(inCart!=''){
					chk=true; // 카드에 담김
				}
				
	    		strTbl += `
				    <tr class="gdsDtl" data-no="${list.gdsCode}" data-nm="${list.gdsNm}"
				    	data-unit="${list.unitNm}" data-type="${type}" data-chk="${chk}"
				    	data-qty="${list.stockVOList[0].sfStockQty - list.stockVOList[0].qty}"
				    	data-amt="${list.stockVOList[0].gdsAmtVOList[0].amt}" data-max="${list.stockVOList[0].ntslQty}">
				        <td class="center">${list.rnum}</td>
				        <td class="td-cart ${chk?'active':''}">${list.gdsNm} <span class="cartYn">${inCart}</span></td>
				        <td class="right" ${red}>${list.stockVOList[0].qty.toLocaleString()}</td>
				        <td class="right">${list.stockVOList[0].sfStockQty.toLocaleString()}</td>
				        <td class="center">${list.unitNm}</td>
				        <td class="right">${list.stockVOList[0].gdsAmtVOList[0].amt.toLocaleString()}</td>
				        <td class="right">${list.stockVOList[0].ntslQty.toLocaleString()}</td>
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
			$('#table-body-gds').html(strTbl)
			console.log(gdsList);
			}
		});			
 }
 
  /*************************************************************************************
			발주 추가(가맹점 추가)
**************************************************************************************/
function addPoFrcsList(poList){
		// 소수점 4자리에서 반올림
		let inputqq = Math.ceil(poList.inputQty);  
		let poListStr = `
			<tr data-code="${poList.gdsCode}" data-amt="${poList.amt}">
				<td style="text-align:center; width:8%;"><button class="btn btn-default remove" data-no="${poList.gdsCode}">삭제</button></td>
				<td style="width:17%;">${poList.gdsNm}</td>
				<td style="text-align:center; width:18%;">${poList.gdsType}</td>
				<td style="width:8%;" class="right"><input class="poQty" style="width: 120px;" value="${inputqq}" type="number" max="${poList.max}" data-amt="${poList.amt}"></td>
				<td style="text-align:center; width:10%;">${poList.unitNm}</td>
				<td style="width:15%;" class="right">${poList.amt.toLocaleString()}</td>
				<td style="width:15%;" class="right gdsTotal">${(poList.inputQty * poList.amt).toLocaleString()}</td>
			</tr>
		`;
		total+=poList.inputQty * poList.amt;
		$('#clclnAmt').text(total.toLocaleString());
		$('#po-list').append(poListStr);
}

  /*************************************************************************************
			발주 자동 입력
**************************************************************************************/
function addPoFrcsCartList(){
	gdsList = [];
	total = 0;
	// 서버전송
	$.ajax({
		url : "/frcs/deal/frcsGdsCart",
		type : "POST",
		data: { bzentNo : bzentNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			//// 상품 상세
			total = 0;
			let num = 1;
			let gdsStr= '';
			res.forEach(list => { 
			let type = `<span class='bge ${
				    list.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsTypeNm}</span>`;
			
			let inputQty = 0;
			let max = list.stockVOList[0].ntslQty;
			let qty = list.stockVOList[0].sfStockQty - list.stockVOList[0].qty - list.stockVOList[0].aprvQty;
			if(qty<=0){
				return; // 현재 반복을 종료하고 다음 반복으로 넘어감
			};
			if(max-qty>0){
				inputQty = qty;
			} else {
				inputQty = max;
			}
			inputQty = Math.ceil(inputQty); 
				gdsStr += `<tr data-code="${list.gdsCode}" data-amt="${list.stockVOList[0].gdsAmtVOList[0].amt}">
						<td style="text-align:center; width:8%;"><button class="btn btn-default remove" data-no="${list.gdsCode}">삭제</button></td>
						<td style="width:17%;">${list.gdsNm}</td>
						<td style="text-align:center; width:18%;">${type}</td>
						<td style="width:8%;" class="right"><input class="poQty" style="width: 120px;" value="${inputQty}" type="number" max="${list.stockVOList[0].ntslQty}" data-amt="${list.stockVOList[0].gdsAmtVOList[0].amt}"></td>
						<td style="text-align:center; width:10%;">${list.unitNm}</td>
						<td style="width:15%;" class="right">${list.stockVOList[0].gdsAmtVOList[0].amt.toLocaleString()}</td>
						<td style="width:15%;" class="right gdsTotal">${(inputQty * list.stockVOList[0].gdsAmtVOList[0].amt).toLocaleString()}</td>
					</tr>`;
				total+=inputQty * list.stockVOList[0].gdsAmtVOList[0].amt;
				gdsList.push(list.gdsCode);
			});
		$('#clclnAmt').text(total.toLocaleString());
		$('#po-list').html(gdsStr);	
		
		if(gdsStr==''){
			Swal.fire({
				  title: "자동 담을 상품이 없습니다.",
				  text: "안전 재고 이하 상품에 대해 승인 대기 중인 내역이 있습니다.",
				  icon: "info"
			})
			return;
		}

		// 카트모양 업로드
		selectGdsFrcsAjax();	
		} // success 끝
	});				
}

/*************************************************************************************
			발주 신청 (가맹점)
*************************************************************************************/
// 추가
function insertPoFrcsAjax(stockPOList){
	poVO = {};
	poVO.bzentNo = bzentNo;
	
	// 서버전송
	$.ajax({
		url : "/frcs/deal/registAjax",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify({
        	stockPOList : stockPOList,
        	poVO : poVO
        }), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "발주가 성공적으로 신청되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
					 location.href="/frcs/deal/list";
				}
			});
			}
		} // success 끝
	});		
}

/*************************************************************************************
			발주 정산
*************************************************************************************/
// 추가
function updateClclnAjax(){
	poClclnVO = {};
	poClclnVO.npmntAmt = $('#npmntAmt').text().replace(/,/g, '');
	poClclnVO.poNo = poNo;
	poClclnVO.actno = actno;
	poClclnVO.bankType = bankType;
	
	// 서버전송
	$.ajax({
		url : "/com/deal/updateClcln",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(poClclnVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "정산이 성공적으로 완료되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
					 location.reload();
				}
			});
			}
		} // success 끝
	});		
}

