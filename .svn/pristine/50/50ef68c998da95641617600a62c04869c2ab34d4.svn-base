/*******************************************
  @fileName    : notice.js
  @author      : 정기쁨
  @date        : 2024. 09. 17
  @description : 이벤트 관리를 위한 코드 모음
********************************************/

/*******************************************/
function getCsrfTokens() {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    
    return { csrfToken, csrfHeader };
}

// 업데이트 성공 시 토스트ui
function toast(){
	var Toast = Swal.mixin({
	  toast: true,
	  position: 'top-end',
	  showConfirmButton: false,
	  timer: 3000 //3초간 유지
	});
	
	return Toast;
}
/********************************************/
// @url		    : /selectNoticeAjax
// @author      : 정기쁨
// @date        : 2024.09.25
// @jsp         : hdofc/notice/selectNotice
// @description : 공지사항 조회
function selectNoticeAjax(){
	
	var ntcTtl= $('#ntcTtl').val();
	var ntcCn= $('#ntcCn').val();
	var mngrId = $('#mngrId').val();
	var startWrtrDt= $('#startWrtrDt').val();
	var endWrtrDt= $('#endWrtrDt').val();
	
	let data = {};

	// 값이 빈 문자열이 아니면 data 객체에 추가
	if (ntcTtl) {data.ntcTtl = ntcTtl;}
	if (ntcCn) {data.ntcCn = ntcCn;}
	if (mngrId) {data.mngrId = mngrId;}
	if (startWrtrDt) {data.startWrtrDt = startWrtrDt;}
	if (endWrtrDt) {data.endWrtrDt = endWrtrDt;}
	
	data.currentPage = currentPage;
	data.sort = sort;
	data.orderby = orderby;
	
	console.log("selectNoticeAjax => ",data);
	
	$.ajax({
		url : "/hdofc/notice/selectNoticeAjax",
		type : "GET",
		data : data,
		success : function(res){
			console.log(res);
			console.log(res.articlePage.total);
			
			// 탭 처리--------------------------------------------------------------------------------------------------------
			$("#tap-all").text(res.all);
			
			// 설렉트 박스 처리--------------------------------------------------------------------------------------------------------
			let selectedMbrId = '';
			let optiondStr = `<option value="">전체</option>`; 
			res.mngrVOList.forEach( mngrVO => {
				
				selectedMbrId = data.mngrId;
				optionMbrId = mngrVO.mngrId;
				mbrNm = mngrVO.memberVO.mbrNm;
				
				console.log("selectedMbrId => ",selectedMbrId);
				console.log("optionMbrId => ",optionMbrId);
				console.log("mbrNm => ",mbrNm);
				
				if(selectedMbrId != optionMbrId){
					optiondStr += `
						<option value="${optionMbrId}">${mbrNm}(${optionMbrId})</option>
					`;
				}else {
					optiondStr += `
						<option value="${optionMbrId}" selected>${mbrNm}(${optionMbrId})</option>
					`;
					
					$('#mngrId').data('mbrNm', mbrNm);
				}
			}) // 1. res.mngrVOList.forEach
			
			$(".select2-custom").html(optiondStr);
	
			// 테이블 처리--------------------------------------------------------------------------------------------------------
			let strTbl = '';
			
			// 검색 결과가 없는 경우
			console.log("es.articlePage.total => ",res.articlePage.total)
			
			if(res.articlePage.total == 0){
				strTbl+= `
					<tr>
						<td class="error-info" colspan="7">
							<span class="icon material-symbols-outlined">error</span>
							<div class="error-msg">검색 결과가 없습니다</div>
						</td>
					</tr>
				`;
				
				$('#table-body').html(strTbl);
				$('.pagination').html('');
				
			} else { //검색결과 있는 경우
			
				// 상단 고정인 경우 --------------------------------------------------------------------------------------------
				res.fixList.forEach( list => {
					
					wrtrDt = list.wrtrDt.substr(0,4)+'-'+list.wrtrDt.substr(4,2)+'-'+list.wrtrDt.substr(6,2);
					inqCnt = list.inqCnt > 0 ? list.inqCnt : '-' ;
					ntcSeq = list.ntcSeq;
					let fileGroupNo = '';
					let fileSaveLocate = '';
					let fileOriginalName = '';
					
					list.fileDetailVOList.forEach(fileDetail => {
						fileGroupNo = fileDetail.fileGroupNo;
					 	fileSaveLocate = fileDetail.fileSaveLocate;	
					 	 console.log(fileSaveLocate);
					}) // 3. list.fileDetailVOList.forEach
							
		    		strTbl += `
							<tr>
								<td class="right py-10">
									<input type="checkbox" class="check-btn" id="chkBox${ntcSeq}" name="chkBox${ntcSeq}" value="${ntcSeq}" />
							       <label for="chkBox${ntcSeq}"><span></span></label>
								</td>
								<td class="center"><span class="icon material-symbols-outlined fix-icon">Keep</span> </td>
								<td class="py-10">
									<a href="/hdofc/notice/selectNoticeDetail?ntcSeq=${ntcSeq}">${list.ntcTtl}</a>
								</td>
								<td class="center py-10">${list.memberVO.mbrNm}</td>
								<td class="center py-10">${wrtrDt}</td>
								<td class="center py-10">${inqCnt}</td>
					`; // 3
					/*		
					if(fileSaveLocate != null) {
						strTbl += `
							<td class="center py-10">
                                <button type="button" class="btn btn-download"  id="downloadBtn" data-file-locate="${fileSaveLocate}" data-file-name="${fileOriginalName}">
                                    다운로드<span class="icon material-symbols-outlined">Download</span> 
                                </button>
                            </td>
						`;
					} else {
						strTbl += `
							<td class="center py-10">
								<button type="button" class="btn btn-disabled">
								 	다운로드<span class="icon material-symbols-outlined" style="color: var(--text--placeholder);">Download</span> 
								</button>
							</td>
						`;
					} // 3
					*/
					strTbl += `</tr>`;
                }) // fixList
					
                // 전체 조회 (고정x) --------------------------------------------------------------------------------------------
                res.articlePage.content.forEach(list => {
                
                    wrtrDt = list.wrtrDt.substr(0,4)+'-'+list.wrtrDt.substr(4,2)+'-'+list.wrtrDt.substr(6,2);
                    inqCnt = list.inqCnt > 0 ? list.inqCnt : '-' ;
                    ntcSeq = list.ntcSeq;
                    let fileGroupNo = '';
                    let fileSaveLocate = '';
                    
                    list.fileDetailVOList.forEach(fileDetail => {
                        fileGroupNo = fileDetail.fileGroupNo;
                        fileSaveLocate = fileDetail.fileSaveLocate;
                        fileOriginalName = fileDetail.fileOriginalName;
                        console.log(fileSaveLocate);
                    }) // 3. list.fileDetailVOList.forEach
                            
                    strTbl += `
                        <tr>
                            <td class="right py-10">
                                <input type="checkbox" class="check-btn" id="chkBox${ntcSeq}" name="chkBox${ntcSeq}" value="${ntcSeq}" />
                                <label for="chkBox${ntcSeq}"><span></span></label>
                            </td>
                            <td class="center py-10">${list.rnum}</td>
                        <td>
                            <a href="/hdofc/notice/selectNoticeDetail?ntcSeq=${ntcSeq}">${list.ntcTtl}</a>
                        </td>
                        <td class="center py-10">${list.memberVO.mbrNm}</td>
                        <td class="center py-10">${wrtrDt}</td>
                        <td class="center py-10">${inqCnt}</td>
                    `; // 3
                     
                     /*       
                    if(fileSaveLocate != null) {
                        strTbl += `
                            <td class="center py-10">
                                <button type="button" class="btn btn-download"  id="downloadBtn" data-file-locate="${fileSaveLocate}" data-file-name="${fileOriginalName}">
                                    다운로드<span class="icon material-symbols-outlined">Download</span> 
                                </button>
                            </td>
                        `;
                    } else {
                        strTbl += `
                            <td class="center py-10">
                                <button type="button" class="btn btn-disabled">
                                    다운로드<span class="icon material-symbols-outlined">Download</span> 
                                </button>
                            </td>
                        `;
                    } // 3
                    */
                    strTbl += `</tr>`;
                        
                   $('#table-body').html(strTbl);
                        
                }); // 2. 전체조회 (고정x)
                        
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
            
            } // else
		} // success	
	});	// ajax	
}
// selectNoticeAjax 종료

// @url		    : /noticeInsert
// @author      : 정기쁨
// @date        : 2024.09.26
// @jsp         : hdofc/notice/selectNotice
// @description : 공지사항 추가
function noticeInsert(){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	
	var formData = new FormData();
	formData.append("mngrId", mngrId);
	formData.append("ntcTtl", $('#ntcTtl').val());
	formData.append("ntcCn",$('#ntcCn').val());

	fixdSeq = $('#fixdSeq').is(':checked');
	if(fixdSeq){
		formData.append("fixdSeq","checked")
	}else {
		formData.append("fixdSeq","unchecked")
	}

	var inputFile = $("input[name='uploadFile']");
	if(inputFile){
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i =0;i<files.length;i++){
			formData.append("uploadFile", files[i]);
		}
	}
	
	for (const x of formData) {
	 console.log(x);
	};

	$.ajax({
		url: "/hdofc/notice/noticeInsert",
	    type: "POST",
	    data: formData,
		processData : false,
		contentType : false,
		dataType:"text",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res){
			// 알럿창
			Toast = toast();
			
			Toast.fire({
				icon:'success',
				title:'공지가 추가 되었습니다'
			});

			// 페이지 이동
			ntcSeq = res;
			setTimeout(function() {
			    window.location.href="/hdofc/notice/selectNoticeDetail?ntcSeq="+ntcSeq;
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

// @url		    : /hdofc/notice/selectNoticeList
// @author      : 정기쁨
// @date        : 2024.09.27
// @jsp         : hdofc/notice/selectNoticeList
// @description : 상단 고정 해체
function updateFixd(selectedArr) {
	
	const { csrfToken, csrfHeader } = getCsrfTokens();

	console.log("deleteFixd() => ",selectedArr);
	
	let data = {};
	data.selectedArr = selectedArr;
	
	console.log(data);


    $.ajax({
        url: "/hdofc/notice/updateFixd",
	    type: "POST",
	    data: JSON.stringify(selectedArr),
	    contentType: 'application/json',
		dataType:"text",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
        success: function(res) {
            Toast = toast();
			Toast.fire({
				icon:'success',
				title:'상단고정이 해체 되었습니다'
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
    });

}// 

// @url		    : /hdofc/notice/updateNoticeDtlAjax
// @author      : 정기쁨
// @date        : 2024.10.12
// @jsp         : hdofc/notice/updateNoticeDtlAjax
// @description : 공지사항 수정
function updateNoticeDtlAjax(){
	
	const { csrfToken, csrfHeader } = getCsrfTokens();
	
	var formData = new FormData();
	formData.append("ntcSeq", ntcSeq);
	formData.append("ntcTtl", $('#ntcTtl').val());
	formData.append("ntcCn",$('#ntcCn').val());
	
	fixdSeq = $('#fixdSeq').is(':checked');
	if(fixdSeq){
		formData.append("fixdSeq","checked")
	}else {
		formData.append("fixdSeq","unchecked")
	}
	
	if(deleteFileGroupNo){
		formData.append("fileGroupNo", deleteFileGroupNo);
	}
	
	var inputFile = $("input[name='uploadFile']");
	if(inputFile){
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i =0;i<files.length;i++){
			formData.append("uploadFile", files[i]);
		}
	}
	
	for (const x of formData) {
	 console.log(x);
	};

	$.ajax({
		url: "/hdofc/notice/updateNoticeDtlAjax",
	    type: "POST",
	    data: formData,
		processData : false,
		contentType : false,
		dataType:"text",
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success: function(res){
			// 알럿창
			Toast = toast();
			
			Toast.fire({
				icon:'success',
				title:'공지가 수정 되었습니다'
			});

			setTimeout(function() {
			    location.reload();
			}, 1000); 
			
		}, // success
		error: function(jqXHR, textStatus, errorThrown) {
	        // 에러 발생 시 페이지 새로고침
	        console.error('AJAX 요청 실패:', textStatus, errorThrown);
	        Swal.fire({
			  icon: "error",
			  title: "수정 실패",
		  	  showConfirmButton: false,
	  		  timer: 3000 //3초간 유지
			});
	    } // error
	}); // ajax
	
}

// @url		    : /noticeDelete
// @author      : 정기쁨
// @date        : 2024.09.23
// @jsp         : hdofc/event/selectNoticeDetail
// @description :공지사항 삭제
function noticeDelete(){
	const swalWithBootstrapButtons = Swal.mixin({
	  customClass: {
	    confirmButton: "btn-active",
	    cancelButton: "btn-danger"
	  },
	  buttonsStyling: false
	});
	swalWithBootstrapButtons.fire({
	  title: "공지사항을 삭제하시겠습니까?",
	  text: "삭제하면 복구할 수 없습니다",
	  icon: "warning",
	  showCancelButton: true,
	  confirmButtonText: "확인",
	  cancelButtonText: "취소",
	  reverseButtons: true
	}).then((result) => {
	  if (result.isConfirmed) {
	    
	    let data = {};
	    data.ntcSeq = ntcSeq; // 공지사항 삭제
	    
	    if(fileGroupNo!='0'){
		    data.fileGroupNo = fileGroupNo; // 파일그룹 삭제 (파일디테일 종속 삭제됨)
	    }
	    
	    console.log("noticeDelete: ",data);
	    
	    $.ajax({
	    	url: "/hdofc/notice/noticeDelete",
	    	data: data,
	    	type: "GET",
	    	success: function(res){
	    		console.log("noticeDelete",res);

	    		swalWithBootstrapButtons.fire({
			      title: "삭제 완료",
			      icon: "success",
			      showConfirmButton: false,
			      timer: 3000 //3초간 유지
			    });
	    		
				// 페이지 이동
				setTimeout(function() {
				    window.location.href="/hdofc/notice/selectNoticeList";
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
    	esult.dismiss === Swal.DismissReason.cancel
		}
		
	}); 
	
}

// @url		    : /download
// @author      : 정기쁨
// @date        : 2024.09.27
// @jsp         : hdofc/notice/selectNoticeList
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





