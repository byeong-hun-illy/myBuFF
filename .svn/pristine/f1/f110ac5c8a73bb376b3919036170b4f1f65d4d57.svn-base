<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.buff.util.Telno" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<link href="/resources/hdofc/css/menu.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src="/resources/hdofc/js/menu.js"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let mbrId = '<c:out value="${user.mbrId}"/>';
let menuNo = '';
let sort = '';
let orderby = '';
let currentPage = 1;
let menuType = '';
let set = false;
let urlParams = new URLSearchParams(window.location.search);
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
let gdsList = [];
let menuList = [];
$(function(){
	 $('input[name="menuType"]').on('change', function() {
		 let mt = $('input[name="menuType"]:checked').val();
	    if(mt == 'MENU01') {
	        $('.menu-recipe').hide();
	        $('.set-recipe').show();
	        set = true;
	    } else {
	    	set = false;
	        $('.menu-recipe').show();
	        $('.set-recipe').hide();
	    }
	});
	
	select2Custom();
	if (urlParams.has('menuNo')) { // 상세
		menuNo = urlParams.get('menuNo');  
		$('.menu-insert').hide();
		selectMenuDtlAjax();
	} else{ // 추가
		$('.menu-dtl').hide();
		$('#mngrId').val(mbrId);
		$('#mngrNm').val('<c:out value="${user.mbrNm}"/>');
		$('#mngrEmlAddr').val('<c:out value="${user.mbrEmlAddr}"/>');
		let telno = '<c:out value="${user.mbrTelno}"/>'
		let telnoArr = splitTel(telno);
		$('#mngrTelno1').val(telnoArr[0]);
		$('#mngrTelno2').val(telnoArr[1]);
		$('#mngrTelno3').val(telnoArr[2]);
		
		$('.menu-recipe').hide();
		$('.set-recipe').hide();
	}
	
	/////////// 관리자 ///////////////////////////
	/////////////////////// 관리자 변경 /////////////////////////////
	
	var modal = new bootstrap.Modal(document.getElementById('staticBackdrop'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	// 관리자 모달 실행
	$('.update-mngr').on('click', function(){
		$('.frcs-insert').hide();
		Swal.fire({
			  title: "관리자를 변경하시겠습니까?",
			  showCancelButton: true,
			  confirmButtonText: "확인",
			  cancelButtonText: "취소",
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#7F9CAB",
			}).then((result) => {
			  /* Read more about isConfirmed, isDenied below */
				 if (result.isConfirmed) {
					 modal.show();
					 // 정렬 초기값
					 sort = "jncmp";
					 orderby = 'asc';
					 currentPage = 1;
					 select2Custom();
					 selectMngrAjax();
				 } else{
				 	Swal.fire("변경되지 않았습니다", "", "info");
				 }
			});
	})
	
	// 모달 닫기
	$('.modal-close').on('click',function(){
		$('.warning').text('');
		modal.hide();
		
		mbrModal.hide();
	})
	
	///// 관리자 검색 시작/////
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-mngr').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort-mngr').removeClass('active');
	      $(this).addClass('active');
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-mngr .sort-arrow .sort-asc, .sort-mngr .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectMngrAjax();
	})
	
	// 관리자 검색어 검색 결과
	$('#submit-mngr').on('click',function(){
		currentPage=1;
		selectMngrAjax();
	})
	
	///// 관리자 검색 끝 /////
	
	// 관리자 페이징 처리
	$(document).on('click','.page-mngr',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		selectMngrAjax();
	})
	
	// 관리자 테이블 클릭 시
	$(document).on('click', '.mngrDtl', function(){
		let mngrId = $(this).data('id');
		let mbrNm = $(this).data('nm');
		let mbrTel = $(this).data('tel');
		let mbrTelArr = splitTel(mbrTel);
		let mbrEml = $(this).data('eml');
		$('.warning').text('');
		
		$('#mngrId').val(mngrId)
		$('#mngrNm').val(mbrNm);
		$('#mngrTelno1').val(mbrTelArr[0]);
		$('#mngrTelno2').val(mbrTelArr[1]);
		$('#mngrTelno3').val(mbrTelArr[2]);
		$('#mngrEml').val(mbrEml);
		
		modal.hide();
	})
	///////////// 관리자 끝
	
	///////////////////////////////// 레시피 수정
	// 상품 삭제
	// gdsList에서 삭제 후 총금액변경
	$(document).on('click', '.remove', function(){
		if(set){ // 세트일경우
			let mno = $(this).data("no");
			// menuList에서 menuNo의 인덱스를 찾음
		    let index = menuList.indexOf(mno);
		    menuList.splice(index, 1);
		} else{ // 일반 메뉴일 경우
			let gdsCode = $(this).data("no");
			// gdsList에서 gdsCode의 인덱스를 찾음
		    let index = gdsList.indexOf(gdsCode);
		    gdsList.splice(index, 1);
		}
		
		$(this).closest("tr").remove();
	})
	
	/////////////////////////// 일반 레시피 /////////////////////
	
	var gdsModal = new bootstrap.Modal(document.getElementById('gdsModal'));
	
	$('#gdsAdd').on('click', function(){
		$('#gdsNmModal').val();
		$('#gdsTypeModal').val();
		$('#gdsTypeModal').siblings('.select-selected').text('전체');
		sort = 'gdsNm';
		orderby = 'asc';
		currentPage = 1;
		selectGdsFoodAjax();
		gdsModal.show();
	})
	// 검색어
	$('#submit').on('click', function(){
		currentPage=1;
		selectGdsFoodAjax();
	})
	// 상품 페이징 처리
	$(document).on('click','.page-gds',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		selectGdsFoodAjax();
	})
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort-gds').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      
	      $('.sort-gds').removeClass('active');
	      $(this).addClass('active');
	      
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-gds .sort-arrow .sort-asc, .sort-gds .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-gds .sort-arrow .sort-asc, .sort-gds .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectGdsFoodAjax();
	})
	//// 상품 선택
	$(document).on('click', '.gdsDtl', function(){
		if($(this).find('.active').length>0){
			Swal.fire({
				  title: "이미 등록된 상품입니다",
				  showConfirmButton: false,
				  timer: 500
				});
			return;
		}
		let list = {};

		let gdsNm = $(this).data("nm");
		let gdsCode = $(this).data("no");
		let type = $(this).data("type");
		let unit = $(this).data("unit");
		
		list.gdsNm = gdsNm;
		list.gdsCode = gdsCode;
		list.type =type;
		list.unitNm =unit;
		
		addRecipe(list);
		
		gdsList.push(gdsCode);
	})
	
	
	//////////////////////////// 세트 메뉴 ////////////////////////////
	var menuModal = new bootstrap.Modal(document.getElementById('menuModal'));

	$('#menuAdd').on('click', function(){
		menuModal.show();
		$('#menuNmModal').val();
		$('#ntslTypeModal').val();
		$('#ntslTypeModal').siblings('.select-selected').text('전체');
		$('#menuTypeModal').val();
		$('#menuTypeModal').siblings('.select-selected').text('전체');
		sort = 'menuNm';
		orderby = 'asc';
		selectMenuModalAjax();
	})
	
	$('#searchBtnMenu').on('click', function(){
		currentPage=1;
		menuType = $('#menuTypeModal').val();
		selectMenuModalAjax();
		
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-conts').removeClass('active');
	 
	    if(menuType=='MENU01'){
	    	 $('#tap-menu01').parent().addClass('active');
	    } else if(menuType=='MENU02'){
	    	 $('#tap-menu02').parent().addClass('active');
	    } else if(menuType=='MENU03'){
	    	 $('#tap-menu03').parent().addClass('active');
	    } else if(menuType=='MENU04'){
	    	 $('#tap-menu04').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-conts').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-conts').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    menuType = $(this).data('type');
 		$('#menuTypeModal').val(menuType);
 		var selectedOptionText = $('#menuTypeModal option:selected').text();
 		$('#menuTypeModal').parent().find('.select-selected').text(selectedOptionText);
 		selectMenuModalAjax();
	})
	
	// 상품 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		//console.log($(this).data('page'));
		selectMenuModalAjax();
	})
		//////////////////////// 정렬  ////////////////////////////////
	$('.sort-menu').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      
	      $('.sort-menu').removeClass('active');
	      $(this).addClass('active');
	      
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-menu .sort-arrow .sort-asc, .sort-menu .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-menu .sort-arrow .sort-asc, .sort-menu .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectMenuModalAjax();
	})
	//// 메뉴 선택
	$(document).on('click', '.menuDtl', function(){
		if($(this).find('.active').length>0){
			Swal.fire({
				  title: "이미 등록된 메뉴입니다",
				  showConfirmButton: false,
				  timer: 500
				});
			return;
		}
		let list = {};

		let menuNm = $(this).data("nm");
		let mno = $(this).data("no");
		let type = $(this).data("type");
		let amt = $(this).data("amt");
		
		list.menuNm = menuNm;
		list.menuNo = mno;
		list.type = type;
		list.menuAmt = amt;
		
		console.log(list);
		
		addRecipe(list);
		
		menuList.push(mno);
// 		menuModal.hide();
	})
	
	$('#updateMenu').on('click', function(){
		updateMenuAjax();
	})
		/////////////////////// 추가 /////////////////////////////
	$('#insertMenu').on('click',function(){
		Swal.fire({
			  title: "확인",
			  html: "<p style='color:red'>메뉴 유형은 수정이 불가능합니다</p><p>정말 등록하시겠습니까?</p>",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "생성",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  insertMenuAjax();
			  }
			});
	})
	
	$('#resetBtn').on('click', function(){
		$('.input-reset').val('');
		$('.select-selected').text('미선택');
		$('input[name="menuType"]:checked').prop("checked", false);
		$('#menuImg').text('');
		$('#table-body-recipe').html('');
        $('#table-body-set').html('');
        
        gdsList = [];
        menuList = [];
	})
	/////////////////////////////////////////////////// 삭제
	$('#deleteMenu').on('click', function(){
		Swal.fire({
			  title: "확인",
			  html: "해당 메뉴를 정말 삭제하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#00C157",
			  cancelButtonColor: "#E73940",
			  confirmButtonText: "삭제",
			  cancelButtonText: "취소"
			}).then((result) => {
			  if (result.isConfirmed) {
				  deleteMenuAjax();
			  }
			});
	})
	
	$('#autoInput').on('click', function(){
		$('#ntslType').val('NTSL02')
		$('#ntslType').siblings('.select-selected').text('판매');
		$('#menuNm').val('선데');
		$('#menuAmt').val('2000');
		$('#menuExpln').val('천연바닐라빈과 퓨어버터 첨가로 더욱 고급스러운 프리미엄 밀크 아이스크림!');
	})
})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/menu/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 menu-dtl">메뉴 상세</h1>
	        <h1 class="m-0 menu-insert" id="autoInput">메뉴 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default menu-insert" id="resetBtn">초기화</button>
			<button type="button" class="btn-active menu-insert" id="insertMenu">등록 <span class="icon material-symbols-outlined">East</span></button>
			<button type="button" class="btn-default menu-dtl" onclick="selectMenuDtlAjax()">초기화</button>
			<button type="button" class="btn-danger menu-dtl gds-update" id="deleteMenu">삭제</button>
			<button type="button" class="btn-active menu-dtl menu-dtl" id="updateMenu">저장 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap" style="overflow-x: inherit;">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">lunch_dining</span>메뉴 정보</div> 
					<div class="menu-insert" style="margin-left: var(--gap--l)"><span class="es">*</span> 표기된 항목은 필수입력 항목입니다.</div>
			</div>
			<table class="table-blue">
				<tr>
					<th rowspan="5" style="width: 15%;">
						<label for="menuImgFile" class="btn-active">사진</label>
						<span class="es menu-insert">*</span>
						<input type="file" accept="image/*" name="file" class="input-reset" id="menuImgFile" onchange="updateFileList()" hidden>
					</th>
					<!-- td-img클래스로 사진너비를 테이블 크기와 맞춤,사진 크기는 여기서 조정해줄 것 -->
						<td class="center td-img" rowspan="5" id="menuImg"> 
							
						</td>
						<!-- 사진 td끝 -->
					<th>판매유형 <span class="es menu-insert">*</span></th>
					<td id="ntslTypeTd">
						<div class="select-custom w-100">
							<select name="ntslType" id="ntslType">
								<option value="" disabled selected>미선택</option>
								<c:forEach var="ntsl" items="${ntsl}">
									<option value="${ntsl.comNo}">
									${ntsl.comNm}</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th style="width: 15%;">유형  <span class="es menu-insert">*</span></th>
					<td style="width: 37%" class="menuType">
							<div class="form_toggle row-vh d-flex flex-row" style="gap:var(--gap--s);">
								<div class="form_radio_btn radio_male">
									<input id="radio-1" type="radio" name="menuType" value="MENU01">
									<label for="radio-1">세트</label>
								</div>
								<div class="form_radio_btn">
									<input id="radio-2" type="radio" name="menuType" value="MENU02">
									<label for="radio-2">단품</label>
								</div>
								<div class="form_radio_btn">
									<input id="radio-3" type="radio" name="menuType" value="MENU03">
									<label for="radio-3">사이드</label>
								</div>
								<div class="form_radio_btn">
									<input id="radio-4" type="radio" name="menuType" value="MENU04">
									<label for="radio-4">음료</label>
								</div>
							</div>
					</td>
				</tr>
				<tr>
					<th>상품명  <span class="es menu-insert">*</span></th>
					<td><input id="menuNm" type="text" class="text-input input-reset input-gds"></td>
				</tr>
				<tr>
					<th>단가(원) <span class="es menu-insert">*</span></th>
					<td>
						<input id="menuAmt" type="number" class="input-reset">
					</td>
				</tr>
				<tr class="menu-dtl">
					<th>판매 수량(개)</th>
					<td id="ntslQty">0</td>
				</tr>
				<tr>
					<th class="menu-dtl">등록일자</th>
					<td class="menu-dtl">
						<input type="date" id="regYmd" disabled>
					</td>
					<th>출시일자</th>
					<td>
						<input type="date" id="rlsYmd" class="input-reset">
					</td>
				</tr>
				<tr>
					<th>메뉴 설명 <span class="es menu-insert">*</span></th>
					<td colspan="3">
						<textarea rows="" cols="" id="menuExpln" class="input-reset"></textarea>
					</td>
				</tr>
			</table>
			<div></div>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	
	<!-- cont시작 !!!!!!!세트 레시피-->
	<div class="cont set-recipe">
		<!-- table-wrap 레시피 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">package_2</span>메뉴 레시피 정보  <span class="es menu-insert">*</span></div> 
					<div class="btn-wrap">
						<button class="btn btn-active" id="menuAdd">추가 <span class="material-symbols-outlined icon">add</span></button>
					</div>
			</div>
			<table class="table-blue table-recipe">
				<thead>
					<tr>
						<th class="center">순번</th>
						<th class="center">메뉴명</th>
						<th class="center">유형</th>
						<th class="center">수량</th>
						<th class="center">단가</th>
					</tr>
				</thead>
				<tbody id="table-body-set">
				</tbody>
			</table>
		</div>
		<!-- /.table-wrap 가맹점주 정보 -->
		</div>
		<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont시작 !!!!!!!레시피-->
	<div class="cont menu-recipe">
		<!-- table-wrap 레시피 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">package_2</span>상품 레시피 정보  <span class="es menu-insert">*</span></div> 
					<div class="btn-wrap">
						<button class="btn btn-active" id="gdsAdd">추가 <span class="material-symbols-outlined icon">add</span></button>
					</div>
			</div>
			<table class="table-blue table-recipe">
				<thead>
					<tr>
						<th class="center">순번</th>
						<th class="center">상품명</th>
						<th class="center">유형</th>
						<th class="center">수량</th>
						<th class="center">단위</th>
					</tr>
				</thead>
				<tbody id="table-body-recipe">
				</tbody>
			</table>
		</div>
		<!-- /.table-wrap 가맹점주 정보 -->
		</div>
		<!-- /.cont: 해당 영역의 설명 -->
		
		<!-- cont시작 !!!!!!!등록자-->
	<div class="cont">
		<!-- table-wrap 등록자 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>등록자 정보  <span class="es menu-insert">*</span></div> 
			</div>
			<table class="table-blue">
				<tr>
					<th>이름</th>
					<td>
						<div class="input-wrapper">
							<input id="mngrNm" disabled>
								<button type="button" class="update-btn update-mngr"></button>
							</div>
					</td>
					<th>아이디</th>
					<td>
						<input id="mngrId" disabled class="text-input">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input id="mngrTelno1" type="text" class="input-tel" disabled>-
						<input id="mngrTelno2" type="text" class="input-tel" disabled>-
						<input id="mngrTelno3" type="text" class="input-tel" disabled>
					</td>
					<th>이메일</th>
					<td>
						<input id="mngrEmlAddr" class="text-input" disabled>
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap 가맹점주 정보 -->
		</div>
		<!-- /.cont: 해당 영역의 설명 -->
</div>
<!-- wrap 끝 -->

<!-- --------------------------------------- 모달 시작 ---------------------------------------------------- -->
<!-- 관리자 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/mngrModal.jsp" />
<jsp:include page="/WEB-INF/views/hdofc/modal/gdsModal.jsp" />
<jsp:include page="/WEB-INF/views/hdofc/modal/menuModal.jsp" />

