/*******************************************
  @fileName    : netProfit.js
  @author      : 송예진
  @date        : 2024. 10. 14
  @description : 순수익
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");
 function selectProfitAjax(){
 	let month = $('#month').val();
	let year = $('#year').val();
	
	let data = {};

	data.month = month;
	data.year = year;
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.bzentNo = bzentNo;
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/frcs/netProfitListAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.total);
			
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
				res.content.forEach(list => {
				
				let slsYm = (""+list.slsYm).substring(0,4)+"-"+(""+list.slsYm).substring(4);
	    		strTbl += `
				    <tr class="profixDtl" data-ym="${list.slsYm}">
				        <td class="center">${list.rnum}</td>
				        <td class="center">${slsYm}</td>
				        <td class="right">${list.pureAmt.toLocaleString()}</td>
				        <td class="right">${list.frcsClclnVO.slsGramt.toLocaleString()}</td>
				        <td class="right">${list.frcsClclnVO.royalty.toLocaleString()}</td>
				        <td class="right">${list.sumPoAmt.toLocaleString()}</td>
				        <td class="right">${list.mngAmt.toLocaleString()}</td>
				        <td class="right">${list.hireAmt.toLocaleString()}</td>
				    </tr>
				`;
				
				});
				
				// 페이징 처리
				let page = '';
				
				if (res.startPage > res.blockSize) {
				    page += `
				        <a href="#page" class="page-link" data-page="${res.startPage - res.blockSize}">
				            <span class="icon material-symbols-outlined">chevron_left</span>
				        </a>
				    `;
				}
				
				// 페이지 번호 링크들 추가
				for (let pnum = res.startPage; pnum <= res.endPage; pnum++) {
				    if (res.currentPage === pnum) {
				        page += `<a href="#page" class="page-link active" data-page="${pnum}">${pnum}</a>`;
				    } else {
				        page += `<a href="#page" class="page-link" data-page="${pnum}">${pnum}</a>`;
				    }
				}
				
				// 'chevron_right' 아이콘 및 다음 페이지 링크 추가
				if (res.endPage < res.totalPages) {
				    page += `
				        <a href="#page" class="page-link" data-page="${res.startPage + res.blockSize}">
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
			매출 등록
********************************************/
function insertSls(){
	// 서버전송
	$.ajax({
		url : "/frcs/insertNetPorfitAjax",
		type : "POST",
		data: {bzentNo : bzentNo},  // JSON으로 변환
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
				Swal.fire({
					  icon: "success",
					  title: "등록이 완료되었습니다",
					  text : `총 ${res}건이 등록되었습니다.`,
					  showConfirmButton: true,
					  confirmButtonText : "확인"
					}).then((result) => {
			  if (result.isConfirmed) {
				  location.reload();
			  }
			});
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
}
 /*******************************************
			매출 상세
********************************************/
function selectSlsDtl(){
	let frcsSlsVO = {};
	frcsSlsVO.frcsNo = bzentNo;
	frcsSlsVO.slsYm = slsYm;
	// 서버전송
	$.ajax({
		url : "/frcs/netProfitDtlAjax",
		type : "POST",
		data: JSON.stringify(frcsSlsVO),  // JSON으로 변환
        contentType: "application/json",  // JSON 형식으로 전송
	// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			let ym = (""+slsYm).substring(0,4)+"년 "+(""+slsYm).substring(4)+"월";
		    $('#slsYm').html(ym);
			$('#slsGramt').text(res.frcsClclnVO.slsGramt.toLocaleString());
			$('#royalty').text(res.frcsClclnVO.royalty.toLocaleString());
			$('#dscntAmt').text(res.frcsClclnVO.dscntAmt.toLocaleString());
			$('#npmntAmt').text(res.frcsClclnVO.npmntAmt.toLocaleString());
			$('#poAmt').text(res.poAmt.toLocaleString());
			$('#poNpmntAmt').text(res.poNpmntAmt.toLocaleString());
			$('#mngAmt').val(res.mngAmt);
			$('#hireAmt').val(res.hireAmt);
			$('#pureAmt').text(res.pureAmt.toLocaleString());
		},
		error: function(xhr, status, error) {
        	console.error("에러 발생: ", error);
        }
		});		
}
 /*******************************************
			순수익 변경
********************************************/
function changePureAmt(){
    // 쉼표 제거 후 숫자로 변환
    const slsGramt = parseFloat($('#slsGramt').text().replace(/,/g, '')) || 0;
    const royalty = parseFloat($('#royalty').text().replace(/,/g, '')) || 0;
    const dscntAmt = parseFloat($('#dscntAmt').text().replace(/,/g, '')) || 0;
    const npmntAmt = parseFloat($('#npmntAmt').text().replace(/,/g, '')) || 0;
    const poAmt = parseFloat($('#poAmt').text().replace(/,/g, '')) || 0;
    const poNpmntAmt = parseFloat($('#poNpmntAmt').text().replace(/,/g, '')) || 0;
    const mngAmt = parseFloat($('#mngAmt').val());
    const hireAmt = parseFloat($('#hireAmt').val());
	console.log(hireAmt);
    // 계산: (slsGramt + dscntAmt) - (royalty + npmntAmt + poAmt + poNpmntAmt + mngAmt + hireAmt)
    console.log(slsGramt + dscntAmt);
    console.log(royalty + npmntAmt + poAmt + poNpmntAmt + mngAmt + hireAmt);
    const pureAmt = (slsGramt + dscntAmt) - (royalty + npmntAmt + poAmt + poNpmntAmt + mngAmt + hireAmt);
	//console.log(pureAmt);
    // 결과를 쉼표 형식으로 변환하여 표시
    $('#pureAmt').text(pureAmt.toLocaleString());
}
 /*******************************************
			매출 수정
********************************************/
function updateSls(){
	let frcsSlsVO = {};
	let mngAmt = $('#mngAmt').val();
	let hireAmt = $('#hireAmt').val();
	
	frcsSlsVO.frcsNo = bzentNo;
	frcsSlsVO.slsYm = slsYm;
	frcsSlsVO.mngAmt = mngAmt;
	frcsSlsVO.hireAmt = hireAmt;
	// 서버전송
	$.ajax({
		url : "/frcs/updateNetProfitAjax",
		type : "POST",
		data: JSON.stringify(frcsSlsVO),  // JSON으로 변환
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