<%--
    @fileName    : selectMyPage.jsp
    @programName : 메인홈화면
    @description : 고객 마이페이지에서 문의사항, 가맹점 상담내역, 주문내역, 보유 쿠폰 조회, 관심 매장에 대한 정보를 확인할 수 있음.
    @author      : 서윤정
    @date        : 2024. 09. 29
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.buff.vo.OrdrVO"%>
<%@page import="java.util.Date"%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link href="/resources/cust/css/custMyPage.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- <script src="/resources/js/sweetalert2.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="user" />
</sec:authorize>

<style>
.more-btn {
    display: flex;
    align-items: center;
    cursor: pointer;
    border: 1px solid var(--gray--7);
    width: fit-content;
    margin: 32px auto;
    padding: 7px 17px 7px 14px;
    border-radius: 50px;
}

.likeBtn {
	margin: auto;
    padding: 10px;
    background-color: var(--green--5);
    color: white;
}

.star-btn {
    background: none;
    padding: 0;
}

.star-icon02 {
	font-size: 2rem;
	font-variation-settings: 'FILL' 1, 'wght' 200, 'GRAD' 0, 'opsz' 24;
	color: var(--brand--primary);
}

.likeStoreLine{
	vertical-align: middle;
}

</style>


<script type="text/javascript">
	let mbrId = "${user.mbrId}";

	function toggleAccordion(element) {
		var collapseRow = element.nextElementSibling;
		var isVisible = collapseRow.classList.contains('show');

		// Hide all open rows
		document.querySelectorAll('.accordion-collapse').forEach(function(row) {
			row.classList.remove('show');
		});

		// Toggle the clicked row
		if (!isVisible) {
			collapseRow.classList.add('show');
		} // if 끝

	};// toggleAccordion 끝

	//다음 주소 검색 api
	function openHomeSearch() {
		new daum.Postcode({
			oncomplete : function(data) {
				$('#mbrZip').val(data.zonecode);
				$('#mbrAddr').val(data.address);
				$('#mbrDaddr').val(data.buildingName);
				$('#mbrDaddr').focus();
			}
		}).open();
	}

	// 주문 내역이 제일 먼저 나오게 먼저 실행
	function fn_orderListAjax() {
		$(".table-wrap").hide();

		$.ajax({
			url : "/custPage/selectOrderListAjax",
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				console.log("result : ", result);
				$("#con_tit1").html(
						"<p>주문 내역</p> <em>(6개월 주문 내역만 조회 가능합니다.)</em>");
	
				let str = "<table><colgroup>";
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
				str += "<th>결제 금액 (원)</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>"; // 데이터는 tbody에 추가
	
				// 주문 내역이 없을 경우 처리
				if (result.length === 0) {
					str += '<tr class="order-empty">';
					str += '<td colspan="5" class="center">주문 내역이 없습니다</td>'; // colspan을 5로 설정
					str += '</tr>';
				} else {
					// Ajax 결과를 사용해 데이터를 동적으로 추가합니다
					$.each(result,function(idx, ordrVO) {
						str += "<tr class='ordrAccordion-item' onclick='toggleAccordion(this)'>";
						str += "<td class='center'>"
								+ ordrVO.ordrNo
								+ "</td>";
						str += "<td class='en_font' style='text-align: left;'>"
								+ ordrVO.ordrDtlVOList[0].bzentVO.bzentNm
								+ "</td>";
						str += "<td class='status'>";
						if (ordrVO.ordrType === 'ORDR01') {
							str += "<span class='bge bge-danger'>포장</span>";
						} else {
							str += "<span class='bge bge-info'>매장</span>";
						}
						str += "</td>";
	
						str += "<td class='en_font'>"
								+ new Intl.DateTimeFormat(
										'ko-KR',
										{
											year : 'numeric',
											month : '2-digit',
											day : '2-digit',
											hour : '2-digit',
											minute : '2-digit',
											second : '2-digit',
											hour12 : false
										// 12시간제 대신 24시간제로 표시
										})
										.format(new Date(
												ordrVO.ordrDt))
								+ "</td>";
						str += "<td class='center' style= 'text-align: right;'>"
								+ new Intl.NumberFormat()
										.format(ordrVO.ordrDtlVOList[0].totalOrdrAtm)
								+ "</td>";
						str += "</tr>";
					});
				}
				str += "</tbody></table>";
				$("#list_tbl").html(str);
				 moreItem(".list_tbl", ".ordrAccordion-item", 5);
			},
			error : function(err) {
				console.log("주문 데이터를 불러오는데 실패했습니다: ", err);
			}
		}); // ajax 끝
	} // end function

$(function() { // 전체 시작 

	$('#custInfo').css("display", "none"); // 초기화
	$('#myList').css("display", "block"); // 초기화
	$('.otherList').css("display", "block");

	//document가 로딩된 후에 주문내역(전역 함수 처리된)을 자동 실행되기
	fn_orderListAjax();

	// 토글 이벤트 -------------------------------------------
	// 초기 5개의 항목만 표시
	$(".ordrAccordion-item").slice(0, 5).show(); // show()를 사용하여 첫 5개 항목을 표시

	$("#addOrdr").click(function(e) {
		e.preventDefault();

		// 더보기 버튼 클릭 시, 숨겨진 다음 5개의 항목을 표시
		var hiddenItems = $(".ordrAccordion-item:hidden").slice(0, 5); // 아직 보여지지 않은 항목 중 5개 선택
		hiddenItems.show(); // 선택된 항목을 보여줌

		// 더 이상 숨겨진 항목이 없을 경우 '더보기' 버튼 숨김
		if ($(".ordrAccordion-item:hidden").length === 0) {
			$("#addOrdr").hide();
		}
	}); // addOrdr 끝

	//나의 주문 현황 시작 --------------------------------------
	let ordrType1 = 0; // 포장
	let ordrType2 = 0; // 매장

	<c:forEach var="ordrVO" items="${ordrVOList}">

	if ("${ordrVO.ordrType}" == "ORDR01") {
		ordrType1++;
	} else {
		ordrType2++;
	}
	</c:forEach>

	$("#ordrType1").text(ordrType1);
	$("#ordrType2").text(ordrType2);

	//쿠폰 현황 시작 -----------------------------------------
	let couponTotal = 0;

	<c:forEach var="eventVO" items="${eventVOList}">
	if ("${eventVO.remainDay}" > 0) { // 사용가능한 쿠폰 갯수
		couponTotal++;
	}
	</c:forEach>

	// 쿠폰 총 갯수를 HTML에 표시
	$("#couponTotal").text(couponTotal);

	// 초기 설정: 주문 테이블 보이기, 쿠폰 테이블 숨기기
	$("#myList").show();

	// 주문 내역 클릭 시
	$("#myOrderList").on("click", function() {
		$("#myList").show(); // 주문 내역 테이블을 보이기
		$("#couponListTable").hide(); // 쿠폰 테이블 숨기기
	});

	// 쿠폰 클릭 시
	$("#myCouponList").on("click", function() {
		$("#myList").hide(); // 주문 내역 테이블 숨기기
		$("#couponListTable").show(); // 쿠폰 테이블 보이기
	});

	//나의 관심 매장 현황 시작 --------------------------------------
	let likeStoreTotal = 0;

	<c:forEach var="favFrcsVO" items="${memberVOList.favFrcsVOList}">
	likeStoreTotal++;
	</c:forEach>

	$("#likeStoreTotal").text(likeStoreTotal);

	// 문의 현황 시작 ------------------------------------------------
	let qsTotal = 0;
	// 문의 목록에서 각 건수 계산
	<c:forEach var="qsVO" items="${qsVOList}">
	qsTotal++;
	</c:forEach>

	// 건수 표시
	$("#qsTotal").text(qsTotal);

	// 가맹점 상담  현황 시작 ------------------------------------------------
	let dscsnTotal = 0;

	<c:forEach var="frcsDscsnVO" items="${frcsDscsnVOList}">
	dscsnTotal++;
	</c:forEach>

	// 건수 표시
	$("#dscsnTotal").text(dscsnTotal);

	// 가. 주문 목록 시작 ------------------------------------------------
	$("#myOrderList").on("click", function() {

		fn_orderListAjax();

	}); // myOrderList 끝

	// 나. 쿠폰
	$(".clsLeftMenu").on("click",function() {
		let gubun = $(this).data("gubun");
		console.log("gubun : " + gubun);
		$(".table-wrap").hide();
		$("#chageCustInfoForm").hide();

		// 쿠폰
		if (gubun == "myCouponList") {
			$.ajax({
				url : "/custPage/selectCouponListAjax",
				type : "post",
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(
							"${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {

					$("#con_tit1").html("<p>보유쿠폰</p>");

					let str = "";

					str += '<table>';
					str += '<colgroup>';
					str += '<col width="23%">';
					str += '<col width="23%">';
					str += '<col width="15%">';
					str += '<col width="25%">';
					str += '<col width="14%">';
					str += '</colgroup>';
					str += '<tbody>';
					str += '<tr>';
					str += '<th>쿠폰</th>';
					str += '<th>이벤트 메뉴</th>';
					str += '<th>할인 금액 (원)</th>';
					str += '<th>이벤트 기간</th>';
					str += '<th>유효기간 (일)</th>';
					str += '</tr>';

					// 쿠폰이 없을 경우 처리
					if (result.length === 0) {
						str += '<tr class="coupon-empty">';
						str += '<td colspan="5" class="center">발급받은 쿠폰이 없습니다</td>'; // colspan을 5로 설정
						str += '</tr>';
					} else {
						// JSON 데이터를 반복하여 테이블 생성
						$.each(result,function(idx,eventVO) {
							if (eventVO.remainDay > 0) { // 남은 기간이 0보다 클 경우만 표시
								str += '<tr class="ordrAccordion-item">';
								str += '<td style="text-align: left;">' + eventVO.couponGroupVOList[0].couponNm + '</td>';
								str += '<td style="text-align: left;">' + eventVO.couponGroupVOList[0].menuVO.menuNm + '</td>';

								// 할인 금액 포맷
								let discountAmount = new Intl.NumberFormat().format(eventVO.couponGroupVOList[0].dscntAmt);
								str += '<td style="text-align: right;">'+ discountAmount+ '</td>';

								// 이벤트 기간 포맷
								let bgngYmd = eventVO.bgngYmd;
								let expYmd = eventVO.expYmd;
								let formattedDate = '';
								let formattedExpDate = '';

								if (bgngYmd&& bgngYmd.length === 8) {
									formattedDate = bgngYmd.substring(0,4)+ '-'+ bgngYmd.substring(4,6)+ '-'+ bgngYmd.substring(6,8);
								}

								if (expYmd&& expYmd.length === 8) {
									formattedExpDate = expYmd.substring(0,4)+ '-'+ expYmd.substring(4,6)+ '-'+ expYmd.substring(6,8);
								}

								str += '<td class="status">'+ formattedDate+ ' ~ '+ formattedExpDate+ '</td>';
								str += '<td>'+ eventVO.remainDay+ '</td>';
								str += '</tr>';
							} // if 끝
						});
					}

					str += '</tbody>';
					str += '</table>';

					console.log("str : ", str);
					$(".list_tbl").html(str);
					
					// 더보기
					moreItem(".list_tbl", ".ordrAccordion-item", 5);
				},
				error : function(err) {
					console.log("쿠폰 데이터를 불러오는데 실패했습니다: ",err);
				}
			}); // ajax 끝
		} // if 끝
	}); // clsLeftMenu 끝

	// 다. 관심 매장 목록
	$("#myLikeStore").on("click",function() {
		
		$(".table-wrap").hide();
		$("#chageCustInfoForm").hide();
		$("#con_tit1").html("<p>관심 매장</p>");

		$.ajax({
			url : "/custPage/selectMyStoreListAjax",
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(
						"${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				
				let str = '<table>';
				str += '<colgroup>';
				str += '<col width="13%">';
				str += '<col width="20%" style="text-align: left;">';
				str += '<col width="45%" style="text-align: left;">';
				str += '<col width="17%">';
				str += '<col width="15%">';
				str += '</colgroup>';
				str += '<tbody>';
				str += '<tr>';
				str += '<th>관심 삭제</th>';
				str += '<th>매장명</th>';
				str += '<th>매장 주소</th>';
				str += '<th>전화번호</th>';
				str += '<th>이용 시간</th>';
				str += '</tr>';
				
				// 관심 매장 삭제 후, 관심 매장이 0일 경우
				let hasStore = false; // 매장이 있는지 확인하는 변수

				// result.favFrcsVOList가 비어 있지 않은 경우
				$.each(result.favFrcsVOList,function(index,memberVO) {
					// 매장명이 null인지 확인
					if (memberVO.bzentVO.bzentNm) {
						hasStore = true; // 매장이 있는 경우
						let bzentTelno = memberVO.bzentVO.bzentTelno;
						let newBzentTelno = formatPhoneNumber(bzentTelno);
						
						let ddlnTm = memberVO.frcsVOList[0].ddlnTm;
	                    if (ddlnTm === '00:00') {
	                        ddlnTm = '24:00';
	                    }
	                    
						str += '<tr class="ordrAccordion-item">';
						//str += '<td><button class="likeBtn" value="' + memberVO.frcsVOList[0].frcsNo + '">관심 삭제</button></td>';
						str += '<td><button type="button" value="' + memberVO.frcsVOList[0].frcsNo + '" class="likeBtn star-btn">';
						str += '<span id="starIcon" class="star-icon02 material-symbols-outlined">star</span>';
						str += '</button></td>';
						str += '<td class="likeStoreLine" style="text-align: left;">'+ memberVO.bzentVO.bzentNm+ '</td>';
						str += '<td class="likeStoreLine" style="text-align: left;">'+ memberVO.bzentVO.bzentAddr+ '('+ memberVO.bzentVO.bzentDaddr+ ')'+ '</td>';
						str += '<td class="likeStoreLine">'+ newBzentTelno+ '</td>';
						str += '<td class="likeStoreLine">'+ memberVO.frcsVOList[0].openTm+ '~'+ ddlnTm + '</td>';
						str += '</tr>';
					}
				});

				// 매장이 없는 경우 메시지 추가
				if (!hasStore) {
					str += '<tr class="likeStore-empty">';
					str += '<td colspan="5">등록된 관심 매장이 없습니다</td>'; // colspan을 5로 수정
					str += '</tr>';
				}

				str += '</tbody>';
				str += '</table>';

				$("#list_tbl").html(str);
				
				// 더보기
				 moreItem(".list_tbl", ".ordrAccordion-item", 5);

			},
			error : function(err) {
				console.log("관심 매장 데이터를 불러오는데 실패했습니다: ",err);
			}
		}); // ajax 끝
	}); // myStoreList 끝

	// 라. 문의 내역
	$("#myQsList").on("click",function() {
		$(".table-wrap").hide();
		$("#chageCustInfoForm").hide();

		$.ajax({
			url : "/custPage/selectMyQsListAjax",
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(result) {

			$("#con_tit1").html("<p>문의 내역</p>");

			let str = '';
			str = '<table>';
			str += '<colgroup>';
			str += '<col width="10%">';
			str += '<col width="20%">';
			str += '<col width="30%">';
			str += '<col width="10%">';
			str += '</colgroup>';
			str += '<tbody>';
			str += '<tr>';
			str += '<th>문의 유형</th>';
			str += '<th>제목</th>';
			str += '<th>작성 일자</th>';
			str += '<th>문의 답변 여부</th>';
			str += '</tr>';

			if (result.length === 0) {
				str += '<tr class="qs-empty">';
				str += '<td colspan="4">등록된 문의 내역이 없습니다</td>';
				str += '</tr>';
			} else {
				// 문의 내역 리스트 순회하여 동적으로 생성
				$.each(result,function(index,qsVO) {
					 // str += '<tr class="accordion-item" onclick="toggleAccordion(this)">';
					//  str += '<tr class="accordion-item" onclick="window.location.href=\'/center/selectBoard?tap=qsTap\'">';
						str += '<tr class="accordion-item" onclick="window.location.href=\'/cust/selectQsDetail?qsSeq='+ qsVO.qsSeq+ '\'">';



					// 문의 유형 처리
					let qsTypeText = '';
					switch (qsVO.qsType) {
						case 'QS01':qsTypeText = '구매'; break;
						case 'QS02':qsTypeText = '매장이용'; break;
						case 'QS03': qsTypeText = '채용'; break;
						case 'QS04': qsTypeText = '가맹점'; break;
						case 'QS05': qsTypeText = '기타'; break;
						default:qsTypeText = '알 수 없음';
					}
					str += '<td>'+ qsTypeText+ '</td>';
				 	str += '<td style="text-align: left;"><a href="/cust/selectQsDetail?qsSeq='+ qsVO.qsSeq+ '">'+ qsVO.qsTtl+ '</a></td>';
					//str += '<td style="text-align: left;"><a href="/center/selectBoard?tap=qsTap">' + qsVO.qsTtl + '</a></td>';
					str += '<td>'+ qsVO.wrtrDt+ '</td>';

					// 문의 답변 여부 처리
					if (qsVO.ansCn === 'N') {
						str += '<td>';
						str += '<span class="bge bge-warning" id="tap-clsing">';
						str += '<span class="tap-title">준비중</span>';
						str += '</span>';
						str += '</td>';
					} else {
						str += '<td>';
						str += '<span class="bge bge-active" id="tap-clsing">';
						str += '<span class="tap-title">답변 완료</span>';
						str += '</span>';
						str += '</td>';
					}

					str += '</tr>';

					// 답변 내용이 있을 때만 보여줌
					/* if (qsVO.ansCn !== 'N') {
						str += '<tr class="accordion-collapse">';
						str += '<td colspan="4">';
						str += '<div class="accordion-body">';
						str += qsVO.ansCn;
						str += '</div>';
						str += '</td>';
						str += '</tr>';
					} */
				});
			}
			str += '</tbody>';
			str += '</table>';

			console.log("str : ", str);
			$("#list_tbl").html(str);
			
			// 더보기
			 moreItem("#list_tbl", ".accordion-item", 5);

			},
			error : function(err) {
				console.log("문의 데이터를 불러오는데 실패했습니다: ",err);
			}
		}); // ajax 끝
	}); // myStoreList 끝

	// 가맹점 상담 목록 
	$("#myDscsnList").on("click", function(){
	    $(".table-wrap").hide();
	    $("#chageCustInfoForm").hide();
	
	    console.log("개똥이 나와줘~!!");
	
	    $("#con_tit1").html("<p>가맹점 상담 내역</p>");
	
	    $.ajax({
	        url: "/custPage/selectMyDscsnListAjax",
	        type: "post",
	        dataType: "json",
	        beforeSend: function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function(result){
	            console.log("myDscsnListAjax->result : ", result);
	
	            let str = '';
	            str = '<table>';
	            str += '<colgroup>';
	            str += '<col width="20%">';
	            str += '<col width="20%">';
	            str += '<col width="30%">';
	            str += '</colgroup>';
	            str += '<tbody>';
	            str += '<tr>';
	            str += '<th>희망 지역</th>';
	            str += '<th>희망 상담 일자</th>';
	            str += '<th>상담 상태</th>';
	            str += '</tr>';
	
	            // 상담 내역이 없는 경우 처리
	            if (result.length === 0) {
	                str += '<tr class="consultation-empty">';
	                str += '<td colspan="3" class="center">등록된 상담 내역이 없습니다</td>'; // colspan을 3으로 설정
	                str += '</tr>';
	            } else {
	                // 가맹 상담 리스트 순회하여 동적으로 생성
	                $.each(result, function(index, frcsDscsnVO) {
	                    str += '<tr class="accordion-item" onclick="toggleAccordion(this)">';
	
	                    // 희망 지역 처리
	                    let rgnNm = '';
	                    switch (frcsDscsnVO.rgnNo) {
	                        case 'RGN11': rgnNm = '서울특별시'; break;
	                        case 'RGN21': rgnNm = '부산광역시'; break;
	                        case 'RGN22': rgnNm = '대구광역시'; break;
	                        case 'RGN23': rgnNm = '인천광역시'; break;
	                        case 'RGN24': rgnNm = '광주광역시'; break;
	                        case 'RGN25': rgnNm = '대전광역시'; break;
	                        case 'RGN26': rgnNm = '울산광역시'; break;
	                        case 'RGN29': rgnNm = '세종특별자치시'; break;
	                        case 'RGN31': rgnNm = '경기도'; break;
	                        case 'RGN32': rgnNm = '강원도'; break;
	                        case 'RGN33': rgnNm = '충청북도'; break;
	                        case 'RGN34': rgnNm = '충청남도'; break;
	                        case 'RGN35': rgnNm = '전라북도'; break;
	                        case 'RGN36': rgnNm = '전라남도'; break;
	                        case 'RGN37': rgnNm = '경상북도'; break;
	                        case 'RGN38': rgnNm = '경상남도'; break;
	                        case 'RGN39': rgnNm = '제주특별자치도'; break;
	                        default: rgnNm = '알 수 없음';
	                    }
	                    str += '<td class="center">' + rgnNm + '</td>';
	
	                    // 상담 일자 처리
	                    if (frcsDscsnVO.dscsnPlanYmd) {
	                        let formattedDate = frcsDscsnVO.dscsnPlanYmd.substring(0, 4) + '-' + frcsDscsnVO.dscsnPlanYmd.substring(4, 6) + '-' + frcsDscsnVO.dscsnPlanYmd.substring(6, 8);
	                        str += '<td class="center">' + formattedDate + '</td>';
	                    } else {
	                        str += '<td class="center"></td>';
	                    }
	
	                    // 상담 상태 처리
	                    if (frcsDscsnVO.dscsnType === 'DSC01') {
	                        str += '<td class="center">';
	                        str += '<span class="bge bge-warning" id="tap-clsing">';
	                        str += '<span class="tap-title">상담 대기중</span>';
	                        str += '</span>';
	                        str += '</td>';
	                    } else {
	                        str += '<td class="center">';
	                        str += '<span class="bge bge-active" id="tap-clsing">';
	                        str += '<span class="tap-title">상담 완료</span>';
	                        str += '</span>';
	                        str += '</td>';
	                    }
	
	                    str += '</tr>';
	                });
	            }
	
	            str += '</tbody>';
	            str += '</table>';
	
	            console.log("str : ", str);
	            $("#list_tbl").html(str);
	            
	            // 더보기
	            moreItem(".list_tbl", ".ordrAccordion-item", 5);
	
	        },
	        error: function(err) {
	            console.log("상담 내역 데이터 불러오는데 실패했습니다: ", err);
	        }
	    }); // ajax 끝
	}); // myDscsnList 끝


	// 개인정보 수정 ajax
	$("#changeInfo").on("click", function() {
	    console.log("#changeInfo -> 개인정보 변경");
	
	    let isValid = true; // 유효성 검사 결과 저장 변수
	
	    // 이메일 유효성 검사
	    var mbrEmlAddr = $('#mbrEmlAddr').val();
	    console.log("입력된 이메일 주소: ", mbrEmlAddr); // 이메일 값이 제대로 가져와지는지 확인
	    var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
	
	    if (!emailRegex.test(mbrEmlAddr)) {
	        $('#emailError').text('유효한 이메일 주소를 입력해주세요.').css("color", "red");
	        isValid = false; // isValid로 수정
	        return;
	    } else {
	        $('#emailError').text(''); // 오류 메시지 지우기
	    }
	
	    // mbrZip 유효성검증
	    let mbrZip = $("#mbrZip").val();
	    console.log("mbrZip : ", mbrZip);
	
	    if (mbrZip == "") {
	        $("#mbrZipError").text("우편번호를 입력해주세요.").css("color", "red");
	        return;
	    }

	    // 주소 입력 확인
	    let mbrAddr = $('#mbrAddr').val();
	    if (mbrAddr == "") {
	        $('#mbrAddrError').text('주소를 입력해주세요.').css("color", "red");
	        isValid = false;
	        return;
	    } else {
	        $('#mbrAddrError').text('');
	    }
	
	    let mbrTelno1 = $('#mbrTelNo1').val().trim();
	    let mbrTelno2 = $('#mbrTelNo2').val().trim();
	    let mbrTelno3 = $('#mbrTelNo3').val().trim();
	    let mbrTelno = mbrTelno1 + mbrTelno2 + mbrTelno3;
	
	    if (mbrTelno1.length !== 3 || mbrTelno2.length !== 4 || mbrTelno3.length !== 4) {
	        $('#mbrTelnoError')
	            .text('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)')
	            .css("color", "red");
	        isValid = false;
	        return;
	    } else {
	        $('#mbrTelnoError').text('');
	    }
	
	    // 비밀번호 확인 (비밀번호 입력 없이도 업데이트 가능)
	    let mbrPswd = $('#mbrPswd').val();
	    let mbrPswd2 = $('#mbrPswd2').val();
	    console.log("mbrPswd : " + mbrPswd);
	    
	    if (mbrPswd && mbrPswd != mbrPswd2) { // 비밀번호가 입력되었고 서로 다를 때
	        $('#passwordError2').text('비밀번호를 확인하세요.').css("color", "red");
	        isValid = false;
	        return;
	    } else {
	        $('#passwordError2').text('');
	    }
	
	    if (isValid) { // 모든 유효성 검사 통과 시에만 ajax 요청
	        let jsonData = {
	            "mbrId": mbrId,
	            "mbrPswd": mbrPswd, // 비밀번호가 입력되었을 경우만 포함
	            "mbrTelno": mbrTelno1 + mbrTelno2 + mbrTelno3,
	            "mbrAddr": mbrAddr,
	            "mbrDaddr": $('#mbrDaddr').val(),
	            "mbrZip": $('#mbrZip').val(),
	            "mbrEmlAddr": $("#mbrEmlAddr").val()
	        };
	
	        console.log("jsonData : ", jsonData);
	
	        $.ajax({
	            url: "/custPage/updateCustInfoAjax",
	            type: "post",
	            contentType: "application/json;charset=utf-8", // JSON 형식으로 전송
	            data: JSON.stringify(jsonData), // JSON 문자열로 변환
	            dataType: "json", // 응답받는 데이터 형식을 JSON으로 설정
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            success: function(result) {
	                if (result) {
	                    Swal.fire({
	                        icon: 'success',
	                        timer : 2000,
	                        title: '개인 정보 변경 완료 ',
	                        text: '개인 정보 변경이 완료되었습니다'
	                    });
	                    
	                    $('#cancelBtn, #changeInfo, #delmbr').css('display', 'none');
	            		$('.chagePwd').css('display', 'table-column');
	            		$('#btnPwd').css('display', 'block');
	            		$('#chageCustInfoForm input').attr('disabled', true);
	                    
	                    // 2초 후에 location.href를 실행
	                   /*  setTimeout(function() {
	                        location.href = "/login";
	                    }, 2000); */
	                    
	                    
	                } else {
	                    Swal.fire({
	                        icon: 'error',
	                        title: '개인 정보 변경 실패',
	                        text: '개인 정보 변경 실패했습니다.'
	                    });
	
	                    location.href = "/custPage/selectMyPage?mode=myInfo";
	                }
	            },
	            error: function(err) {
	                console.log("개인정보 수정 실패(err): ", err);
	            }
	        });
	    } // end if
	}); // changeInfo 끝


	// 비밀번호 중복 검사 (유효성 검사 포함, 일치 여부 확인)
	$("#checkPswdDuplicateBtn").on("click",function() {
		let mbrPswd = $('#mbrPswd').val();
		let mbrPswd2 = $('#mbrPswd2').val();
		let isPswdValid = false;

		//1. 비밀번호 입력 확인
		if (!mbrPswd) {
			$('#passwordError2').text('비밀번호를 입력하세요.').css(
					"color", "red");
			//2. 비밀번호 확인 입력 확인
		} else if (!mbrPswd2) {
			$('#passwordError2').text('비밀번호 확인을 입력하세요.')
					.css("color", "red");
		} else {
			//3. 비밀번호 유효성 검사
			const passwordPattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/;
			if (!passwordPattern.test(mbrPswd)) {
				$('#passwordError2').text(
						'비밀번호는 영문, 숫자를 포함한 4~12자리여야 합니다.')
						.css("color", "red");
				//4. 비밀번호와 비밀번호 확인 일치 확인
			} else if (mbrPswd !== mbrPswd2) {
				$('#passwordError2').text(
						'비밀번호가 일치하지 않습니다.').css("color",
						"red");
			} else {
				$('#passwordError2').text('비밀번호가 일치합니다.')
						.css("color", "green");
				isPswdValid = true;
			}
		}

		// 비밀번호 유효성 검사 결과에 따라 버튼 활성화/비활성화
		//        if (isPswdValid) {
		//            $("#changeInfo").removeAttr("disabled");
		//        } else {
		//            $("#changeInfo").attr("disabled", "disabled");
		//        }
	});

	// 숫자만 입력받도록 제한 (input 이벤트 리스너)
	$(".input-tel").on("input", function() {
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
	
	// 나의 정보 변경 버튼 클릭시, 비밀번호 재입력 모달 나오기     
	$("#btnPwd").on("click", function() {
		$("#pswdInput").val('');
		$("#pswdCheck").modal("show");
	});

	// 비밀번호 확인 버튼 클릭시 이벤트 핸들러
	$("#ModalBtnCheck").on("click", function() {
		var inputPswd = $("#pswdInput").val();
	
		//inputPswd : java
		console.log("inputPswd : " + inputPswd);
	
		// 비밀번호 검증 Ajax 비동기 처리
		$.ajax({
			url : "/find/checkPswd",
			type : "POST",
			data : {
				"inputPswd" : inputPswd
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(res) {
				console.log("res : ", res);
	
				if (res === "success") {
					
					// 모달 닫기
					closeModal();
	
					$('#btnPwd').css('display', 'none');
					$('#cancelBtn, #changeInfo, #delmbr').css('display','block');
					$('.chagePwd').css('display', 'table-row');
					$('#chageCustInfoForm input').removeAttr('disabled');
	
				} else {
					// 비밀번호 불일치
					Swal.fire({
						icon : 'error',
						text : '비밀번호가 일치하지 않습니다',
						timer : 2000,
						position : 'top-center',
						showConfirmButton : false
					});
	
					$('#cancelBtn, #changeInfo, #delmbr').css('display','none');
					$('#btnPwd').css('display', 'block');
					$('#chageCustInfoForm input').attr('disabled',true);
	
					// 모달 닫기
					closeModal();
				}
			},
			error : function(xhr, status, error) {
				console.log("xhr: ", xhr);
				console.log("status: ", status);
				console.log("error: ", error);
			}
	
		});
	
		// 모달창 이벤트 핸들러 끝.   
	});
	
	// 회원 탈퇴 
	$("#updateMbrBtn").on("click",function() {

		console.log("회원 탈퇴 실행");
	
		$.ajax({
			url : "/custPage/updateMbrAjax",
			type : "post",
			data : {"mbrId" : mbrId},
			dataType : "text",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(result) {
				console.log("updateMbrAjax->result : ", result);
	
				Swal.fire({
					icon : 'success',
					title : '회원 탈퇴',
					text : '회원 탈퇴가 되었습니다.',
					timer : 2000,
					showConfirmButton : false
				});
	
				// window.location.href = "/buff/home";
				//로그아웃 처리
				
				setTimeout(function() {
					$("#logoutForm").submit();
				}, 2000);
											
			},
			error : function(err) {
				console.log("회원 탙퇴 실패 : ", err);
	
				Swal.fire({
					icon : 'error',
					title : '회원 탈퇴 실패',
					text : '회원 탈퇴 실패했습니다.',
					timer : 1000,
					showConfirmButton : false
				});
				
				setTimeout(function() {
					window.location.href = "/custPage/selectMyPage";
				}, 2000);
				
			}
		}); // ajax 끝
	}); // updateMbrBtn 끝

	// 관심 매장 관심 삭제  시작
	$(document).on('click','.likeBtn',
		function() {
		// 방금 클릭한 버튼을 가져온다. 
		let btn = $(this);
	
		// 해당 버튼의 value값 가져오기
		let bzentNo = btn.val();
		console.log("bzentNo :", bzentNo);
	
		$.ajax({
			url : "/cust/selectStoreAjax",
			type : "POST",
			data : {bzentNo : bzentNo},
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(response) {
				if (response.isDuplicate === 'N') {
	
					Swal.fire({
						icon : 'success',
						title : '관심 매장 삭제',
						text : '관심 매장 해제되었습니다.'
					});
	
					// 클릭한 버튼의 부모 tr 요소를 찾아서 관심 매장 삭제
					btn.closest('tr').remove();
	
					if ($("#list_tbl tbody tr").length === 1) { // 1은 헤더 행만 남았다는 의미
						let str = '<tr class="likeStore-empty">';
						str += '<td colspan="5">등록된 관심 매장이 없습니다</td>'; // colspan을 5로 수정
						str += '</tr>';
						$("#list_tbl tbody")
								.append(str); // 메시지 추가
					}
	
				} else {
					Swal.fire({
						icon : 'success',
						title : '관심 매장 삭제 실패',
						text : '관심 매장 삭제에 실패했습니다.'
					});
				}
			},
			error : function(xhr, status, error) {
				console.log("err : ", err);
			}
		}); // ajax 끝
	
	}); // .likeBtn 끝

	/* 정기쁨 추가 ************************************************/
	// 게시판 왼쪽 메뉴 클릭 시 이벤트
	$('.lef_menu ul li').on('click', function() {
	
		$('#custInfo').css("display", "none"); // 초기화
		$('#myList').css("display", "block"); // 초기화
		$('.otherList').css("display", "block");
	
		//왼쪽 메뉴1~5는 <div id="myList"..>각각의 목록이 나옴</div>
		// 주문 내역 클릭 시
		if ($(this).is('#myOrderList')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
		}
	
		// 쿠폰 클릭 시
		if ($(this).is('#myCouponList')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
		}
	
		// 가맹상담 클릭 시
		if ($(this).is('#myLikeStore')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
		}
	
		// 문의 내역 클릭 시
		if ($(this).is('#myQsList')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
		}
	
		// 가맹상담 클릭 시
		if ($(this).is('#myDscsnList')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
		}
	
		// 개인 정보 클릭 시
		if ($(this).is('#myInfo')) {
			$('.lef_menu ul li').removeClass('on');
			$(this).addClass('on');
	
			$('.otherList').css("display", "none"); // 초기화
			$('.chagePwd').css("display", "none"); // 초기화
			$('#chageCustInfoForm').css("display", "block"); // 초기화
			$('#custInfo').css("display", "block"); // 초기화
		}
	});// lef_menu ul li 끝

	// 나의 정보 수정 취소
	$("#cancelBtn").on("click", function() {
		$('#cancelBtn, #changeInfo, #delmbr').css('display', 'none');
		$('.chagePwd').css('display', 'table-column');
		$('#btnPwd').css('display', 'block');
		$('#chageCustInfoForm input').attr('disabled', true);
	});

	// 회원 탈퇴 모달 띄우기
	$("#delmbr").on("click", function() {
		console.log("버튼 2 회원 탈퇴 모달 ")
		$("#deleteMbrModal").modal("show"); // 회원 탈퇴 모달 보이기
	});

	// 모달 밖에 클릭시 모달 닫기
	window.onclick = function(event) {
		var modal = document.getElementById("deleteMbrModal");
		if (event.target === modal) {
			modal.style.display = "none"; // 모달 닫기
		} // if 끝
	};

	//개인 정보 수정 후 화면 리플레시 후 개인정보 수정이 클릭된 효과
	let mode = "${param.mode}";//?mode=myInfo
	console.log("mode : " + mode);

	if (mode == "myInfo") {
		console.log("mode! : " + mode);

		$('.lef_menu ul li').removeClass('on');
		$("#myInfo").addClass('on');

		$('#myList, #couponListTable, #qsListTable, #dscsnListTable')
				.hide(); // 초기화
		$(".table-wrap").show(); // 기본 정보 변경 폼 보이기

		$("#myList").css("display", "none");
	}
	
}); // 전체 끝

function openModal() {
	$(".deleteMbrModal").modal("show");
}

function closeModal() {
	$("#pswdCheck").modal("hide"); // 패스워드 모달 
}

function closeModal2() {
	$("#deleteMbrModal").modal("hide"); // 패스워드 모달 
}

/*
 // 모달 외부 클릭 시 닫기 
 window.onclick = function(event) {
 var modal = document.querySelector('.deleteMbrModal');
 if (event.target == modal) {
 closeModal();
 } //if 끝
 }; //  모달 외부 닫기 끝
 */
function formatPhoneNumber(bzentTelno) {
	let newBzentTelno = '';

	if (bzentTelno) {
		if (bzentTelno.length === 10) {
			newBzentTelno = bzentTelno.substring(0, 2) + '-'+ bzentTelno.substring(2, 6) + '-'+ bzentTelno.substring(6);
		} else if (bzentTelno.length === 11) {
			newBzentTelno = bzentTelno.substring(0, 3) + '-'+ bzentTelno.substring(3, 7) + '-'+ bzentTelno.substring(7);
		} else {
			console.warn('전화번호 형식이 잘못되었습니다:', bzentTelno);
			newBzentTelno = bzentTelno;
		}
	} else {
		console.warn('매장 번호가 없음.');
		newBzentTelno = '-';
	}

	return newBzentTelno;
}
 
 // 더보기
 function moreItem(bigFrame, executionPlace, cnt) {
	    // 모든 항목 숨김
	    $(executionPlace).hide();
	    
	    // 처음 N개 항목만 표시
	    $(executionPlace).slice(0, cnt).show();

	    // 기존의 더보기 버튼이 있을 경우 제거
	    $(bigFrame).find(".view-more").remove();

	    // 더보기 버튼 추가
	    if ($(executionPlace).length > cnt) {
	        $(bigFrame).append(`
	            <div class="view-more">
	                <div class="more-btn">
	                    <span class="material-symbols-outlined">add</span>더보기
	                </div>
	            </div>
	        `);
	    }

	    // 더보기 버튼 클릭 이벤트
	    $(".more-btn").off("click").on("click", function(e) {
	        e.preventDefault();

	        // 숨겨진 다음 N개 항목 선택
	        var hiddenItems = $(executionPlace + ":hidden").slice(0, cnt); 
	        hiddenItems.show(); // 선택된 항목을 보여줌

	        // 더 이상 숨겨진 항목이 없을 경우 더보기 버튼 숨김
	        if ($(executionPlace + ":hidden").length === 0) {
	            $(this).closest(".view-more").hide();
	        }
	    });
	}
</script>

<!-- 로그아웃을 위한 form -->
<form id="logoutForm" action="/logout" method="post">
	<sec:csrfInput />
</form>

<div class="wrap">

	<!-- 마이페이지 상단 -->
	<div class="mypage-top">
		<div class="wrap-cont">

			<div class="info">
				<div class="tit">
					<p>${user.mbrNm}님의<br> <span class="en_font">MYPAGE</span></p>
				</div>
				<ul>
					<li>
						<div class="membership">
							<div class="box box1 mbs1">
								<div class="hambergur-icon"></div>
								<p>나의 주문 현황</p>
								<strong>포장 <span id="ordrType1"></span>건
								</strong> <strong>매장 <span id="ordrType2"></span>건
								</strong>
							</div>
						</div>
					</li>
					<li class="division">
						<div class="delivering">
							<div class="box box2">
								<div>
									<p>관심 매장</p>
									<strong><span class="en_font"><span
											id="likeStoreTotal"></span></span>개</strong>
								</div>
								<div class="box2-icon delivering-icon"></div>
							</div>
						</div>
						<div class="delivered" id="myQsList_">
							<div class="box box2">
								<div>
									<p>1:1 문의</p>
									<strong><span class="en_font"><span
											id="qsTotal"></span></span>건</strong>
								</div>
								<div class="box2-icon  qs-icon"></div>
							</div>
						</div>
					</li>
					<li class="division">
						<div class="point" id="myDscsnList_">
							<div class="box box2">
								<div>
									<p>가맹지점 상담</p>
									<strong><span class="en_font"><span
											id="dscsnTotal"></span></span>건</strong>
								</div>
								<div class="box2-icon dscsn-icon"></div>
							</div>
						</div>
						<div class="coupon" id="myCouponList">
							<div class="box box2">
								<div>
									<p>쿠폰</p>
									<strong><span class="en_font"><span
											id="couponTotal"></span></span>건</strong>
								</div>
								<div class="box2-icon coupon-icon"></div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<!-- /.info -->

			<ul class="order-wrap">
				<li class="order-cont here"
					onclick="window.location.href='/cust/ordr/regist?ordrType=ORDR01'">
					<p class="order-title">
						<!-- ?gubun=order1 -->
						매장 주문하기 <span class="go-icon material-symbols-outlined">east</span>
					</p>
					<p>신선한 재료로 바로 조리된 음식을</p>
					<p>매장에서 여유롭게 즐겨보세요</p>
				</li>
				<li class="order-cont togo"
					onclick="window.location.href='/cust/ordr/regist?ordrType=ORDR02'">
					<p class="order-title">
						<!-- ?gubun=order2 -->
						포장 주문하기 <span class="go-icon material-symbols-outlined">east</span>
					</p>
					<p>주문과 동시에 음식을 빠르게 준비해드려</p>
					<p>간편하게 가져갈 수 있어요</p>
				</li>
			</ul>
			<!-- order-wrap -->
		</div>
		<!-- /.wrap-cont -->
	</div>
	<!-- /.mypage-top: 페이지 상단 끝  -->

	<!-- 마이페이지 하단 -->
	<div class="mypage-bom">
		<div class="wrap-cont">

			<!-- 사이드 영역 시작  -->
			<div class="side_nav">
				<div class="lef_menu">
					<ul>
						<li class="on" id="myOrderList"><span>주문내역</span></li>
						<li class="clsLeftMenu" data-gubun="myCouponList"
							id="myCouponList"><span>쿠폰</span></li>
						<li id="myLikeStore"><span>관심 매장</span></li>
						<li id="myQsList"><span>문의 내역</span></li>
						<li id="myDscsnList"><span>가맹 상담</span></li>
						<li id="myInfo"><span>개인정보 수정</span></li>
					</ul>
				</div>
				<!-- /.lef_menu -->

				<!-- 게시판 영역 시작 -->
				<div class="rig_con">
					<!-- 주문내역 시작 -->
					<div id="myList">
						<div class="otherList">
							<div class="con_tit1" id="con_tit1">
								<p>주문내역</p>
								<em>(6개월 주문 내역만 조회 가능합니다.)</em>
							</div>
							<!-- /.con_tit1 -->

							<!-- 리스트들이 출력 될 ajax 영역 -->
							<div class="list_tbl" id="list_tbl"></div>
						</div>

						<!-- 나의 정보 변경 시작 show -> table-wrap -->
						<div class="cont" id="custInfo">
							<div class="con_tit1" id="con_tit1">
								<p>개인 정보</p>
								<button type="button" id="delmbr">회원 탈퇴 <span class="icon material-symbols-outlined">arrow_forward_ios</span></button>
							</div>
							<!-- 개인정보 리스트 시작 -->
							<div class="bdr_box">
								<form id="chageCustInfoForm">
									<div class="write_tbl">
										<table>
											<colgroup>
												<col width="15%">
												<col width="85%">
											</colgroup>
											<tbody>
												<tr>
													<th>이름</th>
													<td>${memberVOList.mbrNm}</td>
												</tr>
												<tr>
													<th>생년월일</th>
													<td>
														<c:if test="${not empty memberVOList.mbrBrdt}">
															<c:set var="mbrBrdt" value="${fn:substring(memberVOList.mbrBrdt, 0, 4)}-${fn:substring(memberVOList.mbrBrdt, 4, 6)}-${fn:substring(memberVOList.mbrBrdt, 6,8)}" />${mbrBrdt}
							                           </c:if>
						                           </td>
												</tr>
												<tr>
													<th>이메일</th>
													<td>
														<input type="text" id="mbrEmlAddr" value="${memberVOList.mbrEmlAddr}" disabled> 
														<span id="emailError" class="error-message"></span> <!-- 이메일 오류 메시지 영역 -->
													</td>
												</tr>
												<tr>
													<th>핸드폰 번호</th>
													<td>
														<c:set var="phoneNumber" value="${memberVOList.mbrTelno}" />
														<c:if test="${not empty phoneNumber}">
															<input class="input-tel" id="mbrTelNo1" type="text" maxlength="3" size="5" value="${phoneNumber.substring(0, 3)}" disabled /> -
															<input class="input-tel" id="mbrTelNo2" type="text" maxlength="4" size="5" value="${phoneNumber.substring(3, 7)}" disabled /> -
															<input class="input-tel" id="mbrTelNo3" type="text" maxlength="4" size="5" value="${phoneNumber.substring(7)}" disabled />
															<span id="mbrTelnoError" class="error-message"></span>
															<!-- 오류 메시지 영역 -->
														</c:if>
													</td>
												</tr>
												<tr>
													<th>주소</th>
													<td>
														<div class="addr-zip-wrap">
															<div class="addr-wrap">
																<input id="mbrZip" class="input-zip" type="text" value="${memberVOList.mbrZip}" readonly disabled />
																<button class="btn btn-default" type="button" onclick="openHomeSearch()" id="homeSearch">우편번호 검색</button>
																<span id="mbrZipError" class="error-message"></span>
																<!-- 오류 메시지 영역 -->
															</div>
															<div class="addr-wrap">
																<input id="mbrAddr" class="input-addr" type="text" value="${memberVOList.mbrAddr}" disabled /> 
																<input id="mbrDaddr" class="input-addr" type="text" value="${memberVOList.mbrDaddr}" disabled />
																<span id="mbrAddrError" class="error-message"></span> <!-- 오류 메시지 영역 -->
															</div>
														</div>
													</td>
												</tr>
												<tr class="chagePwd">
			                                    	<th>비밀번호 변경</th>
				                                    <td>
				                                       <input type="password" id="mbrPswd" name="mbrPswd" class="text-input" placeholder="비밀번호 변경 시 입력">
				                                    </td>
			                                    </tr>
			                                    <tr class="chagePwd">
				                                    <th>비밀번호 확인</th>
				                                    <td>
				                                       <!-- 비밀번호 확인 text폼 만들기 -->
				                                       <input type="password" id="mbrPswd2" class="text-input" placeholder="비밀번호 변경 시 입력">
				                                       <button type="button" class="btn btn-default" id="checkPswdDuplicateBtn">확인</button>   
				                                       <span id="passwordError2" class="error-message"></span> <!-- 오류 메시지 영역 -->
				                                    </td>
				                                </tr>
											</tbody>
										</table>
									</div>
									<!-- /.write_tbl -->

									<div class="btn_area mt45">
										<button type="button" class="btn-active" id="btnPwd">나의 정보 변경</button>
										<button type="button" id="cancelBtn">취소</button>
										<button type="button" id=changeInfo class="btn-active">저장</button>
									</div>
									<!-- /.btn_area -->
								</form>
							</div>
							<!-- 나의 정보 변경 , 회원 탈퇴 끝 -->

						</div>
						<!-- /.custInfo -->

					</div>
					<!-- /.myList -->
				</div>
				<!-- /.rig_con -->
			</div>
			<!-- /.side_nav -->
		</div>
		<!-- /.wrap-cont: 페이지 하단 끝 -->
	</div>
	<!-- /.mypage-bom 하단 끝 -->
</div>
<!-- /.wrap -->

<!-- 비밀 번호 확인 모달 -->
<div class="modal fade" id="pswdCheck" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<div>
					<h4 class="modal-title">비밀번호 확인</h4>
				</div>
				<div>
					<button type="button" class="btn-icon" data-dismiss="modal">
						<span class="material-symbols-outlined icon-btn" id="ModalBtnCancel">close</span>
					</button>
				</div>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group modal-cont">
					<div class="cont-title">비밀번호</div>
					<div class="cont-cont">
						<input type="password" class="text-input" id="pswdInput"
							name="pswdInput" placeholder="비밀번호를 입력하세요." />
					</div>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer" id="ModalBtnCheck">확인</div>
		</div>
	</div>
</div>
<!-- 비밀 번호 확인 모달 끝-->

<!-- /////  회원 탈퇴 모달 시작  //// -->
<div class="modal fade" id="deleteMbrModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog del-modal">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<div>
					<h4 class="modal-title">회원 탈퇴</h4>
				</div>
				<div>
					<button type="button" class="btn-icon" data-dismiss="modal" onclick="closeModal()">
						<span class="material-symbols-outlined icon-btn" id="deleteClsbizBtn">close</span>
					</button>
				</div>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group">
					<div class="del-info">
						<h2>회원 탈퇴시 유의 사항</h2>
						<p>1. 탈퇴 시 고객님의 개인정보 및 쿠폰 정보는 모두 삭제되어 더 이상 혜택을 받을 수 없으며, 재가입 이후에도 복구가 불가능합니다.</p>
						<p>2. 탈퇴 후, 어떠한 방법으로도 기존의 개인정보를 복원할 수 없습니다.</p>
						<p>3. 삭제 기록 : 회원정보, 관심매장, 관심 메뉴, 미사용 쿠폰</p>
					</div>
					<div class="modal-cont">
						<div class="cont-title">계정 확인</div>
						<div class="cont-cont">
							<input type="text" readonly value="${user.mbrEmlAddr}" />
						</div>
					</div>
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer" id="updateMbrBtn">회원 탈퇴</div>
			
		</div>
	</div>
</div>
<!-- /////  회원 탈퇴 모달 끝  //// -->

















