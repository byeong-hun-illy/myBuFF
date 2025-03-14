<%--
    @fileName    : selectFrcsStockList.jsp
    @programName : 가맹점 재고 관리
    @description : 가맹점 재고 관리를 위한 페이지
    @author      : 정현종
    @date        : 2024. 09. 20
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
	let bzentNo = 'HO0001';
	let mbrId = '${user.mbrId}';

	$(function() { // 꼭 여기 안에!	
		select2Custom(); // 셀렉트 디자인 라이브러리. common.js에서 호출 됨
	})

	$(function() {
		// 검색영역 초기화
		$('.search-reset').on('click', function() {
			$('#gdsClass').val(''); // 대유형 초기화
			$('#gdsType').val('').trigger('change'); // 소유형 초기화
			$('#keyword').val(''); // 상품 명 초기화
			$('#sfStockQty').val(''); // 안전재고 초기화

			$('#gdsTypeSummary').text('전체');
			$('#keywordSummary').text('전체');
			$('#sfSummary').text('전체');

			$('.tap-cont').removeClass('active');
			$('#tap-all').parent().addClass('active');

			gdsClass = '';
			$('.fd').show();
			$('.sm').show();
			$('.pm').show();
			
			window.location.href = "/frcs/stockList";  // 페이지 이동
		})
		//.search-reset

		// 소유형 선택시
		$('#gdsType').on(
				'change',
				function() {
					let selectedOption = $(this).find('option:selected'); // 선택된 option 요소
					let className = selectedOption.attr('class'); // 선택된 option의 클래스 이름
					if (className == 'fd') {
						$('#gdsClass').val("FD");
					} else if (className == 'sm') {
						$('#gdsClass').val("SM");
					} else if (className == 'pm') {
						$('#gdsClass').val("PM");
					}
					var selectedOptionText = $('#gdsClass option:selected')
							.text();
					$('#gdsClass').parent().find('.select-selected').text(
							selectedOptionText);
				});

		// 검색영역 요약보기
		$('.search-toggle').on('click', function() {
		    if ($(this).hasClass('active')) {
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

		    // 인풋 데이터 가져오기
		    let gdsClasss = $('#gdsClass option:selected').text(); // 대유형
		    let gdsType = $('#gdsType option:selected').text(); // 소유형
		    let keyword = $('#keyword').val(); // 상품 명
		    let sfStockQty = $('#sfStockQty option:selected').text(); // 안전재고

		    // 대유형 데이터 입력
		    if (gdsClasss == '') {
		        $('#clsSummary').text('전체');
		    } else {
		        $('#clsSummary').text(gdsClasss);
		    }

		    // 소유형 데이터 입력
		    if (gdsType == '') {
		        $('#gdsTypeSummary').text('전체');
		    } else {
		        $('#gdsTypeSummary').text(gdsType);
		    }

		    // 상품 명 데이터 입력
		    if (keyword == '') {
		        $('#keywordSummary').text('전체');
		    } else {
		        $('#keywordSummary').text(keyword);
		    }

		    // 안전재고 데이터 입력
		    if (sfStockQty == '') {
		        $('#sfSummary').text('전체');
		    } else {
		        $('#sfSummary').text(sfStockQty);
		    }

		});
		//.search-toggle

		// 검색 버튼 클릭시
		$('#searchBtn').on('click', function() {
			gdsClass = $('#gdsClass').val();

			// 모든 tap-cont에서 active 클래스를 제거
			$('.tap-cont').removeClass('active');

			if (gdsClass == 'FD') {
				$('#tap-fd').parent().addClass('active');
			} else if (gdsClass == 'SM') {
				$('#tap-sm').parent().addClass('active');
			} else if (gdsClass == 'PM') {
				$('#tap-pm').parent().addClass('active');
			} else {
				$('#tap-all').parent().addClass('active');
			}
		});

		// 분류 조건 클릭 시 스타일 변화와 데이터 변화
		$('.tap-cont').on('click', function() {
			// 모든 tap-cont에서 active 클래스를 제거
			$('.tap-cont').removeClass('active');

			// 클릭된 tap-cont에 active 클래스를 추가
			$(this).addClass('active');
			gdsClass = $(this).data('type');
			$('#gdsClass').val(gdsClass);
			var selectedOptionText = $('#gdsClass option:selected').text();
			$('#gdsClass').parent().find('.select-selected').text(selectedOptionText);
			
			$("#searchForm").submit();
		})
	});

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
</script>


<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<h1 class="m-0">재고 현황 조회</h1>
			</div>
			<!-- /.row align-items-center -->
		</div>
		<!-- /.row mb-2 justify-content-between -->
	</div>
	<!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<div class="wrap">
	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- 검색 조건 시작 -->
		<form id="searchForm">
			<!-- cont: 검색 영역 -->
			<div class="cont search-original">
				<div class="search-wrap">
					<!-- 대유형 검색조건 -->
					<div class="search-cont w-150">
						<p class="search-title">대유형</p>
						<div class="select-custom">
							<!-- div 감싸주고 클래스에 select-costom 꼭 추가!! -->
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
						<input type="text" id="keyword" name="keyword"
							placeholder="키워드를 입력하세요" value="${param.keyword}">
					</div>

					<!-- 안전 재고 검색조건 -->
					<div class="search-cont w-150">
						<p class="search-title">안전재고</p>
						<div class="select-custom">
							<select name="sfStockQty" id="sfStockQty">
								<option value="">전체</option>
								<option value="down"
									<c:if test="${param.sfStockQty == 'down'}">selected</c:if>>미만</option>
								<option value="up"
									<c:if test="${param.sfStockQty == 'up'}">selected</c:if>>이상</option>
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
					<!-- 대유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							대유형 <span class="summary" id="clsSummary">전체</span>
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
							상품명<span class="summary" id="keywordSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>
					<!-- 안전재고 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							안전재고 <span class="summary" id="sfSummary">전체</span>
						</p>
					</div>
				</div>
				<!-- /.search-wrap -->
			</div>
			<!-- /.cont: 검색 영역 -->

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

	<!-- 테이블 디자인 1 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<!-- 테이블 분류 시작 -->
			<div class="tap-wrap">
			    <div data-type='' class="tap-cont <c:if test="${param.gdsClass == ''}">active</c:if>">
			        <span class="tap-title">전체</span> <span class="bge bge-default">${gdsTypeQtyMap.allStockQty}</span>
			    </div>
			    <div data-type='FD' class="tap-cont <c:if test="${param.gdsClass == 'FD'}">active</c:if>">
			        <span class="tap-title">식품</span> <span class="bge bge-active">${gdsTypeQtyMap.fdStockQty}</span>
			    </div>
			    <div data-type='SM' class="tap-cont <c:if test="${param.gdsClass == 'SM'}">active</c:if>">
			        <span class="tap-title">부자재</span> <span class="bge bge-warning">${gdsTypeQtyMap.smStockQty}</span>
			    </div>
			    <div data-type='PM' class="tap-cont <c:if test="${param.gdsClass == 'PM'}">active</c:if>">
			        <span class="tap-title">포장재</span> <span class="bge bge-danger">${gdsTypeQtyMap.pmStockQty}</span>
			    </div>
			</div>
			<!-- 테이블 분류 끝 -->

			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">상품 명</th>
						<th class="center">상품 유형</th>
						<th class="center">단위</th>
						<th class="center">단가(원)</th>
						<th class="center">재고 수량</th>
						<th class="center">안전 재고</th>
					</tr>
				</thead>
				<!-- 검색 결과가 0인 경우 -->
				<c:if test="${articlePage.total == 0}">
					<tbody id="table-body" class="table-error">
						<tr>
							<td class="error-info" colspan="7"><span
								class="icon material-symbols-outlined">error</span>
								<div class="error-msg">검색 결과가 없습니다</div></td>
						</tr>
					</tbody>
				</c:if>
				<tbody>
					<c:forEach var="gdsVO" items="${articlePage.content}">
						<c:if test="${fn:contains(gdsVO.gdsNm, param.keyword)}">
							<tr
								onclick="location.href='/frcs/stockDetail?gdsCode=${gdsVO.gdsCode}'"
								style="cursor: pointer;">
								<td class="center">${gdsVO.rnum}</td>
								<td>${gdsVO.gdsNm}</td>
								<td class="center"><c:choose>
										<c:when test="${gdsVO.gdsType == 'FD01'}">
											<span class="bge bge-active">축산</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'FD02'}">
											<span class="bge bge-active">농산물</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'FD03'}">
											<span class="bge bge-active">유제품</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'FD04'}">
											<span class="bge bge-active">베이커리</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'FD05'}">
											<span class="bge bge-active">조미료/소스</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'FD06'}">
											<span class="bge bge-active">냉동식품</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'PM01'}">
											<span class="bge bge-danger">일회 용품</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'SM01'}">
											<span class="bge bge-warning">매장 소모품</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'SM02'}">
											<span class="bge bge-warning">조리 용품</span>
										</c:when>
										<c:when test="${gdsVO.gdsType == 'SM03'}">
											<span class="bge bge-warning">위생 용품</span>
										</c:when>
										<c:otherwise>기타</c:otherwise>
									</c:choose></td>
								<td class="center">${gdsVO.unitNm}</td>
								<td class="right"><fmt:formatNumber
										value="${gdsVO.stockVOList[0].gdsAmtVOList[0].amt}"
										pattern="#,###" /></td>
								<td class="right"><c:choose>
										<c:when
											test="${gdsVO.stockVOList[0].qty < gdsVO.stockVOList[0].sfStockQty}">
											<span style="color: red;"> <fmt:formatNumber
													value="${gdsVO.stockVOList[0].qty}" pattern="#,###" />
											</span>
										</c:when>
										<c:otherwise>
											<fmt:formatNumber value="${gdsVO.stockVOList[0].qty}"
												pattern="#,###" />
										</c:otherwise>
									</c:choose></td>
								<td class="right"><fmt:formatNumber
										value="${gdsVO.stockVOList[0].sfStockQty}" pattern="#,###" /></td>
							</tr>
						</c:if>
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
								href="/frcs/stockList?gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&keyword=${param.keyword}&sfStockQty=${param.sfStockQty}&currentPage=${articlePage.startPage - 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_left</span>
							</a>
						</c:if>
						<c:forEach var="pNo" begin="${articlePage.startPage}"
							end="${articlePage.endPage}">
							<a
								href="/frcs/stockList?gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&keyword=${param.keyword}&sfStockQty=${param.sfStockQty}&currentPage=${pNo}"
								class="page-link 
                                <c:if test="${pNo == articlePage.currentPage}">active</c:if>">
								${pNo} </a>
						</c:forEach>
						<c:if test="${articlePage.endPage lt articlePage.totalPages}">
							<a
								href="/frcs/stockList?gdsClass=${param.gdsClass}&gdsType=${param.gdsType}&keyword=${param.keyword}&sfStockQty=${param.sfStockQty}&currentPage=${articlePage.startPage + 5}"
								class="page-link"> <span
								class="icon material-symbols-outlined">chevron_right</span>
							</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<!-- pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
</div>

