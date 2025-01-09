/*******************************************
  @fileName    : menu.js
  @author      : 송예진
  @date        : 2024. 10. 01
  @description : 가맹점 거래처 코드
********************************************/
document.write("<script src='/resources/js/global/value.js'></script>");
 function selectMenuAjax(){
 	let data = {};
 	
 	let mngrId = $('#mngrId').val();
 	let menuNm = $('#menuNm').val();
	let ntslType = $('#ntslType').val();
	let sregYmdDt = $('#sregYmd').val();
	let eregYmdDt = $('#eregYmd').val();
	let srlsYmdDt = $('#srlsYmd').val();
	let erlsYmdDt = $('#erlsYmd').val();
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.menuType = menuType;
	data.menuNm = menuNm;
	data.mngrId = mngrId;
	data.ntslType = ntslType;
	
	if(sregYmdDt){
		data.sregYmd = dateToStr(sregYmdDt);
	}
	if(eregYmdDt){
		data.eregYmd = dateToStr(eregYmdDt);
	}
	if(srlsYmdDt){
		data.srlsYmd = dateToStr(srlsYmdDt);
	}
	if(erlsYmdDt){
		data.erlsYmd = dateToStr(erlsYmdDt);
	}
	
	console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/menu/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-menu01').text(res.MENU01);
			$('#tap-menu02').text(res.MENU02);
			$('#tap-menu03').text(res.MENU03);
			$('#tap-menu04').text(res.MENU04);
			
			//console.log(res);
			// 테이블 처리
			let strTbl = '';
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="9"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.articlePage.content.forEach(list => {
				// 등록일자
				let reg = strToDate(list.regYmd);
				// 출시일자
				let rls = strToDate(list.rlsYmd);
				
				let newRebbon = `<div class="ribbon-wrapper ribbon-s">
							<div class="ribbon bg-danger text-s">
								NEW
							</div>
						</div>`;
											
				// 판매 유형
				let ntslType = `<span class='bge ${
				    list.ntslType=='NTSL01' ? 'bge-info-border' 
				    : list.ntslType=='NTSL02' ? 'bge-active-border' 
				    : 'bge-danger-border'}'>${list.ntslTypeNm}</span>`;;
				// 유형
				let type = `<span class='bge ${
				    list.menuType=='MENU01' ? 'bge-active' 
				    : list.menuType=='MENU02' ? 'bge-warning' 
				    : list.menuType=='MENU03' ? 'bge-danger' 
				    : 'bge-info'}'>${list.menuTypeNm}</span>`;
	    		strTbl += `
				    <tr class="menuDtl" data-no="${list.menuNo}">
				        <td class="center">${list.rnum}</td>
				        <td class="td-sumimg"><div class="position-relative"><img alt="${list.menuNm}" src="${list.menuImgPath}" class="menu-img">${list.rlsYmd && somethingNew(list.rlsYmd) ? newRebbon : ''}</div></td>
				        <td>${list.menuNm}</td>
				        <td class="center">${type}</td>
				        <td class="center">${list.menuAmt.toLocaleString()}</td>
				        <td class="center">${list.mngrVO.mbrNm}</td>
				        <td class="center">${reg}</td>
				        <td class="center">${rls}</td>
				        <td class="center">${list.ntslQty.toLocaleString()}</td>
				        <td class="center">${ntslType}</td>
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
			메뉴 상세 조회
********************************************/
// 상세!!!
function selectMenuDtlAjax(){
	// 서버전송
	$.ajax({
		url : "/hdofc/menu/dtlAjax",
		type : "POST",
		data: { menuNo : menuNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
			// console.log(res);
			// 상품
			let menu = res.menu;
			$('#menuNm').val(menu.menuNm);
			let newRebbon = `<div class="ribbon-wrapper ribbon-s">
							<div class="ribbon bg-danger text-s">
								NEW
							</div>
						</div>`;
			$('#menuImg').html(`<div class="position-relative">
								<img alt="${menu.menuNm}" src="${menu.menuImgPath}">
								${menu.rlsYmd && somethingNew(menu.rlsYmd) ? newRebbon : ''}
							</div>`);
			// 유형
			let type = `<span class='bge ${
			    menu.menuType=='MENU01' ? 'bge-active' 
			    : menu.menuType=='MENU02' ? 'bge-warning' 
			    : menu.menuType=='MENU03' ? 'bge-danger' 
			    : 'bge-info'}'>${menu.menuTypeNm}</span>`;
			$('.menuType').html(type);
			
			$('#menuAmt').val(menu.menuAmt);
			$('#ntslType').val(menu.ntslType);
			$('#ntslType').parent().find('.select-selected').text(menu.ntslTypeNm);
			$('#ntslQty').text(menu.ntslQty.toLocaleString())
			// 등록 일자
			let reg = strToDate(menu.regYmd);
			$('#regYmd').val(reg);
			// 출시 일자
			if(menu.rlsYmd){
				let rls = strToDate(menu.rlsYmd);
				$('#rlsYmd').val(rls);
				
				if(isPastOrToday(menu.rlsYmd)){
					// 출시 일자가 이미 지난 경우엔 출시일자 수정 X
					$('#rlsYmd').prop('disabled', true);
					// 출시 일자가 이미 지난경우에는 삭제 불가능
					$('#deleteMenu').prop('disabled', true);
				}
			}
			
			
			$('#menuExpln').val(menu.menuExpln);
			
			// 등록자
			$('#mngrNm').val(menu.mngrVO.mbrNm);
			$('#mngrId').val(menu.mngrId);
			let mngrTelNo = splitTel(menu.mngrVO.mbrTelno);
			$('#mngrTelno1').val(mngrTelNo[0]);
			$('#mngrTelno2').val(mngrTelNo[1]);
			$('#mngrTelno3').val(mngrTelNo[2]);
		       
			$('#mngrEmlAddr').val(menu.mngrVO.mbrEmlAddr);
			
			let num = 1;
			let strTbl = '';
			if(menu.menuSetList.length!=0){					// 세트 레시피
				set = true; // 세트메뉴일때
				$('.menu-recipe').hide();
				menu.menuSetList.forEach(list => {
				menuList.push(list.menuNo);	
				// 유형
				let typeSet = `<span class='bge ${
				    list.menuType=='MENU01' ? 'bge-active' 
				    : list.menuType=='MENU02' ? 'bge-warning' 
				    : list.menuType=='MENU03' ? 'bge-danger' 
				    : 'bge-info'}'>${list.menuTypeNm}</span>`;	
				    	
	    		strTbl += `
				    <tr data-no="${list.menuNo}">
				    	<td class="center" style="width:15%;"><button class="btn btn-default remove" type="button">삭제</button></td>
				    	<td style="width:30%;">${list.menuNm}</td>
				    	<td style="width:25%;" class="center">${typeSet}</td>
				    	<td style="width:15%;" class="center"><input type="number" value="${list.qty}" class="recipeQty" style="text-align:right;"></td>
				    	<td style="width:15%;" class="center">${list.menuAmt.toLocaleString()}</td>
				    </tr>
				`;
				});
				$('#table-body-set').html(strTbl)
			} else { 									// 일반 레시피
				$('.set-recipe').hide();
				menu.recipeVOList.forEach(list => {
				gdsList.push(list.gdsCode);			
	    		strTbl += `
				    <tr data-code="${list.gdsCode}">
				    	<td class="center" style="width:15%;"><button class="btn btn-default remove" type="button">삭제</button></td>
				    	<td style="width:30%;">${list.gdsVO.gdsNm}</td>
				    	<td style="width:25%;" class="center"><span class="bge bge-active">${list.gdsVO.gdsTypeNm}</span></td>
				    	<td style="width:15%;" class="center"><input type="number" value="${list.qty}" class="recipeQty" style="text-align:right;"></td>
				    	<td style="width:15%;" class="center">${list.gdsVO.unitNm}</td>
				    </tr>
				`;
				});
				$('#table-body-recipe').html(strTbl)
			}
		} // success 끝
	});		
}

 /*******************************************
			음식 상품 조회 (모달)
********************************************/
 function selectGdsFoodAjax(){
 	let data = {};
 	
 	let gdsType = $('#gdsTypeModal').val();
	let gdsNm = $('#gdsNmModal').val();	
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.gdsNm = gdsNm;
	data.gdsType = gdsType;
	
	//console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
	
	// 서버전송
	$.ajax({
		url : "/hdofc/menu/gdsList",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			//console.log(res);
			// 테이블 처리
			let strTbl = '';
			$('#tap-all-gds').text(res.total);
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="4"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.content.forEach(list => {
				let type = `<span class="bge bge-active">${list.gdsTypeNm}</span>`;
				
				 let inCart = gdsList.includes(list.gdsCode) ? 
                `active` : '';
                
	    		strTbl += `
				    <tr class="gdsDtl" data-no="${list.gdsCode}" data-nm="${list.gdsNm}"
				    data-type='${type}' data-unit="${list.unitNm}">
				        <td class="center">${list.rnum}</td>
				        <td class="${inCart}">${list.gdsNm}</td>
				        <td class="center">${type}</td>
				        <td class="center">${list.unitNm}</td>
				    </tr>
				`;
				
				});
				
				// 페이징 처리
				let page = '';
				
				if (res.startPage > res.blockSize) {
				    page += `
				        <a href="#page" class="page-gds" data-page="${res.startPage - res.blockSize}">
				            <span class="icon material-symbols-outlined">chevron_left</span>
				        </a>
				    `;
				}
				
				// 페이지 번호 링크들 추가
				for (let pnum = res.startPage; pnum <= res.endPage; pnum++) {
				    if (res.currentPage === pnum) {
				        page += `<a href="#page" class="page-gds active" data-page="${pnum}">${pnum}</a>`;
				    } else {
				        page += `<a href="#page" class="page-gds" data-page="${pnum}">${pnum}</a>`;
				    }
				}
				
				// 'chevron_right' 아이콘 및 다음 페이지 링크 추가
				if (res.endPage < res.totalPages) {
				    page += `
				        <a href="#page" class="page-gds" data-page="${res.startPage + res.blockSize}">
				            <span class="icon material-symbols-outlined">chevron_right</span>
				        </a>
				    `;
				}
				$('#gdspage').html(page);
				}
			$('#table-gds').html(strTbl)
			}
		});			
 }

 /*******************************************
			모달 상품 선택하면 테이블 추가
********************************************/
function addRecipe(list){
		if(set){
			let tableStr = `<tr data-no="${list.menuNo}">
				    	<td class="center" style="width:15%;"><button class="btn btn-default remove" type="button">삭제</button></td>
				    	<td style="width:30%;">${list.menuNm}</td>
				    	<td style="width:25%;" class="center">${list.type}</td>
				    	<td style="width:15%;" class="center"><input type="number" value="1" style="text-align:right;" class="recipeQty"></td>
				    	<td style="width:15%;" class="center">${list.menuAmt.toLocaleString()}</td>
				    </tr>`;
			$('#table-body-set').append(tableStr)
		} else{
			let tableStr = `
					    <tr data-code="${list.gdsCode}">
			    	<td class="center" style="width:15%;"><button class="btn btn-default remove" type="button">삭제</button></td>
			    	<td style="width:30%;">${list.gdsNm}</td>
			    	<td class="center" style="width:25%;">${list.type}</td>
			    	<td class="center" style="width:15%;"><input type="number" value="1" style="text-align:right;" class="recipeQty"></td>
			    	<td class="center" style="width:15%;">${list.unitNm}</td>
			    </tr>
			`;
			$('#table-body-recipe').append(tableStr)
		}
}
 /*******************************************
			메뉴를 선택하는 모달
********************************************/
function selectMenuModalAjax(){
 	let data = {};
 	
 	let menuNm = $('#menuNmModal').val();
	let ntslType = $('#ntslTypeModal').val();
	
	data.sort = sort;
	data.orderby = orderby;
	data.currentPage = currentPage;
	data.menuType = menuType;
	data.menuNm = menuNm;
	data.ntslType = ntslType;
	data.notSet = 'true';
	
	console.log(data);
	
	// 서버전송
	$.ajax({
		url : "/hdofc/menu/listAjax",
		type : "GET",
		data : data,
		success : function(res){
			// 분류 처리
			$('#tap-all').text(res.all);
			$('#tap-menu02').text(res.MENU02);
			$('#tap-menu03').text(res.MENU03);
			$('#tap-menu04').text(res.MENU04);
			
			//console.log(res);
			// 테이블 처리
			let strTbl = '';
			
			if(res.total == 0){ // 검색 결과가 0인 경우
				strTbl+= `
							<tr>
								<td class="error-info" colspan="5"> 
									<span class="icon material-symbols-outlined">error</span>
									<div class="error-msg">검색 결과가 없습니다</div>
								</td>
							</tr>
				`;
				$('.pagination').html('');
			} else {
				res.articlePage.content.forEach(list => {
				// 판매 유형
				let ntslType = `<span class='bge ${
				    list.ntslType=='NTSL01' ? 'bge-info-border' 
				    : list.ntslType=='NTSL02' ? 'bge-active-border' 
				    : 'bge-danger-border'}'>${list.ntslTypeNm}</span>`;
				// 유형
				let type = `<span class='bge ${
				    list.menuType=='MENU01' ? 'bge-active' 
				    : list.menuType=='MENU02' ? 'bge-warning' 
				    : list.menuType=='MENU03' ? 'bge-danger' 
				    : 'bge-info'}'>${list.menuTypeNm}</span>`;
				    
				let inCart = menuList.includes(list.menuNo) ? 
                `active` : '';
                
	    		strTbl += `
				    <tr class="menuDtl" data-no="${list.menuNo}"
				    data-type="${type}" data-amt="${list.menuAmt}" data-nm="${list.menuNm}">
				        <td class="center">${list.rnum}</td>
				        <td class="${inCart}">${list.menuNm}</td>
				        <td class="center">${type}</td>
				        <td class="center">${list.menuAmt.toLocaleString()}</td>
				        <td class="center">${ntslType}</td>
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
				$('#menupage').html(page);
				}
			$('#table-body').html(strTbl)
			}
		});			
 }

/*************************************************************************************
			메뉴 수정!!
*************************************************************************************/
// 추가
function updateMenuAjax(){
	let ntslType = $('#ntslType').val();
	let menuNm = $('#menuNm').val();
	let menuAmt = $('#menuAmt').val();
	let rlsYmdDt = $('#rlsYmd').val();
	let menuExpln = $('#menuExpln').val();
	let mngrId = $('#mngrId').val();
	
	let menuVO = {};
	
	if(rlsYmdDt){
		menuVO.rlsYmd = dateToStr(rlsYmdDt);
	}
	
	menuVO.menuNo = menuNo;
	menuVO.ntslType = ntslType;
	menuVO.menuNm = menuNm;
	menuVO.menuAmt = menuAmt;
	menuVO.menuExpln = menuExpln;
	menuVO.mngrId = mngrId;
	menuVO.ntslType = ntslType;
	
   // 파일 처리
    let file = $('#menuImgFile')[0].files[0]; // 선택한 파일을 가져옴
    let formData = new FormData(); // FormData 객체 생성
     if (file) {
        formData.append('file', file); // 선택한 파일 추가
    }
	    
    formData.append('menuVO', new Blob([JSON.stringify(menuVO)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	
	if(set){ // ************************************************************************* 세트일때!!!!
		let menuSetVOList = [];
		
		$('#table-body-set tr').each(function(index) {
		    // tr에서 필요한 데이터를 추출
		    let mnNo = $(this).data('no'); 
		    let qty = $(this).find('.recipeQty').val(); // 수량
		    
		    // po_seq 부여하여 stockPOList에 추가
		    let menuSetVO = {
		        setNo: menuNo,
		        qty: qty,
		        menuNo : mnNo
		    };
		    
		    menuSetVOList.push(menuSetVO);
		});
		
	 if(menuSetVOList.length.length === 0){
	    	Swal.fire({
	    		  title: "실패",
	    		  text: "레시피를 반드시 입력해주세요.",
	    		  icon: "error"
	    		});
	    	return;
	    }
	    
	    // FormData에 데이터 추가
	    
	    formData.append('menuSetVOList', new Blob([JSON.stringify(menuSetVOList)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	    
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/editSetAjax",
			type : "POST",
			data: formData, // FormData 객체를 전송
	        contentType: false, // 파일 전송 시 false로 설정해야 합니다.
	        processData: false, // FormData를 문자열로 처리하지 않도록 설정
	        beforeSend: function(xhr) { 
	            xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	        },
			success : function(res){
				if(res>0){
					Swal.fire({
					  title: "완료",
					  text: "메뉴가 변경되었습니다.",
					  icon: "success"
					});
				}
			} // success 끝
		});		
	} else{ // ************************************************************************ 일반일때!!!!
		let recipeVOList = [];
		
		$('#table-body-recipe tr').each(function(index) {
		    // tr에서 필요한 데이터를 추출
		    let gdsCode = $(this).data('code'); 
		    let qty = $(this).find('.recipeQty').val(); // 수량
		    
		    // po_seq 부여하여 stockPOList에 추가
		    let recipeVO = {
		        gdsCode: gdsCode,
		        qty: qty,
		        menuNo : menuNo
		    };
		    
		    recipeVOList.push(recipeVO);
		});
		
	 if(recipeVOList.length.length === 0){
	    	Swal.fire({
	    		  title: "실패",
	    		  text: "레시피를 반드시 입력해주세요.",
	    		  icon: "error"
	    		});
	    	return;
	    }
	    
	     // FormData에 데이터 추가
	    
	    formData.append('recipeVOList', new Blob([JSON.stringify(recipeVOList)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	    
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/editAjax",
			type : "POST",
			data: formData, // FormData 객체를 전송
	        contentType: false, // 파일 전송 시 false로 설정해야 합니다.
	        processData: false, // FormData를 문자열로 처리하지 않도록 설정
	        beforeSend: function(xhr) { 
	            xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	        },
			success : function(res){
				if(res>0){
					Swal.fire({
					  title: "완료",
					  text: "메뉴가 변경되었습니다.",
					  icon: "success"
					});
				}
			} // success 끝
		});		
	}// else 끝
}

 /*******************************************
			메뉴 삭제
********************************************/
function deleteMenuAjax(){

	if(set){// ************************************************************************ 세트일때!!!!
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/deleteSetAjax",
			type : "POST",
			data: { menuNo : menuNo },  // 객체 형태로 전송
			// csrf설정 secuity설정된 경우 필수!!
			beforeSend:function(xhr){ 
				xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
			},
			success : function(res){
				if(res>0){
					Swal.fire({
					  title: "완료",
					  text: "메뉴가 성공적으로 삭제되었습니다",
					  icon: "success"
					}).then((result) => {
					 if (result.isConfirmed) {
						 location.href="/hdofc/menu/list";
					}
				});
				} 
			} // success 끝
		});		
	} else {// ************************************************************************ 일반일때!!!!
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/deleteAjax",
			type : "POST",
			data: { menuNo : menuNo },  // 객체 형태로 전송
			// csrf설정 secuity설정된 경우 필수!!
			beforeSend:function(xhr){ 
				xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
			},
			success : function(res){
				if(res>0){
					Swal.fire({
					  title: "완료",
					  text: "메뉴가 성공적으로 삭제되었습니다",
					  icon: "success"
					}).then((result) => {
					 if (result.isConfirmed) {
						 location.href="/hdofc/menu/list";
					}
				});
				} 
			} // success 끝
		});		
	
	}
}
 /*******************************************
			이미지 미리보기
********************************************/

    // 파일 목록 표시를 업데이트하는 함수
    function updateFileList() {
        const fileInput = document.getElementById('menuImgFile');
        const files = fileInput.files; // 선택된 파일 목록
        const previewContainer = document.getElementById('menuImg');
        
        // 미리보기 컨테이너 초기화
        previewContainer.innerHTML = '';

        // 파일이 선택되었는지 확인
        if (files.length > 0) {
            // 첫 번째 파일만 미리보기 생성 (여러 파일 중 첫 번째 파일만 미리보기)
            const file = files[0];

            // 파일 타입이 이미지인지 확인
            if (file.type.match("image.*")) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result; // 파일의 base64 이미지 데이터
                    img.className = 'file-preview'; // CSS 클래스 적용 (필요 시)
                    img.style.maxWidth = '100%'; // 이미지 너비 조정
                    //img.style.maxHeight = '200px'; // 이미지 높이 조정 (필요 시)
                    
                    previewContainer.appendChild(img); // 미리보기 이미지 추가
                };
                
                reader.readAsDataURL(file); // 파일을 읽어 base64로 변환
            } else {
                // 이미지 파일이 아닐 경우 기본 이미지 표시
                const noImage = document.createElement('img');
                noImage.src = '/resources/images/noimage.jpg';
                noImage.className = 'file-preview';
                noImage.style.maxWidth = '100%';
                noImage.style.maxHeight = '200px';
                
                previewContainer.appendChild(noImage);
            }
        }
    }
    
    /*************************************************************************************
			메뉴 등록!!
*************************************************************************************/
// 추가
function insertMenuAjax(){
	let meType = $('input[name="menuType"]:checked').val();
	let ntslType = $('#ntslType').val();
	let menuNm = $('#menuNm').val();
	let menuAmt = $('#menuAmt').val();
	let rlsYmdDt = $('#rlsYmd').val();
	let menuExpln = $('#menuExpln').val();
	let mngrId = $('#mngrId').val();
	
		// 입력값이 하나라도 비어 있으면 경고 메시지 출력
	if (!meType || !ntslType || !menuNm || !menuAmt || !menuExpln || !mngrId) {
	    Swal.fire({
	        title: "실패",
	        text: "필수 항목을 반드시 입력해주세요.",
	        icon: "error"
	    });
	    return; // 함수를 종료하여 이후 코드가 실행되지 않도록 함
	}
	
	let menuVO = {};
	
	if(rlsYmdDt){
		menuVO.rlsYmd = dateToStr(rlsYmdDt);
	}
	menuVO.menuType = meType;
	menuVO.menuNo = menuNo;
	menuVO.ntslType = ntslType;
	menuVO.menuNm = menuNm;
	menuVO.menuAmt = menuAmt;
	menuVO.menuExpln = menuExpln;
	menuVO.mngrId = mngrId;
	menuVO.ntslType = ntslType;
	
   // 파일 처리
    let file = $('#menuImgFile')[0].files[0]; // 선택한 파일을 가져옴
    let formData = new FormData(); // FormData 객체 생성
     if (file) {
        formData.append('file', file); // 선택한 파일 추가
    }
	    
    formData.append('menuVO', new Blob([JSON.stringify(menuVO)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	
	if(set){ // ************************************************************************* 세트일때!!!!
		let menuSetVOList = [];
		
		$('#table-body-set tr').each(function(index) {
		    // tr에서 필요한 데이터를 추출
		    let mnNo = $(this).data('no'); 
		    let qty = $(this).find('.recipeQty').val(); // 수량
		    
		    // po_seq 부여하여 stockPOList에 추가
		    let menuSetVO = {
		        setNo: menuNo,
		        qty: qty,
		        menuNo : mnNo
		    };
		    
		    menuSetVOList.push(menuSetVO);
		});
		
	 if(menuSetVOList.length === 0){
	    	Swal.fire({
	    		  title: "실패",
	    		  text: "레시피를 반드시 입력해주세요.",
	    		  icon: "error"
	    		});
	    	return;
	    }
	    
	    // FormData에 데이터 추가
	    
	    formData.append('menuSetVOList', new Blob([JSON.stringify(menuSetVOList)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	    
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/registSetAjax",
			type : "POST",
			data: formData, // FormData 객체를 전송
	        contentType: false, // 파일 전송 시 false로 설정해야 합니다.
	        processData: false, // FormData를 문자열로 처리하지 않도록 설정
	        beforeSend: function(xhr) { 
	            xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	        },
			success : function(res){
				Swal.fire({
				  title: "완료",
				  text: "메뉴가 변경되었습니다.",
				  icon: "success"
				}).then((result) => {
					 if (result.isConfirmed) {
					 	location.href='/hdofc/menu/dtl?menuNo='+res;
					 } 
				});
			} // success 끝
		});		
	} else{ // ************************************************************************ 일반일때!!!!
		let recipeVOList = [];
		
		$('#table-body-recipe tr').each(function(index) {
		    // tr에서 필요한 데이터를 추출
		    let gdsCode = $(this).data('code'); 
		    let qty = $(this).find('.recipeQty').val(); // 수량
		    
		    // po_seq 부여하여 stockPOList에 추가
		    let recipeVO = {
		        gdsCode: gdsCode,
		        qty: qty,
		        menuNo : menuNo
		    };
		    
		    recipeVOList.push(recipeVO);
		});
		
	 if(recipeVOList.length.length === 0){
	    	Swal.fire({
	    		  title: "실패",
	    		  text: "레시피를 반드시 입력해주세요.",
	    		  icon: "error"
	    		});
	    	return;
	    }
	    
	     // FormData에 데이터 추가
	    
	    formData.append('recipeVOList', new Blob([JSON.stringify(recipeVOList)], { type: 'application/json' })); // JSON을 Blob 형태로 추가
	    
		// 서버전송
		$.ajax({
			url : "/hdofc/menu/registAjax",
			type : "POST",
			data: formData, // FormData 객체를 전송
	        contentType: false, // 파일 전송 시 false로 설정해야 합니다.
	        processData: false, // FormData를 문자열로 처리하지 않도록 설정
	        beforeSend: function(xhr) { 
	            xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	        },
			success : function(res){
				Swal.fire({
				  title: "완료",
				  text: "메뉴가 변경되었습니다.",
				  icon: "success"
				}).then((result) => {
					 if (result.isConfirmed) {
					 	location.href='/hdofc/menu/dtl?menuNo='+res;
					 } 
				});
			} // success 끝
		});		
	}// else 끝
}