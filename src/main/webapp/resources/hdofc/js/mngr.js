/*******************************************
  @fileName    : mngr.js
  @author      : 정기쁨
  @date        : 2024. 09. 28
  @description : 사원 관리를 위한 코드 모음
********************************************/
$(function(){
	// 셀렉트 디자인 라이브러리
	select2Custom();
	// 사원 목록 조회
	selectMngrAjax(currentPage);
})
/*******************************************/
// 변수 선언
/*******************************************/
var currentPage = 1;
var sortField = 'jncmpYmdSort';
var orderby = 'desc';
var mngrVO = '${mngrMap.mngrVO}';
var mngrVOList = '${mngrMap.mngrVOList}';
// jsp 에서 가져온 값
function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
    const fields = ['mngrId', 'frcs', 'cnpt', 'hdofYn', 'startJncmpYmd', 'endJncmpYmd', 'mngrType', 'approvedType'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    data.sort = sortField;
    data.orderby = orderby;

    return data; // data 객체 반환
}
/*******************************************/
// 공통
/*******************************************/
// 검색버튼 클릭 시
$('#searchBtn').on('click',function(){
	// 탭 처리
	let data = getInputData();
	let typeValue = data.approvedType;
    $('.tap-cont').removeClass('active');
	$(`.tap-cont[data-approved="${typeValue}"]`).addClass('active');
	if(!typeValue){
		$(`.tap-cont[data-approved=""]`).addClass('active');
	}
	currentPage = 1;
    selectMngrAjax(currentPage);
})

// 페이징 처리
$(document).on('click','.page-link',function(){
	currentPage = $(this).data('page');
	selectMngrAjax(currentPage);
})

// th 정렬 기능
$('.sort').on('click',function(){
	 // 정렬 색상 변경 이벤트 호출
	 thClickEvent($(this));
	 currentPage = 1;
	 // 리스트 호출
	 selectMngrAjax(currentPage);
})

// 상세조건 변화
$('.search-toggle').on('click', function() {
	// 상세조건 토글 이벤트 호출
	searchToggle(this);
	
	const fields = ['mngrId', 'frcs', 'cnpt', 'hdofYn', 'startJncmpYmd', 'endJncmpYmd'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        $(`#${field}Summary`).text(value ? value : '미선택');
    });

	// 담당자 요약 업데이트
    let mngrIdValue = $('#select2-mngrId-container').text();
    $('#mngrIdSummary').text(mngrIdValue);

	// 재직/퇴직 요약 업데이트
    let hdofYnValue = $('#hdofYn').val();
    $('#hdofYnSummary').text(hdofYnValue === 'Y' ? '재직' : '퇴직');

    // 날짜 범위 요약 업데이트
    let startJncmpYmd = $('#startJncmpYmd').val();
    let endJncmpYmd = $('#endJncmpYmd').val();
    $('#jncmpYmdSummary').text(!startJncmpYmd && !endJncmpYmd ? '미선택' : `${startJncmpYmd} ~ ${endJncmpYmd}`);

    // 관리 유형 요약 업데이트
    let mngrType = $('#mngrType').val();
    $('#mngrNmSummary').text(mngrType === 'HM01' ? '일반관리자' : (mngrType === 'HM02' ? '최상위관리자' : '미선택'));

    // 승인 여부 요약 업데이트
    let approvedType = $('#approvedType').val();
    $('#approvedSummary').text(approvedType === 'yes' ? '승인' : (approvedType === 'no' ? '미승인' : '미선택'));
});

// 검색영역 초기화
$('.search-reset').on('click', function(){
	// 상세조건 초기화
	$('#hdofYn, #mngrId, #frcs, #cnpt, #startJncmpYmd, #endJncmpYmd, #mngrType, #approvedType').val('');
	$('#mngrIdSummary, #frcsSummary, #cnptSummary, #hdofYnSummary, #jncmpYmdSummary, #mngrNmSummary, #approvedSummary').text('미선택');
	$('.select-selected').text('전체');
		
	// 정렬 초기화 이벤트 호출
	resetSort( $('.sort[data-sort="mngrTypeSort"]'), $('.sort[data-orderby="desc"]') );
	currentPage = 1;
	// 리스트 호출
	selectMngrAjax(currentPage);
})

// 승인 버튼 클릭 시
$('#approvedBtn').on('click', function() {
		var selectedArr = [];

	    // 전체 선택이 아닌 체크박스 값을 배열에 추가
	    $('.check-btn:checked').not('.check-btn.all').each(function() {
    		selectedArr.push($(this).val());
	    });
	    
	    console.log("selectedArr => ",selectedArr);

	    // 배열이 비어 있지 않으면 AJAX 호출
	    if (selectedArr.length > 0) {
	    	updateAuthAjax(selectedArr);
	    } else {
	    	var Toast = Swal.mixin({
    		  toast: true,
    		  position: 'top-end',
    		  showConfirmButton: false,
    		  timer: 3000 //3초간 유지
    		});
    		
    		Toast.fire({
    			icon:'error',
    			title:'항목을 선택해주세요'
    		});
	    }
	});

// 전체 선택 체크박스
$('.check-btn.all').on('click',function(){
	if($(this).is(":checked")){
		$('.check-btn').prop("checked", true);
	}else {
		$('.check-btn').prop("checked", false);
	}
})

// 분류 조건 클릭 시 스타일 변화와 데이터 변화
$('.tap-cont').on('click', function(){
	currentPage=1;
	// 모든 tap-cont에서 active 클래스를 제거
    $('.tap-cont').removeClass('active');
    // 클릭된 tap-cont에 active 클래스를 추가
    $(this).addClass('active');
    
    let typeValue = $(this).data('approved');
    switch (typeValue) {
        case 'yes':
        case 'no':
        	$('#approvedType').val(typeValue);
            break;
        default:
        	eventType = '';
        	$('#approvedType').val('');
            break;
    }
    
    var selectedOptionText = $('#approvedType option:selected').text();
	$('#approvedType').parent().find('.select-selected').text(selectedOptionText);
    
    currentPage = 1;
    selectMngrAjax(currentPage);
})


/********************************************/
// 개발 로직
/********************************************/
// @url		    : /selectMngrAjax
// @author      : 정기쁨
// @date        : 2024.09.25
// @jsp         : hdofc/mngr/selectMngrList
// @description : 사원목록
function selectMngrAjax(currentPage){

	let data = getInputData(); // 새로운 함수 호출
	data.currentPage = currentPage;
    
    console.log("selectMngrAjax -> ", data);
	
	$.ajax({
		url : "/hdofc/mngr/selectMngrAjax",
		type : "GET",
		data : data,
		success : function(res){
			console.log(res);
			// 성공적으로 응답을 받았을 때 처리할 코드
            handleAjaxResponse(res);
		} // success	
	});	// ajax	
}
// selectNoticeAjax 종료

// @description  : success 한 경우 처리
function handleAjaxResponse(res) {
    // 탭 처리
    $("#tap-all").text(res.tapNum.MEM_COUNT);
    $("#tap-approved").text(res.tapNum.MNGR_COUNT);
    $("#tap-no-approved").text(res.tapNum.AUTH_COUNT);
    
    // 셀렉트 박스 처리
    updateSelectBoxes(res);
    // 테이블 처리
    updateTable(res);
}

// 셀렉트 박스 업데이트
function updateSelectBoxes(res) {

    let data = getInputData();
	
    // 거래처 셀렉트 박스
    let selectedCnpt = '';
	let cnptStr = `<option value="">전체</option>`; 
	res.selectCntpList.forEach( cntp => {
		
		selectedCnpt = data.cnpt;
		optionCnpt = cntp.bzentNm;
		
		if(selectedCnpt != optionCnpt){
			cnptStr += `
				<option value="${optionCnpt}">${optionCnpt}</option>
			`;
		}else {
			cnptStr += `
				<option value="${optionCnpt}" selected>${optionCnpt}</option>
			`;
		}
	}) //
    $(".select-cnpt").html(cnptStr);

    // 가맹점 셀렉트 박스
    let selectedFrcs = '';
	let frcsStr = `<option value="">전체</option>`; 
	res.selectFrcsList.forEach( frcs => {
		
		selectedFrcs = data.frcs;
		optionFrcs = frcs.bzentNm;
		
		if(selectedFrcs != optionFrcs){
			frcsStr += `
				<option value="${optionFrcs}">${optionFrcs}</option>
			`;
		}else {
			frcsStr += `
				<option value="${optionFrcs}" selected>${optionFrcs}</option>
			`;
		}
	}) //
	$(".select-frcs").html(frcsStr);

    // 담당자 셀렉트 박스
    let selectedMbrId = '';
	let mbrIdStr = `<option value="">전체</option>`; 
	res.selectMngrList.forEach( mngrVO => {
		
		selectedMbrId = data.mngrId;
		optionMbrId = mngrVO.mngrId;
		mbrNm = mngrVO.memberVO.mbrNm;
		
		if(selectedMbrId != optionMbrId){
			mbrIdStr += `
				<option value="${optionMbrId}">${mbrNm}(${optionMbrId})</option>
			`;
		}else {
			mbrIdStr += `
				<option value="${optionMbrId}" selected>${mbrNm}(${optionMbrId})</option>
			`;
		}
	}) 
    $(".select-mngrId").html(mbrIdStr);
}

// 테이블 업데이트
function updateTable(res) {
    let strTbl = '';
    
    // 검색 결과 없는 경우
    if (res.articlePage.total === 0) {
	    // 탭 처리
    	$("#tap-all").text('0');
    	$("#tap-approved").text('0');
    	$("#tap-no-approved").text('0');
    
        strTbl += `
            <tr>
                <td class="error-info" colspan="9">
                    <span class="icon material-symbols-outlined">error</span>
                    <div class="error-msg">검색 결과가 없습니다</div>
                </td>
            </tr>
        `;
        $('#table-body').html(strTbl);
        $('.pagination').html('');
    } else {
    	
    	// 검색 결과 있는 경우
        res.articlePage.content.forEach(list => {
        	
        	let jncmpYmd = '';
            let frcsNames = list.frcsNames;
            let cnptNames = list.cnptNames;
            let hdofYn = list.hdofYn === 'Y' ? '재직' : ( list.hdofYn === 'N' ? '퇴직' : '-');
        	
        	if(list.jncmpYmd){
	            jncmpYmd = list.jncmpYmd.substr(0, 4) + '-' + list.jncmpYmd.substr(4, 2) + '-' + list.jncmpYmd.substr(6, 2);
        	}else {
        		jncmpYmd = '-';
        	}
			
            strTbl += `
            <tr>
            	<td class="right">
					<input type="checkbox" class="check-btn" id="chkBox${list.rnum}" name="chkBox${list.rnum}" value="${list.memberVO.mbrId}" />
			    	<label for="chkBox${list.rnum}"><span></span></label>
				</td>
            	<td class="center" style="width: 100px">${list.rnum}
        	</td>`;
            
            if(list.mngrType == null){
	            strTbl += `<td class="center" style="width: 60px">${list.memberVO.mbrNm}</td>`;
            } else {
            	strTbl += `
                    <td class="center" style="width: 60px">
                    	<a href="/hdofc/mngr/selectMngrDtl?mngrId=${list.mngrId}">${list.memberVO.mbrNm}</a></a>
                	</td>						
            	`;
            }
            
            strTbl += `<td class="center" style="width: 100px">${list.memberVO.mbrId}</td>`;
            
            
            // 가맹점 처리
            if(!frcsNames){
            	strTbl += `<td class="left" style="min-width: 300px">-</td>`;
            } 
            else if(frcsNames && frcsNames.length > 30) {
            	strTbl += `
            		<td style="max-width: 300px">
            			<div style="white-space:nowrqp; overflow:hidden; text-overflow:ellipsis;">
            				<button type="button" class="tooltip-custom"
								data-bs-toggle="tooltip"
								title="${frcsNames}">
								<span class="tooltip-icon material-symbols-outlined">info</span>
							</button>
            				${frcsNames}
            			</div>
            		</td>
            	`;
            } 
            else if(frcsNames && frcsNames.length < 30) {
            	strTbl += `<td class="left" style="min-width: 300px">${frcsNames}</td>`;
            }
            
            // 거래처 처리
	        if(!cnptNames){
            	strTbl += `<td class="left" style="min-width: 300px">-</td>`;
            }     
	        else if(cnptNames && cnptNames.length > 30){
            	strTbl += `
            		<td style="max-width: 300px">
            			<div style="white-space:nowrqp; overflow:hidden; text-overflow:ellipsis;">
            				<button type="button" class="tooltip-custom"
								data-bs-toggle="tooltip"
								title="${cnptNames}">
								<span class="tooltip-icon material-symbols-outlined">info</span>
							</button>
            				${cnptNames}
            			</div>
            		</td>
            	`;
            } 
            else if(cnptNames && cnptNames.length < 30) {
        		strTbl += `<td class="left" style="min-width: 300px">${cnptNames}</td>`;
            }
	            
            
            strTbl += `
            	 <td class="center" style="width: 100px">${hdofYn}</td>						
                 <td class="center" style="width: 100px">${jncmpYmd}</td>						
            `;
            
            // 관리자 유형 처리
            if(list.mngrType == 'HM01'){
				strTbl += `<td class="center" style="width: 200px"><span class="bge bge-active mngrType">일반</span></td>`	            	
            }
            else if(list.mngrType == 'HM02'){
				strTbl += `<td class="center" style="width: 200px"><span class="bge bge-info mngrType">최상위</span></td>`	            	
            }
            else if(list.mngrType == null){
				strTbl += `<td class="center" style="width: 200px"><span class="bge bge-danger mngrType">미승인</span></td>`	            	
            }
            
           	strTbl += `</tr>`;
            
        });
        $('.mngrList-table').html(strTbl);
        
        // 툴팁 띄우기
		tooltipCustom();
        
        // 페이징 처리
        updatePagination(res);
    }
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


// 승인 설정
function updateAuthAjax(selectedArr){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	console.log("deleteFixd() => ",selectedArr);
	
	let data = {};
	data.selectedArr = selectedArr; // ['1', '2', '3']
	console.log(data);
	
	$.ajax({
      url: "/hdofc/mngr/updateAuthAjax",
	    type: "POST",
	    data: JSON.stringify(selectedArr),
	    contentType: 'application/json',
			dataType:"text",
			beforeSend:function(xhr){ 
				xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
			},
      success: function(res) {
	        Toast = toastAlert();
			Toast.fire({
				icon:'success',
				title:'승인이 완료 되었습니다!'
			});
	    
			// 1초 후에 페이지 새로고침
			setTimeout(function() {
			    location.reload();
			}, 1000); 
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 오류:', error);  // 에러 처리
            alert('서버와의 통신에 문제가 발생했습니다.');
        }
    }); //. ajax
	
}













