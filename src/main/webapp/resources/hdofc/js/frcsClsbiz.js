/*******************************************
  @fileName    : frcsClsbiz.js
  @author      : 송예진
  @date        : 2024. 09. 21
  @description : 가맹점 폐업
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");

// @methodName  : selectFrcsClsbizListAjax
// @author      : 송예진
// @date        : 2024.09.21
// @jsp         : hdofc/frcs/selectFrcsClsbiz
// @description : 가맹점 폐업 대상 조회
function selectFrcsClsbizListAjax(){
	let mngrId = $('#mngrId').val();
	let rgnNo = $('#rgnNo').val();
	let bzentNm = $('#bzentNm').val();
	let mbrNm = $('#mbrNm').val();
	let bgngYmdDt = $('#bgngYmd').val();
	let endYmdDt = $('#endYmd').val();
	let apsYmdDt = $('#apsYmd').val();
	let apeYmdDt = $('#apeYmd').val();
	let clsbizRsnType = $('#clsbizRsnType').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (mngrId) {
	    data.mngrId = mngrId;
	}
	if (rgnNo) {
	    data.rgnNo = rgnNo;
	}
	if (bzentNm) {
	    data.bzentNm = bzentNm;
	}
	if (mbrNm) {
	    data.mbrNm = mbrNm;
	}
	if (bgngYmdDt) {
	    data.bgngYmd = dateToStr(bgngYmdDt);
	}
	if (endYmdDt) {
	    data.endYmd = dateToStr(endYmdDt);
	}
	if (apsYmdDt) {
	    data.apsYmd = dateToStr(apsYmdDt);
	}
	if (apeYmdDt) {
	    data.apeYmd = dateToStr(apeYmdDt);
	}
	if (clsbizRsnType) {
	    data.clsbizRsnType = clsbizRsnType;
	}
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	if (clsbizType) {
		data.clsbizType = clsbizType;
	}
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/clsbiz/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-pre').text(res.pre);
			$('#tap-noCln').text(res.noCln);
			$('#tap-cln').text(res.cln);
			$('#tap-aprv').text(res.aprv);
			
			// 테이블 처리
			let strTbl = '';
			
			if(res.articlePage.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="9"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				
				$('#table-body').html(strTbl);
				$('.pagination').html('');
				return;
			}
			
			res.articlePage.content.forEach(list => {
			// 폐업 일자
			let clsbizYmd = strToDate(list.clsbizYmd);
			// 승인 일자
			let clsbizAprvYmd = '-';
			if(list.frcsClsbizVO.clsbizAprvYmd){
				clsbizAprvYmd = strToDate(list.frcsClsbizVO.clsbizAprvYmd);
			}
			
			// 폐업 여부
			let clsbiz = list.frcsClsbizVO.clsbizType=='CLS04' ? `<span class='bge bge-active'>폐업완료</span>` : list.frcsClsbizVO.clsbizType=='CLS01' ? `<span class='bge bge-info'>폐업예정</span>` : list.frcsClsbizVO.clsbizType=='CLS02' ? `<span class='bge bge-danger'>폐업미납</span>` : `<span class='bge bge-warning'>폐업대기</span>`;
			// 폐업 사유 유형
			let clsbizType = list.frcsClsbizVO.clsbizRsnType=='CR06' ? `<span class='bge bge-danger-border'>${list.frcsClsbizVO.clsbizRsnTypeNm}</span>` : `<span class='bge bge-default-border'>${list.frcsClsbizVO.clsbizRsnTypeNm}</span>`;
			
    		strTbl += `
			    <tr class="frcsDtl" data-no="${list.frcsNo}" data-type="${list.frcsClsbizVO.clsbizType}">
			        <td class="center">${list.rnum}</td>
			        <td>${list.bzentVO.bzentNm}</td>
			        <td class="center">${list.bzentVO.mbrVO ? list.bzentVO.mbrVO.mbrNm : '-'}</td>
			        <td class="center">${list.bzentVO.mngrVO && list.bzentVO.mngrVO.mbrNm ? list.bzentVO.mngrVO.mbrNm : '-'}</td>
			        <td class="center">${clsbizYmd}</td>
			        <td class="center">${clsbizAprvYmd}</td>
			        <td class="center">${list.bzentVO.rgnNm}</td>
			        <td class="center">${clsbizType}</td>
			        <td class="center">${clsbiz}</td>
			    </tr>
			`;
			
			});
			$('#table-body').html(strTbl)
			
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
		});			
}


function frcsClsbizDtlAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/clsbiz/dtlAjax",
		type : "GET",
		data: { frcsNo: frcsNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			console.log(res);
			let bge = `<span class="bge ${res.frcsType === 'FRS01' ? 'bge-active' : res.frcsType === 'FRS02' ? 'bge-danger' : 'bge-warning'}">
						  ${res.frcsTypeNm}
						</span>`;
						
			$('#storelink').html(`<span class="material-symbols-outlined icon" onclick="location.href='/hdofc/frcs/list/dtl?frcsNo=${res.frcsNo}'" style='cursor:pointer;'>open_in_new</span>`);
			$('#modal-bzentNm').text(res.bzentVO.bzentNm);
			$('#modal-frcsType').html(bge);
			$('#modal-mbrNm').text(res.bzentVO.mbrVO.mbrNm);
			
			$('#modal-rgnNm').text(res.bzentVO.rgnNm);
			let bzentTelNo = splitTel(res.bzentVO.bzentTelno);
			$('#modal-bzentTelno').text(bzentTelNo[0]+"-"+bzentTelNo[1]+"-"+bzentTelNo[2]);
			
			let mbrTelNo = splitTel(res.bzentVO.mbrVO.mbrTelno);
			$('#modal-mbrTelno').text(mbrTelNo[0]+"-"+mbrTelNo[1]+"-"+mbrTelNo[2]);
			
			if(res.bzentVO.mngrVO){
				$('#modal-mngrNm').text(res.bzentVO.mngrVO.mbrNm);
				let mngrTelNo = splitTel(res.bzentVO.mngrVO.mbrTelno);
				$('#modal-mngrTelno').text(mngrTelNo[0]+"-"+mngrTelNo[1]+"-"+mngrTelNo[2]);
			} else{
				$('#modal-mngrNm').text('-');
				$('#modal-mngrTelno').text('-');
			}
			
			// 폐업 유형
			let clsbiz = res.frcsClsbizVO.clsbizType=='CLS04' ? `<span class='bge bge-active'>폐업완료</span>` : res.frcsClsbizVO.clsbizType=='CLS01' ? `<span class='bge bge-info'>폐업예정</span>` : res.frcsClsbizVO.clsbizType=='CLS02' ? `<span class='bge bge-danger'>폐업미납</span>` : `<span class='bge bge-warning'>폐업대기</span>`;
			// 폐업 사유 유형
			let clsbizType = res.frcsClsbizVO.clsbizRsnType=='CR06' ? `<span class='bge bge-danger-border'>${res.frcsClsbizVO.clsbizRsnTypeNm}</span>` : `<span class='bge bge-default-border'>${res.frcsClsbizVO.clsbizRsnTypeNm}</span>`;
			
			$('#modal-clsbiz').html(clsbiz);
			$('#modal-clsType').html(clsbizType);
			
			console.log(res.frcsClsbizVO.clsbizAprvYmd);
			
			let clsbizAprvYmd = '-';
			if(res.frcsClsbizVO.clsbizAprvYmd){
				clsbizAprvYmd = strToDate(res.frcsClsbizVO.clsbizAprvYmd);
			} 
			$('#modal-aprvYmd').text(clsbizAprvYmd);
			
			let clsbizYmd = '-';
			if(res.frcsClsbizVO.clsbizAprvYmd){
				clsbizYmd = strToDate(res.clsbizYmd);
			} 
			$('#modal-clsbizYmd').text(clsbizYmd);
			
			let clsbizRsn = '-'
			if(res.frcsClsbizVO.clsbizRsn){
				clsbizRsn = res.frcsClsbizVO.clsbizRsn;
			} 
			$('#modal-clsbizRsn').html(clsbizRsn);
			}
		});		
}

/***********************************************************************
		폐업상태로 변경, 가맹점주의 권한도 삭제
************************************************************************/
function updateOneFrcsClsbiz(){
// 서버전송
	$.ajax({
		url : "/hdofc/frcs/clsbiz/updateOne",
		type : "POST",
		data: { frcsNo: frcsNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
				Swal.fire({
				  title: "완료",
				  html : `폐업 처리가 완료되었습니다.`,
				  confirmButtonColor: "#3085d6",
				  confirmButtonText: "확인",
				}).then((result) => {
				  if (result.isConfirmed) {
				  	location.reload();
				  } 
				});
			}
		});		
}

/***********************************************************************
		폐업 미납인 상태인 가맹점들 중에 정산이 완료된 항목을 찾아 폐업 대기로 변경
************************************************************************/

function updateClclnChk(){
// 서버전송
	$.ajax({
		url : "/hdofc/frcs/clsbiz/clclnChk",
		type : "POST",
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
				let htmlStr = res+"건이 폐업대기 상태로 변경되었습니다.";
				console.log(res);
				if(res>0){
					Swal.fire({
					  title: "완료",
					  html : htmlStr,
					  icon : "success",
					  confirmButtonColor: "#3085d6",
					  confirmButtonText: "확인",
					}).then((result) => {
					  if (result.isConfirmed) {
					  	location.reload();
					  } 
					});
				} else{
					Swal.fire({
					  title: "에러",
					  html : "정산이 완료된 폐업 가맹점이 없습니다",
					  icon : "error",
					  confirmButtonColor: "#3085d6",
					  confirmButtonText: "확인",
					});
				}
			}
		});		
}