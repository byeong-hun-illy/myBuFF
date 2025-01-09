/**
 * 고객 마이페이지를 위한 Js 모음
 */
/*
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

let mbrId = "${user.mbrId}";

// 토글 이벤트
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
   }
};//end 달러function

//주문 현황 불러오기
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
}); */
