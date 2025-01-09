<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<link href="/resources/com/css/deal.css" rel="stylesheet">
<script src="/resources/hdofc/js/common.js"></script>
<script src="/resources/js/global/value.js"></script>
<script src='/resources/com/js/deal.js'></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let poNo = '';
let currentPage = 1;
let gdsClass = '';
let sort = 'gdsType';
let orderby = 'desc';
let urlParams = new URLSearchParams(window.location.search);
let bzentNo = '<c:out value="${user.bzentNo}"/>';
let type = urlParams.get('type'); 
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

let gdsList = [];

// 구매 목록에 보낼 항목을 저장하는 변수
let poList = {};
let total = 0;

let node = '';
$(function(){
	select2Custom();
	///////////////////////////////// 상품 검색 ////////////////////////////////////
	selectGdsFrcsAjax();
	//$('.po').hide();
	// 테이블 탭 클릭 시 스타일 변화와 데이터 변화
// 	$('.page-tap-cont').on('click', function(){
// 		// 모든 tap-cont에서 active 클래스를 제거
// 	    $('.page-tap-cont').removeClass('active');
// 	    // 클릭된 tap-cont에 active 클래스를 추가
// 	    $(this).addClass('active');
// 	})
	
	$('#gds').on('click', function(){
		$('.gds').show();
		$('.po').hide();
	})
	$('#po').on('click', function(){
		$('.gds').hide();
		$('.po').show();
	})
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#gdsClass').val('');
		$('#gdsType').val('').trigger('change');
		$('#gdsNm').val('');
		$('#sfStockQty').val('');
		$('.select-selected').text('전체');
		
		$('#typeSummary').text('전체');
		$('#clsSummary').text('전체');
		$('#sfSummary').text('전체');
		$('#gdsSummary').text('전체');
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		gdsClass = '';
		selectGdsFrcsAjax();
	})
	//.search-reset
	
	
	// 소유형 선택시
	$('#gdsType').on('change', function(){
		let selectedOption = $(this).find('option:selected'); // 선택된 option 요소
		 let className = selectedOption.attr('class'); // 선택된 option의 클래스 이름
		if(className=='fd'){
			$('#gdsClass').val("FD");
		} else if(className=='sm'){
			$('#gdsClass').val("SM");
		} else if(className=='pm'){
			$('#gdsClass').val("PM");
		}
		var selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
	})
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function(){
	   	if ($(this).hasClass('active')){
	   		$(this).removeClass('active');
	   		$('.search-toggle').html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
	   		$('.search-original').slideDown(300);
	   		$('.search-summary').slideUp(300);
	   	} else {
	   		$(this).addClass('active');
	   		$('.search-toggle').html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
	   		$('.search-original').slideUp(300);
	   		$('.search-summary').slideDown(300);
	   	} 
		
	   	/* 아래 부분은 구현하는 페이지에 맞춰서 작성해주세요!! */
		// 인풋 데이터 가져오기
		let gdsClasss = $('#gdsClass option:selected').text();
		let gdsType= $('#gdsType option:selected').text();
		let gdsNm = $('#gdsNm').val();
		let sfStockQty = $('#sfStockQty option:selected').text();
		
		if(gdsType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(gdsType);
		}
		
		if(gdsClasss==''){
			$('#clsSummary').text('전체');
		}else {
			$('#clsSummary').text(gdsClasss);
		}
		
		if(gdsNm==''){
			$('#gdsSummary').text('전체');
		}else {
			$('#gdsSummary').text(gdsNm);
		}
		
		if(sfStockQty==''){
			$('#sfSummary').text('전체');
		}else {
			$('#sfSummary').text(sfStockQty);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    gdsClass = $('#gdsClass').val();
	    selectGdsFrcsAjax(); 
	    
	 // 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');
	 
	    if(gdsClass=='FD'){
	    	 $('#tap-fd').parent().addClass('active');
	    } else if(gdsClass=='SM'){
	    	 $('#tap-sm').parent().addClass('active');
	    } else if(gdsClass=='PM'){
	    	 $('#tap-pm').parent().addClass('active');
	    } else{
	    	 $('#tap-all').parent().addClass('active');
	    }
	});
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectGdsFrcsAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
 		gdsClass = $(this).data('type');
 		$('#gdsClass').val(gdsClass);
	 	var selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
		selectGdsFrcsAjax();
	})
	
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectGdsFrcsAjax();
	})
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort').removeClass('active');
	      $(this).addClass('active');
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	    	  
	      }
	      currentPage=1;
	      selectGdsFrcsAjax();
	})
	//////////////////////////////////// 모달 /////////////////////////////////
	
	// 이미 담은 항목이면 확인
	$(document).on('click','.gdsDtl',function(){
		let chk = $(this).data('chk');
		node = $(this);
		if(chk){
			Swal.fire({
				  title: "에러",
				  html : `<p>이미 카트에 있는 항목입니다.</p>`,
				  confirmButtonColor: "#3085d6",
				  confirmButtonText: "확인",
				})
		} else {
			let gdsCode = $(this).data('no');
			let gdsNm = $(this).data('nm');
			let unitNm = $(this).data('unit');
			let gdsType = $(this).data('type');
			let qty = $(this).data('qty');
			let amt = $(this).data('amt');
			let max = $(this).data('max');
			
			let inputQty = 1;
			if(qty>0){
				if(max-qty>0){
					inputQty = qty;
				} else {
					inputQty = max;
				}
			}
			
			poList.gdsCode = gdsCode;
			poList.gdsNm = gdsNm;
			poList.unitNm = unitNm;
			poList.gdsType = gdsType;
			poList.qty = qty;
			poList.inputQty = inputQty;
			poList.amt = amt;
			poList.max = max;
			
			addPoFrcsList(poList);
			gdsList.push(poList.gdsCode);
			
			node.data('chk', true);
			node.find('.cartYn').html('<span class="material-symbols-outlined">shopping_cart</span>');
			node.find('.td-cart').addClass('active');
			node = '';
			poList = {};
		}
	})
	
	// 수량 변경
	// 수량 변경시 가격과 총 금액 변경
	$(document).on('change', '.poQty', function(){
		// 현재 입력한 수량을 가져옴
	    let inputQty = $(this).val();
		 
	    let amt = $(this).data('amt');
	    let gdsTotal = inputQty * amt;
	    
	 // 해당 tr의 gdsTotal 셀에 값을 업데이트
	    $(this).closest('tr').find('.gdsTotal').text(gdsTotal.toLocaleString());
	 
	 	// 총 합계(id="total")도 업데이트
	    updateTotal();
	})
	
	// 상품 삭제
	// gdsList에서 삭제 후 총금액변경
	$(document).on('click', '.remove', function(){
		let gdsCode = $(this).data("no");
		$(this).closest("tr").remove();
		// gdsList에서 gdsCode의 인덱스를 찾음
	    let index = gdsList.indexOf(gdsCode);
	    gdsList.splice(index, 1);
	    
	 	// 총 합계(id="total")도 업데이트
	    updateTotal();
	 	
	 	// 카트모양 삭제
	    selectGdsFrcsAjax();
	})
	
	///////////////////////////////// 추가 ////////////////////////////////////
	$('#insertPo').on('click',function(){
		let stockPOList = [];

		$('#po-list tr').each(function(index) {
		    // tr에서 필요한 데이터를 추출
		    let bzentNo = $(this).data('no'); 
		    let gdsCode = $(this).data('code'); 
		    let qty = $(this).find('.poQty').val(); // 수량
		    let gdsAmt = $(this).data('amt'); 
		    
		    // po_seq 부여하여 stockPOList에 추가
		    let stockPO = {
		        poSeq: index + 1,   // 순차적으로 poSeq 부여
		        bzentNo: bzentNo,
		        gdsCode: gdsCode,
		        qty: qty,
		        gdsAmt: gdsAmt
		    };
		    
		    stockPOList.push(stockPO);
		});

		
	    if(stockPOList.length.length === 0){
	    	Swal.fire({
	    		  title: "실패",
	    		  text: "담은 상품이 없습니다",
	    		  icon: "error"
	    		});
	    	return;
	    }
	    //console.log('생성된 bzentNoGroups:', bzentNoGroups);
	    Swal.fire({
	    	  title: "확인",
	    	  html : `<p>발주 신청을 하겠습니까?</p>`,
	    	  icon: "warning",
	    	  showCancelButton: true,
	    	  confirmButtonColor: "#3085d6",
	    	  confirmButtonText: "확인",
	    	  cancelButtonText: "취소"
	    	}).then((result) => {
	    	  /* Read more about isConfirmed, isDenied below */
	    	  if (result.isConfirmed) {
	    	    insertPoFrcsAjax(stockPOList);
	    	  } 
	    	});
	})
	
	$('#resetBtn').on('click', function(){
		$('#po-list').html('');
		gdsList = [];
		updateTotal();
		// 카트모양 삭제
	    selectGdsFrcsAjax();
	})
	
	$('#autoCart').on('click', function(){
		Swal.fire({
	    	  title: "확인",
	    	  html : `<p>현재의 담긴 정보는 삭제가 됩니다.</p><p>안전 재고 수량만큼 카트에 담으시겠습니까?</p>`,
	    	  icon: "warning",
	    	  showCancelButton: true,
	    	  confirmButtonColor: "#3085d6",
	    	  confirmButtonText: "확인",
	    	  cancelButtonText: "취소"
	    	}).then((result) => {
	    	  /* Read more about isConfirmed, isDenied below */
	    	  if (result.isConfirmed) {
	    		  addPoFrcsCartList();
	    	  } 
	    });
	})
})

</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/frcs/deal/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0 po-insert">구매 신청</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default po-insert" id="resetBtn">초기화</button>
			<button type="button" class="btn-active po-insert" id="insertPo">등록 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- 탭 영역 -->
<!-- <div class="table-title blue page-tap"> -->
<!-- 	<div class="cont-title page-tap-wrap"> -->
<!-- 		<div class="page-tap-cont active" id="gds"> -->
<!-- 			<span class="material-symbols-outlined title-icon">package_2</span>상품 선택 -->
<!-- 		</div> -->
<!-- 		<div class="page-tap-cont" id="po"> -->
<!-- 			<span class="material-symbols-outlined title-icon">list_alt</span>구매 목록 -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- wrap 시작 -->
<div class="wrap gds">
	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<sec:authentication property="principal.MemberVO" var="user"/>
				<!-- 대유형 검색조건 -->
				<div class="search-cont w-150">
					<p class="search-title">대유형</p>
					<div class="select-custom">
					<select name="gdsClass" id="gdsClass">
						<option value="">전체</option>
						<option value="FD">식품</option>
						<option value="SM">부자재</option>
						<option value="PM">포장재</option>
					</select>
					</div>
				</div>
				<!-- 소유형 검색조건 -->
				<div class="search-cont" style="width: 180px;">
					<p class="search-title">소유형</p>
					<select name="gdsType" id="gdsType" class="select2-custom">
						<option value="">전체</option>
						<option value="FD01" class="fd">축산 </option>
						<option value="FD02" class="fd">농산물 </option>
						<option value="FD03" class="fd">유제품</option>
						<option value="FD04" class="fd">베이커리</option>
						<option value="FD05" class="fd">조미료/소스</option>
						<option value="FD06" class="fd">냉동식품</option>
						<option value="FD07" class="fd">기타</option>
						<option value="SM01" class="sm">매장 소모품</option>
						<option value="SM02" class="sm">조리 용품</option>
						<option value="SM03" class="sm">위생 용품</option>
						<option value="PM01" class="pm">일회 용품</option>
					</select>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont" style="width: 180px;">
					<p class="search-title">상품명</p>
					<input type="text" id="gdsNm" name="gdsNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 안전 재고 검색조건 -->
				<div class="search-cont w-100">
					<p class="search-title">안전재고</p>
					<div  class="select-custom w-100">
					<select name="sfStockQty" id="sfStockQty">
						<option value="">전체</option>
						<option value="down" selected>미만</option>
						<option value="up">이상</option>
					</select>
					</div>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">대유형 <span class="summary" id="clsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">소유형 <span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상품명 <span class="summary" id="gdsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">안전재고 <span class="summary" id="sfSummary">전체</span></p>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 접기 영역 -->
		
		<!-- 검색 버튼 영역 -->
		<div class="search-control gds">
			<div class="search-control-btns">
				<div class="search-toggle">
					요약보기<span class="icon material-symbols-outlined">Add</span>
				</div>
				<div class="search-reset">
					초기화<span class="icon material-symbols-outlined">restart_alt</span>
				</div>
				<div>
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
	</div>
	<!-- /.search-section -->
		<div class="cont">
					<!-- 테이블 디자인 1 -->
				<div class="table-wrap">
				<!-- 테이블 분류 시작 -->
					<div class="tap-btn-wrap">
						<div class="tap-wrap">
							<div data-type='' class="tap-cont active">
								<span class="tap-title">전체</span>
								<span class="bge bge-default" id="tap-all"></span>
							</div>
							<div data-type='FD' class="tap-cont" >
								<span class="tap-title">식품</span>
								<span class="bge bge-active" id="tap-fd"></span>
							</div>
							<div data-type='SM' class="tap-cont">
								<span class="tap-title">부자재</span>
								<span class="bge bge-warning" id="tap-sm"></span>
							</div>
							<div data-type='PM' class="tap-cont">
								<span class="tap-title">포장재</span>
								<span class="bge bge-danger" id="tap-pm"></span>
							</div>
						</div>
					</div>
				<!-- 테이블 분류 끝 -->
				
					<table class="table-default">
						<thead>
							<tr>
								<th class="center" style="width: 5%;">번호</th>
								<th class="center sort sort-gds" data-sort="gdsNm" style="width: 20%;">상품명
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
								</th>
								<th class="center sort sort-gds" data-sort="qty" style="width: 10%;">보유수량
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
								</th>
								<th class="center sort sort-gds" data-sort="sfStockQty" style="width: 10%;">안전재고
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
								</th>
								<th class="center sort sort-gds" data-sort="unitNm" style="width: 10%;">단위
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
								</th>
								<th class="center" style="width: 10%;">단가(원)
								</th>
								<th class="center" style="width: 10%;">구입가능수량
								</th>
							<th class="center sort sort-gds active" data-sort="gdsType" style="width: 10%;">유형
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc active">▼</span>
									</div>
								</div>
								</th>
							</tr>
						</thead>
						<tbody id="table-body-gds" class="table-error"></tbody>
					</table>
					<div class="pagination-wrap">
						<div class="pagination"></div>
					</div>
					<!-- 페이징 -->
			</div>
			<!-- 테이블 wrap끝 -->
		</div>
		<!-- /cont 상품 목록끝 -->
<!-- 		</div> -->
		<!-- /wrap 상품 목록 끝 gds -->
		
		
<!-- 		<div class="wrap"> -->
		<div class="cont po">
			<div class="table-wrap">
				<div class="table-title">
						<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>구매 목록</div> 
						<div class="btn-wrap">
							<!-- 카트에 대한 툴팁 -->
							<div class="tooltip-wrap">
								<button class="btn btn-active" type="button" id="autoCart" class="tooltip-custom"
									data-bs-toggle="tooltip"
									title="원래 있던 카트내역이 사라지고 부족한 안전재고 수량 만큼 자동으로 카트에 담깁니다.">자동 담기</button>
								</button>
							</div>
							<!-- /카트에 대한 툴팁 -->
						</div>
				</div>
				<table class="table-blue gds-table">
				<thead>
					<tr>
						<th style="text-align:center; width: 8%;">삭제</th>
						<th style="text-align:center; width: 17%;">상품명</th>
						<th style="text-align:center; width: 13%;">유형</th>
						<th style="text-align:center; width: 12%;">수량</th>
						<th style="text-align:center; width: 10%;">단위</th>
						<th style="text-align:center; width: 14%;">단가</th>
						<th style="text-align:center; width: 13%;">가격</th>
					</tr>
				</thead>
				<tbody id="po-list">
				</tbody>
				<tfoot>
					<tr>
						<th colspan="2" style="text-align:center; width: 30%;">총 금액(원)</th>
						<td colspan="6" style="width: 70%;"><span id="clclnAmt">0</span></td>
					</tr>
				</tfoot>
			</table>
			</div>
			<!-- /.table-wrap 관리자 정보 -->
		</div>
		<!-- /cont 발주 목록 -->
	</div>
	<!-- /wrap 발주목록  -->
