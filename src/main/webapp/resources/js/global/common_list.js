/*******************************************
  @fileName    : ui.js
  @author      : 정기쁨
  @date        : 2024. 09. 28
  @description : 리스트 페이지에서 공통으로 사용 되는 js
********************************************/
// 페이지 시작 할 때 로드 되어야 하는 js
/*******************************************/
(function(){
	// 셀렉트 디자인 라이브러리
	select2Custom();
	// 사원 목록 조회
	selectMngrAjax();
})
/*******************************************/
// 변수 선언
/*******************************************/
var currentPage = 1;
var sortField = 'mngrTypeSort';
var orderby = 'desc';
// jsp 에서 가져온 값
function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
     /** 여기를 바꿔주세요! => **/ const fields = ['mngrId', 'frcs', 'cnpt', 'hdofYn', 'startJncmpYmd', 'endJncmpYmd', 'mngrType'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    // 항상 추가되는 값
    /** 여기를 바꿔주세요! => **/data.sort = sortField;
    /** 여기를 바꿔주세요! => **/data.orderby = 'desc';
    data.currentPage = currentPage;

    return data; // data 객체 반환
}
/*******************************************/
// 공통
/*******************************************/
// 검색버튼 클릭 시
$('#searchBtn').on('click',function(){
    selectMngrAjax();
})

// 페이징 처리
$(document).on('click','.page-link',function(){
	currentPage = $(this).data('page');
	selectMngrAjax();
})

// th 정렬 기능
$('.sort').on('click',function(){
	 // 정렬 색상 변경 이벤트 호출
	 thClickEvent($(this));
	 // 리스트 호출
	 selectMngrAjax();
})

// 요약보기[+] 버튼 클릭 시 이벤트
$('.search-toggle').on('click', function() {
	// 상세조건 토글 이벤트 호출
	searchToggle(this);
	
	// 각 input 필드의 값을 가져와서 data 객체에 추가
	/** 여기를 바꿔주세요! => **/ const fields = ['mngrId', 'frcs', 'cnpt', 'hdofYn', 'startJncmpYmd', 'endJncmpYmd'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        $(`#${field}Summary`).text(value ? value : '미선택');
    });
	
	/** 페이지 마다 달라지는 영역 
	// 재직/퇴직 요약 업데이트
    let hdofYnValue = $('#hdofYn').val();
    $('#hdofYnSummary').text(hdofYnValue === 'Y' ? '재직' : '퇴직');

    // 관리 유형 요약 업데이트
    let mngrType = $('#mngrType').val();
    $('#mngrNmSummary').text(mngrType === 'HM01' ? '일반관리자' : (mngrType === 'HM02' ? '최상위관리자' : '미선택'));
    **/
});

// 검색영역 초기화
$('.search-reset').on('click', function(){
	/** 페이지 마다 달라지는 영역 
	// 상세조건 초기화
	$('#mngrId, #frcs, #cnpt, #startJncmpYmd, #endJncmpYmd, #mngrType').val('');
	$('#mngrIdSummary, #frcsSummary, #cnptSummary, #jncmpYmdSummary, #mngrNmSummary').text('미선택');
	$('#hdofYn').val('Y'); // '재직'으로 설정
	$('#hdofYnSummary').text('재직');
	**/
	
	// 정렬 초기화 이벤트 호출
	/** 여기를 바꿔주세요! => **/ resetSort( $('.sort[data-sort="jncmpYmdSort"]'), $('.sort[data-orderby="desc"]') );
	
	// 리스트 호출
	selectMngrAjax();
})

// 전체 선택 체크박스
$('.check-btn.all').on('click',function(){
	if($(this).is(":checked")){
		$('.check-btn').prop("checked", true);
	}else {
		$('.check-btn').prop("checked", false);
	}
})
/********************************************/
// 개발 로직
/********************************************/
// @url		    : /selectMngrAjax
// @author      : 정기쁨
// @date        : 2024.09.25
// @jsp         : hdofc/mngr/selectMngrList
// @description : 사원목록
function selectMngrAjax(){

	let data = getInputData(); // 새로운 함수 호출
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
    $("#tap-all").text(res.all);
    // 셀렉트 박스 처리
    updateSelectBoxes(res);
    // 테이블 처리
    updateTable(res);
}

// 셀렉트 박스 업데이트
function updateSelectBoxes(res) {

    let data = getInputData();
	
	/** 페이지 마다 달라지는 영역 
    // 담당자 셀렉트 박스
    let selectedMbrId = '';
	let mbrIdStr = `<option value="">전체</option>`; 
	res.selectMngrList.forEach( mngrVO => {
		
		selectedMbrId = data.mngrId;
		optionMbrId = mngrVO.mngrId;
		mbrNm = mngrVO.mbrVO.mbrNm;
		
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
    */ 
}

// 테이블 업데이트
function updateTable(res) {
    let strTbl = '';
    
    if (res.articlePage.total === 0) {
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
        res.articlePage.content.forEach(list => {
        	
        	/** 페이지 마다 달라지는 영역 
            let jncmpYmd = list.jncmpYmd.substr(0, 4) + '-' + list.jncmpYmd.substr(4, 2) + '-' + list.jncmpYmd.substr(6, 2);
            let frcsNames = list.frcsNames !== null ? list.frcsNames : '-';
            let cnptNames = list.cnptNames !== null ? list.cnptNames : '-';
            let hdofYn = list.hdofYn === 'Y' ? '재직' : '퇴직';
            let mngrType = list.mngrType === 'HM01' ? '일반관리자' : '최상위관리자';

            strTbl += `
                <tr>
                    <td class="right py-10" style="width: 50px">
                        <input type="checkbox" data-mngr-id="${list.mngrId}" class="check-btn" id="chkBox${list.rnum}" name="chkBox${list.rnum}" value="${list.rnum}" />
                        <label for="chkBox${list.rnum}"><span></span></label>
                    </td>
                    <td class="center" style="width: 60px">${list.rnum}</td>						
                    <td class="center" style="width: 60px">${list.mbrVO.mbrNm}</td>						
                    <td class="center" style="width: 100px">${list.mngrId}</td>						
                    <td class="left" style="min-width: 300px">${frcsNames}</td>						
                    <td class="left" style="min-width: 300px">${cnptNames}</td>						
                    <td class="center" style="width: 100px">${hdofYn}</td>						
                    <td class="center" style="width: 100px">${jncmpYmd}</td>						
                    <td class="center" style="width: 200px">${mngrType}</td>						
                </tr>
            `;
	     	*/
	     
        });
        $('#table-body').html(strTbl);
        
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
