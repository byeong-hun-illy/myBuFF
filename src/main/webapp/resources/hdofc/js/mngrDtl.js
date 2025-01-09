/*******************************************
  @fileName    : event.js
  @author      : 정기쁨
  @date        : 2024. 09. 28
  @description : 사원 관리를 위한 코드 모음
********************************************/
$(function(){
	// 셀렉트 디자인 라이브러리
	select2Custom();
	
	var modal = new bootstrap.Modal(document.getElementById('bzentInsert'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	// 업체 추가 선택 시 모달창
	$('.bzent-insert').on('click', function(){
		modal.show();
		selectBzentAjax();
	})

	// 모달 닫기
	$('.modal-close').on('click',function(){
		$('.warning').text('');
		modal.hide();
		mbrModal.hide();
	})
	
	// 모달창 검색
	$('.select-bzentType').on('click',function(){
		// 탭 조건 바꾸기
		let bzentType = $('#bzentType').val();
		$('.tap-cont').removeClass('active');
		if(bzentType == 'BZ_F'){
			$('.tap-cont[data-bzent-type="BZ_F"]').addClass('active');
		} else if(bzentType == 'BZ_C'){
			$('.tap-cont[data-bzent-type="BZ_C"]').addClass('active');
		} else {
			$('.tap-cont[data-bzent-type=""]').addClass('active');
		}
		// 리스트 호출
		selectBzentAjax();
	})
	$('#rgnNo').on('change',function(){
		 // 리스트 호출
		 selectBzentAjax();
	})
	$('#bzentNm').on('change',function(){
		 // 리스트 호출
		 selectBzentAjax();
	})
})
/*******************************************
 공통
*******************************************/
// 전체 선택 체크박스
$('.check-btn.all').on('click',function(){
	if($(this).is(":checked")){
		$('.check-btn').prop("checked", true);
	}else {
		$('.check-btn').prop("checked", false);
	}
})

// 탭 클릭 시 스타일 변화와 데이터 변화
$('.tap-cont').on('click', function(){
	currentPage=1;
	// 모든 tap-cont에서 active 클래스를 제거
    $('.tap-cont').removeClass('active');
    // 클릭된 tap-cont에 active 클래스를 추가
    $(this).addClass('active');
    
    let tapType = $(this).data('bzentType');
    switch (tapType) {
        case 'BZ_F': $('#bzentType').val(tapType);  break;
        case 'BZ_C': $('#bzentType').val(tapType);  break;
        default:
        	tapType = '';
        	$('#bzentType').val('');
            break;
    }
    // 셀렉트 박스에 값 넣기
    var selectedOptionText = $('#bzentType option:selected').text();
	$('#bzentType').parent().find('.select-selected').text(selectedOptionText);
	
	selectBzentAjax();
})

// th 정렬 기능
$('.sort').on('click',function(){
	 // 정렬 색상 변경 이벤트 호출
	 sort = $(this);
	 thClickEvent(sort);
	 // 리스트 호출
	 selectBzentAjax();
})
/*******************************************
 업체 삭제
*******************************************/
$('.bzent-delete').on('click',function(){
	var selectedArr = [];

	// 전체 선택이 아닌 체크박스 값을 배열에 추가
    $('.check-btn:checked').not('.check-btn.all').each(function() {
		selectedArr.push($(this).val());
    });
    
    // 배열이 비어 있지 않으면 AJAX 호출
    if (selectedArr.length > 0) {
    	deleteMngrBzent(selectedArr);
    } else {
    	toastAlert();
		Toast.fire({
			icon:'error',
			title:'항목을 선택해주세요'
		});
    }
    
    console.log("selectedArr => ",selectedArr);
})

/*******************************************
 변수 선언
*******************************************/
let sort = 'bzentNm'; 
let orderby = 'asc';

function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
    const fields = ['bzentType', 'rgnNo', 'bzentNm'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    data.sort = sort; 
    data.orderby = orderby;

    return data; // data 객체 반환
}
/*******************************************/
// 개발 로직
/*******************************************/
// @url		    : /selectBzentAjax
// @author      : 정기쁨
// @date        : 2024.09.25
// @jsp         : hdofc/mngr/selectMngrList의 모달창 bzentListModal
// @description : 사원목록
function selectBzentAjax(){

    const { csrfToken, csrfHeader } = getCsrfTokens();

	let data = getInputData(); // 새로운 함수 호출
    console.log("selectBzentAjax -> ", data);
	
	$.ajax({
		url : "/hdofc/mngr/selectBzentAjax",
		type : "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
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
    $("#tap-all").text(res.totalNum);
    $("#tap-frcs").text(res.frcsNum);
    $("#tap-cntp").text(res.cntpNum);
    
    // 테이블 처리
    updateTable(res);
}

// 테이블 업데이트
function updateTable(res) {
    let strTbl = '';
    
    if (res.bzentVOList === 0) {
        strTbl += `
            <tr>
                <td class="error-info" colspan="5">
                    <span class="icon material-symbols-outlined">error</span>
                    <div class="error-msg">검색 결과가 없습니다</div>
                </td>
            </tr>
        `;
        $('#table-body').html(strTbl);
    } else {
        res.bzentVOList.forEach( (list, idx) => {
            let bzentType = list.bzentType === 'BZ_F01' ? '<span class="bge bge-info">가맹점</span>' : '<span class="bge bge-warning">거래처</span>';
            let bzentNo = list.bzentNo;
            
            strTbl += `
                <tr onclick="updateMngrBzent('${bzentNo}')">
                    <td class="center" style="width: 147px;">${idx+1}</td>						
                    <td class="left" style="width: 309px;">${list.bzentNm}</td>						
                    <td class="center" style="width: 147px;">${list.rgnNm}</td>						
                    <td class="center" style="width: 237px;">${list.memberVO.mbrNm}</td>						
                    <td class="right" style="width: 237px;padding-right: 81px;">${bzentType}</td>						
                </tr>
            `;
        });
        $('.bzent-list-tbody').html(strTbl);
        
    }
}

// 업체 추가
function updateMngrBzent(bzentNo){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();

	mngrId = $('.mngrId').text();
	console.log(mngrId , bzentNo);
	
	let data = {};
	data.mngrId = mngrId;
	data.bzentNo = bzentNo;
	
	$.ajax({
		url : "/hdofc/mngr/updateMngrBzent",
		type : "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			Toast = toastAlert();
			Toast.fire({
				icon:'success',
				title:'담당 업체가 변경 되었습니다!'
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
	})
}

// 업체 삭제
function deleteMngrBzent(selectedArr){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	console.log("deleteFixd() => ",selectedArr);

	mngrId = $('.mngrId').text();
	
	let data = {};
	data.mngrId = mngrId;
	data.selectedArr = selectedArr;
	
	console.log(data)


	$.ajax({
		url : "/hdofc/mngr/deleteMngrBzent",
		type : "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			Toast = toastAlert();
			Toast.fire({
				icon:'success',
				title:'담당 업체가 변경 되었습니다!'
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
	})

}































