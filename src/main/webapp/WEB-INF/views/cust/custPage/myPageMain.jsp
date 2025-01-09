<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="/resources/cust/css/custMyPage.css" rel="stylesheet">

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.memberVO" var="user" />
</sec:authorize>


<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">

let mbrId = "${user.mbrId}";

 
function toggleAccordion(element) {
   var collapseRow = element.nextElementSibling;
   var isVisible = collapseRow.classList.contains('show');


   document.querySelectorAll('.accordion-collapse').forEach(function(row) {
      row.classList.remove('show');
   });


   if (!isVisible) {
      collapseRow.classList.add('show');
   }
};//end 달러function
 
$(function() {
    // 초기 5개의 항목만 표시
    $(".ordrAccordion-item").slice(0, 5).show();  // show()를 사용하여 첫 5개 항목을 표시

    $("#addOrdr").click(function(e) {
        e.preventDefault();

        // 더보기 버튼 클릭 시, 숨겨진 다음 5개의 항목을 표시
        var hiddenItems = $(".ordrAccordion-item:hidden").slice(0, 5);  // 아직 보여지지 않은 항목 중 5개 선택
        hiddenItems.show();  // 선택된 항목을 보여줌

        // 더 이상 숨겨진 항목이 없을 경우 '더보기' 버튼 숨김
        if ($(".ordrAccordion-item:hidden").length === 0) {
            $("#addOrdr").hide();
        }
    });
});//end 달러function

$(document).ready(function() {
    let qsWaitingCount = 0;
    let qsCompletedCount = 0;
	let qsTotal = 0;
    // 문의 목록에서 각 건수 계산
    <c:forEach var="qsVO" items="${qsVOList}">
    qsTotal ++;
    
        if ("${qsVO.ansCn}" == "N") {
            qsWaitingCount++;
        } else {
            qsCompletedCount++;
        }
    </c:forEach>

    // 건수 표시
    $("#qsWaitingCount").text(qsWaitingCount);
    $("#qsCompletedCount").text(qsCompletedCount);
    $("#qsTotal").text(qsTotal);

    let consultationWaitingCount = 0;
    let consultationCompletedCount = 0;
    let dscsnTotal = 0;

    // 가맹지점 상담 목록에서 각 건수 계산
    <c:forEach var="frcsDscsnVO" items="${frcsDscsnVOList}">
        if ("${frcsDscsnVO.dscsnType}" == "DSC01") {
            consultationWaitingCount++;
        } else {
            consultationCompletedCount++;
        }
    </c:forEach>

    // 건수 표시
    $("#consultationWaitingCount").text(consultationWaitingCount);
    $("#consultationCompletedCount").text(consultationCompletedCount);
    $("#dscsnTotal").text(dscsnTotal);
    
    
    let ordrTotal = 0;
    let ordrType1 = 0;
    let ordrType2 = 0;
    
    <c:forEach var="ordrVO" items="${ordrVOList}">
    
    ordrTotal ++;
    
    if ("${ordrVO.ordrType}" == "ORDR01") {
    	ordrType1++;
    } else {
    	ordrType2++;
    }
	</c:forEach>
	
	$("#ordrTotal").text(ordrTotal);
	$("#ordrType1").text(ordrType1);
	$("#ordrType2").text(ordrType2);
	
	
	 let couponTotal = 0;

	    <c:forEach var="eventVO" items="${eventVOList}">
	        if (${eventVO.remainDay} > 0) {
	            couponTotal++;
	        }
	    </c:forEach>

	    // 쿠폰 총 갯수를 HTML에 표시
	    $("#couponTotal").text(couponTotal);
	
	
});//end 달러function


$(document).ready(function() {
    // 초기 설정: 주문 테이블 보이기, 쿠폰 테이블 숨기기
    $("#orderListTable").show();
    $("#couponListTable").hide();

    // 주문 내역 클릭 시
    $("#myOrderList").on("click", function() {
        $("#orderListTable").show();    // 주문 내역 테이블을 보이기
        $("#couponListTable").hide();   // 쿠폰 테이블 숨기기
    });

    // 쿠폰 클릭 시
    $("#myCouponList").on("click", function() {
        $("#orderListTable").hide();    // 주문 내역 테이블 숨기기
        $("#couponListTable").show();   // 쿠폰 테이블 보이기
    });
});//end 달러function

//주문 현황 불러오기
$(function(){
	$("#myOrderList").on("click", function(){
		console.log("개똥이 나와줘!!");
		
		$.ajax({
			url: "/custPage/orderList",
			contentType: "application/json;charset=utf-8",
			type: "get",
			dataType: "json",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(result){
				console.log("result : ", result);
				
				$("#cont-table").html("");

				let str = "<colgroup>";
				str += "<col width='15%'>";
				str += "<col width='23%'>";
				str += "<col>";
				str += "<col width='30%'>";
				str += "<col width='17%'>";
				str += "</colgroup>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>주문 번호</th>";
				str += "<th>주문 지점</th>";
				str += "<th>주문 유형</th>";
				str += "<th>주문 일시</th>";
				str += "<th>결제 금액</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";  // 데이터는 tbody에 추가

				// Ajax 결과를 사용해 데이터를 동적으로 추가합니다
				$.each(result, function(idx, ordrVO){
					str += "<tr class='ordrAccordion-item' onclick='toggleAccordion(this)'>";
					str += "<td class='center'>" + ordrVO.ordrNo + "</td>";
					str += "<td class='en_font'>" + ordrVO.ordrDtlVOList[0].bzentVO.bzentNm + "</td>";
					str += "<td class='status'>";
					if (ordrVO.ordrType === 'ORDR01') {
						str += "<span>포장</span>";
					} else {
						str += "<span>매장</span>";
					}
					str += "</td>";
					str += "<td class='en_font'>" + ordrVO.ordrDt + "</td>";
					str += "<td class='center'>" + new Intl.NumberFormat().format(ordrVO.ordrDtlVOList[0].ordrAmt) + "원</td>";
					str += "</tr>";
				});
				
				str += "</tbody>";
				
				$("#cont-table").html(str);
			},
			error: function(err) {
				console.log("주문 데이터를 불러오는데 실패했습니다: ", err);
			}
		});
	});
});

//end 달러function
/* 
$(function(){
	$("#myCouponList").on("click", function(){
		console.log("개똥이 나와줘~!!")
		$.ajax({
			url: "/custPage/myCouponList",
			contentType: "application/json;charset=utf-8",
			type: "get",
			dataType: "json",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log("result : ", result);
				
				$("#rig_con").html("");  // 기존 내용 초기화
				
				let str = "";
				
				// JSON 데이터를 반복하여 테이블 생성
				$.each(result.eventVOList, function(idx, eventVO){
					if (eventVO.remainDay > 0) {  // 남은 기간이 0보다 클 경우만 표시
						str += "<div class='product_tbl'>";
						str += "<ul class='con_box'>";
						str += "<li class='on'>";
						str += "<div class='list_tbl'>";
						str += "<table>";
						str += "<colgroup>";
						str += "<col width='15%'>";
						str += "<col>";
						str += "<col width='15%'>";
						str += "<col width='11%'>";
						str += "</colgroup>";
						str += "<tbody>";
						str += "<tr>";
						str += "<th>쿠폰</th>";
						str += "<th>메뉴</th>";
						str += "<th>할인금액</th>";
						str += "<th>기간</th>";
						str += "</tr>";
						str += "<tr>";
						str += "<td>" + eventVO.couponGroupVOList[0].couponNm + "</td>";
						str += "<td>" + eventVO.couponGroupVOList[0].menuVO.menuNm + "</td>";
						str += "<td class='en_font'>" + eventVO.couponGroupVOList[0].dscntAmt + "원</td>";
						
						let formattedDate = formatDate(eventVO.bgngYmd);
						let formattedExpDate = formatDate(eventVO.expYmd);
						
						str += "<td class='list-date'>" + formattedDate + " ~ " + formattedExpDate + "</td>";
						str += "</tr>";
						str += "</tbody>";
						str += "</table>";
						str += "</div>";
						str += "</li>";
						str += "</ul>";
						str += "</div>";
					}
				});
				
				$("#rig_con").html(str);
			},
			error: function(err) {
				console.log("쿠폰 데이터를 불러오는데 실패했습니다: ", err);
			}
		});
	});
});//end 달러function

// 
function formatDate(dateStr) {
	if (!dateStr) return "";
	let year = dateStr.substring(0, 4);
	let month = dateStr.substring(4, 6);
	let day = dateStr.substring(6, 8);
	return year + "-" + month + "-" + day;
}//end 달러function

*/



//end 달러function
</script>

<body>

	<!-- 마이페이지 시작  -->
	<!-- 마이페이지 상단 시작  -->

	<div class="content">
		<div class="mypage">
			<div class="inner in_1170">
				<div class="con">
					<div class="info">
						<div class="tit">
							<p>
								${user.mbrNm}님의<br> <span class="en_font">MY PAGE</span>
							</p>
						</div>
						<ul>
							<li>
								<div class="membership">
									<a href="#" id="myCouponList">
										<div class="box box1 mbs1">
											<div class="ic_bg">
												<p>나의 주문 현황</p>
												<strong>포장 <span class="en_font"><span
														id="ordrType1"></span></span>건
												</strong> <strong>매장 <span class="en_font"><span
														id="ordrType2"></span></span>건
												</strong>
											</div>
										</div>
									</a>
								</div>
							</li>
							<li class="division" id="myLikeStore">
								<div class="delivering">
									<a href="#">
										<div class="box box2">
											<div class="ic_bg">
												<p>관심 매장</p>
												<strong><span class="en_font">0</span>개</strong>
											</div>
										</div>
									</a>
								</div>
								<div class="delivered">
									<a href="#" id="myQsList">
										<div class="box box2">
											<div class="ic_bg">
												<p>나의 문의 현황</p>
												<strong><span class="en_font"><span id="qsTotal"></span></span>건</strong>
											</div>
										</div>
									</a>
								</div>
							</li>
							<li class="division">
								<div class="point">
									<a href="#" id="myDscsnList">
										<div class="box box2">
											<div class="ic_bg">
												<p>가맹지점 상담</p>
												<strong><span class="en_font"><span id="dscsnTotal"></span></span>건</strong>
											</div>
										</div>
									</a>
								</div>
								<div class="coupon">
									<a href="#" id="myCouponList">
										<div class="box box2">
											<div class="ic_bg">
												<p>쿠폰</p>
												<strong><span class="en_font"><span id="couponTotal"></span></span>건</strong>
											</div>
										</div>
									</a>
								</div>
							</li>
						</ul>
					</div>

					<div class="eco">
						<ul>
							<li class="stamp"><a href="#">
									<div class="box">
										<dl>
											<dt>
												<p>매장 주문</p>
												<span>GO</span>
											</dt>
											<dd>
												신선한 재료로 바로 조리된 음식을 매장에서 여유롭게 즐겨보세요.<br>따뜻한 식사와 함께 편안한
												시간을 보내세요.
											</dd>
										</dl>
									</div>
							</a></li>
							<li class="roulette"><a href="#">
									<div class="box">
										<dl>
											<dt>
												<p>포장 주문</p>
												<span>GO</span>
											</dt>
											<dd>
												원하는 시간에 맞춰 음식을 빠르게 준비해드려 간편하게 가져갈 수 있어요.<br>어디서든 신선한
												음식을 빠르게 즐길 수 있습니다.
											</dd>
										</dl>
									</div>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="off1"></div>
		</div>
		<!-- 마이페이지 상단 끝  -->
		<div class="con_top">
			<div class="inner in_1170">
				<div class="side_nav">
					<div class="lef_menu">
						<ul>
							<li class="on"><a href="#" id="myOrderList"><span>주문내역</span></a></li>
							<li><a href="#" id="myCouponList"><span>쿠폰</span></a></li>
							<li><a href="#" id="myLikeStore"><span>관심 매장</span></a></li>
							<li><a href="#" id="myQsList"><span>문의 내역</span></a></li>
							<li><a href="#" id="myDscsnList"><span>가맹 상담</span></a></li>
							<li><a href="#" id="myInfo"><span>개인정보 수정</span></a></li>
						</ul>
						<div class="notice_box">
							<a href="/center/insertQs">
								<p>
									1:1 문의는<br>고객센터를 이용해주세요
								</p>
							</a>
						</div>
					</div>
					<div class="rig_con">
						<div class="con_tit1 mb15">
							<div>
								<p>주문내역</p>
							</div>
						</div>
						<div class="bdr_box">
							<div class="product_tbl">
								<ul class="con_box">
									<li class="on">
										<div class="list_tbl">
											<table id="orderListTable">
												<colgroup>
													<col width="15%">
													<col width="23%">
													<col>
													<col width="30%">
													<col width="17%">
												</colgroup>
												<tbody>
													<tr>
														<th>주문 번호</th>
														<th>주문 지점</th>
														<th>주문 유형</th>
														<th>주문 일시</th>
														<th>결제 금액</th>
													</tr>
													<c:forEach var="ordrVO" items="${ordrVOList}">
														<tr class="ordrAccordion-item" style="display: none;"
															onclick="toggleAccordion(this)">
															<td class="center">${ordrVO.ordrNo}</td>
															<td class="en_font">${ordrVO.ordrDtlVOList[0].bzentVO.bzentNm}</td>
															<td class="status"><c:if
																	test="${ordrVO.ordrType == 'ORDR01'}">
																	<span>포장</span>
																</c:if> <c:if test="${ordrVO.ordrType != 'ORDR01'}">
																	<span>매장</span>
																</c:if></td>
															<td class="en_font">${ordrVO.ordrDt}</td>
															<td class="center"><fmt:formatNumber value="${ordrVO.ordrDtlVOList[0].ordrAmt}"
																	pattern="#,###" />원</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div style="text-align: center; padding: 20px;">
												<button type="button" id="addOrdr">더보기</button>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>

						<div class="con_tit1 mb15">
							<div>
								<p>보유 쿠폰</p>
							</div>
						</div>
						<div class="bdr_box">
							<div class="product_tbl">
								<ul class="con_box">
									<li class="on">
										<div class="list_tbl">
											<table id="couponListTable">
												<colgroup>
													<col width="20%">
													<col width="20%">
													<col width="10%">
													<col width="30%">
													<col width="10%">
												</colgroup>
												<tbody>
													<tr>
														<th>쿠폰</th>
														<th>이벤트 메뉴</th>
														<th>할인 금액</th>
														<th>이벤트 기간</th>
														<th>유효기간</th>
													</tr>
													<c:forEach var="eventVO" items="${eventVOList}">
														<c:if test="${eventVO.remainDay > 0}">
														<tr class="ordrAccordion-item">
															<td>${eventVO.couponGroupVOList[0].couponNm}</td>
															<td>${eventVO.couponGroupVOList[0].menuVO.menuNm}</td>
															<td>${eventVO.couponGroupVOList[0].dscntAmt}원</td>
															<td class="status">
																<c:if test="${not empty eventVO.bgngYmd}">
																	<c:set var="year"
																		value="${fn:substring(eventVO.bgngYmd, 0, 4)}" />
																	<c:set var="month"
																		value="${fn:substring(eventVO.bgngYmd, 4, 6)}" />
																	<c:set var="day"
																		value="${fn:substring(eventVO.bgngYmd, 6, 8)}" />
																	<c:set var="formattedDate"
																		value="${year}-${month}-${day}" />
																</c:if> <c:if test="${not empty eventVO.expYmd}">
																	<c:set var="expYear" value="${fn:substring(eventVO.expYmd, 0, 4)}" />
																	<c:set var="expMonth" value="${fn:substring(eventVO.expYmd, 4, 6)}" />
																	<c:set var="expDay" value="${fn:substring(eventVO.expYmd, 6, 8)}" />
																	<c:set var="formattedExpDate" value="${expYear}-${expMonth}-${expDay}" />
																</c:if> ${formattedDate} ~ ${formattedExpDate}</td>
																<td>${eventVO.remainDay}일</td>
															</tr>
														</c:if>
													</c:forEach>
												</tbody>
											</table>
											<div style="text-align: center; padding: 20px;">
												<button type="button" id="addOrdr">더보기</button>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						
						<div class="con_tit1 mb15">
							<div>
								<p>문의 내역</p>
							</div>
						</div>
						<div class="bdr_box">
							<div class="product_tbl">
								<ul class="con_box">
									<li class="on">
										<div class="list_tbl">
											<table id="orderListTable">
												<colgroup>
													<col width="10%">
													<col width="20%">
													<col width="30%">
													<col width="10%">
												</colgroup>
												<tbody>
													<tr>
														<th>문의 유형</th>
														<th>제목</th>
														<th>작성 일자</th>
														<th>문의 답변 여부</th>
													</tr>
												<c:forEach var="qsVO" items="${qsVOList}">
								               <tr class="accordion-item" onclick="toggleAccordion(this)">
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
								                  <td>${qsVO.qsTtl}</td>
								                  <td>${qsVO.wrtrDt}</td>
								                   <td>
								                        <c:if test="${qsVO.ansCn == 'N'}">
								                            <span class="bge bge-warning" id="tap-clsing">
								                                <span class="tap-title">준비중</span>
								                            </span>
								                        </c:if>
								                        <c:if test="${qsVO.ansCn != 'N'}">
								                            <span class="bge bge-active" id="tap-clsing">
								                                <span class="tap-title">답변 완료</span>
								                            </span>
								                        </c:if>
								                    </td>
								               </tr>
								               <tr class="accordion-collapse">
								                  <c:if test="${qsVO.ansCn != 'N'}">
								                     <td colspan="4">
								                        <div class="accordion-body">
								                           ${qsVO.ansCn}
								                        </div>
								                     </td>
								                  </c:if>   
								               </tr>
								            </c:forEach>
								         	</tbody>
											</table>
										</div>
									</li>
								</ul>
							</div>
						</div>
						
						<div class="con_tit1 mb15">
							<div>
								<p>가맹지점 상담 </p>
							</div>
						</div>
						<div class="bdr_box">
							<div class="product_tbl">
								<ul class="con_box">
									<li class="on">
										<div class="list_tbl">
											<table id="orderListTable">
												<colgroup>
													<col width="20%">
													<col width="20%">
													<col width="30%">
												</colgroup>
												<tbody>
													<tr>
														<th>희망 지역</th>
														<th>희망 상담 일자</th>
														<th>상담 상태</th>
													</tr>
												  <c:forEach var="frcsDscsnVO" items="${frcsDscsnVOList}">
									               <tr class="accordion-item" onclick="toggleAccordion(this)">
									                  <td class="center">
									                     <c:choose>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN11'}">서울특별시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN21'}">부산광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN22'}">대구광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN23'}">인천광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN24'}">광주광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN25'}">대전광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN26'}">울산광역시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN29'}">세종특별자치시</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN31'}">경기도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN32'}">강원도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN33'}">충청북도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN34'}">충청남도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN35'}">전라북도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN36'}">전라남도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN37'}">경상북도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN38'}">경상남도</c:when>
									                         <c:when test="${frcsDscsnVO.rgnNo == 'RGN39'}">제주특별자치도</c:when>
									                         <c:otherwise>알 수 없음</c:otherwise>
									                     </c:choose>
									                  </td>
									                  <td class="center">
									                     <c:if test="${not empty frcsDscsnVO.dscsnPlanYmd}">
									                          <c:set var="dscsnPlanYmd" value="${fn:substring(frcsDscsnVO.dscsnPlanYmd, 0, 4)}-${fn:substring(frcsDscsnVO.dscsnPlanYmd, 4, 6)}-${fn:substring(frcsDscsnVO.dscsnPlanYmd, 6,8)}" />
									                          ${dscsnPlanYmd}
									                     </c:if>
									                  </td>
									                   <td class="center">
									                        <c:if test="${frcsDscsnVO.dscsnType == 'DSC01'}">
									                            <span class="bge bge-warning" id="tap-clsing">
									                                <span class="tap-title">상담 대기중</span>
									                            </span>
									                        </c:if>
									                        <c:if test="${frcsDscsnVO.dscsnType != 'DSC01'}">
									                            <span class="bge bge-active" id="tap-clsing">
									                                <span class="tap-title">상담 완료</span>
									                            </span>
									                        </c:if>
									                    </td>
									               </tr>
									            </c:forEach>
												</table>
										</div>
									</li>
								</ul>
							</div>
						</div>
						
						
						<div class="con_tit1 mb15">
							<div>
								<p>개인 정보 수정</p>
							</div>
						</div>
						<div class="bdr_box">
							<div class="product_tbl">
								<ul class="con_box">
									<li class="on">
										<div class="list_tbl">
											<table id="orderListTable">
												<colgroup>
													<col width="20%">
													<col width="20%">
													<col width="10%">
													<col width="30%">
													<col width="10%">
												</colgroup>
												<tbody>
													<tr>
														<th>쿠폰</th>
														<th>이벤트 메뉴</th>
														<th>할인 금액</th>
														<th>이벤트 기간</th>
														<th>유효기간</th>
													</tr>
													<c:forEach var="eventVO" items="${eventVOList}">
														<c:if test="${eventVO.remainDay > 0}">
														<tr class="ordrAccordion-item">
															<td>${eventVO.couponGroupVOList[0].couponNm}</td>
															<td>${eventVO.couponGroupVOList[0].menuVO.menuNm}</td>
															<td>${eventVO.couponGroupVOList[0].dscntAmt}원</td>
															<td class="status">
																<c:if test="${not empty eventVO.bgngYmd}">
																	<c:set var="year"
																		value="${fn:substring(eventVO.bgngYmd, 0, 4)}" />
																	<c:set var="month"
																		value="${fn:substring(eventVO.bgngYmd, 4, 6)}" />
																	<c:set var="day"
																		value="${fn:substring(eventVO.bgngYmd, 6, 8)}" />
																	<c:set var="formattedDate"
																		value="${year}-${month}-${day}" />
																</c:if> <c:if test="${not empty eventVO.expYmd}">
																	<c:set var="expYear" value="${fn:substring(eventVO.expYmd, 0, 4)}" />
																	<c:set var="expMonth" value="${fn:substring(eventVO.expYmd, 4, 6)}" />
																	<c:set var="expDay" value="${fn:substring(eventVO.expYmd, 6, 8)}" />
																	<c:set var="formattedExpDate" value="${expYear}-${expMonth}-${expDay}" />
																</c:if> ${formattedDate} ~ ${formattedExpDate}</td>
																<td>${eventVO.remainDay}일</td>
															</tr>
														</c:if>
													</c:forEach>
												</tbody>
											</table>
											<div style="text-align: center; padding: 20px;">
												<button type="button" id="addOrdr">더보기</button>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- 페이지 끝 -->

