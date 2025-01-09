/*******************************************
  @fileName    : frcs.js
  @author      : 송예진
  @date        : 2024. 09. 12
  @description : 가맹점 조회 코드
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");

// @methodName  : selectFrcsAjax
// @author      : 송예진
// @date        : 2024.09.12
// @jsp         : hdofc/frcs/selectFrcs
// @description : 가맹점 검색 조건에 따른 리스트 ajax 조회 & 페이징 처리
function selectFrcsAjax(){
	let mngrId = $('#mngrId').val();
	let rgnNo = $('#rgnNo').val();
	let bgngYmdDt = $('#bgngYmd').val();
	let endYmdDt = $('#endYmd').val();
	let clbYmdDt = $('#clbYmd').val();
	let cleYmdDt = $('#cleYmd').val();
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
	if (bgngYmdDt) {
	    data.bgngYmd = dateToStr(bgngYmdDt);
	}
	if (endYmdDt) {
	    data.endYmd = dateToStr(endYmdDt);
	}
	if (clbYmdDt) {
	    data.clbYmd = dateToStr(clbYmdDt);
	}
	if (cleYmdDt) {
	    data.cleYmd = dateToStr(cleYmdDt);
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
	data.frcsType = frcsType;
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-open').text(res.open);
			$('#tap-cls').text(res.cls);
			$('#tap-clsing').text(res.clsing);
			
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
				let opbiz = strToDate(list.opbizYmd);
				// 폐업 일자
				let clsbiz = strToDate(list.clsbizYmd);
				// 등록 일자
				let reg = strToDate(list.bzentVO.regYmd);
				
	    		strTbl += `
				    <tr class="frcsDtl" data-no="${list.frcsNo}">
				        <td class="center">${list.rnum}</td>
				        <td>${list.bzentVO.bzentNm}</td>
				        <td class="center">${list.bzentVO.mbrVO ? list.bzentVO.mbrVO.mbrNm : '-'}</td>
				        <td class="center">${list.bzentVO.mngrVO && list.bzentVO.mngrVO.mbrNm ? list.bzentVO.mngrVO.mbrNm : '-'}</td>
				        <td class="center">${reg}</td>
				        <td class="center">${opbiz}</td>
				        <td class="center">${clsbiz}</td>
				        <td class="center">${list.bzentVO.rgnNm}</td>
				        <td class="center">
				            <span class="bge ${list.frcsType === 'FRS01' ? 'bge-active' : list.frcsType === 'FRS02' ? 'bge-danger' : 'bge-warning'}">
							  ${list.frcsTypeNm}
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
// selectFrcsAjax 종료

// @methodName  : preFrcsList
// @author      : 송예진
// @date        : 2024.09.13
// @jsp         : hdofc/frcs/list/dtl, hdofc/frcs/regist
// @description : 가맹점 상담을 마친 가맹점주 할당되지않은 회원 조회
function preFrcsList(){
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
	console.log(data);  
	
	// 서버전송
	$.ajax({
		url : "/hdofc/preFrcsList",
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
				
				$('#table-mbr').html(strTbl);
				$('#mbrpage').html('');
				return;
			}
			res.content.forEach(list => {
			
			let telno = telToStr(list.mbrVO.mbrTelno);
			
			let plan = strToDate(list.dscsnPlanYmd);
			
    		strTbl += `
			    <tr class="mbrDtl" data-nm="${list.mbrVO.mbrNm}" data-id="${list.mbrVO.mbrId}"
			    	data-tel="${list.mbrVO.mbrTelno}" data-eml="${list.mbrVO.mbrEmlAddr}"
			    	data-plan="${plan}" data-cn="${list.dscsnCn}" data-code="${list.dscsnCode}">
			        <td class="center">${list.rnum}</td>
			        <td class="center">${list.mbrVO.mbrId}</td>
			        <td class="center">${list.mbrVO.mbrNm}</td>
			        <td class="center">${plan}</td>
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

// @methodName  : updateFrcs
// @author      : 송예진
// @date        : 2024.09.14
// @jsp         : hdofc/frcs/selectDtlFrcs.jsp
// @description : 전부 수정
function updateFrcs(){
	let frcsVO = {}; // opbizYmd, bzentNo   
	
	let bzentVO = {}; // mbrId, mngrId, bzentTelno, bzentNm, bzentZip, bzentAddr, bzentDaddr,  bzentNo
	// 나중에 들어가는 값  rgnNo
	
	let frcsDscsnVO = {}; // frcsNo, dscsnCode
	
	// 필수
	// Date 객체를 yyyyMMdd 형식으로 변환
	let opbizYmd = dateToStr($('#opbiz').val());
	let mbrId = $('#mbrId').val();
	let bzentNm = $('#bzentNm').val();
	let bzentZip= $('#bzentZip').val();
	let bzentAddr= $('#bzentAddr').val();
	
	// 선택
	let bzentDaddr= $('#bzentDaddr').val();
	let mngrId = $('#mngrId').val();
	let bzentTelno = $('#bzentTelno1').val()+$('#bzentTelno2').val()+$('#bzentTelno3').val();
	
	let dscsnCode = $('#dscsnCode').val();
	
	frcsVO.opbizYmd = opbizYmd;
	frcsVO.frcsNo = frcsNo;
	
	bzentVO.bzentNo = frcsNo;
	bzentVO.mbrId = mbrId;
	bzentVO.bzentNm = bzentNm;
	bzentVO.bzentZip = bzentZip;
	bzentVO.bzentAddr = bzentAddr;
	bzentVO.bzentTelno = bzentTelno;
	
	frcsDscsnVO.dscsnCode = dscsnCode;
	frcsDscsnVO.frcsNo = frcsNo;
	
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
	console.log(frcsVO);
	
	// 변경시 가맹점주 권한도 삭제할 것
	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/list/dtl/update",
		type : "POST",
		data: JSON.stringify({
			bzentVO: bzentVO,
        	frcsVO: frcsVO,
        	frcsDscsnVO : frcsDscsnVO
		}),  // JSON으로 변환
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

// @methodName  : insertFrcs
// @author      : 송예진
// @date        : 2024.09.14
// @jsp         : hdofc/frcs/registAjax
// @description : 가맹점주 수정
function insertFrcs(){
	let frcsVO = {}; // opbizYmd          
	// 나중에 들어가는 값 frcsNo, bzentNo
	
	let bzentVO = {}; // mbrId, mngrId, bzentTelno, bzentNm, bzentZip, bzentAddr, bzentDaddr, 
	// 나중에 들어가는 값 bzentNo, bzentType('BZ_F01'), rgnNo
	
	let frcsDscsnVO = {}; // frcsNo, dscsnCode
	
	let dscsnCode = $('#dscsnCode').val();
	
	// 필수
	// Date 객체를 yyyyMMdd 형식으로 변환
	let opbizYmd = dateToStr(new Date($('#opbiz').val()));
	
	let mbrId = $('#mbrId').val();
	let bzentNm = $('#bzentNm').val();
	let bzentZip= $('#bzentZip').val();
	let bzentAddr= $('#bzentAddr').val();
	if(!opbizYmd || !mbrId || !bzentNm || !bzentZip || !bzentAddr){
		Swal.fire({
		  title: "입력 오류",
		  html: "필수 항목을 입력해주세요",
		  icon: "error",
		  confirmButtonColor: "#00C157",
		  confirmButtonText: "확인",
		})
		return;
	}
	// 선택
	let bzentDaddr = $('#bzentDaddr').val();
	let mngrId = $('#mngrId').val();
	let bzentTelno = $('#bzentTelno1').val()+$('#bzentTelno2').val()+$('#bzentTelno3').val();
	
	frcsVO.opbizYmd = opbizYmd;
	
	bzentVO.mbrId = mbrId;
	bzentVO.bzentNm = bzentNm;
	bzentVO.bzentZip = bzentZip;
	bzentVO.bzentAddr = bzentAddr;
	
	frcsDscsnVO.dscsnCode = dscsnCode;
	
	if(bzentDaddr){
		bzentVO.bzentDaddr = bzentDaddr;
	}
	if(mngrId){
		bzentVO.mngrId = mngrId;
	}
	if(bzentTelno){
		bzentVO.bzentTelno = bzentTelno;
	}
	
	//console.log(bzentVO);
	//console.log(frcsVO);
	//console.log(frcsDscsnVO);
	
	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/registAjax",
		type : "POST",
		data: JSON.stringify({
			bzentVO: bzentVO,
        	frcsVO: frcsVO,
        	frcsDscsnVO : frcsDscsnVO
		}),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			setTimeout(function() {
        		location.href='/hdofc/frcs/list/dtl?frcsNo='+res;
			}, 1000);
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
	
}

// 상세!!!
function selectFrcsDtlAjax(){
	console.log(frcsNo);
	// 서버전송
	$.ajax({
		url : "/hdofc/frcs/list/dtlAjax",
		type : "POST",
		data: { frcsNo : frcsNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			//console.log(res);
			frcs = res.frcs;
			$('#bzentNm').val(frcs.bzentVO.bzentNm);
			let opbiz = strToDate(frcs.opbizYmd);
			let reg = strToDate(frcs.bzentVO.regYmd);
			$('#opbiz').val(opbiz);
			
			let bzentTelno = splitTel(frcs.bzentVO.bzentTelno);
			$('#bzentTelno1').val(bzentTelno[0]);
			$('#bzentTelno2').val(bzentTelno[1]);
			$('#bzentTelno3').val(bzentTelno[2]);
			$('#bzentZip').val(frcs.bzentVO.bzentZip);
			$('#bzentAddr').val(frcs.bzentVO.bzentAddr);
			$('#bzentDaddr').val(frcs.bzentVO.bzentDaddr);
			$('#frcsNo').text(frcs.frcsNo);
			let bge = ` <span class="bge ${frcs.frcsType === 'FRS01' ? 'bge-active' : frcs.frcsType === 'FRS02' ? 'bge-danger' : 'bge-warning'}">
									  ${frcs.frcsTypeNm}
									</span>`;
			$('#frcsType').html(bge);
			$('#warnCnt').text(frcs.warnCnt);
			$('#regYmd').text(reg);
		
		    // 시간 문자열을 "HH:mm" 형식으로 변환
		    let otm = frcs.openTm.substring(0, 2) + ':' + frcs.openTm.substring(2, 4);
		    let ctm = frcs.ddlnTm.substring(0, 2) + ':' + frcs.ddlnTm.substring(2, 4);
		
		    // 시간 정보를 #time 요소에 삽입
		    $('#time').text(otm + ' ~ ' + ctm);
		
			$('#mbrNm').val(frcs.bzentVO.mbrVO.mbrNm);
			$('#mbrId').val(frcs.bzentVO.mbrId);
			let mbrTelNo = splitTel(frcs.bzentVO.mbrVO.mbrTelno);
			$('#mbrTelno1').val(mbrTelNo[0]);
			$('#mbrTelno2').val(mbrTelNo[1]);
			$('#mbrTelno3').val(mbrTelNo[2]);
		
			$('#mbrEml').val(frcs.bzentVO.mbrVO.mbrEmlAddr);
			
			if(frcs.bzentVO.mngrVO!=null){
				$('#mngrNm').val(frcs.bzentVO.mngrVO.mbrNm);
				$('#mngrId').val(frcs.bzentVO.mngrId);
				let mngrTelNo = splitTel(frcs.bzentVO.mngrVO.mbrTelno);
				$('#mngrTelno1').val(mngrTelNo[0]);
				$('#mngrTelno2').val(mngrTelNo[1]);
				$('#mngrTelno3').val(mngrTelNo[2]);
			       
				$('#mngrEml').val(frcs.bzentVO.mngrVO.mbrEmlAddr);
			}
			
			console.log(res);
			// 점검 정보 check
			// 테이블 처리
			let strTbl = '';
			
			if(res.check.length == 0){ // 검색 결과가 0인 경우
				strTbl+= `
								<div class="error-info" style="width:100%;"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">점검 결과가 없습니다</div>
								</div>
				`;
				$('.check').html(strTbl);
			} else{
				res.check.forEach(list => {
				// 점검 일자
				let check = strToDate(list.chckYmd);
				
	    		strTbl += `
				    <tr class="frcsChkDtl" data-no="${list.frcsNo}" data-seq="${list.chckSeq}">
				        <td class="center" style="width: 15%">${list.rnum}</td>
				        <td class="center" style="width: 20%">${list.insctrVO.mbrNm}</td>
				        <td class="center" style="width: 20%">${check}</td>
				        <td class="center" style="width: 15%">${list.totStr}</td>
				        <td class="center" style="width: 15%">${list.clenScr}</td>
				        <td class="center" style="width: 15%">${list.srvcScr}</td>
				    </tr>
				`;
				});
				$('#table-body-check').html(strTbl)
			}
			
			// 평균 avg
			$('.totalScore').text(res.avg);
			if (res.avg == 'A') {
			    $('.circle').addClass('circle-active');
			} else if (res.avg == 'B' || res.avg == 'C') { // 'B' 또는 'C'일 경우
			    $('.circle').addClass('circle-warning');
			} else if (res.avg == 'D') {
			    $('.circle').addClass('circle-danger');
			} else if(res.check==null){// 검사 안함
			    $('.circle').addClass('circle-default');
			} else { // F
			    $('.circle').addClass('circle-info');
			}
			
			// 폐업 정보
			if(res.clsbiz==null){
				$('.clsbiz-table').html(`
							<tr>
								<td class="error-info" colspan="4"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">폐업 신청 결과가 없습니다</div>
								</td>
							</tr>
				`);
			} else{
				// 폐업 유형
				let clsbiz = res.clsbiz.frcsClsbizVO.clsbizType=='CLS04' ? `<span class='bge bge-active'>폐업완료</span>` : res.clsbiz.frcsClsbizVO.clsbizType=='CLS01' ? `<span class='bge bge-info'>폐업예정</span>` : res.clsbiz.frcsClsbizVO.clsbizType=='CLS02' ? `<span class='bge bge-danger'>폐업미납</span>` : `<span class='bge bge-warning'>폐업대기</span>`;
				// 폐업 사유 유형
				let clsbizType = res.clsbiz.frcsClsbizVO.clsbizRsnType=='CR06' ? `<span class='bge bge-danger-border'>${res.clsbiz.frcsClsbizVO.clsbizRsnTypeNm}</span>` : `<span class='bge bge-default-border'>${res.clsbiz.frcsClsbizVO.clsbizRsnTypeNm}</span>`;
				
				$('#modal-clsbiz').html(clsbiz);
				$('#modal-clsType').html(clsbizType);
				
				console.log(res.clsbiz.frcsClsbizVO.clsbizAprvYmd);
				
				let clsbizAprvYmd = '-';
				if(res.clsbiz.frcsClsbizVO.clsbizAprvYmd){
					clsbizAprvYmd = strToDate(res.clsbiz.frcsClsbizVO.clsbizAprvYmd);
				} 
				$('#modal-aprvYmd').text(clsbizAprvYmd);
				
				let clsbizYmd = '-';
				if(res.clsbiz.frcsClsbizVO.clsbizAprvYmd){
					clsbizYmd = strToDate(res.clsbizYmd);
				} 
				$('#modal-clsbizYmd').text(clsbizYmd);
				
				let clsbizRsn = '-'
				if(res.clsbiz.frcsClsbizVO.clsbizRsn){
					clsbizYmd = res.clsbiz.frcsClsbizVO.clsbizRsn;
				} 
				$('#modal-clsbizRsn').html(clsbizRsn);
			}
		
		} // success 끝
	});		
}

