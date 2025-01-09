<%--
    @fileName    : selectFrcsStockAjmtList.jsp
    @programName : 가맹점 재고 조정 내역 조회
    @description : 가맹점 재고 조정 내역 조회를 위한 페이지
    @author      : 정현종
    @date        : 2024. 09. 30
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<script src='/resources/js/global/value.js'></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user" />

<script type="text/javascript">
let gdsClass = '';
let bzentNo = '${user.bzentNo}';
let mbrId = '${user.mbrId}';

$(function() { // 꼭 여기 안에!	
	select2Custom(); // 셀렉트 디자인 라이브러리. common.js에서 호출 됨
})

$(function() {
	$('.search-reset').on('click', function() {
	    // 각 입력 필드 초기화
	    $('.select-selected').text('전체');
	    $('#ajmtType').val('');   // 조정유형(주문,폐기) 초기화
	    $('#startYmd').val('');   // 조정기간(시작) 초기화
	    $('#endYmd').val('');     // 조정기간(끝) 초기화
	    $('#gdsClass').val('');   // 상품 대유형 초기화
	    $('#gdsType').val('');    // 상품 소유형 초기화
	    $('#gdsNm').val('');      // 상품명 초기화

	    // 요약 초기화
	    $('#ajmtTypeSummary').text('전체');
	    $('#dateSummary').text('전체');
	    $('#gdsClassSummary').text('전체');
	    $('#gdsTypeSummary').text('전체');
	    $('#gdsNmSummary').text('전체');
	    
	    $('.tap-cont').removeClass('active');
		$('#tap-all').parent().addClass('active');
			
		gdsClass = '';
		$('.fd').show();
		$('.sm').show();
		$('.pm').show();
	});
	//.search-reset
	
	// 소유형 선택시
	$('#gdsType').on('change', function() {
		let selectedOption = $(this).find('option:selected'); // 선택된 option 요소
		let className = selectedOption.attr('class'); // 선택된 option의 클래스 이름
		if (className == 'fd') {
			$('#gdsClass').val("FD");
		} else if (className == 'sm') {
			$('#gdsClass').val("SM");
		} else if (className == 'pm') {
			$('#gdsClass').val("PM");
		}
		var selectedOptionText = $('#gdsClass option:selected').text();
	 	$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
	});
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function() {
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
		let ajmtType = $('#ajmtType option:selected').text();  
		let startYmd = $('#startYmd').val();                      
		let endYmd = $('#endYmd').val();                        
		let gdsClass = $('#gdsClass option:selected').text();  
		let gdsType = $('#gdsType option:selected').text();  
		let gdsNm = $('#gdsNm').val();                        
		
		// 조정 유형 입력
		if(ajmtType==''){
			$('#ajmtTypeSummary').text('전체');
		}else {
			$('#ajmtTypeSummary').text(ajmtType);
		}

		// 조정 일자 입력
		if(startYmd=='' && endYmd ==''){
			$('#dateSummary').text('전체');
		}else {
			$('#dateSummary').text(startYmd + "~" + endYmd);
		}

		// 대유형 데이터 입력
		if(gdsClass==''){
			$('#gdsClassSummary').text('전체');
		}else {
			$('#gdsClassSummary').text(gdsClass);
		}

		// 소유형 데이터 입력
		if(gdsType==''){
			$('#gdsTypeSummary').text('전체');
		}else {
			$('#gdsTypeSummary').text(gdsType);
		}

		// 상품 명 데이터 입력
		if (gdsNm == '') {
			$('#gdsNmSummary').text('전체');
		} else {
			$('#gdsNmSummary').text(gdsNm);
		}

	})
	//.search-toggle
	
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function() {

		// 모든 tap-cont에서 active 클래스를 제거
		$('.tap-cont').removeClass('active');

		// 클릭된 tap-cont에 active 클래스를 추가
		$(this).addClass('active');
		eventType = $(this).data('type');
		$('#ajmtType').val(eventType);
		var selectedOptionText = $('#ajmtType option:selected').text();
		$('#ajmtType').parent().find('.select-selected').text(selectedOptionText);
	})
		
	//대유형에 따라 소유형의 view변경
	function changeSelect() {
		let gdsT = $('#gdsClass').val();
		console.log(gdsT);
		$('.fd').hide();
		$('.sm').hide();
		$('.pm').hide();

		if (gdsT == 'FD') {
			$('.fd').show();
		} else if (gdsT == 'SM') {
			$('.sm').show();
		} else if (gdsT == 'PM') {
			$('.pm').show();
		} else {
			$('.fd').show();
			$('.sm').show();
			$('.pm').show();
		}
	}
	
});
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">재고 조정 내역 조회</h1>
			</div>
		</div>
	</div>
</div>

<div class="wrap">
	<div class="search-section">
		<form id="searchForm">
			<!-- 검색 영역 -->
			<div class="cont search-original">
				<div class="search-wrap">
					<!-- 조정 유형 검색조건 -->
					<div class="search-cont w-150">
						<p class="search-title">조정 유형</p>
						<div class="select-custom">
							<select name="ajmtType" id="ajmtType">
								<option value="">전체</option>
								<option value="AJMT03"
									<c:if test="${param.ajmtType == 'AJMT03'}">selected</c:if>>판매</option>
								<option value="AJMT02"
									<c:if test="${param.ajmtType == 'AJMT02'}">selected</c:if>>폐기</option>
							</select>
						</div>
					</div>

					<!-- 조정 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">조정 일자</p>
						<div class="search-date-wrap">
							<input type="date" id="startYmd" name="startYmd"
								value="${param.startYmd}"> ~ <input type="date"
								id="endYmd" name="endYmd" value="${param.endYmd}">
						</div>
					</div>

					<!-- 대유형 검색조건 -->
					<div class="search-cont w-150">
						<p class="search-title">대유형</p>
						<div class="select-custom">
							<select name="gdsClass" id="gdsClass">
								<option value="">전체</option>
								<option value="FD"
									<c:if test="${param.gdsClass == 'FD'}">selected</c:if>>식품</option>
								<option value="SM"
									<c:if test="${param.gdsClass == 'SM'}">selected</c:if>>부자재</option>
								<option value="PM"
									<c:if test="${param.gdsClass == 'PM'}">selected</c:if>>포장재</option>
							</select>
						</div>
					</div>

					<!-- 소유형 검색조건 -->
					<div class="search-cont w-200">
						<p class="search-title">소유형</p>
						<select class="select2-custom" name="gdsType" id="gdsType">
							<option value="">전체</option>
							<option value="FD01" class="fd"
								<c:if test="${param.gdsType == 'FD01'}">selected</c:if>>축산</option>
							<option value="FD02" class="fd"
								<c:if test="${param.gdsType == 'FD02'}">selected</c:if>>농산물</option>
							<option value="FD03" class="fd"
								<c:if test="${param.gdsType == 'FD03'}">selected</c:if>>유제품</option>
							<option value="FD04" class="fd"
								<c:if test="${param.gdsType == 'FD04'}">selected</c:if>>베이커리</option>
							<option value="FD05" class="fd"
								<c:if test="${param.gdsType == 'FD05'}">selected</c:if>>조미료/소스</option>
							<option value="FD06" class="fd"
								<c:if test="${param.gdsType == 'FD06'}">selected</c:if>>냉동식품</option>
							<option value="FD07" class="fd"
								<c:if test="${param.gdsType == 'FD07'}">selected</c:if>>기타</option>
							<option value="SM01" class="sm"
								<c:if test="${param.gdsType == 'SM01'}">selected</c:if>>매장소모품</option>
							<option value="SM02" class="sm"
								<c:if test="${param.gdsType == 'SM02'}">selected</c:if>>조리용품</option>
							<option value="SM03" class="sm"
								<c:if test="${param.gdsType == 'SM03'}">selected</c:if>>위생용품</option>
							<option value="PM01" class="pm"
								<c:if test="${param.gdsType == 'PM01'}">selected</c:if>>일회용품</option>
						</select>
					</div>

					<!-- 상품 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">상품 명</p>
						<input type="text" id="gdsNm" name="gdsNm"
							placeholder="키워드를 입력하세요" value="${param.gdsNm}">
					</div>
				</div>
			</div>
			<!-- /.search-wrap -->

			<!-- 검색 접기 영역 -->
			<div class="cont search-summary">
				<div class="search-wrap">
				
					<!-- 조정 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							조정 유형 <span class="summary" id="ajmtTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 조정 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							조정 일자 <span class="summary" id="dateSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 대유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							대유형 <span class="summary" id="gdsClassSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 소유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							소유형 <span class="summary" id="gdsTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 상품 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							상품명 <span class="summary" id="gdsNmSummary">미입력</span>
						</p>
					</div>
				</div>
			</div>
			<!-- /.search-summary -->

			<!-- 검색 버튼 영역 -->
			<div class="search-control">
				<div class="search-control-btns">
					<div class="search-toggle">
						요약보기<span class="icon material-symbols-outlined">Add</span>
					</div>
					<div class="search-reset">
						초기화<span class="icon material-symbols-outlined">restart_alt</span>
					</div>
					<div>
						<button class="btn btn-default search" id="searchBtn">
							검색 <span class="icon material-symbols-outlined">search</span>
						</button>
					</div>
				</div>
			</div>
			<!-- /.검색 버튼 영역 -->
		</form>
	</div>
	<!-- 검색 조건 끝 -->


	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-wrap">
				<div data-type="" class="tap-cont active">
					<span class="tap-title">전체</span> <span class="bge bge-default"
						id="tap-all">${all}</span>
				</div>
				<div data-type="AJMT03" class="tap-cont">
					<span class="tap-title">판매</span> <span class="bge bge-info"
						id="tap-waiting">${order}</span>
				</div>
				<div data-type="AJMT02" class="tap-cont">
					<span class="tap-title">폐기</span> <span class="bge bge-active"
						id="tap-progress">${dispose}</span>
				</div>
			</div>
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">상품명</th>
						<th class="center">대유형</th>
						<th class="center">소유형</th>
						<th class="center">조정 유형</th>
						<th class="center">조정 수량</th>
						<th class="center">조정 일자</th>
						<th class="center">조정 사유</th>

					</tr>
				</thead>
				<!-- 검색 결과가 0인 경우 -->
				<c:if test="${articlePage.total == 0}">
					<tbody id="table-body" class="table-error">
						<tr>
							<td class="error-info" colspan="8"><span
								class="icon material-symbols-outlined">error</span>
								<div class="error-msg">검색 결과가 없습니다</div></td>
						</tr>
					</tbody>
				</c:if>
				<tbody>
					<c:forEach var="gdsVO" items="${articlePage.content}">
						<tr>
							<td class="center">${gdsVO.rnum}</td>
							<td>${gdsVO.gdsNm}</td>
							<td class="center"><c:choose>
									<c:when
										test="${gdsVO.gdsType == 'FD01' || gdsVO.gdsType == 'FD02' || gdsVO.gdsType == 'FD03' || gdsVO.gdsType == 'FD04' || gdsVO.gdsType == 'FD05' || gdsVO.gdsType == 'FD06'}">
									식품
								</c:when>
									<c:when
										test="${gdsVO.gdsType == 'SM01' || gdsVO.gdsType == 'SM02' || gdsVO.gdsType == 'SM03'}">
									부자재
								</c:when>
									<c:when test="${gdsVO.gdsType == 'PM01'}">
									포장재
								</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose></td>
							<td class="center"><c:choose>
									<c:when test="${gdsVO.gdsType == 'FD01'}">축산</c:when>
									<c:when test="${gdsVO.gdsType == 'FD02'}">농산물</c:when>
									<c:when test="${gdsVO.gdsType == 'FD03'}">유제품</c:when>
									<c:when test="${gdsVO.gdsType == 'FD04'}">베이커리</c:when>
									<c:when test="${gdsVO.gdsType == 'FD05'}">조미료/소스</c:when>
									<c:when test="${gdsVO.gdsType == 'FD06'}">냉동식품</c:when>
									<c:when test="${gdsVO.gdsType == 'PM01'}">일회 용품</c:when>
									<c:when test="${gdsVO.gdsType == 'SM01'}">매장 소모품</c:when>
									<c:when test="${gdsVO.gdsType == 'SM02'}">조리 용품</c:when>
									<c:when test="${gdsVO.gdsType == 'SM03'}">위생 용품</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose></td>
							<td class="center">
								<c:if test="${gdsVO.stockVOList[0].stockAjmtVOList[0].ajmtType == 'AJMT03'}">
						       		<span class="bge bge-info">판매</span>
						    	</c:if> 
						    	<c:if test="${gdsVO.stockVOList[0].stockAjmtVOList[0].ajmtType == 'AJMT02'}">
						       		<span class="bge bge-active">폐기</span>
						    	</c:if>
						    </td>
						    <td class="right"><fmt:formatNumber value="${gdsVO.stockVOList[0].stockAjmtVOList[0].qty}" pattern="#,###"/></td>
							<td class="center"><c:set var="useYmd"
									value="${gdsVO.stockVOList[0].stockAjmtVOList[0].ajmtYmd}" />
								${fn:substring(useYmd, 0, 4)}-${fn:substring(useYmd, 4, 6)}-${fn:substring(useYmd, 6, 8)}
							</td>
							<td>${gdsVO.stockVOList[0].stockAjmtVOList[0].ajmtRsn}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- pagination-wrap -->
			<!-- 검색 결과가 0인 경우 -->
			<c:if test="${articlePage.total > 0}">
				<div class="pagination-wrap">
					<div class="pagination">
						<c:if test="${articlePage.startPage gt 5}">
							<a
								href="/frcs/stockAjmtList?ajmtType=${param.ajmtType}&startYmd=${param.startYmd}&endYmd=${param.endYmd}&gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&gdsNm=${param.gdsNm}&currentPage=${articlePage.startPage - 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<c:forEach var="pNo" begin="${articlePage.startPage}"
							end="${articlePage.endPage}">
							<a
								href="/frcs/stockAjmtList?ajmtType=${param.ajmtType}&startYmd=${param.startYmd}&endYmd=${param.endYmd}&gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&gdsNm=${param.gdsNm}&currentPage=${pNo}"
								class="page-link <c:if test="${pNo == articlePage.currentPage}">active</c:if>">
								${pNo} </a>
						</c:forEach>
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a
								href="/frcs/stockAjmtList?ajmtType=${param.ajmtType}&startYmd=${param.startYmd}&endYmd=${param.endYmd}&gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&gdsNm=${param.gdsNm}&currentPage=${articlePage.startPage + 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<!-- pagination-wrap -->
</div>
<!-- table-wrap -->