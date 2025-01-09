/*******************************************
  @fileName    : common.js
  @author      : 송예진
  @date        : 2024. 09. 12
  @description : 본사에서 공통적으로 사용하는 js
********************************************/

// @methodName  : selectMngrAjax
// @author      : 송예진
// @date        : 2024.09.12
// @jsp         : /hdofc/mngrModalList
// @description : 가맹점이나 거래처 관리자 단일 추가시 사용하는 js
// @Controller  : HodfcFrcsController
function selectMngrAjax(){
	let gubun = $('#gubun').val();
	let keyword = $('#keyword').val();
	let rgnNo = $('#rgn-mngr').val();
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
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
	//console.log(data);  
	
	// 서버전송
	$.ajax({
		url : "/hdofc/mngrModalList",
		type : "GET",
		data : data,
		success : function(res){
			// 구분
			$('#tap-all-mngr').text(res.total);
		
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
				
				$('#table-body-mngr').html(strTbl);
				return;
			}
			res.content.forEach(list => {
			//console.log(list);
			let telno = telToStr(list.memberVO.mbrTelno)
			// 입사 일자
			let jncmp = strToDate(list.jncmpYmd)
    		strTbl += `
			    <tr class="mngrDtl" data-nm="${list.memberVO.mbrNm}" data-id="${list.mngrId}"
			    	 data-tel="${list.memberVO.mbrTelno}" data-eml="${list.memberVO.mbrEmlAddr}">
			        <td class="center">${list.rnum}</td>
			        <td class="center">${list.mngrId}</td>
			        <td class="center">${list.memberVO.mbrNm}</td>
			        <td class="center">${telno}</td>
			        <td class="center">${list.memberVO.rgnNm}</td>
			        <td class="center">${jncmp}</td>
			    </tr>
			`;
			
			});
			$('#table-body-mngr').html(strTbl)
			
			// 페이징 처리
			let page = '';
			
			if (res.startPage > res.blockSize) {
			    page += `
			        <a href="#page" class="page-link page-mngr" data-page="${res.startPage - res.blockSize}">
			            <span class="icon material-symbols-outlined">chevron_left</span>
			        </a>
			    `;
			}
			
			// 페이지 번호 링크들 추가
			for (let pnum = res.startPage; pnum <= res.endPage; pnum++) {
			    if (res.currentPage === pnum) {
			        page += `<a href="#page" class="page-link page-mngr active" data-page="${pnum}">${pnum}</a>`;
			    } else {
			        page += `<a href="#page" class="page-link page-mngr" data-page="${pnum}">${pnum}</a>`;
			    }
			}
			
			// 'chevron_right' 아이콘 및 다음 페이지 링크 추가
			if (res.endPage < res.totalPages) {
			    page += `
			        <a href="#page" class="page-link page-mngr" data-page="${res.startPage + res.blockSize}">
			            <span class="icon material-symbols-outlined">chevron_right</span>
			        </a>
			    `;
			}
			$('#mngrPage').html(page);
			}
		});			
}