<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link href="/resources/hdofc/css/main.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/main.js"></script>
<!-- <sec:authentication property="principal.MemberVO" var="user"/> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script>
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
let date = 'year' // 매출 조회시 사용
$(function(){
	// 매출 차트
	selectAmtAjax();
  	 $('input[name="clclnDate"]').on('change', function() {
		 date = $('input[name="clclnDate"]:checked').val();
		 selectAmtAjax();
	});
  	 
  	///// 점검 차트
  	// JSP에서 Java 객체를 JSON으로 변환, null일 경우 빈 배열로 설정
	  const chkData = ${chk != null ? chk : '[]'};  // chk가 null이면 빈 배열로 처리
	
	  
	// 등급과 총합 데이터 추출
	const gradeLabels = chkData.map(item => item.grade);  // 등급(A, B, C, D, F)
	const totalData = chkData.map(item => item.total);    // 총합 값
	
	// 도넛 차트 데이터 설정
	const doughnutData = {
	  labels: gradeLabels,  // chk.grade 값을 labels로 사용
	  datasets: [{
	    label: '등급별 총합',
	    data: totalData,  // chk.total 값을 데이터로 사용
	    backgroundColor: [
	      'rgba(255, 99, 132, 0.2)',  // 색상 설정
	      'rgba(54, 162, 235, 0.2)', 
	      'rgba(255, 206, 86, 0.2)', 
	      'rgba(75, 192, 192, 0.2)', 
	      'rgba(153, 102, 255, 0.2)'
	    ],
	    borderColor: [
	      'rgba(255, 99, 132, 1)',  // 테두리 색상 설정
	      'rgba(54, 162, 235, 1)', 
	      'rgba(255, 206, 86, 1)', 
	      'rgba(75, 192, 192, 1)', 
	      'rgba(153, 102, 255, 1)'
	    ],
	    borderWidth: 1  // 테두리 두께
	  }]
	};
	
	// 도넛 차트 옵션 설정
	const doughnutOptions = {
	  responsive: false,  // 반응형 여부
	  plugins: {
	    legend: {
	      display: true,  // 범례 표시
	      position: 'bottom',
	      font: { // [타이틀 폰트 스타일 변경]
				family: 'NanumSquare, sans-serif', // 폰트 설정
				size: 18,
				weight: 'bold',
			}
	    }
	  }
	};
	
	// 차트 생성
	var ctx = document.getElementById('chk-doughnut').getContext('2d');
	var chkDoughnutChart = new Chart(ctx, {
	  type: 'doughnut',  // 차트 유형
	  data: doughnutData,  // 데이터
	  options: doughnutOptions  // 옵션
	});
  	
  	////// 점검 차트 끝
  	 
	////////////// 카테고리
	const allIndicator = document.querySelectorAll('.indicator li');
	const allContent = document.querySelectorAll('.main-content li');
	
// 	$('.indicator li').on('click', function(){
// 		let type = $(this).date('type');
// 	})
	
	allIndicator.forEach(item=> {
	  item.addEventListener('click', function () {
	    const content = document.querySelector(this.dataset.target);
		
	    allIndicator.forEach(i=> {
	      i.classList.remove('active');
	    })
	
	    allContent.forEach(i=> {
	      i.classList.remove('active');
	    })
	
	    content.classList.add('active');
	    this.classList.add('active');
	  })
	})
	/////////////카테고리 끝
	
	
	///////////// 상담 달력 이벤트 추가
	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: "dayGridMonth",
	    firstDay: 1,
	    buttonText: {
	        today: '오늘'  // today 버튼 텍스트를 "오늘"로 변경
	    },
	    datesSet: function(info) { // 사용자가 달력을 이동할 때 발생하는 이벤트
	        // 현재 조회 중인 달의 시작일과 종료일 가져오기
	        var startDate = info.startStr.split('T')[0];  // '2024-09-30' 형식으로 변환
			var endDate = info.endStr.split('T')[0];      // '2024-11-11' 형식으로 변환
	        
	        console.log(startDate, endDate);
	     // AJAX로 서버에 조회 중인 기간 데이터를 요청
	        $.ajax({
	          url: '/hdofc/getEvent',
	          type: 'POST',
		       // csrf설정 secuity설정된 경우 필수!!
		  		beforeSend:function(xhr){ 
		  			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		  		},
	          contentType: 'application/json',
	          data: JSON.stringify({
	            startDate: startDate,
	            endDate: endDate
	          }),
	          success: function(res) {
	            // 서버로부터 받은 데이터를 처리하여 FullCalendar에 반영
	            calendar.removeAllEvents(); // 기존 이벤트 제거
	            
	            // 서버에서 받은 데이터가 객체라고 가정하고, 객체의 값을 배열처럼 처리
	            Object.values(res).forEach(function(event) {
	              // 각 이벤트 추가
	              var eventData = {
	                title: event.mbrNm,          // VO에서 mbrNm을 이벤트 제목으로 설정
	                start: event.dscsnPlanYmd,   // VO에서 dscsnPlanYmd를 이벤트 날짜로 설정 (YYYY-MM-DD 형식)
	                allDay: true                 // 하루 종일 이벤트로 설정
	              };
	              
	              // 이벤트 소스에 추가
	              calendar.addEvent(eventData);
	            });
	          },
	          error: function(xhr, status, error) {
	            console.error('Error:', error); // 에러 처리
	          }
	        });
	     },
// 	    showNonCurrentDates: false,  // 현재 달 외의 날짜를 숨김
	    titleFormat: function (date) {
	      year = date.date.year;
	      month = date.date.month + 1;

	      return year + "년 " + month + "월";
	    },
    });
    calendar.render();
    

});
</script>



<div class="wrap home-wrap">
<!-- 11111 -->
<div class="frow">
	 
	<!-- BUFF 현황 -->
	<div class="main-cont fcol buff">
		<div class="cont-title">BUFF 현황</div>
		<div class="btnBox-wrap">
			<!-- fcol시작 -->
			<div class="fcol">
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/frcs/list'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">가맹점 수</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.frcsCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">arrow_outward</span>
					</div>
				</div>
				
				<div class="frow btnBox-cont" onclick="/hdofc/member/selectMemberList'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">회원 수</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.custCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">arrow_outward</span>
					</div>
				</div>
			</div>
			<!-- fcol끝 -->
		
			<!-- fcol시작 -->
			<div class="fcol">
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/cnpt/list'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">거래처 수</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.cnptCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">arrow_outward</span>
					</div>
				</div>
				
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/mngr/selectMngrList'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">사원 수</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.mngrCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">arrow_outward</span>
					</div>
				</div>
			</div>
		</div>
		<!-- fcol끝 -->
	</div>
	<!-- BUFF 현황 끝 -->
	
	<!-- 물류 매출 -->
	<div class="main-cont fcol">
		<div class="cont-title">물류 관리</div>
		<div class="btnBox-wrap">
			<!-- fcol시작 -->
			<div class="fcol">
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/deal/regist'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">구매필요 건</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.purCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">sell</span>
					</div>
				</div>
				
				<div class="frow btnBox-cont">
					<div class="btnBox-dtl">
						<div class="btnBox-title">판매승인 건</div>
						<div class="btnBox-num" onclick="location.href='/hdofc/deal/list?type=so'">
							<fmt:formatNumber value="${cnt.aprvCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">gavel</span>
					</div>
				</div>
			</div>
			<!-- fcol끝 -->
		
			<!-- fcol시작 -->
			<div class="fcol">
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/deal/list?type=po'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">배송확정 건</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.deliCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">quick_reorder</span>
					</div>
				</div>
				
				<div class="frow btnBox-cont" onclick="location.href='/hdofc/deal/list?type=po'">
					<div class="btnBox-dtl">
						<div class="btnBox-title">정산미납 건</div>
						<div class="btnBox-num">
							<fmt:formatNumber value="${cnt.clclnCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					<div class="btnBox-icon">
						<span class="material-symbols-outlined icon-cnt">paid</span>
					</div>
				</div>
			</div>
		</div>
		<!-- fcol끝 -->
	</div>
	<!-- 물류매출 끝 -->
	
	<!-- 상담 대기 내역
		문의 대기 내역 갯수 -->
	<div class="fcol">
		<div class="frow">
			<div class="cnt-wrap">
				<div class="cnt-cont" onclick="location.href='/hdofc/frcs/dscsn/list'">
					<div class="cnt-icon" style="background: var(--green--3)">
						<span class="material-symbols-outlined icon-cnt">person</span>
					</div>
					<div class="cnt-title">상담 대기</div>
					<div class="cnt-num">
						<fmt:formatNumber value="${cnt.dscCnt}" type="number" groupingUsed="true"/>
					</div>
				</div>
				
				<div class="cnt-cont" onclick="location.href='/hdofc/qs/selectQsList'">
					<div class="cnt-icon" style="background: var(--green--2)">
						<span class="material-symbols-outlined icon-cnt">person</span>
					</div>
					<div class="cnt-title">답변 대기</div>
					<div class="cnt-num">
						<fmt:formatNumber value="${cnt.qsCnt}" type="number" groupingUsed="true"/>
					</div>
				</div>
			</div>
		</div>
		<!-- 폐업대기 가맹점, 승인 관리자 -->
		<div class="fcol">
			<div class="frow">
				<div class="cnt-wrap">
					<div class="cnt-cont" onclick="location.href='/hdofc/frcs/check/list'">
						<div class="cnt-icon" style="background: var(--yellow--3)">
							<span class="material-symbols-outlined icon-cnt">store</span>
						</div>
						<div class="cnt-title">점검 예정</div>
						<div class="cnt-num">
							<fmt:formatNumber value="${cnt.checkCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
					
					<div class="cnt-cont" onclick="location.href='/hdofc/frcs/clsbiz/list'">
						<div class="cnt-icon" style="background: var(--red--2)">
							<span class="material-symbols-outlined icon-cnt">store</span>
						</div>
						<div class="cnt-title">폐업 예정</div>
						<div class="cnt-num">
							<fmt:formatNumber value="${cnt.clsCnt}" type="number" groupingUsed="true"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 갯수 끝 -->
	
	<!-- 점검별 가맹점 분포 -->
	<div class="main-cont fcol check-chart">
			<div class="cont-title">가맹점 점검 현황</div>
			<div class="chk-chart">
				<canvas id="chk-doughnut" width="200" height="200"></canvas>
			</div>
	</div>
</div>
<!-- 11111111 -->

<!-- 2번째줄 -->
<div class="frow">

	<!--  상담/문의/점검/폐업 시작 -->
	<div class="main-container" style="flex-grow: 1;">
		<div class="main-wrapper">
			<ul class="indicator">
				<li class="active" data-target="#home" data-type="dsc"><i class="ph-house"></i> 상담</li>
				<li data-target="#profile" data-type="qs"><i class="ph-user-circle"></i> 문의</li>
				<li data-target="#contact" data-type="notice"><i class="ph-phone"></i> 이벤트</li>
			</ul>
			<ul class="main-content main-cont board-box">
				<li class="active" id="home">
					<div class="table-wrap" style="width: 100%;">
						<div class="table-title">
							<div class="cont-title">상담 예정</div> 
							<div class="btn-wrap">
								<button type="button" class="btn-active" onclick="location.href='/hdofc/frcs/dscsn/list'">더보기 <span class="icon material-symbols-outlined">East</span></button>
							</div>
						</div>
							<table class="table-default table-main-info">
								<thead>
									<tr>
										<th class="center" style="width: 90px;">번호</th>
										<th class="center" width="30%;">이름</th>
										<th class="center" width="30%;">상담일자</th>
										<th class="center" width="30%;">희망지역</th>
									</tr>
								</thead>
								<tbody class="table-error">
									<c:if test="${dscsn==null}">
										<tr>
											<td class="error-info" colspan="5"> 
												<span class="icon material-symbols-outlined">error</span>
												<div class="error-msg">문의 답변 대기 결과가 없습니다</div>
											</td>
										</tr>
									</c:if>
								<c:if test="${dscsn!=null}">
									<c:forEach var="dsc" items="${dscsn}">
										<tr onclick="location.href='/hdofc/frcs/dscsn/dtl?dscsnCode=${dsc.dscsnCode}'">
											<td class="center" style="width: 90px;">${dsc.rnum}</td>
											<td class="center" width="30%;">${dsc.mbrNm }</td>
											<c:set var="plan" value="${dsc.dscsnPlanYmd.substring(0,4)}-${dsc.dscsnPlanYmd.substring(4,6)}-${dsc.dscsnPlanYmd.substring(6,8)}" />
											<td class="center" width="30%;">${plan}</td>
											<td class="center" width="30%;">${dsc.rgnNm}</td>
										</tr>
									</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>	
						<!-- table-wrap끝 -->	
				</li>
				<li id="profile">
					<div class="table-wrap" style="width: 100%;">
						<div class="table-title">
							<div class="cont-title">문의 답변 대기</div> 
							<div class="btn-wrap">
								<button type="button" class="btn-active" onclick="location.href='/hdofc/qs/selectQsList'">더보기 <span class="icon material-symbols-outlined">East</span></button>
							</div>
						</div>
							<table class="table-default table-main-info">
								<thead>
									<tr>
										<th class="center" style="width: 90px;">번호</th>
										<th class="center" width="45%;">제목</th>
										<th class="center" width="25%;">작성일자</th>
										<th class="center" width="20%">유형</th>
									</tr>
								</thead>
								<tbody class="table-error">
									<c:if test="${qs==null}">
										<tr>
											<td class="error-info" colspan="5"> 
												<span class="icon material-symbols-outlined">error</span>
												<div class="error-msg">문의 답변 대기 결과가 없습니다</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${qs!=null }">
									</c:if>
									<c:forEach var="qs" items="${qs}">
									<tr onclick="location.href='/hdofc/qs/selectQsDetail?qsSeq=${qs.qsSeq}'">
										<td class="center" width="90px;">${qs.rnum}</td>
										<td width="45%;">
												<c:choose>
												    <c:when test="${fn:length(qs.qsTtl) > 20}">
												        ${fn:substring(qs.qsTtl, 0, 20)}...
												    </c:when>
												    <c:otherwise>
												        ${qs.qsTtl}
												    </c:otherwise>
												</c:choose>
										</td>
										
										<!-- 시간 처리!!! -->
										<td class="center" width="20%;">
								            <script>
								                // 서버에서 넘어온 wrtrDt 데이터
								                var wrtrDt = new Date('${qs.wrtrDt}');
								                console.log(wrtrDt);
								                var currentDate = new Date();  // 현재 날짜
								
								                // 날짜 비교 함수 (날짜만 비교)
								                function isSameDay(d1, d2) {
								                    return d1.getFullYear() === d2.getFullYear() &&
								                           d1.getMonth() === d2.getMonth() &&
								                           d1.getDate() === d2.getDate();
								                }
								
								                // 날짜를 YYYY-MM-DD 형식으로 출력하는 함수
								                function formatDate(date) {
								                    const year = date.getFullYear();
								                    const month = String(date.getMonth() + 1).padStart(2, '0');  // 2자리 월
								                    const day = String(date.getDate()).padStart(2, '0');  // 2자리 일
								                    return year+"-"+month+"-"+day;
								                }
								
								                // 시간을 HH:MM:SS 형식으로 출력하는 함수
								                function formatTime(date) {
								                    const hours = String(date.getHours()).padStart(2, '0');  // 2자리 시
								                    const minutes = String(date.getMinutes()).padStart(2, '0');  // 2자리 분
								                    const seconds = String(date.getSeconds()).padStart(2, '0');  // 2자리 초
								                    return hours+":"+minutes+":"+seconds;
								                }
								
								                // 같은 날이면 시간만, 다른 날이면 날짜만 출력
								                if (isSameDay(wrtrDt, currentDate)) {
								                    document.write(formatTime(wrtrDt));  // 시간만 출력
								                } else {
								                    document.write(formatDate(wrtrDt));  // 날짜만 출력
								                }
								            </script>
										</td>
										<td class="center" width="25%;"><span class="bge bge-default-border">${qs.qsTypeNm}</span></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>	
						<!-- table-wrap끝 -->	
				</li>
				<li id="contact">
					<div class="table-wrap" style="width: 100%;">
						<div class="table-title">
							<div class="cont-title">진행 중인 이벤트</div> 
							<div class="btn-wrap">
								<button type="button" class="btn-active" onclick="location.href='/hdofc/event/selectEventList'">더보기 <span class="icon material-symbols-outlined">East</span></button>
							</div>
						</div>
							<table class="table-default table-main-info">
								<thead>
									<tr>
										<th class="center" style="width: 90px;">번호</th>
										<th class="center" width="45%;">제목</th>
										<th class="center" width="25%;">시작일자</th>
										<th class="center" width="20%;">종료일자</th>
									</tr>
								</thead>
								<tbody class="table-error">
									<c:if test="${evt==null}">
										<tr>
											<td class="error-info" colspan="4"> 
												<span class="icon material-symbols-outlined">error</span>
												<div class="error-msg">진행 중인 이벤트가 없습니다</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${evt!=null}">
										<c:forEach var="evt" items="${evt}">
										<tr onclick="location.href='/hdofc/event/selectEventDetail?eventNo=${evt.eventNo}'">
											<td class="center" width="90px;">${evt.rnum}</td>
											<td width="47%;">
												<c:choose>
												    <c:when test="${fn:length(evt.eventTtl) > 20}">
												        ${fn:substring(evt.eventTtl, 0, 20)}...
												    </c:when>
												    <c:otherwise>
												        ${evt.eventTtl}
												    </c:otherwise>
												</c:choose>
											</td>
											<c:set var="bgng" value="${evt.bgngYmd.substring(0,4)}-${evt.bgngYmd.substring(4,6)}-${evt.bgngYmd.substring(6,8)}" />
											<c:set var="exp" value="${evt.expYmd.substring(0,4)}-${evt.expYmd.substring(4,6)}-${evt.expYmd.substring(6,8)}" />
											<td class="center" width="25%;">${bgng}</td>
											<td class="center" width="20%;">${exp}</td>
										</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>	
						<!-- table-wrap끝 -->	
				</li>
<!-- 				<li id="settings"> -->
			
<!-- 				</li> -->
			</ul>
		</div>
	</div>
	<!--  상담/문의/점검/폐업 끝 -->

	<!-- 달력 -->
	<div class="main-cont">
		<div id="calendar"></div>	
	</div>
</div>
<!-- 2번째 줄 끝 -->

<!-- 3번째줄 매출 -->
<div class="frow">
	<!-- 최근 1년 매출 -->
	<div class="fcol w-350 main-cont back-red">
		<div class="cont-title">최근 1년간 내역</div>
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					상품 판매 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt"><fmt:formatNumber value="${cnt.sellAmt}" type="number" groupingUsed="true"/></p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt" style="color: var(--bge--active)">trending_up</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
		
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					상품 구매 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt"><fmt:formatNumber value="${cnt.purAmt}" type="number" groupingUsed="true"/></p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt" style="color: var(--bge--danger)">trending_down</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
		
		<!-- amt-cont시작 -->
		<div class="amt-cont">
			<div class="amt-cont-dtl">
				<div class="amt-title">
					정산 금액
				</div>
				<div class="amt-dtl">
					<p class="amt-amt"><fmt:formatNumber value="${cnt.clclnAmt}" type="number" groupingUsed="true"/></p>
					<p>원</p>
				</div>
			</div>
			<!-- amt-cont-dtl끝 -->
			<div class="amt-icon">
				<span class="material-symbols-outlined icon-amt" style="color: var(--bge--warning)">send_money</span>
			</div>
		</div>
		<!-- amt-cont끝 -->
	</div>
	<!-- 최근 1년간 내역 -->

	<!-- 매출 금액 -->
	<div class="main-cont sls-chart frow">
		<!-- 매출 차트 -->
		<div class="fcol" style="flex-grow: 1; padding: var(--gap--s);">
			<!-- cont-title시작 -->
			<div class="cont-title">
				<!-- clcln-wrap시작 -->
				<div class="clcln-wrap">
					<!-- clcln-cont시작 -->
					<div class="clcln-cont">
						<div class="clcln-icon">
							<span class="material-symbols-outlined">send_money</span>
						</div>
						<div class="clcln-dtl">
							<div class="clcln-title">기간별 매출</div>
							<div class="clcln-cn" id="totalAmt"></div>
						</div>
					</div>
					<!-- clcln-cont 끝 -->
					
				</div>
				<!-- clcln-wrap 끝 -->
			</div>
			<!-- cont-title -->
			
			<div class="clcln-chart">
				<div class="ordr-chart">
					<canvas id="myChart" style="display: block; box-sizing: border-box; height: 300px; width: 100%;">
					</canvas>
				</div>
			</div>	
		</div>
		<!-- 매출차트 끝 -->
		
		<!-- 지역별 매출 +radio -->
		<div class="fcol">
			<div class="radio">
				<div class="form_toggle row-vh d-flex flex-row" style="gap:var(--gap--s);">
					<div class="form_radio_btn radio_male">
						<input id="radio-1" type="radio" name="clclnDate" value="day">
						<label for="radio-1">일간</label>
					</div>
					<div class="form_radio_btn">
						<input id="radio-2" type="radio" name="clclnDate" value="month">
						<label for="radio-2">월간</label>
					</div>
					<div class="form_radio_btn">
						<input id="radio-3" type="radio" name="clclnDate" value="year" checked>
						<label for="radio-3">년간</label>
					</div>
				</div>
			</div>
			
			<div class="cont-title">지역별 매출</div>
			<div class="rgn-chart">
				<canvas id="rgn-doughnut" width="300" height="210"></canvas>
			</div>
		</div>
		<!-- 지역별매출 + radio끝 -->
		
	</div>
	<!-- 매출끝 -->
</div>
<!-- 333333333333 -->

</div>
<!-- wrap끝 -->