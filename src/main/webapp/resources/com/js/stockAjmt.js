/*******************************************
  @fileName    : frcsClcln.js
  @author      : 송예진
  @date        : 2024. 10. 05
  @description : 가맹점 정산 코드
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");

// @methodName  : selectFrcsAjax
// @author      : 송예진
// @date        : 2024.09.12
// @jsp         : 
// @description : 가맹점 검색 조건에 따른 리스트 ajax 조회 & 페이징 처리
function selectStockAjmtAjax(){
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let gdsNm = $('#gdsNm').val();
	let gdsType = $('#gdsType').val();
	let gdsClass = $('#gdsClass').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (gdsNm) {
	    data.gdsNm = gdsNm;
	}
	if (sregYmdDt) {
	    data.sregYmd = dateToStr(sregYmdDt);
	}
	if (eregYmdDt) {
	    data.eregYmd = dateToStr(eregYmdDt);
	}
	if (gdsType){
		data.gdsType = gdsType;
	}
	if (gdsClass){
		data.gdsClass = gdsClass;
	}
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.ajmtType = ajmtType;
	data.bzentNo = bzentNo;
	
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
								<td class="error-info" colspan="8"> 
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
				let gdsType = `<span class='bge ${
				    list.gdsVO.gdsType.substring(0, 2) == 'FD' ? 'bge-active-border' 
				    : list.gdsVO.gdsType.substring(0, 2) == 'SM' ? 'bge-warning-border' 
				    : 'bge-danger-border'}'>${list.gdsVO.gdsTypeNm}</span>`;
				    
				// 유형
				let type = `<span class='bge ${
				    list.ajmtType == 'AJMT01' ? 'bge-info' 
				    : list.ajmtType == 'AJMT02' ? 'bge-danger' 
				    : list.ajmtType == 'AJMT03' ? 'bge-active' 
				    : 'bge-warning'}'>${list.ajmtTypeNm}</span>`;
				
				let ajmtRsn = '-';
				            // 가맹점 처리
		       	if(list.ajmtRsn && list.ajmtRsn.length > 5) {
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
				        <td>${list.gdsVO.gdsNm}</td>
				        <td class="center">${gdsType}</td>
				        <td class="right">${list.qty.toLocaleString()}</td>
				        <td class="center">${list.gdsVO.unitNm}</td>
				        <td class="center">${ajmtYmd}</td>
				        <td class="center">${type}</td>
				        <td style="max-width: 100px">${ajmtRsn}</td>
				        <td class="center"><button class="btn-default" onclick="deleteStockAjmt(${list.ajmtNo})" ${list.ajmtType=='AJMT01' || list.ajmtType=='AJMT02' ? '' : 'disabled'}>삭제</button></td>
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
			정산 추가
********************************************/
// 상세!!!
function deleteStockAjmt(ajmtNo){
	Swal.fire({
				  title: "확인",
				  text: "정말 해당 재고 조정 내역을 삭제하시겠습니까?",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "삭제",
				  cancelButtonText: "취소"
				}).then((result) => {
					 if (result.isConfirmed) {
					 		// 서버전송
							$.ajax({
								url : "/com/stockAjmt/deleteAjax",
								type : "POST",
								data: { ajmtNo : ajmtNo },  // 객체 형태로 전송
								// csrf설정 secuity설정된 경우 필수!!
								beforeSend:function(xhr){ 
									xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
								},
								success : function(res){
									if(res>0){
										Swal.fire({
										  title: "완료",
										  text: "조정내역이 성공적으로 삭제되었습니다",
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
				});
	
}

 /*******************************************
			정산 상세
********************************************/
// 추가
function insertStockAjmtAjax(){
	let gdsCode = $('#gdsCode').val();
	let qty = $('#qty').val();
	let ajmtRsn = $('#ajmtRsn').val();

	stockAjmtVO = {};
	stockAjmtVO.gdsCode = gdsCode;
	stockAjmtVO.bzentNo = bzentNo;
	stockAjmtVO.qty = qty;
	
	if(gdsCode && qty && qty > max){
		Swal.fire({
		  title: "오류",
		  text: "보유 재고 수량보다 더 많은 수량입니다",
		  icon: "error"
		})
	} else if(!gdsCode || !qty){
		Swal.fire({
		  title: "오류",
		  text: "필수항목은 필수적으로 작성해주세요",
		  icon: "error"
		})
	}
	
	if(ajmtRsn){
		stockAjmtVO.ajmtRsn = ajmtRsn;
	}
	
	// 서버전송
	$.ajax({
		url : "/com/stockAjmt/insertAjax",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(stockAjmtVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
					  title: "완료",
					  text: "조정내역이 성공적으로 등록되었습니다",
					  icon: "success"
					}).then((result) => {
					 if (result.isConfirmed) {
					 	if(bzentNo=='HO0001'){
						 location.href="/hdofc/stockAjmt/list";
					 	} else {
						 location.href="/frcs/stockAjmt/list";
					 	}
					}
				});
			}
		} // success 끝
	});		
}

 /*******************************************
			상품 검색!!!!!!!!
********************************************/
 function selectGdsAjax(){
	let gdsType = $('#gdsTypeModal').val();
	let gdsNm = $('#gdsNmModal').val();
	let size = 5;
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (gdsType) {
	    data.gdsType = gdsType;
	}
	if (gdsNm) {
	    data.gdsNm = gdsNm;
	}

	data.size = size;
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.bzentNo = bzentNo;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/com/stockAjmt/stockListAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all-gds').text(res.all);
			
			//console.log(res);
			// 테이블 처리
			let strTbl = '';
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="5"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.articlePage.content.forEach(list => {

				let type = `<span class='bge ${
				    list.gdsType.substring(0, 2) == 'FD' ? 'bge-active' 
				    : list.gdsType.substring(0, 2) == 'SM' ? 'bge-warning' 
				    : 'bge-danger'}'>${list.gdsTypeNm}</span>`;

	    		strTbl += `
				    <tr class="gdsDtl" data-no="${list.gdsCode}" data-unit="${list.unitNm}" data-nm="${list.gdsNm}" data-max="${list.stockVOList[0].qty}">
				        <td class="center">${list.rnum}</td>
				        <td>${list.gdsNm}</td>
				        <td class="right">${list.stockVOList[0].qty.toLocaleString()}</td>
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
				$('#gdspage').html(page);
				}
			$('#table-gds').html(strTbl)
			}
		});			
 }
 
 /*******************************************
			param GdsCode를 보냈을 때 이름과 재고를 넣는 것
********************************************/
 function selectGdsParamAjax(gdsCode){
	let size = 5;
	
	let data = {};

	data.size = size;
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.bzentNo = bzentNo;
	data.gdsCode = gdsCode;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/com/stockAjmt/stockListAjax",
		type : "GET",
		data : data,
		success : function(res){
			let unitNm = "("+res.articlePage.content[0].unitNm+")";
			$('#unitNm').text(unitNm);
			$('#gdsCode').val(gdsCode);
			$('#gdsNm').val(res.articlePage.content[0].gdsNm);
			max = res.articlePage.content[0].stockVOList[0].qty;
			
			} // success 끝
		});			
 }