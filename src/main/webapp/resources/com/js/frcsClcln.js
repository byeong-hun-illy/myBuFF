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
// @jsp         : hdofc/frcs/selectFrcs
// @description : 가맹점 검색 조건에 따른 리스트 ajax 조회 & 페이징 처리
function selectFrcsClclnAjax(){
	let bgngYmdDt = $('#bgngYmd').val();
	let endYmdDt = $('#endYmd').val();
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let bzentNm = $('#bzentNm').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (bzentNm) {
	    data.bzentNm = bzentNm;
	}
	if (bgngYmdDt) {
	    data.bgngYmd = dateToStr(bgngYmdDt);
	}
	if (endYmdDt) {
	    data.endYmd = dateToStr(endYmdDt);
	}
	if (sregYmdDt) {
	    data.sregYmd = dateToStr(sregYmdDt);
	}
	if (eregYmdDt) {
	    data.eregYmd = dateToStr(eregYmdDt);
	}
	if (frcsNo){
		data.frcsNo = frcsNo;
	}
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.clclnYn = clclnYn;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/com/frcsClcln/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-y').text(res.y);
			$('#tap-n').text(res.n);
			$('#tap-all').text(res.all);
			//console.log(res);
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
				let reg = strToDate(list.regYmd);
				// 정산 일자
				let clclnYmd = '-';
				if(list.clclnYmd){
					clclnYmd = strToDate(list.clclnYmd);
				}
				
				let clclnYm = (""+list.clclnYm).substring(0, 4)+"-"+(""+list.clclnYm).substring(4, 6);
				
	    		strTbl += `
				    <tr class="frcsDtl" data-no="${list.frcsNo}" data-ym="${list.clclnYm}">
				        <td class="center">${list.rnum}</td>
				        <td class="center">${clclnYm}</td>
				        <td>${list.bzentVO.bzentNm}</td>
				        <td class="center">${reg}</td>
				        <td class="right">${list.royalty.toLocaleString()}</td>
				        <td class="right">${list.dscntAmt.toLocaleString()}</td>
				        <td class="center">${clclnYmd}</td>
				        <td class="center">
				            <span class="bge ${list.clclnYn === 'Y' ? 'bge-active' :  'bge-danger'}">
							  ${list.clclnYn === 'Y' ? '정산완료' :  '정산대기'}
							</span>
				        </td>
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
function insertFrcsClclnAjax(clclnYm){
	// 서버전송
	$.ajax({
		url : "/hdofc/frcsClcln/registAjax",
		type : "POST",
		data: { clclnYm : clclnYm },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "정산이 성공적으로 등록되었습니다",
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

 /*******************************************
			정산 상세
********************************************/
// 추가
function selectFrcsClclnDtlAjax( ){
	frcsClclnVO = {};
	frcsClclnVO.frcsNo = frcsNo;
	frcsClclnVO.clclnYm = clclnYm;
	
	// 서버전송
	$.ajax({
		url : "/com/frcsClcln/dtlAjax",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(frcsClclnVO), // 데이터를 JSON으로 변환
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			let cln = res.frcsClclnVO;
			
			if(bzentNo && cln.clclnYn === 'N'){
				$('#updateClcln').show();
			}
			
			let bzentNm=cln.bzentVO.bzentNm;
			let bzentTelno = telToStr(cln.bzentVO.bzentTelno);
			let bzentAddr = `
						<p>(${cln.bzentVO.bzentZip})</p>
						<p>${cln.bzentVO.bzentAddr}, ${cln.bzentVO.bzentDaddr}</p>
						`;
			$('#bzentNm').text(bzentNm);
			$('#bzentTelno').text(bzentTelno);
			$('#bzentAddr').html(bzentAddr);
			
			// 가맹점일 경우 계좌정보 등록하여 결제가 필요함
			actno = cln.bzentVO.actno;
			bankType = cln.bzentVO.bankType; 
			bankTypeNm = cln.bzentVO.bankTypeNm;
			
			let ym = (""+clclnYm).substring(0, 4)+"-"+(""+clclnYm).substring(4, 6);

			$('#clclnYm').text(ym);
			
			let clclnYn = `<span class="bge ${cln.clclnYn === 'Y' ? 'bge-active' :  'bge-danger'}">
							  ${cln.clclnYn === 'Y' ? '정산완료' :  '정산대기'}
							</span>`;
			$('#clclnYn').html(clclnYn);
			
			$('#regYmd').text(strToDate(cln.regYmd))
			
			let clclnYmd = '-';
			if(cln.clclnYmd!=null){
				clclnYmd = strToDate(cln.clclnYmd);
				$('#actno').text(maskActno(cln.actno));
				$('#bankTypeNm').text(cln.bankTypeNm);
			}
			$('#clclnYmd').text(clclnYmd);
			
			$('#royalty').text(cln.royalty.toLocaleString());
			$('#dscntAmt').text(cln.dscntAmt.toLocaleString());
			$('#npmntAmt').text(cln.npmntAmt.toLocaleString());
			$('#totalAmt').text((cln.royalty+cln.npmntAmt-cln.dscntAmt).toLocaleString());
		} // success 끝
	});		
}

/*************************************************************************************
			발주 정산
*************************************************************************************/
// 추가
function updateClclnAjax(){
	let frcsClclnVO = {};
	frcsClclnVO.npmntAmt = $('#npmntAmt').text().replace(/,/g, '');
	frcsClclnVO.frcsNo = frcsNo;
	frcsClclnVO.clclnYm = clclnYm;
	
	// 서버전송
	$.ajax({
		url : "/frcs/frcsClcln/updateClcln",
		type : "POST",
		contentType: 'application/json',
        data: JSON.stringify(frcsClclnVO), // 데이터를 JSON으로 변환
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