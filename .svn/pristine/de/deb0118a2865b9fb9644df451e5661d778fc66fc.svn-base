 <meta name="_csrf" content="${_csrf.token}"> 
 <meta name="_csrf_header" content="${_csrf.headerName}"> 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="/resources/cust/css/selectBoard.css" rel="stylesheet">
<style>
/* 1:1문의 */
 #qsInsertBtn2{ 
    background: var(--green--5);
    border-radius: 10px;
    color: white;
   	cursor: pointer;
	width: 160px;
    height: 50px;
    line-height: 48px;
    font-size: 0.875rem;
    margin: 50px auto;
    text-align: center;
}

#deleteBtn, #cancelBtn{
	border-radius: 10px;
    color: white;
   	cursor: pointer;
	width: 160px;
    height: 50px;
    line-height: 34px;
    font-size: 0.875rem;
    margin: 50px 30px;
    text-align: center;
    color: black;

}

#modeBtn, #updateBtn {
    background: var(--green--5);
    border-radius: 10px;
    color: white;
    cursor: pointer;
    width: 160px;
    height: 50px;
    line-height: 32px;
    font-size: 0.875rem;
    margin: 50px 30px;
    text-align: center;
}


.btn_area {
    margin: 10px auto;
    display: flex;
    justify-content: center;
    gap: 10px;
}

.qsItem{
	cursor: pointer;
}


.faqCon{
	display : flex;
	justify-content: space-between;
	width: 100%;
}

.noticeCont{
	display : flex;
	justify-content: space-between;
	width: 100%;
}

.accordion-body{
    overflow: auto;
    text-align: left;
    padding: 0px 50px;
    line-height: 24px;
    color: black;
}

#div1{
	margin: 0px auto;
}

/* 셀렉트 커스텀 */
.select2-selection[aria-labelledby="select2-faqCategory-container"] { 
	width: 200px !important;
}
.select2-selection[aria-labelledby="select2-faqCategory-container"] .select2-dropdown {
	width: 198px !important;
}



</style>
<sec:authorize access="isAuthenticated()"> 
    <sec:authentication property="principal.memberVO" var="user" />
</sec:authorize> 

<script type="text/javascript">

let mbrId = "${user.mbrId}";

let urlParams = new URLSearchParams(window.location.search);
let tap = urlParams.get('tap') || 'noticeTap'; // 기본 값 설정


$(document).ready(function() {
	//내용 자동 채우기
	
	$(document).on("click","#divAuto",function(){
		console.log("자동완성");
		// 카테고리
		$("#category option:eq(0)").removeAttr("selected");
		$("#category option:eq(1)").attr("selected",true);
	    $('#category').next().text("구매");
	    
		// 제목
		$("#qa_subject").val("구매문의 드립니다.");
		
		// 내용
		$("textarea[name='cont']").val("대량 구매 가능한가요?");
		
		
	});
	
	// select 라이브러리
	select2Custom();
	
    // 초기 탭 표시
    showTabContent(tap);

    // 탭 클릭 이벤트 처리
    $('.lef_menu ul li').on('click', function (e) {
        e.preventDefault(); // 기본 동작 방지
        let selectedTap = $(this).attr('id');
        
        console.log("selectedTap : " + selectedTap);

        // URL 파라미터 갱신 (페이지 리로드 없이)
        let newUrl = new URL(window.location.href);
        newUrl.searchParams.set('tap', selectedTap);
        history.pushState({}, '', newUrl);

        // 탭에 맞는 내용 표시
        showTabContent(selectedTap);
    });

    // 탭 내용 표시 함수
    function showTabContent(tapId) {
    	console.log("성공");
        // 모든 테이블 숨기기
        $('#noticeListTable, #faqListTable, #qsListTable').hide();

        $('.lef_menu ul li').removeClass('on');
        // 선택된 탭에 맞는 테이블 보이기
        switch (tapId) {
            case 'noticeTap':
                $('#noticeTap').addClass('on');
                $('#noticeListTable').show();
                $('#qsInsert').hide();
                $("#qsUpdate").css("display","none");
                break;
            case 'faqTap':
                $('#faqTap').addClass('on');
                $('#faqListTable').show();
                $('#qsInsert').hide();
                $("#qsUpdate").css("display","none");
                break;
            case 'qsTap':
                $('#qsTap').addClass('on');
                $('#qsListTable').show();
                $('#qsInsert').hide();
                $("#qsUpdate").css("display","none");
                break;
            default:
                $('#noticeListTable').show(); // 기본값 설정
                $('#qsInsert').hide();
                $("#qsUpdate").css("display","none");
                break;
        }
    }
	
	$("#div2").hide();
	$("deleteFileDiv").hide();
	
	// 원래 데이터를 저장할 객체
	let originalData = {};
	
	// 수정 모드 버튼 클릭 시 동작
	$("#modeBtn").on("click", function() {
		console.log("수정 버튼 실행")
		// 수정 버튼 숨기고 확인, 취소, 삭제 버튼 보이기
		$("#div1").hide(); // div1 숨기기
		$("#div2").show(); // div2 보이기
		$("#deleteFileDiv").show(); // 수정 모드일 때만 파일 삭제 버튼 보이기
		
		console.log($("#qsSeq").val());

		console.log("Original Data2:", originalData);
		
		$("#qa_subject2").removeAttr("disabled");
		$("#cont2").removeAttr("disabled");
		
		//파일 존재 유무 체크
		let fileYn = $("#imagePreview").html();
		
		if(fileYn==""){//파일이 없다면
			$("#deleteFileBtn").css("display","none");
		}else{//파일이 있다면
			$("#deleteFileBtn").css("display","block");
		}
		
		$("#uploadFile2").css("display","block");
	}); // modeBtn 끝

	
	
	
	// 수정 모드에서 취소 버튼 클릭 시 수정 모드 종료
	$("#cancelBtn").on("click", function() {
	   
		console.log("cancelBtn->originalData : ", originalData);
		
		// 확인, 취소,삭제 버튼 숨기고 수정 버튼 보이기
	    console.log("취소 버튼 실행");
	    $("#div2").hide();
	    $("#div1").show();
	
	    // 기존 데이터로  복원
	    $('#qa_subject2').val(originalData.qsTtl); // 제목
	    $('#cont2').val(originalData.qsCn); // 내용

	    // 카테고리 기존 데이터로 초기화 
	    $('#category2').val(""); // select 값 초기화
	    $('#category2').val(originalData.qsType); // 기존 값 설정
	  	
	    var selectedOptionText = $('#category2 option:selected').text() // 카테고리 
	    $('#category2').parent().find('.select-selected').text(selectedOptionText);

	    $("#deleteFileBtn").css("display","none"); // 파일 삭제 버튼 숨기기
	    
	    //originalData.fileSaveLocate : undefined
	    console.log("originalData : ", originalData);
	    console.log("originalData.fileSaveLocate : ", originalData.fileSaveLocate);
	    
	    // 기존 미리보기 이미지 상태 복원
	    if (originalData.fileSaveLocate) {
	        $("#imagePreview").show();
	        $("#uploadFile_fileSaveLocate").attr("src", originalData.fileSaveLocate);
	        $("#upload_fileOriginalName").text(originalData.fileOriginalName);
	    } else {
	        $("#imagePreview").hide();
	    }
	    $("#newImagePreview").hide(); // 새 미리보기 숨기기
	    
	    $("#uploadFile2").css("display","none");
	    console.log("Restored Data:", originalData);
	
	}); // cancelBtn 끝

	
	
	
	// 파일 업로드[등록]
    $("#uploadFile").on("change", function() {
        // 선택된 파일 가져오기
        const file = this.files[0];

        // 파일이 선택된 경우에만 처리
        if (file) {
            const reader = new FileReader();

            // 미리보기 이미지 업데이트
            reader.onload = function(e) {
                // 기존 이미지 미리보기 숨기기
                $("#imagePreview").hide();
                
                // 새로 선택된 이미지 미리보기 표시
                $("#newPreviewImg").attr("src", e.target.result);
                $("#newImagePreview").show();
            };

            // 파일을 읽어 미리보기를 생성
            reader.readAsDataURL(file);
        } else {
            // 파일 선택이 취소되면 새 미리보기 숨기고 기존 미리보기 표시
            $("#newImagePreview").hide();
            $("#imagePreview").show();
        }
  
    }); // uploadFile 끝
    
	// 파일 업로드[수정]
    $("#uploadFile2").on("change", function() {
        // 선택된 파일 가져오기
        const file = this.files[0];

        // 파일이 선택된 경우에만 처리
        if (file) {
            const reader = new FileReader();

            // 미리보기 이미지 업데이트
            reader.onload = function(e) {
                // 기존 이미지 미리보기 숨기기
                $("#imagePreview").hide();
                
                // 새로 선택된 이미지 미리보기 표시
                $("#newPreviewImg").attr("src", e.target.result);
                $("#newImagePreview").show();
            };

            // 파일을 읽어 미리보기를 생성
            reader.readAsDataURL(file);
        } else {
            // 파일 선택이 취소되면 새 미리보기 숨기고 기존 미리보기 표시
            $("#newImagePreview").hide();
            $("#imagePreview").show();
        }
  
    }); // uploadFile 끝
	
    
    // 문의 내용 삭제
    $("#deleteBtn").on("click", function() {
		console.log("삭제 버튼 실행");
		
		let qsSeq = $("#qsSeq").val();
		
		$.ajax({
			url:"/cust/deleteQsAjax",
			contentType:"application/json;charset=utf-8",
			data:qsSeq,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				
				if (result) {
					Swal.fire({
	                    icon: "success",
	                    title: "문의 삭제에 성공하였습니다",
	                    showConfirmButton: true,  // 확인 버튼을 활성화
	                    confirmButtonText: "확인"
	                });
					
					setTimeout(function(){
		               	 location.href="/center/selectBoard?tap=qsTap";
	                 }, 2000);  // 목록 페이지로 이동
               
				} else {
                    alert("문의사항 삭제에 실패했습니다.");
                   
                    setTimeout(function(){
		               	 location.href="/center/selectBoard?tap=qsTap";
	                 }, 2000); // 목록 페이지로 이동
                }
			},
            error: function(xhr, status, error) {
                console.log("문의 삭제 오류: " + error);
                alert("문의 삭제 중 문제가 발생했습니다.");
                window.location.href = "/center/selectBoard?tap=qsTap";  // 목록 페이지로 이동
            }
		}); // ajax 끝
	}); // deleteBtn 끝
	
	
	
	// 문의 수정
  $("#updateBtn").on("click", function(e) {
    e.preventDefault(); // 기본 동작 막기
    console.log("문의 수정 ajax 시작");

    let category = $('#category2').val();
    let title = $("#qa_subject2").val();
    let cont = $("#cont2").val();
    let fileArr = $("#uploadFile2")[0].files;

    // 문의 유형 선택 확인
    if (!category || category === "") {
        Swal.fire({
            icon: 'warning',
            title: '문의 유형을 선택해주세요.',
        });
        return; // 선택하지 않았을 경우 함수 종료
    }

    // 제목과 내용 입력 확인 (필요할 경우 추가)
    if (!title) {
        Swal.fire({
            icon: 'warning',
            title: '제목을 입력해주세요.',
        });
        return;
    }

    if (!cont) {
        Swal.fire({
            icon: 'warning',
            title: '내용을 입력해주세요.',
        });
        return;
    }

    // 폼 데이터 수집(QsVO)
    let formData = new FormData();
    formData.append("qsType", category);
    formData.append("qsTtl", title);
    formData.append("qsCn", cont);
    for (let i = 0; i < fileArr.length; i++) {
        formData.append("uploadFile", fileArr[i]);
    }
    formData.append("qsSeq", $("#qsSeq").val());

    console.log("formData", formData);

    $.ajax({
        url: "/cust/updateQsAjax",
        type: "POST",
        data: formData,
        processData: false,  
        contentType: false,  
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            console.log("updateQsAjax -> result : ", result);

            if (result) {
                Swal.fire({
                    icon: "success",
                    title: "문의 수정에 성공하였습니다",
                    showConfirmButton: true,
                    confirmButtonText: "확인"
                });
                
                $("#div2").hide();
                $("#div1").show();
                
                // 성공 후 2초 뒤 게시판으로 이동
                setTimeout(function(){
                    location.href="/center/selectBoard?tap=qsTap";
                }, 2000);
            } else {
                // 모달 밖 다른 곳을 클릭해도 동일하게 처리
                $("#div2").hide();
                $("#div1").show();
                $("textarea").attr("disabled", true);
                
                setTimeout(function(){
                    location.href="/center/selectBoard?tap=qsTap";
                }, 2000);
            }
        },
        error: function(xhr, status, error) {
            console.log("문의 수정 오류: " + error);
            Swal.fire({
                icon: 'error',
                title: '문의 수정 중 문제가 발생했습니다.',
                text: '다시 시도해 주세요.'
            });
        }
    }); // updateAjax 끝
}); // updateBtn 끝

	
    
 	// 문의 파일 삭제
    $(document).on("click", "#deleteFileBtn", function() {
        console.log("문의 파일 삭제 버튼 실행");

        let qsSeq = $("#qsSeq").val();
        console.log("deleteFileBtn -> qsSeq : ", qsSeq);

        $.ajax({
            url: "/cust/updateFileAjax",
            contentType: "application/json;charset=utf-8",
            data: qsSeq,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("result : ", result);

                if (result) {
                  /*   Swal.fire({
                        icon: "success",
                        title: "파일 삭제 성공",
                        showConfirmButton: true,
                        confirmButtonText: "확인"
                    }); */

                	 // 기존 이미지 미리보기 숨기기
                    $("#imagePreview").hide();  
                	 // 파일 이름 지우기
                    $("#upload_fileOriginalName").text(""); 
                	 // 이미지 src 비우기
                    $("#uploadFile_fileSaveLocate").attr("src", ""); 

                    // 새로운 이미지 미리보기 숨기기
                    $("#newImagePreview").hide();
                    
                    $("#deleteFileBtn").css("display","none");
                } else {
                    alert("파일 삭제에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.log("문의 파일 삭제 오류: " + error);
                alert("문의 파일 삭제 중 문제가 발생했습니다.");
            }
        }); // ajax 끝
    }); // deleteFileBtn 문의 파일 삭제 끝
	
	
	// 문의등록하기 클릭 시
	$('#qsInsertBtn').on('click',function(){
		
		resetForm();
		
		// 문의등록 보이기
       	$('#qsInsert').show();
       	// 문의게시판 숨기기
       	$('#qsListTable').hide();
       	$('#qsUpdate').hide();
       	
     	// 확인, 취소,삭제 버튼 숨기고 수정 버튼 보이기
	    console.log("취소 버튼 실행")
	    $("#div2").hide();
	    $("#div1").show();
	
	    // 기존 데이터로  복원
	    $('#qs_Ttl').val(originalData.qsTtl);
	    $('#qs_Cn').val(originalData.qsCn);

	    // 카테고리 기존 데이터로 초기화 
	    $('#category').val(""); // select 값 초기화
	    $('#category').val(originalData.qsType); // 기존 값 설정
	  	
	    var selectedOptionText = $('#category option:selected').text();
	    $('#category').parent().find('.select-selected').text(selectedOptionText);

	    // 기존 미리보기 이미지 상태 복원
	    if (originalData.fileSaveLocate) {
	        $("#imagePreview").show();
	        $("#uploadFile_fileSaveLocate").attr("src", originalData.fileSaveLocate);
	        $("#upload_fileOriginalName").text(originalData.fileOriginalName);
	    } else {
	        $("#imagePreview").hide();
	    }
	    $("#newImagePreview").hide(); // 새 미리보기 숨기기
	    console.log("Restored Data:", originalData);
	});
	
	// 문의수정하기 클릭 시
	$('.qsItem').on('click',function(){
		resetForm();
		
		// 카테고리 기존 데이터로 초기화 
	    $('#category').val(""); // select 값 초기화
	    var selectedOptionText = $('#category option:selected').text();
	    $('#category').parent().find('.select-selected').text(selectedOptionText);
	    $('#category2').val(""); // select 값 초기화
	    var selectedOptionText = $('#category2 option:selected').text();
	    $('#category2').parent().find('.select-selected').text(selectedOptionText);
		
		// 문의등록 보이기
       	$('#qsUpdate').show();
       	// 문의게시판 숨기기
       	$('#qsListTable').hide();
       	$('#qsInsert').hide();
       	
       	let qsSeq = $(this).data("qsSeq");
       	console.log("qsSeq : " + qsSeq);
       	
       	$.ajax({
       		url:"/center/updateQs",
       		data:{"qsSeq":qsSeq},
       		type:"post",
       		beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
       		success:function(qsVO){
       			//result : qsVO
       			console.log("qsVO : ", qsVO);
			
				$("#qsSeq").val(qsVO.qsSeq);
			
       			let qsType = qsVO.qsType;
				let qsTypeName = "";
				if(qsType=="QS01"){
					qsTypeName = "구매";
				}else if(qsType=="QS02"){
					qsTypeName = "매장이용";
				}else if(qsType=="QS03"){
					qsTypeName = "채용";
				}else if(qsType=="QS04"){
					qsTypeName = "가맹점";
				}else if(qsType=="QS05"){
					qsTypeName = "기타";
				}
				
				$(".select-hide").children().each(function(){
					console.log($(this).text());
					
					if($(this).text() == qsTypeName){
						$(this).addClass("same-as-selected");
						$(".select-selected").html(qsTypeName);
						
						$("#category2").val(qsType);
					}
				});
			
				$("#qa_subject2").val(qsVO.qsTtl);
				$("#qa_subject2").attr("disabled",true);
				$("#cont2").val(qsVO.qsCn);
				$("#cont2").attr("disabled",true);
				
				console.log("qsVO.fileDetailVOList.length : " + qsVO.fileDetailVOList.length);
				
				if(qsVO.fileDetailVOList.length>0){
					originalData = {
					    "qsType": qsVO.qsType,
					    "qsTtl": qsVO.qsTtl, 
					    "qsCn": qsVO.qsCn, 
					    "fileOriginalName": qsVO.fileDetailVOList[0].fileOriginalName, 
					    "fileSaveLocate": qsVO.fileDetailVOList[0].fileSaveLocate 
					};
				}else{
					originalData = {
					    "qsType": qsVO.qsType,
					    "qsTtl": qsVO.qsTtl, 
					    "qsCn": qsVO.qsCn
					};
				}
				
				console.log("originalData : ", originalData);
				
				console.log("qsVO.fileDetailVOList.length : " + qsVO.fileDetailVOList.length);
				
				let str = "";
				if(qsVO.fileDetailVOList.length>0 && qsVO.fileDetailVOList[0].fileOriginalName != null) {
				  str += "<div id='imagePreview'>";
				  str += "<img id='uploadFile_fileSaveLocate' src='"+qsVO.fileDetailVOList[0].fileSaveLocate+"' alt='이미지 미리보기' style='width: 200px; height: auto;'>";
				  str += "<p id='upload_fileOriginalName'>"+qsVO.fileDetailVOList[0].fileOriginalName+"</p>";
				  str += "</div>";
				  str += "<div class='btn-wrap' id='deleteFileDiv'>";
				  str += "<button type='button' id='deleteFileBtn' style='display:none;'>파일 삭제하기</button>";
			  	  str += "</div>";
				}
				
				$("#qsUpdateFormGroup").prepend(str);
				
       		}//end success
       	});
	});
	
	$('#btn_cancle').on('click',function(){
		// 문의등록 숨기기 및 초기화
    	$('#qsInsert').hide();
    	$('select[name="category"]').val(''),
        $('input[name="title"]').val(''),
        $('textarea[name="cont"]').val(''),
    	
    	// 문의게시판 보이기
    	$('#qsListTable').show();
    	resetForm();
	})
	
	// 문의작성 후 등록버튼 클릭 시
	$('#btn_submit').on('click', function(e) {

       let fileArr = $("#uploadFile")[0].files;
       
       // 폼 데이터
      	let formData = new FormData();
        formData.append("qsType", $('select[name="category"]').val());
        formData.append("qsTtl", $('input[name="title"]').val());
        formData.append("qsCn", $('textarea[name="cont"]').val());
        
        for(i=0;i<fileArr.length;i++){
        	formData.append("uploadFile",fileArr[i]);
        }
        
        formData.append("mbrId", mbrId);
       
        category = $('select[name="category"]').val();
    	title = $('input[name="title"]').val();
    	cont = $('textarea[name="cont"]').val();
    	
    	console.log(category);
    	console.log(title);
    	console.log(cont);
		
        // 문의 유형 선택 확인
        if (!category || category === "") {
            Swal.fire({
                icon: 'warning',
                title: '문의 유형을 선택해주세요.',
            });
            return; 
        }
		// 문의 제목 입력 확인
        if (!title) {
            Swal.fire({
                icon: 'warning',
                title: '제목을 입력해주세요.',
            });
            return;
        }
		// 문의 내용 입력 확인
        if (!cont) {
            Swal.fire({
                icon: 'warning',
                title: '내용을 입력해주세요.',
            });
            return;
        }
       $.ajax({
    	   url: "/cust/insertQsPostAjax",
           type: "POST",
           data: formData,
           processData: false,
           contentType: false,
           dataType: "json",
           beforeSend: function(xhr) {
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
           },
           success: function(result) {
	        	console.log("result : ", result);
	           
	        	
				switch (category) {
				    case 'QS01': category = '구매'; break;
				    case 'QS02': category = '매장이용'; break; 
				    case 'QS03': category = '채용'; break; 
				    case 'QS04': category = '가맹점'; break; 
				    case 'QS05': category = '기타'; break; 
				}
	        	
				var today = new Date();
			    var year = today.getFullYear();
			    var month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
			    var day = String(today.getDate()).padStart(2, '0');
			    var hours = String(today.getHours()).padStart(2, '0');
			    var minutes = String(today.getMinutes()).padStart(2, '0');
			    var seconds = String(today.getSeconds()).padStart(2, '0');

			    var formattedDate = `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
				
	        	str = `
		        	<tr>
		       			<td>\${category}</td>
		       			<td>\${title}</td>
		       			<td>\${formattedDate}</td>
		       			<td>
		       				<span class="bge bge-warning" id="tap-clsing">
	                        <span class="td-asnCn tap-title">준비중</span>
	                        </span>
                        </td>
	       			</tr>
	        	`;
	        	
	        	
	        	$('.qs-empty').remove();
	        	$('.qs-list').prepend(str);
	        	
	        	console.log(str);
	        	
	        	// 인풋영역 초기화
	        	resetForm();
	            
	        	Swal.fire({
	                   icon: 'success',
	                   title: '문의 등록 성공',
	        	});
	        	
	        	 setTimeout(function(){
	               	 location.href="/center/selectBoard?tap=qsTap";
                 }, 2000);
	        	
           },
           error: function(xhr, status, error) {
               console.error("Error: " + error);
               Swal.fire({
                   icon: 'error',
                   title: '문의 등록 실패',
                   text: '다시 시도해 주세요.'
               });
               resetForm();
               setTimeout(function(){
	               	 location.href="/center/selectBoard?tap=qsTap";
               }, 2000);
           }
       }); // ajax
    });//inquiryForm
});

// 해당 faq를 클릭하면 아코디언이 열리면서 답변을 볼 수 있음
function toggleAccordion(element) {
	var collapseRow = element.nextElementSibling;
	var isVisible = collapseRow.classList.contains('show');

	document.querySelectorAll('.accordion-collapse').forEach(function(row) {
		row.classList.remove('show');
	});

	if (!isVisible) {
		collapseRow.classList.add('show');
	}
}

// 문의 사항 전체 폼 초기화
function resetForm() {
    // 카테고리 초기화
     $('#category').val(""); 
     
     var selectedOptionText = $('#category option:selected').text();
     
     $('#category').parent().find('.select-selected').text(selectedOptionText);
    
    // 제목 초기화
    $('input[name="title"]').val('');
    
    // 내용 초기화
    $('textarea[name="cont"]').val('');
    
    // 파일 초기화
    $("#uploadFile").val(null); 
    
    //이미지 부분 
    $("#imagePreview").empty();
       
}


function noLogin(){
	
	 Swal.fire({
         icon: 'error',
         title: '로그인 후 이용해주세요!'
     });
 
}

// faq 카테고리 
function submitFaqForm() {
	
	const faqCategory = document.getElementById('faqCategory').value;
	const form = document.getElementById('faqForm');
	    
  // 기존 URL에 파라미터 추가
    const url = new URL(form.action, window.location.origin);
    url.searchParams.set('faqCategory', faqCategory);
    url.searchParams.set('tap', 'faqTap');  // 탭을 faqTap으로 설정

    // 페이지를 해당 URL로 이동
    window.location.href = url.toString();
}

</script>

<div class="wrap">

	<!-- wrap-cont 시작 -->
	<div class="wrap-cont">
		
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">고객센터</div>
		<!-- /.wrap-title -->
		
		<!-- 사이드 영역 시작  -->
		<div class="side_nav">
			<div class="lef_menu">
				<ul>
				 	<li class="on" id="noticeTap"><a href="?tap=noticeTap"><span>공지사항</span></a></li>
					<li id="faqTap"><a href="?tap=faqTap"><span>FAQ</span></a></li>
					<li id="qsTap"><a href="?tap=qaTap"><span>1:1 문의</span></a></li> 
					
				<!-- 	<li class="on" id="noticeTap"><span>공지사항</span></li>
					<li id="faqTap"><span>FAQ</span></li>
					<li id="qsTap"><span>1:1 문의</span></li> -->
				</ul>
			</div>
			<!-- /.lef_menu -->
			
			<!-- 게시판 영역 시작 -->
			<div class="rig_con">
				
				<!-- 공지사항 시작 -->
				<div id="noticeListTable">
					<div class="noticeCont">
					<div class="con_tit1">
						<p>공지사항</p>
					</div>
					<!-- /.con_tit1 -->
					<form id="noticeForm" method="get" action="/center/selectBoard">
					<div class="con_tit1">
						  <div class="search-input-btn">
	                        <input type="text" name="keyword" placeholder="제목과 내용을 입력해주세요"  class="search-input" style="width: 300px;" value="${param.keyword}"/>
	                        <button type="submit" class="search-btn"></button>
                    	</div>									
					</div>
					</form>
					</div>	
					<!-- 공지사항 리스트 -->
					<div class="list_tbl">
						<table>
							<colgroup>
								<col width="15%">
								<col width="30%">
								<col width="17%">
							</colgroup>
							<tbody>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>조회수</th>
								</tr>
								<c:forEach var="noticeVO" items="${articlePage.content}" varStatus="stat">
								    <tr>
								        <td style="text-align: center;">
								            <c:if test="${noticeVO.fixdSeq > 0}">
								                <span class="icon material-symbols-outlined fix-icon">Keep</span>
								            </c:if>
								            <c:if test="${noticeVO.fixdSeq == 0}">
								                ${noticeVO.ntcSeq}
								            </c:if>
								        </td>
								        <td>
								            <a href="/center/selectNoticeDetail?ntcSeq=${noticeVO.ntcSeq}">
								                ${noticeVO.ntcTtl}
								            </a>
								        </td>
								        <td style="text-align: center;">
								            ${noticeVO.inqCnt}
								        </td>
								    </tr>
								    <tr class="accordion-collapse">
								        <td colspan="3">
								            <div class="accordion-body" style="overflow: auto;  text-align: left;">
								                ${faqVO.faqCn}
								            </div>
								        </td>
								    </tr>
								</c:forEach>
							</tbody>
						</table>
						
						<div class="pagination-wrap">
			               <div class="pagination">
			                  <c:if test="${articlePage.startPage gt 5}">
			                     <a href="/center/selectBoard?&currentPage=${articlePage.startPage-5}&keyword=${param.keyword}" class="page-link">
			                        <span class="icon material-symbols-outlined">chevron_left</span>
			                     </a>
			                  </c:if>
			                  <!-- 선택한 페이지만 class="active"가 설정되게 한다 -->
			                  <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
			                     <a href="/center/selectBoard?currentPage=${pNo}&keyword=${param.keyword}" class="page-link 
			                          <c:if test="${pNo == articlePage.currentPage}">active</c:if>">
			                          ${pNo}
			                      </a>
			                  </c:forEach>
			                  <!-- endPage < totalPages일때만 [다음] 활성 -->
			                  <c:if test="${articlePage.endPage lt articlePage.totalPages}">
			                     <a href="/center/selectBoard?currentPage=${articlePage.startPage+5}&keyword=${param.keyword}" class="page-link">
			                        <span class="icon material-symbols-outlined">chevron_right</span>
			                     </a>
			                  </c:if>
			               </div>
			            </div>
						
					</div>
				</div>
				<!-- /.list_tbl: 공지사항 -->
				
				<!-- FAQ 시작 -->
				<div id="faqListTable">
				<div class="faqCon">
					<div class="con_tit1">
						<p>FAQ</p>
					</div>
					<!-- /.con_tit1 -->
					<form id = "faqForm" method="get" action="/center/selectBoard" >
					<div class="con_tit1">
						<div class="search-cont">
							<select class="select2-custom" name="faqCategory" id="faqCategory" onchange="submitFaqForm()">
								<option value="" selected>전체</option>
								<option value="QS01"<c:if test="${param.faqCategory == 'QS01'}">selected</c:if>>구매</option>
								<option value="QS02"<c:if test="${param.faqCategory == 'QS02'}">selected</c:if>>매장 이용</option>
								<option value="QS03"<c:if test="${param.faqCategory == 'QS03'}">selected</c:if>>채용</option>
								<option value="QS04"<c:if test="${param.faqCategory == 'QS04'}">selected</c:if>>가맹점</option>
								<option value="QS05"<c:if test="${param.faqCategory == 'QS05'}">selected</c:if>>기타</option>
							</select>
						</div>
					</div>
					</form>
				</div>	
					<!-- /.select_faq -->
					<!-- FAQ 리스트 -->
					<div class="list_tbl">
						<table>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<th>구분</th>
									<th>제목</th>
								</tr>
								<c:forEach var="faqVO" items="${faqVOList}">
									<tr class="accordion-item" onclick="toggleAccordion(this)">
										<td>
											<c:choose>
												<c:when test="${faqVO.qsType == 'QS01'}">구매</c:when>
												<c:when test="${faqVO.qsType == 'QS02'}">매장이용</c:when>
												<c:when test="${faqVO.qsType == 'QS03'}">채용</c:when>
												<c:when test="${faqVO.qsType == 'QS04'}">가맹점</c:when>
												<c:when test="${faqVO.qsType == 'QS05'}">기타</c:when>
												<c:otherwise>알 수 없음</c:otherwise>
											</c:choose>
										</td>
										<td>${faqVO.faqTtl}</td>
									</tr>
									<tr class="accordion-collapse">
										<td colspan="3">
											<div class="accordion-body" style="overflow: auto; text-align: left">
												${faqVO.faqCn}</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- /.list_tbl: FAQ -->
				
				<div id="qsListTable">
					<div class="con_tit1">
						<p>문의 내역</p>
					</div>
					<div class="list_tbl">
						<table>
							<colgroup>
								<col width="10%">
								<col width="20%">
								<col width="30%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>문의 유형</th>
									<th>제목</th>
									<th>작성 일자</th>
									<th>문의 답변 여부</th>
								</tr>
							</thead>
							<tbody class="qs-list">
								<c:if test="${empty qsVOList}">
								    <tr class="qs-empty">
								        <td colspan="4">등록된 문의 내역이 없습니다</td>
								    </tr>
								</c:if>
								<c:forEach var="qsVO" items="${qsVOList}">
									<c:if test="${!empty qsVO}">
									   	<c:if test="${qsVO.ansCn == 'N'}"><!-- 준비중 -->
						               		<tr class="qsItem" data-qs-seq="${qsVO.qsSeq}">
						               	</c:if>
						               	<c:if test="${qsVO.ansCn != 'N'}"><!-- 답변 완료 -->
						               		<tr class="qsItem" onclick="location.href='/cust/selectQsDetail?qsSeq=${qsVO.qsSeq}'">
						               	</c:if>
					                  <td>
					                     <c:choose>
					                        <c:when test="${qsVO.qsType == 'QS01'}">구매</c:when>
					                        <c:when test="${qsVO.qsType == 'QS02'}">매장이용</c:when>
					                        <c:when test="${qsVO.qsType == 'QS03'}">채용</c:when>
					                        <c:when test="${qsVO.qsType == 'QS04'}">가맹점</c:when>
					                        <c:when test="${qsVO.qsType == 'QS05'}">기타</c:when>
					                        <c:otherwise>알 수 없음</c:otherwise>
					                     </c:choose>
					                  </td>
					                  <td style=" text-align: left;">${qsVO.qsTtl}</td>
					                  <td>${qsVO.wrtrDt}</td>
					                  <td>
					                        <c:if test="${qsVO.ansCn == 'N'}">
					                            <span class="bge bge-warning" id="tap-clsing">
					                                <span class="td-asnCn tap-title">준비중</span>
					                            </span>
					                        </c:if>
					                        <c:if test="${qsVO.ansCn != 'N'}">
					                            <span class="bge bge-active" id="tap-clsing">
					                                <span class="tap-title">답변 완료</span>
					                            </span>
					                        </c:if>
					                    </td>
					               </tr>
					               </c:if>
				            	</c:forEach>
			         		</tbody>
						</table>
					</div>
					<sec:authorize access="isAnonymous()">
					    <div id="qsInsertBtn2" onclick="location.href='/login'" >문의하기</div>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<div id="qsInsertBtn">문의하기</div>
					</sec:authorize>
				</div>
				<!-- /.qsListTable -->
				
				<div id="qsInsert">
	                <div class="con_tit1">
	                    <div id="divAuto">
	                        <p>1:1 문의</p>
	                    </div>
	                </div>
	                <!-- /.con_tit1  -->
	                <div class="bdr_box">
	                <form id="inquiryForm">
	                    <div class="write_tbl">
	                        <table>
	                            <colgroup>
	                                <col width="15%">
	                                <col width="85%">
	                                <col>
	                                <col>
	                            </colgroup>
	                     		<tbody>
		                       		<tr>
		                            	<th>문의유형</th>
		                            	<td colspan="2">
		                            		<div class="form-group">
				                            	<div class="select-custom" style="width:200px;">
													<select  id="category" name="category" required>
							                            <option value="" selected disabled>선택해주세요</option>
							                            <option value="QS01">구매</option>
							                            <option value="QS02">매장이용</option>
							                            <option value="QS03">채용</option>
							                            <option value="QS04">가맹점</option>
							                            <option value="QS05">기타</option>
							                        </select>
						                        </div>
					                        </div>
		                               	</td>
	                              	</tr>
	                             	<tr>
		                                <th>제목</th>
		                                <td colspan="2">
		                                	<div class="form-group">
		                                    	<input class="input_type1" type="text" style="width:100%;" name="title" id="qa_subject" size="50" maxlength="255" placeholder="제목을 입력해주세요.">
		                                	</div>
		                                </td>
	                             	</tr>
	                            	<tr>
		                                <th>내용</th>
		                                <td colspan="2">
		                                	<div class="form-group">
											<textarea name="cont" rows="5" cols="50" spellcheck="false" placeholder="내용을 입력해주세요" required></textarea>
		                               		</div>
		                                </td>
	                        	 	</tr>
	                        	 	<tr>
		                                <th>파일</th>
		                                <td colspan="2">
		                                	<div class="form-group">
		                                	<input type="file" id="uploadFile">
		                               		</div>
		                                </td>
	                        	 	</tr>
	                   			</tbody>
	                  		</table>
                        </div>
                        <!-- /.write_tbl -->
	                              
                 		<div class="btn_area mt45">
	                        <button id="btn_cancle">취소</button> 
                   			<button type="button" id="btn_submit" class="_btn co_btn w_160">등록</button> 
                 		</div>
                 		<!-- /.btn_area -->
                 	</form>
               		</div>
               		<!-- /.bdr_box -->
				</div>
				<!-- /.qsInsert -->
				
				
				<!-- ///////////// qsUpdate 시작 ///////////// -->
				<div id="qsUpdate" style="display:none;">
	                <div class="con_tit1">
	                    <div>
	                        <p>1:1 문의</p>
	                    </div>
	                </div>
	                <!-- /.con_tit1  -->
	                <div class="bdr_box">
	                <form id="inquiryForm2">
	                    <div class="write_tbl">
	                        <table>
	                            <colgroup>
	                                <col width="15%">
	                                <col width="85%">
	                                <col>
	                                <col>
	                            </colgroup>
	                     		<tbody>
		                       		<tr>
		                            	<th>문의유형</th>
		                            	<td colspan="2">
		                            		<div class="form-group">
				                            	<div class="select-custom" style="width:200px;">
													<select  id="category2" name="category" required>
							                            <option value="" selected disabled>선택해주세요</option>
							                            <option value="QS01">구매</option>
							                            <option value="QS02">매장이용</option>
							                            <option value="QS03">채용</option>
							                            <option value="QS04">가맹점</option>
							                            <option value="QS05">기타</option>
							                        </select>
						                        </div>
					                        </div>
		                               	</td>
	                              	</tr>
	                             	<tr>
		                                <th>제목</th>
		                                <td colspan="2">
		                                	<div class="form-group">
		                                    	<input class="input_type1" type="text" style="width:100%;" name="title" id="qa_subject2" size="50" maxlength="255" placeholder="제목을 입력해주세요.">
		                                	</div>
		                                </td>
	                             	</tr>
	                            	<tr>
		                                <th>내용</th>
		                                <td colspan="2">
		                                	<div class="form-group">
											<textarea id="cont2" name="cont" rows="5" cols="50" spellcheck="false" placeholder="내용을 입력해주세요" required></textarea>
		                               		</div>
		                                </td>
	                        	 	</tr>
	                        	 	<tr>
				                     <th>파일</th>
				                     <td colspan="2">
				                         <div class="form-group" id="qsUpdateFormGroup">
				                             <!-- 파일 선택 버튼 -->
				                             <input type="file" id="uploadFile2" name="uploadFile" accept="image/*" style="display: none;" />
				                             <div id="newImagePreview" style="display: none;">
				                                 <img id="newPreviewImg" src="" alt="새 이미지 미리보기" style="width: 200px; height: auto;">
				                             </div>
				                         </div>
				                     </td>
				                  </tr>
	                   			</tbody>
	                  		</table>
                        </div>
                        <!-- /.write_tbl -->
	                              
                 		<div class="btn_area mt45" id="div1">
	                        <button type="button" id="modeBtn">수정</button> 
                   			<button type="button" id="deleteBtn" class="_btn co_btn w_160">삭제</button> 
                 		</div>
                 		<div class="btn_area mt45" id="div2">
	                        <button type="button" id="cancelBtn">취소</button> 
                   			<button type="button" id="updateBtn" class="_btn co_btn w_160">저장</button> 
                 		</div>
                 		<!-- /.btn_area -->
                 		<input id="qsSeq" type="hidden" value="" />
                 	</form>
               		</div>
               		<!-- /.bdr_box -->
				</div>
				<!-- /////.qsUpdate 끝 ///////////////// -->
				
			</div>
			<!-- /.rig_con -->
			
		</div>
		<!-- /.side_nav -->
	</div>
	<!-- /.wrap-cont -->
</div>
<!-- /.wrap -->














