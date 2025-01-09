 <%--
    @fileName    : selectFrcsMenuSlsList.jsp
    @programName : 가맹점 매출 관리
    @description : 가맹점 메뉴별 매출 조회 페이지
    @author      : 정현종
    @date        : 2024. 10. 03
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src='/resources/js/global/value.js'></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user" />
<link rel="stylesheet" type="text/css" href="/resources/frcs/css/selectFrcsMenuSlsList.css">

<script type="text/javascript">
let menuType = '';
let bzentNo = '${user.bzentNo}';
let myChart; // 전역 변수로 차트 인스턴스 선언    

$(function() {
	
	// 초기 데이터 로드
    loadDataAndUpdateChart();
	
    // 검색영역 초기화
    $('.search-reset').on('click', function() {
        window.location.href = "/frcs/menuSlsList";  // 페이지 이동
    });

 	// 메뉴 유형에 따른 색상 설정
    const menuColors = {
        'MENU01': 'rgba(76, 175, 80, 0.6)',   // 세트 (연두색)
        'MENU02': 'rgba(255, 193, 7, 0.6)',    // 단품 (노란색)
        'MENU03': 'rgba(255, 0, 0, 0.6)',     // 사이드 (빨간색)
        'MENU04': 'rgba(0, 123, 255, 0.6)'      // 음료 (파란색)
    };

    function loadDataAndUpdateChart() {
        let startYmd = $('#startYmd').val();
        let endYmd = $('#endYmd').val();
        let menuType = $('#menuType').val();

        if (menuType === '') {
            // AJAX 요청
            $.ajax({
                url: "/frcs/menuSlsListAjax",
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                data: JSON.stringify({
                    startYmd: startYmd,
                    endYmd: endYmd,
                    bzentNo: bzentNo,
                    menuType: menuType
                }),
                success: function(data) {
                    console.log('Received Data:', data);

                    var salesData = {};
                    $.each(data, function(index, item) {
                        var menuType = item.menuType;
                        var salesAmount = item.sumOrdrAmt;

                        if (salesData[menuType]) {
                            salesData[menuType] += salesAmount;
                        } else {
                            salesData[menuType] = salesAmount;
                        }
                    });

                    var menuTypes = Object.keys(salesData);
                    var salesAmounts = Object.values(salesData);
                    var colorsToUse = menuTypes.map(type => menuColors[type] || 'rgba(128, 128, 128, 0.6)'); // 기본 색상은 회색

                    drawPieChart(menuTypes, salesAmounts, colorsToUse);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error:', error);
                    alert('데이터를 가져오는 데 실패했습니다. 잠시 후 다시 시도해 주세요.');
                }
            });
        } else {
            $.ajax({
                url: "/frcs/selectFrcsMenuTypeSlsListAjax",
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                data: JSON.stringify({
                    startYmd: startYmd,
                    endYmd: endYmd,
                    bzentNo: bzentNo,
                    menuType: menuType
                }),
                success: function(data) {
                    console.log('Received Data:', data);

                    var salesData = {};
                    var menuNms = [];

                    $.each(data, function(index, item) {
                        var menuNm = item.menuNm;
                        var salesAmount = item.sumOrdrAmt;

                        if (salesData[menuNm]) {
                            salesData[menuNm] += salesAmount;
                        } else {
                            salesData[menuNm] = salesAmount;
                            menuNms.push(menuNm);
                        }
                    });

                    var salesAmounts = Object.values(salesData);
                    var colorsToUse = menuNms.map(name => menuColors[menuType] || 'rgba(128, 128, 128, 0.6)'); // 기본 색상은 회색

                    drawBarChart(menuNms, salesAmounts, colorsToUse);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error:', error);
                    alert('데이터를 가져오는 데 실패했습니다. 잠시 후 다시 시도해 주세요.');
                }
            });
        }
    }

    function drawPieChart(labels, data, colors) {
        const ctx = document.getElementById('myChart').getContext('2d');

        if (myChart) {
            myChart.destroy();
        }

        // 메뉴 유형에 따른 한글 라벨 매핑
        const menuLabels = {
            'MENU01': '세트',
            'MENU02': '단품',
            'MENU03': '사이드',
            'MENU04': '음료'
        };

        // 한글 라벨로 변환
        const translatedLabels = labels.map(label => menuLabels[label] || label); // 기본값은 원래 라벨

        myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: translatedLabels, // 변환된 라벨 사용
                datasets: [{
                    label: '매출액(원)',
                    data: data,
                    backgroundColor: colors,
                }]
            },
        });
    }


    function drawBarChart(labels, data, colors) {
        const ctx = document.getElementById('myChart').getContext('2d');

        if (myChart) {
            myChart.destroy();
        }

        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '매출액(원)',
                    data: data,
                    backgroundColor: colors, // 색상 배열 사용
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: '매출액'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: '메뉴명'
                        }
                    }
                },
            }
        });
    }


    // 요약보기 
    $('.search-toggle').on('click', function() {
        if ($('.search-summary').is(':visible')) {
            $('.search-summary').slideUp(300);
            $('.search-original').slideDown(300);
            $(this).html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
        } else {
            $('.search-original').slideUp(300);
            $('.search-summary').slideDown(300);
            $(this).html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
        }

        let startYmd = $('#startYmd').val();
        let endYmd = $('#endYmd').val();
        let menuType = $('#menuType option:selected').text();
        let menuNm = $('#menuNm').val();

        if (startYmd == '' && endYmd == '') {
            $('#dateSummary').text('전체');
        } else {
            $('#dateSummary').text(startYmd + " ~ " + endYmd);
        }

        if (menuType == '') {
            $('#menuTypeSummary').text('전체');
        } else {
            $('#menuTypeSummary').text(menuType);
        }

        if (menuNm == '') {
            $('#menuNmSummary').text('전체');
        } else {
            $('#menuNmSummary').text(menuNm);
        }
    });

    // 분류 조건 클릭 시 스타일 변화와 데이터 변화
    $('.tap-cont').on('click', function() {
        $('.tap-cont').removeClass('active');
        $(this).addClass('active');
        menuType = $(this).data('type');
        $('#menuType').val(menuType);
        var selectedOptionText = $('#menuType option:selected').text();
        $('#menuType').parent().find('.select-selected').text(selectedOptionText);
        
        $("#searchForm").submit(); // 폼 제출
    });
    
});
</script>


<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">메뉴별 매출 조회</h1>
			</div>
		</div>
	</div>
</div>

<div class="wrap">
	<div class="search-section">
		<form id="searchForm">
			<!-- cont: 검색 영역 -->
			<div class="cont search-original">
				<div class="search-wrap">

					<!-- 판매 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">판매 일자</p>
						<div class="search-date-wrap">
							<input type="date" id="startYmd" name="startYmd"
								value="${param.startYmd}"> ~ <input type="date"
								id="endYmd" name="endYmd" value="${param.endYmd}">
						</div>
					</div>

					<!-- 메뉴 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 유형</p>
						<div class="select-custom" style="width: 150px;">
							<!-- div 감싸주고 클래스에 select-costom 꼭 추가!! -->
							<select name="menuType" id="menuType">
								<option value="" selected>전체</option>
								<c:forEach var="menu" items="${menu}">
							        <option value="${menu.comNo}" <c:if test="${param.menuType == menu.comNo}">selected</c:if>>${menu.comNm}</option>
							    </c:forEach>
							</select>
						</div>
					</div>

					<!-- 메뉴 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 명</p>
						<input type="text" id="menuNm" name="menuNm"
							placeholder="키워드를 입력하세요" value="${param.menuNm}">
					</div>

				</div>
				<!-- /.search-wrap -->
			</div>
			<!-- /.cont: 검색 영역 -->
			<!-- cont:  검색 접기 영역 -->
			<div class="cont search-summary" style="display: none;">
				<div class="search-wrap">

					<!-- 판매 일자 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							판매 일자 <span class="summary" id="dateSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 메뉴 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 유형 <span class="summary" id="menuTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>

					<!-- 메뉴 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 명<span class="summary" id="menuNmSummary">전체</span>
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
		<!-- /.search-section: 검색어 영역 -->
	</div>
	<!-- cont 끝 -->
	<div class="chart-wrap">
        <div class="cont chart">
        	<div class="table-title">	
		    	<div class="cont-title chart-title">
			        <span class="material-symbols-outlined title-icon">
			            <c:choose>
			                <c:when test="${empty param.menuType}">
			                    donut_small
			                </c:when>
			                <c:otherwise>
			                    bar_chart
			                </c:otherwise>
			            </c:choose>
			        </span>
			        <p id="chart-title-text">
			            <c:choose>
			                <c:when test="${empty param.menuType}">
			                    메뉴별 매출 비율 차트
			                </c:when>
			                <c:otherwise>
			                    메뉴유형별 매출 비율 차트
			                </c:otherwise>
			            </c:choose>
			        </p>
			    </div>
			</div>
			<div class="chart-container">
		    	<canvas id="myChart"></canvas>
		    </div>
		</div>
		<div class="cont table">
			<div class="table-wrap">
				<div class="tap-btn-wrap">
					<div class="tap-wrap">
						<div data-type='' class="tap-cont <c:if test="${param.menuType == ''}">active</c:if>">
						    <span class="tap-title">전체</span> 
						    <span class="bge bge-default" id="tap-all">${total}</span>
						</div>
						<div data-type='MENU01' class="tap-cont <c:if test="${param.menuType == 'MENU01'}">active</c:if>">
						    <span class="tap-title">세트</span> 
						    <span class="bge bge-active" id="tap-menu01">${setMenuCnt}</span>
						</div>
						<div data-type='MENU02' class="tap-cont <c:if test="${param.menuType == 'MENU02'}">active</c:if>">
						    <span class="tap-title">단품</span> 
						    <span class="bge bge-warning" id="tap-menu02">${singleMenuCnt}</span>
						</div>
						<div data-type='MENU03' class="tap-cont <c:if test="${param.menuType == 'MENU03'}">active</c:if>">
						    <span class="tap-title">사이드</span>
						    <span class="bge bge-danger" id="tap-menu03">${sideMenuCnt}</span>
						</div>
						<div data-type='MENU04' class="tap-cont <c:if test="${param.menuType == 'MENU04'}">active</c:if>">
						    <span class="tap-title">음료</span> 
						    <span class="bge bge-info" id="tap-menu04">${drinkMenuCnt}</span>
						</div>
					</div>
				</div>
				<table class="table-default menu-table">
					<thead>
						<tr>
							<th class="center" style="width: 10%">번호</th>
							<th class="center" style="width: 10%">메뉴 사진</th>
							<th class="center" style="width: 35%">메뉴 명</th>
							<th class="center" style="width: 10%">메뉴 유형</th>
							<th class="center" style="width: 35%">총 매출액(원)</th>
						</tr>
					</thead>
					<c:if test="${empty frcsMenuSlsList}">
					    <tbody id="table-body" class="table-error">
					        <tr>
					            <td class="error-info" colspan="5">
					                <span class="icon material-symbols-outlined">error</span>
					                <div class="error-msg">검색 결과가 없습니다</div>
					            </td>
					        </tr>
					    </tbody>
					</c:if>
					<tbody>
						<c:forEach var="menuVO" items="${frcsMenuSlsList}">
							<tr>
								<td class="center" style="width: 10%">${menuVO.rnum}</td>
								<td class="center" style="width: 10%">
									<img src="${menuVO.menuImgPath}" alt="${menuVO.menuImgPath}" style="width: 50px; height: 50px;" /></td>
								<td style="width: 35%">${menuVO.menuNm}</td>
								<td class="center" style="width: 10%">
									<c:if test="${menuVO.menuType eq 'MENU01'}">
										<span class="bge bge-active">세트</span>
									</c:if> 
									<c:if test="${menuVO.menuType eq 'MENU02'}">
										<span class="bge bge-warning">단품</span>
									</c:if> 
									<c:if test="${menuVO.menuType eq 'MENU03'}">
										<span class="bge bge-danger">사이드</span>
									</c:if> 
									<c:if test="${menuVO.menuType eq 'MENU04'}">
										<span class="bge bge-info">음료</span>
									</c:if>
								</td>
								<td class="right" style="width: 35%">
									<fmt:formatNumber value="${menuVO.sumOrdrAmt}" pattern="#,###" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		<!-- table-wrap -->
	    </div>
	</div>
</div>
