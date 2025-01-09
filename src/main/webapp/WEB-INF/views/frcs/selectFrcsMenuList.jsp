<%--
    @fileName    : selectFrcsMenuList.jsp
    @programName : 가맹점 판매 메뉴 관리
    @description : 가맹점 판매 메뉴 관리를 위한 페이지
    @author      : 정현종
    @date        : 2024. 09. 12
--%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.buff.vo.FrcsMenuVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<script src='/resources/js/global/value.js'></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<sec:authentication property="principal.MemberVO" var="user" />
<link rel="stylesheet" type="text/css"
	href="/resources/frcs/css/selectFrcsMenuList.css">

<%!public boolean isNewMenu(String regDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			Date registrationDate = sdf.parse(regDate);
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -30); // 현재 날짜에서 30일 전으로 설정
			Date thirtyDaysAgo = cal.getTime();
			return registrationDate.after(thirtyDaysAgo); // 등록일이 30일 이내인지 확인
		} catch (Exception e) {
			return false; // 오류 발생 시 false 리턴
		}
	}%>
<script type="text/javascript">

let bzentNo = "${user.bzentNo}";
let mbrId = '${user.mbrId}';

$(function(){
	
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
		let selMenuType= $('#selMenuType').val();
		let keyword= $('#keyword').val();

		// 메뉴 유형 데이터 입력
		if(selMenuType==''){
			$('#selMenuTypeSummary').text('전체');
		}else if(selMenuType=='MENU02') {
			$('#selMenuTypeSummary').text('단품');
		}else if(selMenuType=='MENU03') {
			$('#selMenuTypeSummary').text('사이드');
		}else if(selMenuType=='MENU04') {
			$('#selMenuTypeSummary').text('음료');
		}
		
		// 메뉴 명 데이터 입력
		if(keyword==''){
			$('#keywordSummary').text('전체');
		}else {
			$('#keywordSummary').text(keyword);
		}
		
	})
	//.search-toggle
	
 	// Select All Left 체크박스 클릭 시
    $("#selectAllLeft").on("change", function(){
        $("input[name='menuCheckboxLeft']").prop("checked", this.checked);
    });

    // Select All Right 체크박스 클릭 시
    $("#selectAllRight").on("change", function(){
        $("input[name='menuCheckboxRight']").prop("checked", this.checked);
    });
    
	// 테이블 행이 존재하는지 확인하고 메시지를 업데이트하는 함수
    function updateTableMessage(tbodySelector, colspan) {
        let tbody = $(tbodySelector);

        // 기존 오류 메시지 제거
        tbody.find('.error-info').closest('tr').remove();

        // 행이 없을 경우
        if (tbody.children('tr').length === 0) {
            // tbody에 오류 클래스를 추가하고 메시지 출력
            tbody.addClass('table-error').append(`
                <tr>
                    <td class="error-info" colspan="${colspan}">
                        <span class="icon material-symbols-outlined">error</span>
                        <div class="error-msg">검색 결과가 없습니다</div>
                    </td>
                </tr>
            `);
        } else {
            // tbody에서 오류 클래스를 제거
            tbody.removeClass('table-error');
        }
    }
 
 	// Add 버튼 클릭 시(왼쪽->오른쪽)
    $("#addBtn").on("click", function() {
        $("input[name='menuCheckboxLeft']:checked").each(function() {
            var row = $(this).closest("tr").clone(); // 선택된 행 복사
            row.find("input[name='menuCheckboxLeft']").prop("checked", false); // 체크박스 해제
            $("table.table-default tbody").eq(1).append(row); // 오른쪽 테이블에 추가
            
            // 오른쪽 테이블의 모든 행에서 체크박스 이름과 ID 변경
            $("#tbyRight").children("tr").each(function() {
                let checkbox = $(this).children("td").eq(0).children("input[type='checkbox']");
                if (checkbox.attr("name") === "menuCheckboxLeft") {
                    checkbox.attr("name", "menuCheckboxRight");
                }

                // ID 변경
                let id = checkbox.attr("id");
                if (id) {
//                     checkbox.attr("id", id.replace("menu", "frcsMenu"));
                	let newId = id.replace("menu-", "frcsMenu-");
                    checkbox.attr("id", newId);
                    
                    // 레이블의 for 속성 변경
                    $(this).find("label").attr("for", newId);
                } else {
                    console.warn("Checkbox ID is undefined for row:", $(this));
                }
            });
            
            $(this).closest("tr").remove(); // 왼쪽 테이블에서 제거
        });
        $("#selectAllLeft").prop("checked", false);
        
        // 테이블 상태 업데이트
        updateTableMessage('#tbyLeft', 4);
        updateTableMessage('#tbyRight', 4);
    });

 	// Remove 버튼 클릭 시(오른쪽->왼쪽)
    $("#removeBtn").on("click", function() {
        $("input[name='menuCheckboxRight']:checked").each(function() {
            var row = $(this).closest("tr").clone(); // 선택된 행 복사
            row.find("input[name='menuCheckboxRight']").prop("checked", false); // 체크박스 해제
            $("table.table-default tbody").eq(0).append(row); // 왼쪽 테이블에 추가
            
            // 왼쪽 테이블의 모든 행에서 체크박스 이름과 ID 변경
            $("#tbyLeft").children("tr").each(function() {
                let checkbox = $(this).children("td").eq(0).children("input[type='checkbox']");
                if (checkbox.attr("name") === "menuCheckboxRight") {
                    checkbox.attr("name", "menuCheckboxLeft");
                }

                // ID 변경
                let id = checkbox.attr("id");
                if (id) {
//                     checkbox.attr("id", id.replace("frcsMenu", "menu"));
                	let newId = id.replace("frcsMenu-", "menu-");
                    checkbox.attr("id", newId);
                    
                    // 레이블의 for 속성 변경
                    $(this).find("label").attr("for", newId);
                } else {
                    console.warn("Checkbox ID is undefined for row:", $(this));
                }
                
            });
            
            $(this).closest("tr").remove(); // 오른쪽 테이블에서 제거
        });
        $("#selectAllRight").prop("checked", false); 
        
        // 테이블 상태 업데이트
        updateTableMessage('#tbyLeft', 4);
        updateTableMessage('#tbyRight', 4);
    });
    
 	// 처음 로딩될 때 왼쪽과 오른쪽 테이블에 있던 메뉴 번호를 저장
    let initialLeftMenuNos = [];
    let initialRightMenuNos = [];
    
    // 페이지 로드 시 왼쪽 테이블의 초기 메뉴 번호 저장
    $("#tbyLeft .menuNo").each(function () {
        initialLeftMenuNos.push($(this).val().trim());
    });

    // 페이지 로드 시 오른쪽 테이블의 초기 메뉴 번호 저장
    $("#tbyRight .menuNo").each(function () {
        initialRightMenuNos.push($(this).val().trim());
    });

    // 검색영역 초기화
    $('.search-reset').on('click', function () {
        window.location.href = "/frcs/menuList";  // 페이지 이동
    });

 	// 저장 버튼 클릭 시
    $("#saveBtn").on("click", function() {
        var leftMenuNos = [];
        var rightMenuNos = [];

     	// 새로 추가된 왼쪽 테이블의 메뉴 번호만 수집
        $("#tbyLeft .menuNo").each(function () {
            let menuNo = $(this).val().trim();
            if (!initialLeftMenuNos.includes(menuNo)) {
                leftMenuNos.push(menuNo); // 초기 번호 목록에 없는 메뉴 번호만 추가
            }
        });

        // 새로 추가된 오른쪽 테이블의 메뉴 번호만 수집
        $("#tbyRight .menuNo").each(function () {
            let menuNo = $(this).val().trim();
            if (!initialRightMenuNos.includes(menuNo)) {
                rightMenuNos.push(menuNo); // 초기 번호 목록에 없는 메뉴 번호만 추가
            }
        });
		
        var requestData = {
        	    bzentNo: bzentNo,
        	    leftMenuNos: leftMenuNos,
        	    rightMenuNos: rightMenuNos
       	};

       	console.log("Request Data:", JSON.stringify(requestData)); // JSON 문자열로 변환한 데이터 출력
        
       	/*
       	{
            "leftMenuNos": leftMenuNos,
            "rightMenuNos": rightMenuNos
        }
       	*/
        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "/frcs/updateFrcsMenuAjax",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(requestData),
            dataType: "text",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); // CSRF 토큰 설정
            },
            success: function(response) {
                console.log("response : ", response);
                Swal.fire({
                    title: "판매 메뉴 관리 설정",
                    html: "판매 메뉴가 저장되었습니다.",
                    icon: "success",
                    confirmButtonColor: "#00C157",
                    confirmButtonText: "확인",
                }).then((result) => {
                	location.href = '/frcs/menuList';
                });
            },
            error: function(xhr, status, error) {
                alert("변경사항 저장에 실패했습니다. 다시 시도해주세요.");
                console.error(error);
            }
        });
    });
 	
 	// 페이지 로드 시 테이블 상태 업데이트
    updateTableMessage('#tbyLeft', 4);
    updateTableMessage('#tbyRight', 4);
});
</script>

<%
List<Map<String, String>> menuTypes = new ArrayList<>();
Map<String, String> menu1 = new HashMap<>();
menu1.put("value", "MENU02");
menu1.put("name", "단품");
menuTypes.add(menu1);

Map<String, String> menu2 = new HashMap<>();
menu2.put("value", "MENU03");
menu2.put("name", "사이드");
menuTypes.add(menu2);

Map<String, String> menu3 = new HashMap<>();
menu3.put("value", "MENU04");
menu3.put("name", "음료");
menuTypes.add(menu3);

request.setAttribute("menuTypes", menuTypes);
%>
<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2 justify-content-between">
			<div class="row align-items-center">
				<h1 class="m-0">판매 메뉴 관리</h1>
			</div>
			<div class="btn-wrap">
				<button type="button" class="btn-default" id="resetBtn">초기화</button>
				<button type="button" class="btn-active" id="saveBtn">저장</button>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</div>
<div class="wrap">
	<div class="search-section">
		<form id="searchForm">
			<!-- cont: 검색 영역 -->
			<div class="cont search-original">
				<div class="search-wrap">
					<!-- 메뉴 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 유형</p>
						<div class="select-custom" style="width: 150px;">
							<!-- div 감싸주고 클래스에 select-costom 꼭 추가!! -->
							<select id="selMenuType" name="menuType" style="width: 150px;">
								<option value=""
									<c:if test="${param.menuType == ''}">selected</c:if>>전체</option>
								<c:forEach var="menu" items="${menuTypes}">
									<option value="${menu.value}"
										<c:if test="${param.menuType == menu.value}">selected</c:if>>${menu.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 메뉴 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">메뉴 명</p>
						<input type="text" id="keyword" name="keyword"
							placeholder="키워드를 입력하세요" value="${param.keyword}">
					</div>
				</div>
				<!-- /.search-wrap -->
			</div>
			<!-- /.cont: 검색 영역 -->
			<!-- cont:  검색 접기 영역 -->
			<div class="cont search-summary" style="display: none;">
				<div class="search-wrap">
					<!-- 메뉴 유형 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 유형 <span class="summary" id="selMenuTypeSummary">전체</span>
						</p>
					</div>
					<div class="divide-border"></div>
					<!-- 메뉴 명 검색조건 -->
					<div class="search-cont">
						<p class="search-title">
							메뉴 명<span class="summary" id="keywordSummary">전체</span>
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
	<div>
		<div class="table-container">
			<div style="display: flex; justify-content: space-between;">
				<div class="cont" style="flex: 1; margin-right: 10px;">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">sell</span> 판매 가능한 메뉴</div>
					<div class="table-wrap">
						<table class="table-default menu-table">
							<thead>
								<tr>
									<th class="center"  style="width: 10%">
										<input type="checkbox" class="check-btn all" id="selectAllLeft" name="selectAllLeft">
								       	<label for="selectAllLeft"><span></span></label>
									</th>
									<th class="center" style="width: 15%">사진</th>
									<th class="center"  style="width: 50%">메뉴 명</th>
									<th class="center"  style="width: 25%">가격</th>
								</tr>
							</thead>
							<tbody id="tbyLeft">
								<c:forEach var="MenuVO" items="${menuVOList}">
									<c:if test="${fn:contains(MenuVO.menuNm, param.keyword)}">
										<tr class="menu-row" data-type="${MenuVO.menuType}">
											<td class="center" style="width: 10%">
												<input type="checkbox" class="check-btn" id="menu-${MenuVO.menuNo}" name="menuCheckboxLeft" value="${MenuVO.menuNo}">
										       	<label for="menu-${MenuVO.menuNo}"><span></span></label>
											</td>
											<td class="center" style="width: 15%">
												<img src="${MenuVO.menuImgPath}" alt="${MenuVO.menuImgPath}" style="width: 50px; height: 50px;"/>
											</td>
											<td style="width: 45%">
												${MenuVO.menuNm}
											</td>
											<td class="right" style="width: 22%; padding-right: var(--pd--m);">
												<fmt:formatNumber value="${MenuVO.menuAmt}" pattern="#,###"/>
											</td>
											<td style="display: none;">
												<input type="hidden" class="menuNo" value="${MenuVO.menuNo}"/>
											</td>
											<!-- 숨겨진 메뉴 번호 -->
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 버튼 영역 -->
				<div style="flex: 0 0 100px; display: flex; flex-direction: column; justify-content: center; align-items: center;">
					<button type="button" class="btn-default" id="addBtn">▶</button>
					<button type="button" class="btn-default" id="removeBtn" style="margin-top: 10px;">◀</button>
				</div>

				<div class="cont" style="flex: 1; margin-left: 10px;">
					<div class="cont-title"><span class="material-symbols-outlined title-icon">storefront</span> 가맹점에서 판매할 메뉴</div>
					
					<div class="table-wrap">
						<!-- 스크롤 추가 -->
						<table class="table-default menu-table">
							<thead>
								<tr>
									<th class="center"  style="width: 10%">
										<input type="checkbox" class="check-btn all" id="selectAllRight" name="selectAllRight">
								       	<label for="selectAllRight"><span></span></label>
									</th>
									<th class="center" style="width: 20%">사진</th>
									<th class="center"  style="width: 45%">메뉴 명</th>
									<th class="center"  style="width: 25%">가격</th>
								</tr>
							</thead>
							<tbody id="tbyRight">
								<c:forEach var="frcsMenuVO" items="${frcsMenuVOList}">
									<c:if test="${fn:contains(frcsMenuVO.menuNm, param.keyword)}">
										<tr class="menu-row" data-type="${frcsMenuVO.menuType}">
											<c:set var="registrationDate" value="${frcsMenuVO.menuRegYmd}" />
											<td class="center" style="width: 10%">
												<input type="checkbox" class="check-btn" id="frcsMenu-${frcsMenuVO.menuNo}" name="menuCheckboxRight" value="${frcsMenuVO.menuNo}">
										       	<label for="frcsMenu-${frcsMenuVO.menuNo}"><span></span></label>
											</td>
											<td class="center" style="width: 20%">
												<div class="position-relative">
													<img src="${frcsMenuVO.menuImgPath}" alt="${frcsMenuVO.menuNm}" style="width: 50px; height: 50px;" />
													<%
							                            String regDate = (String) pageContext.getAttribute("registrationDate"); // registrationDate를 가져옴
							                            if (isNewMenu(regDate)) {
							                        %>
													<div class="ribbon-wrapper ribbon-s">
														<div class="ribbon bg-danger text-s">
															<span style="font-size:10px; color:white;">NEW</span>
														</div>
													</div>
													<%
							                            }
							                        %>
												</div>
											</td>
											<td style="width: 40%">${frcsMenuVO.menuNm}</td>
											<td class="right" style="width: 22%;">
												<fmt:formatNumber value="${frcsMenuVO.menuAmt}" pattern="#,###" />
											</td>
											<td style="display: none;">
												<input type="hidden" class="menuNo" value="${frcsMenuVO.menuNo}" />
											</td>
											<!-- 숨겨진 메뉴 번호 -->
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
