/*******************************************
  @fileName    : event.js
  @author      : 정기쁨
  @date        : 2024. 09. 17
  @description : 이벤트 관리를 위한 코드 모음
********************************************/
// jsp 에서 가져온 값
function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
     /** 여기를 바꿔주세요! => **/ const fields = ['eventType', 'bgngYmd', 'expYmd', 'couponGubun', 'mbrNm', 'eventTtl'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    data.currentPage = currentPage;

    return data; // data 객체 반환
}

// 공통된 데이터 입력 처리 함수
function setSummary(selector, value) {
    $(selector).text(value === '' ? '미선택' : value);
}

// 업데이트 성공 시 토스트ui
function toast(){
	var Toast = Swal.mixin({
	  toast: true,
	  position: 'top-end',
	  showConfirmButton: false,
	  timer: 3000 //3초간 유지
	});
	
	Toast.fire({
		icon:'success',
		title:'정보가 업데이트 되었습니다'
	});
}
/********************************************/

// @url		    : /selectEventAjax
// @author      : 정기쁨
// @date        : 2024.09.17
// @jsp         : hdofc/event/selectEventList
// @description : 이벤트 검색 조건에 따른 리스트 ajax 조회
function selectEventAjax(){
	
	let data = getInputData();
	
	console.log(data);
	
	// 서버전송
	$.ajax({
		url : "/hdofc/event/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			console.log(res);
			console.log(res.articlePage.total);

			// 테이블 처리
			let strTbl = '';
			
			// 검색 결과 없을 때
			if(res.articlePage.total == 0){ 
				strTbl+= `
					<table class="table-default">
						<thead>
							<tr>
								<th class="center" style="width: 3%">번호</th>
								<th style="width: 20%">제목</th>
								<th style="width: 3%">담당자</th>
								<th style="width: 5%">이벤트 쿠폰</th>
								<th class="center" style="width: 5%">이벤트 기간</th>
								<th class="center" style="width: 5%">등록일자</th>
								<th class="center" style="width: 3%">진행상태</th>
							</tr>
						</thead>
						<tbody id="table-body" class="table-error">
							<tr>
								<td class="error-info" colspan="7">
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
						</tbody>
					</table>
				`;
				
				$('.table-default').html(strTbl);
				$('.pagination').html('');
				
			} else { // 검색 결과 있을 때
			
			res.articlePage.content.forEach(list => {
			
				let couponNm = '';
				list.couponGroupVOList.forEach(couponGroupVO => {
					couponNm += couponGroupVO.couponNm ? couponGroupVO.couponNm : '-';
				});
			
	    		strTbl += `
					<tr class="eventDtl" data-event-no="${list.eventNo}">
						<td class="center">${list.rnum}</td>
						<td>
							${list.eventTtl}
						</td>
						<td class="center">${list.mbrNm}</td>
						<td>${couponNm}</td>
						<td class="center">${list.bgngYmd} ~ ${list.expYmd}</td>
						<td class="center">${list.wrtrYmd}</td>
						<td class="center">
						    <span class="bge 
						        ${list.comNm === '대기' ? 'bge-info' : 
						          list.comNm === '진행' ? 'bge-active' :
						          list.comNm === '예정' ? 'bge-warning' :
						          list.comNm === '종료' ? 'bge-danger' :
						          list.comNm === '취소' ? 'bge-danger' : 'bge-info'
						        }">
						        ${list.comNm}
						    </span>
						</td>
					</tr>
				`;
				
			});
			$('#table-body').html(strTbl);
			
			// 페이징 처리
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
		} // ajax
	});		
}
// selectEventAjax 종료

// @url		    : /menuModalAjax
// @author      : 정기쁨
// @date        : 2024.09.19
// @jsp         : hdofc/event/menuModalAjax
// @description : 쿠폰 모달창 조회
function menuModalAjax(){
	
	$.ajax({
		url : "/hdofc/event/menuModalAjax",
		type : "GET",
		data : {menuType: menuType},
		success : function(res){
			console.log(res);
			
			// 이벤트 타입 처리
			$('#tap-total').text(res.total);
			$('#tap-set').text(res.set);
			$('#tap-hambur').text(res.hambur);
			$('#tap-side').text(res.side);
			$('#tap-drink').text(res.drink);
			
			let str = `
				<thead>
					<tr>
						<th class="center" style="width:15%">번호</th>
						<th style="width:60%">메뉴</th>
						<th style="width:21%">가격</th>	
				    </tr>
				</thead>
				<tbody>
			`;
			
			res.menuVOList.forEach( (menuVO, index) => {
				let menuAmt = menuVO.menuAmt.toLocaleString(); 
			
				str += `
					<tr id="menuNo" data-no="${menuVO.menuNo}" data-nm="${menuVO.menuNm}" data-dismiss="modal">
						<td class="center" id="rnum" style="width:15%">${index + 1}</td>
						<td id="menuNm" style="width:60%"><img src="${menuVO.menuImgPath}" class="menu-img" /> ${menuVO.menuNm}</td>
						<td class="right" id="menuAmt" style="width:23%">${menuAmt}</td>
					</tr>
				`;
			})
			
			str += `</tbody>`;
			
			
			$('.event-menu-table').html(str);
			
		} // success
	});	// ajax	

}
// menuModalAjax 종료

// @url		    : /eventInsert
// @author      : 정기쁨
// @date        : 2024.09.22
// @jsp         : hdofc/event/selectEventList
// @description : 이벤트 등록
function eventInsert(){
	
	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	var formData = new FormData();
	formData.append("mngrId", mngrId);
	formData.append("eventTtl", $('#eventTtl').val());
	formData.append("bgngYmd",$('#bgngYmd').val());
	formData.append("expYmd",$('#expYmd').val());
	formData.append("dscntAmt",$('#dscntAmt').val());
	formData.append("issuQty",$('#issuQty').val());
	formData.append("menuNo",$('#menuNo').val());
	formData.append("eventCn",$('#eventCn').val());
	formData.append("couponNm",$('#couponNm').val());
	formData.append("issuQty",$('#issuQty').val());

/*
	var inputFile = $("input[name='uploadFile']");
	if(inputFile){
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i =0;i<files.length;i++){
			formData.append("uploadFile", files[i]);
		}
	}
*/	
	if(saveFiles){
		saveFiles.forEach (file => {
			formData.append("uploadFile", file);
		}) 
	}

	for (const x of formData) {
	 console.log(x);
	};
	
	$.ajax({
		url: "/hdofc/event/eventInsert",
	    type: "POST",
	    data: formData,
		processData : false,
		contentType : false,
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res){
			console.log(res);
			eventNo = res;
			toast();
			// 페이지 이동
			setTimeout(function() {
			    window.location.href="/hdofc/event/selectEventDetail?eventNo="+eventNo;
			}, 1000); 
			
		}, // success
		error: function(jqXHR, textStatus, errorThrown) {
	        // 에러 발생 시 페이지 새로고침
	        console.error('AJAX 요청 실패:', textStatus, errorThrown);
	        Swal.fire({
			  icon: "error",
			  title: "저장 실패",
		  	  showConfirmButton: false,
	  		  timer: 3000 //3초간 유지
			});
	    } // error
	}); // ajax
}

// @url		    : /updateEventDtlAjax
// @author      : 정기쁨
// @date        : 2024.09.21
// @jsp         : hdofc/event/selectEventDetail
// @description : 일반관리자가 이벤트를 수정(업데이트)하는 이벤트 
function updateEventDtlAjax(){

	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	var formData = new FormData();
	formData.append("eventNo", eventNo);
	formData.append("eventTtl", $('#eventTtl').val());
	formData.append("bgngYmd",$('#bgngYmd').val());
	formData.append("expYmd",$('#expYmd').val());
	formData.append("dscntAmt",$('#dscntAmt').val());
	formData.append("issuQty",$('#issuQty').val());
	formData.append("menuNo",$('#menuNo').val());
	formData.append("eventCn",$('#eventCn').val());
	formData.append("couponNm",$('#couponNm').val());
	
	console.log(deleteFileGroupNo);
	if(deleteFileGroupNo){
		formData.append("fileGroupNo", deleteFileGroupNo);
	}
	
	if(saveFiles){
		saveFiles.forEach (file => {
			formData.append("uploadFile", file);
		}) 
	}
	
	for (const x of formData) {
	 console.log(x);
	};

	$.ajax({
		url: "/hdofc/event/updateEventDtlAjax",
	    type: "POST",
	    data: formData,
		processData : false,
		contentType : false,
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res){
			console.log("updateEventDtlAjax => ",res);
			toast();
			// 1초 후에 페이지 새로고침
			
			setTimeout(function() {
			    location.reload();
			}, 1000); 
			
		},  // success
		error: function(jqXHR, textStatus, errorThrown) {
	        // 에러 발생 시 페이지 새로고침
	        console.error('AJAX 요청 실패:', textStatus, errorThrown);
	        Swal.fire({
			  icon: "error",
			  title: "저장 실패",
		  	  showConfirmButton: false,
	  		  timer: 3000 //3초간 유지
			});
	    } // error
	}); // ajax

} // updateEventDtlAjax

// @url		    : /updateEventAjax
// @author      : 정기쁨
// @date        : 2024.09.20
// @jsp         : hdofc/event/selectEventDetail
// @description : 이벤트 승인 또는 반려 처리
function updateEventAjax(){

	const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	
	let aprvYn = $('#aprvYn').val();
	let rjctRsn = $('#rjctRsn').val();
	
	let data = {};
	data.aprvYn = aprvYn;
	data.rjctRsn = rjctRsn;
	data.eventNo = eventNo;
	
	console.log(data);
	
	$.ajax({
	    url: "/hdofc/event/updateEventAjax",
	    type: "POST",
	    contentType: "application/json",
	    data: JSON.stringify(data),
	    beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
	    success: function(res) {
			toast();
			// 1초 후에 페이지 새로고침
			setTimeout(function() {
			    location.reload();
			}, 1000); 
	    },
	    error: function(xhr, status, error) {
	        console.log("Ajax 오류: ", error);
	    }
	});
	
}
// updateEventAjax 종료

// @url		    : /selectFileImgList
// @author      : 정기쁨
// @date        : 2024.09.22
// @jsp         : hdofc/event/selectEventDetail
// @description : 파일 이미지 불러오기
function selectFileImgList(eventNo){
	console.log(eventNo);
	/*
	$.ajax({
		url: "/hdofc/event/selectFileImgList",
		data: {eventNo : eventNo},
		type: "GET",
		success: function(res){
			console.log(res);
			res.forEach(eventVO => {
				// 파일 출력
				eventVO.fileDetailVOList.forEach(fileDetailVO => {
					fileSaveLocate = fileDetailVO.fileSaveLocate;
					fileSn = fileDetailVO.fileSn; 
					fileGroupNo = fileDetailVO.fileGroupNo;
					let imgStr = `
						<img alt="파일이미지" src="${fileSaveLocate}" style="max-height:100px;max-width:100px">
					`;
					$('.file-cont').append(imgStr);
				}) // fileDetailVO
				// 버튼 출력
				let btnStr = `<button type="button" id="fileDelete" class="btn-default mb-2" data-file-group-no="${fileGroupNo}" data-file-sn="${fileSn}" style="display:none; width: fit-content;">삭제</button>`;
				$('.file-wrap').append(btnStr);
			}) // res
		} // success
	}) // ajax
	*/
}

// @url		    : /eventDelete
// @author      : 정기쁨
// @date        : 2024.09.23
// @jsp         : hdofc/event/selectEventDetail
// @description : 이벤트 삭제
function eventDelete(){
	const swalWithBootstrapButtons = Swal.mixin({
	  customClass: {
	    confirmButton: "btn-active",
	    cancelButton: "btn-danger"
	  },
	  buttonsStyling: false
	});
	swalWithBootstrapButtons.fire({
	  title: "이벤트를 삭제하시겠습니까?",
	  text: "삭제하면 복구할 수 없습니다",
	  icon: "warning",
	  showCancelButton: true,
	  confirmButtonText: "확인",
	  cancelButtonText: "취소",
	  reverseButtons: true
	}).then((result) => {
	  if (result.isConfirmed) {
	    
	    let data = {};
	    data.eventNo = eventNo; // 이벤트 삭제 (쿠폰그룹 종속 삭제됨) 
	    data.fileGroupNo = fileGroupNo; // 파일그룹 삭제 (파일디테일 종속 삭제됨)
	    
	    console.log("eventDelete: ",data);
	    
	    $.ajax({
	    	url: "/hdofc/event/eventDelete",
	    	data: data,
	    	type: "GET",
	    	success: function(res){
	    		console.log("eventDelete",res);

	    		swalWithBootstrapButtons.fire({
			      title: "삭제 완료",
			      icon: "success",
			      showConfirmButton: false,
			      timer: 3000 //3초간 유지
			    });
	    		
				// 페이지 이동
				setTimeout(function() {
				    window.location.href="/hdofc/event/selectEventList";
				}, 1000); 
	    		
	    	}, // success
			error: function(jqXHR, textStatus, errorThrown) {
		        // 에러 발생 시 페이지 새로고침
		        console.error('AJAX 요청 실패:', textStatus, errorThrown);
		        Swal.fire({
				  icon: "error",
				  title: "삭제 실패",
				  text: "다시 시도해주세요",
			  	  showConfirmButton: false,
		  		  timer: 3000 //3초간 유지
				});
		    } // error
	    })//ajax
	    
	  } else {
	    result.dismiss === Swal.DismissReason.cancel
  		}
	});
}

// @url		    : /eventDelete
// @author      : 정기쁨
// @date        : 2024.09.23
// @jsp         : hdofc/event/selectEventDetail
// @description : 이벤트 삭제
function selectCouponList(){
	let couponCode = $('#couponCode').val();
	console.log("couponCode => ",couponCode);

	$.ajax({
		url: "/hdofc/event/selectCouponList",
		data: {couponCode : couponCode},
		type: "GET",
		success: function(res) {
			console.log("couponList",res);
		
			// 쿠폰발급 총 갯수
			$('.coupon-total').text(res.total);
		
			let index = '';
			let mbrNm = '';
			let mbrId = '';
			let useYmd = '';
			let useYn = '';
			let frcsNm = '';
			let couponStr = '';
			
			if(res.total > 0){
				console.log("res.memberVOList",res.memberVOList);
				res.memberVOList.forEach( (memberVO,index) =>{
					mbrNm = memberVO.mbrNm;
					mbrId = memberVO.mbrId;
					frcsNm = memberVO.bzentVO.bzentNm ? memberVO.bzentVO.bzentNm : '-';
					memberVO.couponVOList.forEach(couponVO => {
						useYmd = couponVO.useYmd ? couponVO.useYmd.substr(0,4)+'-'+couponVO.useYmd.substr(4,2)+'-'+couponVO.useYmd.substr(6,2) : '-';
						console.log("couponVO.useYn ", couponVO.useYn );
						useYn = couponVO.useYn == 'Y' ? `<span class="bge bge-active">사용</span>` : `<span class="bge bge-danger">미사용</span>`
												
						couponStr += `
							<tr>
								<td class="center" style="width: 15%">${index + 1}</td>
								<td class="center" style="width: 15%">${mbrNm}</td>
								<td style="width: 15%">${mbrId}</td>
								<td class="center" style="width: 15%">${useYmd}</td>
								<td>${frcsNm}</td>
								<td class="center" style="width: 22%">${useYn}</td>
							</tr>
						`;
						$('.select-coupon-list').html(couponStr);
						
					}) // memverVO
				}) // res.forEach
			} else {
				couponStr += `
					<tr>
						<td class="error-info" colspan="6">
							<span class="icon material-symbols-outlined">error</span>
							<div class="error-msg">조회 결과가 없습니다</div>
						</td>
					</tr>
				`
				$('.select-coupon-list').html(couponStr);
			}
					
		} // success
	
	}) // ajax

}

// @url		    : /download
// @author      : 정기쁨
// @date        : 2024.09.27
// @jsp         : hdofc/event/selectEventDetail
// @description : 파일 다운로드
function fileDownloadAjax(fileSaveLocate, fileOriginalName){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	
	// 파일 다운로드를 위해 링크를 동적으로 생성
	const link = document.createElement('a');
	link.href = `/download?fileName=${fileSaveLocate}`;  // 서버에서 전달받은 다운로드 경로
	link.download = fileOriginalName; // 다운로드할 파일 이름 설정
	document.body.appendChild(link);
	link.click(); // 클릭하여 다운로드 시작
	document.body.removeChild(link); // 링크 제거
}









