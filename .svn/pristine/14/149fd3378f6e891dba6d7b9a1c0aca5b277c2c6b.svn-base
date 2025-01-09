/*******************************************
  @fileName    : cnpt.js
  @author      : 송예진
  @date        : 2024. 09. 12
  @description : 가맹점 거래처 코드
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");
 function selectCnptAjax(){
 	let mngrId = $('#mngrId').val();
	let rgnNo = $('#rgnNo').val();
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let bzentNm = $('#bzentNm').val();
	let mbrNm = $('#mbrNm').val();
	
	
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
	if (sregYmdDt) {
	    data.sregYmd = dateToStr(sregYmdDt);
	}
	if (eregYmdDt) {
	    data.eregYmd = dateToStr(eregYmdDt);
	}
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.bzentType = bzentType;
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-c01').text(res.c01);
			$('#tap-c02').text(res.c02);
			$('#tap-c03').text(res.c03);
			
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
				// 개업 일자
				let reg = strToDate(list.regYmd);
				// 전화번호
				let telno = telToStr(list.bzentTelno);
	    		strTbl += `
				    <tr class="cnptDtl" data-no="${list.bzentNo}">
				        <td class="center">${list.rnum}</td>
				        <td>${list.bzentNm}</td>
				        <td class="center">${list.mbrVO ? list.mbrVO.mbrNm : '-'}</td>
				        <td class="center">${list.mngrVO && list.mngrVO.mbrNm ? list.mngrVO.mbrNm : '-'}</td>
				        <td class="center">${reg}</td>
				        <td class="center">${list.rgnNm}</td>
				        <td class="center">${telno}</td>
				        <td class="center">
				            <span class="bge ${list.bzentType === 'BZ_C01' ? 'bge-active' : list.bzentType === 'BZ_C02' ? 'bge-warning' : 'bge-danger'}">
							  ${list.bzentTypeNm.replace(' 거래처','')}
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
			거래처 담당자 조회
********************************************/
 // @methodName  : preCnptList
// @author      : 송예진
// @date        : 2024.09.24
// @jsp         : hdofc/cnpt/list/dtl, hdofc/cnpt/regist
// @description : 가맹점 상담을 마친 가맹점주 할당되지않은 회원 조회
function preCnptList(){
	let gubun = $('#mbrGubun').val();
	let keyword = $('#mbrKeyword').val();
	let rgnNo = $('#rgn-mbr').val();
	console.log(rgnNo);
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	//if (sort) {data.sort = sort;}
	if (gubun) {
	    data.gubun = gubun;
	}
	if (keyword) {
	    data.keyword = keyword;
	}
	if (rgnNo) {
	    data.rgnNo = rgnNo;
	}
	
	data.currentPage = currentPage;
	data.sort = sort;
	data.orderby = orderby;
	
	// 최종적으로 빈 값이 제외된 data 객체
	// console.log(data);  
	
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/preList",
		type : "GET",
		data : data,
		success : function(res){
			console.log(res);
			// 구분
			$('#tap-all-mbr').text(res.total);
		
			// 테이블 처리
			let strTbl = '';
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="6"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				('#mbrpage').html('');
				$('#table-mbr').html(strTbl);
				return;
			}
			res.content.forEach(list => {
			
			let telno = telToStr(list.mbrTelno);
			
    		strTbl += `
			    <tr class="mbrDtl" data-nm="${list.mbrNm}" data-id="${list.mbrId}"
			    	data-tel="${list.mbrTelno}" data-eml="${list.mbrEmlAddr}">
			        <td class="center">${list.rnum}</td>
			        <td class="center">${list.mbrId}</td>
			        <td class="center">${list.mbrNm}</td>
			        <td class="center">${list.mbrEmlAddr}</td>
			        <td class="center">${telno}</td>
			        <td class="center">${list.rgnNm}</td>
			    </tr>
			`;
			
			});
			$('#table-mbr').html(strTbl)
			
			// 페이징 처리
			let page = '';
			
			if (res.startPage > res.blockSize) {
			    page += `
			        <a href="#page" class="page-link page-mbr" data-page="${res.startPage - res.blockSize}">
			            <span class="icon material-symbols-outlined">chevron_left</span>
			        </a>
			    `;
			}
			
			// 페이지 번호 링크들 추가
			for (let pnum = res.startPage; pnum <= res.endPage; pnum++) {
			    if (res.currentPage === pnum) {
			        page += `<a href="#page" class="page-link page-mbr active" data-page="${pnum}">${pnum}</a>`;
			    } else {
			        page += `<a href="#page" class="page-link page-mbr" data-page="${pnum}">${pnum}</a>`;
			    }
			}
			
			// 'chevron_right' 아이콘 및 다음 페이지 링크 추가
			if (res.endPage < res.totalPages) {
			    page += `
			        <a href="#page" class="page-link page-mbr" data-page="${res.startPage + res.blockSize}">
			            <span class="icon material-symbols-outlined">chevron_right</span>
			        </a>
			    `;
			}
			$('#mbrpage').html(page);
			}
		});			
}

 /*******************************************
			거래처 추가
********************************************/
// @methodName  : insertCnpt
// @author      : 송예진
// @date        : 2024.09.24
// @jsp         : hdofc/cnpt/registAjax
// @description : 가맹점주 수정
function insertCnpt(){
	let bzentVO = {}; // mbrId, mngrId, bzentTelno, bzentNm, bzentZip, bzentAddr, bzentDaddr, bzentType
	// 나중에 들어가는 값 bzentNo, rgnNo
	
	let bzentNm = $('#bzentNm').val();
	let bzentZip= $('#bzentZip').val();
	let bzentAddr= $('#bzentAddr').val();
	let bzentType = $('#bzentType').val();

	// 선택
	let bzentDaddr = $('#bzentDaddr').val();
	let mbrId = $('#mbrId').val();
	let mngrId = $('#mngrId').val();
	let bzentTelno = $('#bzentTelno1').val()+$('#bzentTelno2').val()+$('#bzentTelno3').val();
	
	bzentVO.bzentNm = bzentNm;
	bzentVO.bzentZip = bzentZip;
	bzentVO.bzentAddr = bzentAddr;
	bzentVO.bzentType = bzentType;
	
	if(mbrId){
		bzentVO.mbrId = mbrId;
	}
	
	if(bzentDaddr){
		bzentVO.bzentDaddr = bzentDaddr;
	}
	if(mngrId){
		bzentVO.mngrId = mngrId;
	}
	if(bzentTelno){
		bzentVO.bzentTelno = bzentTelno;
	}
	
	console.log(bzentVO);
	
	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/registAjax",
		type : "POST",
		data: JSON.stringify(bzentVO),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			setTimeout(function() {
        		location.href='/hdofc/cnpt/dtl?bzentNo='+res;
			}, 1000);
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
	
}

 /*******************************************
			거래처 상세 조회
********************************************/
// 상세!!!
function selectCnptDtlAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/dtlAjax",
		type : "POST",
		data: { bzentNo : bzentNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			let cnpt = res.cnpt;
			$('#bzentNm').val(cnpt.bzentNm);
			
			let bzentTelno = splitTel(cnpt.bzentTelno);
			$('#bzentTelno1').val(bzentTelno[0]);
			$('#bzentTelno2').val(bzentTelno[1]);
			$('#bzentTelno3').val(bzentTelno[2]);
		
			$('#bzentZip').val(cnpt.bzentZip);
			$('#bzentAddr').val(cnpt.bzentAddr);
			$('#bzentDaddr').val(cnpt.bzentDaddr);
			let bge = ` <span class="bge ${cnpt.bzentType === 'BZ_C01' ? 'bge-active' : cnpt.bzentType === 'BZ_C02' ? 'bge-warning': 'bge-danger'}">
									  ${cnpt.bzentTypeNm.replace(' 거래처','')}
									</span>`;
			$('.bzentType').html(bge);
			
			// 등록 일자
			let reg = strToDate(cnpt.regYmd);
			$('#regYmd').text(reg);
			
			if(cnpt.mbrVO!=null){
			$('#mbrNm').val(cnpt.mbrVO.mbrNm);
			$('#mbrId').val(cnpt.mbrVO.mbrId);
			let mbrTelNo = splitTel(cnpt.mbrVO.mbrTelno);
			$('#mbrTelno1').val(mbrTelNo[0]);
			$('#mbrTelno2').val(mbrTelNo[1]);
			$('#mbrTelno3').val(mbrTelNo[2]);
		
			$('#mbrEml').val(cnpt.mbrVO.mbrEmlAddr);
			}
			
			if(cnpt.mngrVO!=null){
				$('#mngrNm').val(cnpt.mngrVO.mbrNm);
				$('#mngrId').val(cnpt.mngrId);
				let mngrTelNo = splitTel(cnpt.mngrVO.mbrTelno);
				$('#mngrTelno1').val(mngrTelNo[0]);
				$('#mngrTelno2').val(mngrTelNo[1]);
				$('#mngrTelno3').val(mngrTelNo[2]);
			       
				$('#mngrEml').val(cnpt.mngrVO.mbrEmlAddr);
			}
		} // success 끝
	});		
}

 /*******************************************
			거래처 삭제
********************************************/
// 상세!!!
function deleteCnptAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/deleteAjax",
		type : "POST",
		data: { bzentNo : bzentNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			if(res>0){
				Swal.fire({
				  title: "완료",
				  text: "거래처가 성공적으로 삭제되었습니다",
				  icon: "success"
				}).then((result) => {
				 if (result.isConfirmed) {
					 location.href="/hdofc/cnpt/list";
				}
			});
			} else {
				Swal.fire({
				  title: "오류",
				  html: "<p>재고 정보가 존재합니다</p><p>해당 거래처는 삭제할 수 없습니다.</p>",
				  icon: "error"
				});
			}
		} // success 끝
	});		
}

 /*******************************************
			거래처 수정
********************************************/
function updateCnpt(){
	let bzentVO = {}; // bzentNo, mbrId, mngrId, bzentTelno, bzentNm, bzentZip, bzentAddr, bzentDaddr, bzentType
	// 나중에 들어가는 값  rgnNo
	
	let bzentNm = $('#bzentNm').val();
	let bzentZip= $('#bzentZip').val();
	let bzentAddr= $('#bzentAddr').val();
	let bzentType = $('#bzentType').val();

	// 선택
	let bzentDaddr = $('#bzentDaddr').val();
	let mbrId = $('#mbrId').val();
	let mngrId = $('#mngrId').val();
	let bzentTelno = $('#bzentTelno1').val()+$('#bzentTelno2').val()+$('#bzentTelno3').val();
	
	bzentVO.bzentNm = bzentNm;
	bzentVO.bzentZip = bzentZip;
	bzentVO.bzentAddr = bzentAddr;
	bzentVO.bzentType = bzentType;
	bzentVO.bzentNo = bzentNo;
	
	if(mbrId){
		bzentVO.mbrId = mbrId;
	}
	
	if(bzentDaddr){
		bzentVO.bzentDaddr = bzentDaddr;
	}
	if(mngrId){
		bzentVO.mngrId = mngrId;
	}
	if(bzentTelno){
		bzentVO.bzentTelno = bzentTelno;
	}
	
	console.log(bzentVO);
	
	// 서버전송
	$.ajax({
		url : "/hdofc/cnpt/updateAjax",
		type : "POST",
		data: JSON.stringify(bzentVO),  // JSON으로 변환
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