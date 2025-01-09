<%--
 	@fileName    : selectGds.jsp
 	@programName : 상품 재고 현황
 	@description : 상품 재고현황을 확인하기 위한 페이지
 	@author      : 이병훈
 	@date        : 2024. 09. 23
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/resources/cnpt/js/gds.js"></script>
<sec:authentication property="principal.MemberVO" var="user" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Chart.js 라이브러리 추가 -->
 
<script>
let currentPage = 1;
// 기본 정렬 기준
let sort = 'gdsNm';
// 기본 오름차순 정렬
let orderby = 'asc';

let bzentNo = "${user.bzentNo}";
// 대유형
let gdsClass = '';

let bzentType = "${bzentType}";

//대유형에 따라 소유형의 view변경
function changeSelect(){
	let gdsT = $('#gdsClass').val();
	console.log(gdsT);
	$('.fd').hide();
	$('.sm').hide();
	$('.pm').hide();
	
	if(gdsT=='FD'){
		$('.fd').show();
	} else if(gdsT=='SM'){
		$('.sm').show();
	} else if(gdsT=='PM'){
		$('.pm').show();
	} else{
		$('.fd').show();
		$('.sm').show();
		$('.pm').show();
	}
}

$(function(){
	select2Custom();
	//상품 제고 리스트 
	selectGdsAjax();
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		$('#gdsClass').val('');
		$('#gdsType').val('');
		$('#gdsNm').val('');
		$('#ntslType').val('');
		$('.select-selected').text('전체');
		
		$('#typeSummary').text('전체');
		$('#sfSummary').text('전체');
		$('#gdsSummary').text('전체');
		$('#ntslSummary').text('전체');
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
		
		gdsClass = '';
		$('.fd').show();
		$('.sm').show();
		$('.pm').show();
		selectGdsAjax();
	})
	//.search-reset
	
	// 대유형 소유형에 따라서 select박스 변화
	$('#gdsClass').on('change', function(){
		changeSelect();
		$('#gdsType').val('');
	}); 
	
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
		changeSelect();
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
		let ntslType= $('#ntslType option:selected').text();
		
		if(gdsType==''){
			$('#typeSummary').text('전체');
		}else {
			$('#typeSummary').text(gdsType);
		}
		// 담당자 데이터 입력
		if(gdsClasss==''){
			$('#clsSummary').text('전체');
		}else {
			$('#clsSummary').text(gdsClasss);
		}
		// 담당자 데이터 입력
		if(gdsNm==''){
			$('#gdsSummary').text('전체');
		}else {
			$('#gdsSummary').text(gdsNm);
		}
		// 담당자 데이터 입력
		if(ntslType==''){
			$('#ntslSummary').text('전체');
		}else {
			$('#ntslSummary').text(ntslType);
		}
		
	})
	//.search-toggle
	
	$('#searchBtn').on('click', function() {
	    currentPage = 1;
	    gdsClass = $('#gdsClass').val();
	    selectGdsAjax(); 
	    
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
		selectGdsAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    
	    // 선택한 탭의 데이터 속성에서 ntslType 값을 가져옴 (GDNT02 또는 GDNT03)
	    let ntslType = $(this).data('type'); 
	    $('#ntslType').val(ntslType); // 숨겨진 필드에 ntslType 값을 설정
	    
//  	gdsClass = $(this).data('type');
	    
 		$('#gdsClass').val(gdsClass);
 		
 		// 대유형 선택 박스의 UI에도 반영되도록 설정
 		let selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
		
	 	selectGdsAjax();
	});

	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectGdsAjax();
	});
	
	// 검색 후, 입력 텍스트 초기화
	$(".search-btn").on("click", function(){
		currentPage = 1;
		$("#keyword").val("");
	});
	
	// 초기화 버튼 클릭시 목록 처음으로
	$("#resetBtn").on("click", function(){
		// 검색 조건 초기화
		location.reload();
		
	});
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort').on('click',function(){
	   
      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
      
      sort = $(this).data('sort');
      orderby = (orderby === 'asc') ? 'desc' : 'asc';
      
      // 모든 th.center 요소에서 active 클래스를 제거
      $("th.center").removeClass("active");
      
      // 현재 클릭된 th에만 active 클래스 추가
      $(this).addClass("active");
      
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
      
   	  // 모든 화살표 상태 초기화
      $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');

      // 현재 상태에 맞춰 active 추가
      if (orderby === 'asc') {
          sortAsc.addClass('active');
      } else {
          sortDesc.addClass('active');
      }
      
      currentPage=1;
      selectGdsAjax();
	})
	
	// 상품 클릭 시, 상품 상세 페이지 이동
	$(document).on("click", ".product-row" ,function(){
		let gdsCode = $(this).data("gds-code");

		console.log("상품 상세 gdsCode : " + gdsCode);
		
		location.href="/cnpt/gds/selectGdsDtl?gdsCode="+gdsCode;
		
	// 상품 클릭시 이벤트 함수 끝
	});
	
});

</script>
<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="crow mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">재고 관리</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<div class="wrap">
	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 대유형 검색조건 -->
<!-- 				<div class="search-cont w-150"> -->
<!-- 					<p class="search-title">대유형</p> -->
<!-- 					<div class="select-custom"> -->
<!-- 						<select name="gdsClass" id="gdsClass" disabled> -->
<%-- 							<option value="FD" ${bzentType == 'BZ_C01' ? 'selected' : ' ' }>식품</option> --%>
<%-- 							<option value="SM" ${bzentType == 'BZ_C02' ? 'selected' : ' ' }>부자재</option> --%>
<%-- 							<option value="PM" ${bzentType == 'BZ_C03' ? 'selected' : ' ' }>포장재</option> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<!-- 소유형 검색조건 -->
				<div class="search-cont w-100">
					<p class="search-title">상품 유형</p>
					<div class="select-custom" style="width:120px;">
						<select name="gdsType" id="gdsType">
							<option value="">전체</option>
							
							<c:if test="${bzentType == 'BZ_C01'} }">
								<option value="FD01" class="fd">축산 </option>
								<option value="FD02" class="fd">농산물 </option>
								<option value="FD03" class="fd">유제품</option>
								<option value="FD04" class="fd">베이커리</option>
								<option value="FD05" class="fd">조미료/소스</option>
								<option value="FD06" class="fd">냉동식품</option>
								<option value="FD07" class="fd">기타</option>
							</c:if>
							<c:if test="${bzentType == 'BZ_C02' }">
								<option value="SM01" class="sm">매장 소모품</option>
								<option value="SM02" class="sm">조리 용품</option>
								<option value="SM03" class="sm">위생 용품</option>
							</c:if>
							<c:if test="${bzentType == 'BZ_C03' }">
								<option value="PM01" class="pm">일회 용품</option>
							</c:if>
						</select>
					</div>	
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont" style="position: relative; left:10px;">
					<p class="search-title">상품명</p>
					<input type="text" id="gdsNm" name="gdsNm" placeholder="키워드를 입력하세요"> 
				</div>
				<!-- 등록 재고 검색조건 -->
				<div class="search-cont w-150">
					<p class="search-title">판매여부</p>
					<div class="select-custom">
						<select name="ntslType" id="ntslType">
							<option value="">전체</option>
							<option value="GDNT02">미판매</option>
							<option value="GDNT03">판매중</option>
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
					<p class="search-title">상품 유형<span class="summary" id="typeSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">상품명 <span class="summary" id="gdsSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 검색조건 -->
				<div class="search-cont">
					<p class="search-title">판매여부 <span class="summary" id="ntslSummary">전체</span></p>
				</div>
				<div class="divide-border"></div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 접기 영역 -->
		
		<!-- 검색 버튼 영역 -->
		<div class="search-control">
			<div class="search-control-btns">
				<div class="search-toggle">
					요약보기<span class="icon material-symbols-outlined">Add</span>
				</div>
				<div class="search-reset" id="resetBtn">
					초기화<span class="icon material-symbols-outlined">restart_alt</span>
				</div>
				<div>
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
	</div>
	<!-- /.search-section -->
	
	<!-- 테이블 디자인 1 -->
		<div class="cont">
			<div class="table-wrap">
				<div class="tap-btn-wrap">
					<div class="tap-wrap">
						<div data-type="" class="tap-cont active">
							<span class="tap-title">전체</span>
							<span class="bge bge-default" id="tap-all">${all}</span>
						</div>
						<div data-type='GDNT03' class="tap-cont" >
							<span class="tap-title">판매중</span>
							<span class="bge bge-active" id="tap-selling">${selling}</span>
						</div>
						<div data-type='GDNT02' class="tap-cont">
							<span class="tap-title">미판매</span>
							<span class="bge bge-warning" id="tap-notSelling">${notSelling}</span>
						</div>
					</div>
					<div class="tap-btn-wrap">
						<div class="btn-wrap">
							<button class="btn-default" id="gdsExcel"
									onclick="window.location.href='/cnpt/gds/downloadExcel?bzentNo='+bzentNo">엑셀<span class="material-symbols-outlined icon">download</span></button>
							<button class="btn-active" onclick="location.href='/cnpt/gds/regist?bzentType=${bzentType}'">상품 등록 <span class="icon material-symbols-outlined">East</span></button>		
						</div>
					</div>
				</div>
				<table class="table-default">
					<thead>
						<tr>
							<th class="center th-rnum">번호</th>
							<th class="center sort sort-gds th-gdsNm" data-sort="gdsNm">상품 명
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort th-amt" data-sort="gty">수 량</th>
							<th class="center sort th-unitNm" data-sort="unitNm">단 위</th>
							<th class="center sort sort-gds th-amt" data-sort="amt">상품 단가 (원)
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-gds" data-sort="ntslType">판매유형
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
							<th class="center sort sort-gds" data-sort="gdsType">유형
								<div class="sort-icon">
									<div class="sort-arrow">
									  <span class="sort-asc">▲</span>
									  <span class="sort-desc">▼</span>
									</div>
								</div>
							</th>
						</tr>
					</thead>
					<tbody id="table-body">
						
					</tbody>
				</table>
				<!-- 페이지네이션 -->
				<div class="pagination-wrap">
					<div class="pagination">
					</div>
				</div>
		<!-- table-wrap -->
		</div>
	<!-- /테이블 디자인 1 -->
	</div>
	<!-- cont 끝 -->
</div>