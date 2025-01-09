<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.memberVO" var="user" />
</sec:authorize>

<style>


 .cont-wrap {
   display: flex;
   gap: var(--gap--xl); 
} 


/* 아코디언 컨텐츠 스타일 */
.accordion-collapse {
   display: none;
   padding: var(--pd--s);
   background-color: var(--gray--1);
   border-top: 1px solid var(--border--primary);

}ㄴ

.accordion-collapse.show {
   display: table-row;
}

.accordion-item {
   cursor: pointer;
}



/* 나의 정보 변경 폼 컨텐츠 스타일 */
.table-header{ 
	display: flex;
    justify-content: space-between;
}

.ordrAccordion-item {
    display: none; /* 초기 상태를 none으로 설정 */
    cursor: pointer;
}

.ordrAccordion-item.show {
    display: table-row; /* show 시에 table-row로 표시 */
}


</style>



<script type="text/javascript">


$(function() {
    // 초기 4개의 항목만 표시
    $(".ordrAccordion-item").slice(0, 4).addClass('show');

    $("#addOrdr").click(function(e) {
        e.preventDefault();
        
        // 더보기 버튼 클릭 시, 숨겨진 다음 4개의 항목을 표시
        var hiddenItems = $(".ordrAccordion-item:not(.show)").slice(0, 4);
        hiddenItems.addClass('show');

        // 더 이상 숨겨진 항목이 없을 경우 '더보기' 버튼 숨김
        if (hiddenItems.length === 0) {
            $("#addOrdr").hide();
        }
    });
});



   let mbrId = "${user.mbrId}";
   
   ///////////////  모달  //////////////////////

   
   function closeModal() {
      $("#pswdCheck").modal("hide"); // 패스워드 모달 
   }
   
   // 모달 외부 클릭 시 닫기 (선택 사항)
   window.onclick = function(event) {
       var modal = document.querySelector('#deleteMbrModal');
       if (event.target == modal) {
           closeModal();
       }
   };
   
   
   $(function() {
	   $("#delMbrBtn").on("click", function(){
		   console.log("개똥이 나와랏~!");
		   
		   $("#custInfoModal").modal("hide"); 
		   $("#deleteMbrModal").modal("show"); 
	   });
   });
   
   $(function() {
      console.log("개똥이");
      
      $("#btnPwd").on("click",function(){
          $("#pswdCheck").modal("show"); 
      });

      // 현재 수정하고 있는 영역을 저장할 전역변수 설정(업체 : bzent / 담당자 : mbr)
      let editTarget = "";

      //    비밀번호 확인 버튼 클릭시 이벤트 핸들러
      //ModalBtnCheck : 버튼
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
                     xhr.setRequestHeader("${_csrf.headerName}",
                           "${_csrf.token}");
                  },
                  success : function(res) {
                     console.log("res : ", res);

                     if (res === "success") {

                        //    비밀번호 일치 -> 모달창 닫고 수정모드로 전환
                        Swal.fire({
                           icon : 'success',
                           title : '비밀번호 확인 성공',
                           position : 'center-center',
                           timer : 2000,
                           showConfirmButton : false
                        });
                        closeModal();
                        
                        //1. *** 님의 정보 변경 영역(+회원 탈퇴 버튼 포함)이 모달로 띄워짐
                          $("#custInfoModal").modal("show");
                        
                        //2. 회원 탈퇴 버튼 클릭
                        delMbrBtn();

                     } else {
                        //    비밀번호 불일치
                        Swal.fire({
                           icon : 'error',
                           title : 'Error!',
                           text : '비밀번호가 일치하지 않습니다..',
                           position : 'center-center',
                           timer : 3000,
                           showConfirmButton : false
                        });
                        closeModal();
                     }//end if
                  },
                  error : function(xhr, status, error) {
                     console.log("xhr: ", xhr);
                     console.log("status: ", status);
                     console.log("error: ", error);
                  }

               });

               // 모달창 이벤트 핸들러 끝.   
            });

   });//end 달러function
   
   
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
   }
   
   /////////////////////////////--------상단 바 카운트
   $(document).ready(function() {
    let qsWaitingCount = 0;
    let qsCompletedCount = 0;

    // 문의 목록에서 각 건수 계산
    <c:forEach var="qsVO" items="${qsVOList}">
        if ("${qsVO.ansCn}" == "N") {
            qsWaitingCount++;
        } else {
            qsCompletedCount++;
        }
    </c:forEach>

    // 건수 표시
    $("#qsWaitingCount").text(qsWaitingCount);
    $("#qsCompletedCount").text(qsCompletedCount);

    let consultationWaitingCount = 0;
    let consultationCompletedCount = 0;

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
});

   
   
   //////////////////////////주소 /////////////////////////////
   function openHomeSearch(){
   new daum.Postcode({
       oncomplete: function(data) {
          $('#mbrZip').val(data.zonecode);
          $('#mbrAddr').val(data.address);
          $('#mbrDAddr').val(data.buildingName);
          $('#mbrDAddr').focus();
       	}
   	}).open();
	}
   ////////////////////주소 끝/////////////////////
   
    ////////////////////비밀번호 확인/////////////////////
   function testPass(){
	   
	   
   }
   
   ////////////////////비밀번호 확인/////////////////////
   
</script>

<div class="content-header">
   <div class="container-fluid">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0">마이페이지 > 기본정보</h1>
         </div>
         <!-- /.col -->
      </div>
      <!-- /.row -->
   </div>
   <!-- /.container-fluid -->
</div>



.  
<!-- ///// 마이페이지 영역 시작 ///// -->
<div class="wrap">
<!-- ///////////////// 1. 메인 상단 화면 시작 /////////////////-->
<div class="cont">
   <div class="cont-title"><span class="icon material-symbols-outlined">account_circle</span> ${user.mbrNm} 님 반갑습니다.</div>
   <div class="cont-wrap">
      <div class="menu">
         <div class="menu-title">
             <span class="chageInfo">나의 주문 현황 </span> <span class="icon material-symbols-outlined">arrow_forward_ios</span>
          </div>
          <ul>
             <li>포장<span class="bge bge-warning" id="tap-clsing"><span id="ordrType1"></span></span> 건</li>
             <li>매장<span class="bge bge-active" id="tap-clsing"><span id="ordrType2"></span></span> 건</li>
          </ul>
      </div>
      <div class="menu">
         <div class="menu-title">
             <span class="chageInfo"> 나의 쿠폰 목록</span> <span class="icon material-symbols-outlined">arrow_forward_ios</span>
          </div>
          <ul>
             <li>보유 쿠폰 중인 쿠폰</li>
          </ul>
      </div>
      <div class="menu">
         <div class="menu-title">
             <span class="chageInfo">문의 </span> <span class="icon material-symbols-outlined">arrow_forward_ios</span>
          </div>  
          <ul>
             <li>답변 대기 <span class="bge bge-warning" id="tap-clsing"><span id="qsWaitingCount"></span></span> 건</li>
             <li>답변 완료 <span class="bge bge-active" id="tap-clsing"><span id="qsCompletedCount"></span></span> 건</li>
          </ul>
      </div>
      <div class="menu">
         <div class="menu-title">
             <span class="chageInfo">가맹지점 상담</span><span class="icon material-symbols-outlined">arrow_forward_ios</span>
          </div>
          <ul>
             <li>상담 대기 <span class="bge bge-warning" id="tap-clsing"><span id="dscsnWaitingCount"></span></span> 건</li>
              <li>상담 완료 <span class="bge bge-active" id="tap-clsing"><span id="dscsnCompletedCount"></span></span> 건</li>
          </ul>
      </div>
   </div>
</div>
<!-- ///////////////// 1. 메인 상단 화면 끝 /////////////////-->


<!-- ///////////////////////////////////////// 카드 영역 시작 ///////////////////////////////////////// -->


<!-- ///////////////// 1. 기본 정보 화면 시작 /////////////////-->

<div class="cont">
   <!-- table-wrap -->
   <div class="table-wrap">
      <div class="table-title">
         <div class="cont-title"><span class="icon material-symbols-outlined">account_circle</span>기본 정보</div> 
         <div class="btn-wrap">
             <button class="btn-default" id="btnPwd"><span class="chageInfo">나의 정보 변경 </span> <span class="icon material-symbols-outlined">arrow_forward_ios</span></button>
         </div>
      </div>
      <table class="table-blue">
         <tr>
            <th>이름</th>
            <td>${user.mbrNm}</td>
            <th>이메일</th>
            <td>${user.mbrEmlAddr}</td>
         </tr>
         <tr>
            <th>생년월일 </th>
            <td>
               <c:if test="${not empty user.mbrBrdt}">
                    <c:set var="mbrBrdt" value="${fn:substring(user.mbrBrdt, 0, 4)}-${fn:substring(user.mbrBrdt, 4, 6)}-${fn:substring(user.mbrBrdt, 6,8)}" />
                    ${mbrBrdt}
               </c:if>
            
            </td>
            <th>핸드폰 번호</th>
            <td>
               <c:if test="${not empty user.mbrTelno}">
                    <c:set var="mbrTelno" value="${fn:substring(user.mbrTelno, 0, 3)}-${fn:substring(user.mbrTelno, 3, 7)}-${fn:substring(user.mbrTelno, 7,11)}" />
                    ${mbrTelno}
               </c:if>
            </td>
         </tr>
         <tr>
            <th>주소</th>
            <td colspan="3">
               <div class="addr-zip-wrap">
                  <div class="addr-wrap">
                     (${user.mbrZip})
                  </div>
                  <div class="addr-wrap">
                     ${user.mbrAddr}
                     ${user.mbrDaddr}
                  </div>
               </div>
            </td>
         </tr>
         
      </table>
   </div>
   <!-- table-wrap -->
</div>
<!-- /.cont: 해당 영역의 설명 -->

<!-- ///////////////// 1. 기본 정보 화면 끝 /////////////////-->
               

<!-- ///////////////// 2. 주문 내역 조회 화면 시작 /////////////////-->
<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">
			<span class="icon material-symbols-outlined">fastfood</span>주문내역 (<span
				id="ordrTotal"></span> 건)
		</div>
		<div class="orderList">
			<div class="orderList-cont">
				<table class="table-default">
					<thead>
						<tr>
							<th class="center">주문 번호</th>
							<th class="center">주문 일시</th>
							<th class="center">주문 유형</th>
							<th class="center">주문 지점</th>
							<th class="center">결제 금액</th>
						</tr>
					</thead>
					<tbody id="table-body">
						<c:forEach var="ordrVO" items="${ordrVOList}">
							<tr class="ordrAccordion-item" onclick="toggleAccordion(this)">
								<td class="center">${ordrVO.ordrNo}</td>
								<td class="center">${ordrVO.ordrDt}</td>
								<td class="center"><c:if
										test="${ordrVO.ordrType == 'ORDR01'}">
										<span class="tap-title">포장</span>
									</c:if> <c:if test="${ordrVO.ordrType != 'ORDR01'}">
										<span class="tap-title">매장</span>
									</c:if></td>
								<td class="center">
									${ordrVO.ordrDtlVOList[0].bzentVO.bzentNm}</td>
								<td class="center"><fmt:formatNumber
										value="${ordrVO.ordrDtlVOList[0].ordrAmt}" pattern="#,###" />
									원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div style="text-align: center; margin-top: 10px;">
					<button type="button" id="addOrdr">더보기</button>
				</div>
			</div>
		</div>
	</div>



	<!-- /.cont: 해당 영역의 설명 -->
   <!-- ///////////////// 2. 주문 내역 조회 화면 끝 /////////////////-->
               
               
<!-- ///////////////// 3. 보유 쿠폰 조회 화면 시작 /////////////////-->
<div class="cont">
   <div class="cont-title"><span class="icon material-symbols-outlined">redeem</span>보유 쿠폰 조회</div> 
   <div class="cont-wrap">
      <div class="card-cont">
      	<!-- 로그인 한 회원은 여러 이벤트에 당첨됨 
      	eventVOList : 로그인 한 회원은 이벤트를 여러번 당첨 가능
      	eventVO.couponGroupVOList[0] : 로그인 한 회원은 당첨된 이벤트에 단 하나의 쿠폰그룹만 있음
      	-->
         <c:forEach var="eventVO" items="${eventVOList}">
         	<c:if test="${eventVO.remainDay>0}"><!-- 0보다 크면 오늘 이후에 마감일자가 있음 -->
		         <div class="card">
		            <h2>${eventVO.couponGroupVOList[0].couponNm}</h2>
		            <p>${eventVO.couponGroupVOList[0].menuVO.menuNm}</p>
		            <p>${eventVO.couponGroupVOList[0].dscntAmt}원</p>
		            
		            <div class="list-date">
                        	<c:if test="${not empty eventVO.bgngYmd}">
						        <c:set var="year" value="${fn:substring(eventVO.bgngYmd, 0, 4)}" />
						        <c:set var="month" value="${fn:substring(eventVO.bgngYmd, 4, 6)}" />
						        <c:set var="day" value="${fn:substring(eventVO.bgngYmd, 6, 8)}" />
						        <c:set var="formattedDate" value="${year}-${month}-${day}" />
						    </c:if>
						    
						    <c:if test="${not empty eventVO.expYmd}">
						        <c:set var="expYear" value="${fn:substring(eventVO.expYmd, 0, 4)}" />
						        <c:set var="expMonth" value="${fn:substring(eventVO.expYmd, 4, 6)}" />
						        <c:set var="expDay" value="${fn:substring(eventVO.expYmd, 6, 8)}" />
						        <c:set var="formattedExpDate" value="${expYear}-${expMonth}-${expDay}" />
						    </c:if>
			    
    						${formattedDate} ~ ${formattedExpDate}
                        </div>
		         </div>
		       </c:if>
     	 </c:forEach>
      </div>
   </div>
</div>
<!-- ///////////////// 3. 보유 쿠폰 조회 화면 끝 /////////////////-->
               
<!-- ///////////////// 4. 문의 내역 조회 화면 시작 /////////////////-->
<div class="cont">
   <div class="cont-title"><span class="icon material-symbols-outlined">contact_support</span>문의 내역 조회</div> 
   <!-- table-wrap -->
   <div class="table-wrap">
      <table class="table-default">
         <thead>
            <tr>
               <th class="center">문의 유형</th>
               <th style="width: 23%">제목</th>
               <th style="width: 38%">내용</th>
               <th>작성 일자</th>
               <th>문의 답변 여부</th>
            </tr>
         </thead>
         <tbody id="table-body">
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
                  <td>${qsVO.qsCn}</td>
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
                   <c:if test="${qsVO.ansCn == 'N'}">
                     <td class="error-info" colspan="4">
                        <div class="accordion-body">
                           <span class="icon material-symbols-outlined">error</span>
                           <div class="error-msg">문의 답변 결과가 없습니다</div>
                        </div>
                     </td>
                  </c:if>
                  <c:if test="${qsVO.ansCn != 'N'}">
                     <td colspan="4">
                        <div class="accordion-body" style="overflow: auto;">
                           ${qsVO.ansCn}
                        </div>
                     </td>
                  </c:if>   
               </tr>
            </c:forEach>
         </tbody>
      </table>
   </div>
   <!-- table-wrap -->
</div>
<!-- /.cont: 해당 영역의 설명 -->
<!-- ///////////////// 4. 문의 내역 조회 화면 끝 /////////////////-->
               
<!-- ///////////////// 5. 상담 내역 조회 화면 시작 /////////////////-->
<div class="cont">
   <div class="cont-title"><span class="icon material-symbols-outlined">support_agent</span>가맹지점 상담 내역</div> 
   <!-- table-wrap -->
   <div class="table-wrap">
      <table class="table-default">
         <thead>
            <tr>
               <th class="center">희망 지역</th>
               <th class="center">희망 상담 일자</th>
               <th class="center">상담 상태</th>
            </tr>
         </thead>
         <tbody id="table-body">
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
         </tbody>
      </table>
   </div>
</div>
<!-- ///////////////// 5. 상담 내역 조회 화면 끝 /////////////////-->
</div> <!-- ///// wrap 영역 끝 ///// -->
<!-- /////// 메뉴 상세 끝  /////// -->
<!-- ///// 카드 영역 끝 ///// -->






<!-- ///////////////// 6. 나의 정보 변경 시작 최종/////////////////-->
<div class="modal fade" id="custInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
  <form id="chageCustInfoForm"> 
    <div class="modal-content">
    	<div class="modal-header row align-items-center justify-content-between">
				<div>
					<h4 class="modal-title modal-check">나의 정보 변경</h4>
				</div>
				<div>
				  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					<button type="button" class="btn-active">변경</button>
				</div>
      		</div>
      <div class="modal-body wrap">
      	<div class="cont modal-frcs">
		<!-- table-wrap 회원 정보-->
		<div class="table-wrap">
			<div class="table-title">
					<div class="cont-title"><span class="icon material-symbols-outlined">account_circle</span> ${user.mbrNm} 님</div> 
			</div>
			<table class="table-blue modal-table">
				<tr>
					 <th>핸드폰 번호</th>
		          	<td>
		                <c:set var="phoneNumber" value="${user.mbrTelno}" />
					    <c:if test="${not empty phoneNumber}">
					    	<input class="input-tel" readonly="readonly" type="text" value="${phoneNumber.substring(0, 3)}"/> -
					     	<input class="input-tel" readonly="readonly" type="text" value="${phoneNumber.substring(3, 7)}"/> -
					     	<input class="input-tel" readonly="readonly" type="text" value="${phoneNumber.substring(7)}"/>
					    </c:if>
		            </td>
	             </tr>
				<tr>
					<th>주소</th>
					<td>
						<div class="addr-zip-wrap">
							<div class="addr-wrap">
							    <input id="mbrZip" class="input-zip" readonly="readonly" type="text" value= "${user.mbrZip}"/>
								<button class="btn-default" type="button" onclick="openHomeSearch()">우편번호 검색</button>
							</div>
							<div class="addr-wrap">
								<input id="mbrAddr" class="input-addr" readonly="readonly" type="text" value="${user.mbrAddr}"/>
								<input id="mbrDAddr" class="input-addr" readonly="readonly" type="text" value="${user.mbrDaddr}"/>
							</div>
						</div>
					</td>
				</tr>
				<tr class= "pass-cont">
				<th>비밀번호</th>
				<td>
					<div class="pass-wrap">
						변경할 비밀번호 <input class="input-pass" id="chagePass1" type="password" />
					</div>
					<div class="pass-wrap">
						비밀번호 재입력 <input class="input-pass" id="chagePass2" type="password" />
					</div>
					
					<button type="button" class="btn-default" id="chkPass" onclick="testPass()">확인</button>
					
				</td>
			</tr>
		</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
  
      </div>
      <!-- modal-body 끝 -->
       <div class="modal-footer">
			<div>
				<button type="button" id="delMbrBtn" class="btn-default" data-dismiss="modal">회원탈퇴</button>
			</div>
       </div>
    </div>
    </form>
  </div>
</div>

<!-- ///////////////// 6. 나의 정보 변경 끝 /////////////////-->




<!-- 3. aside 처리 : tiles 처리 -->
<!-- ///// 마이페이지 영역 끝 ///// -->

<!-- /////  회원 탈퇴 모달 시작  //// -->
<div class="modal fade" id="deleteMbrModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="max-height: 1000px;">
			<div
				class="modal-header row align-items-center justify-content-between">
				<div>
					<h4 class="modal-title">회원 탈퇴</h4>
				</div>
				<div>
			  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="wrap">
					<div class="cont"
						style="display: -webkit-inline-box; width: 764px;">
						<!-- 테이블 분류 시작 -->
						<div class="table-wrap">
							<!-- 테이블 분류 끝 -->
							<h2>회원 탈퇴시 유의 사항</h2>
							<p>
								아래 유의 사항을 반드시 확인하세요 <br> - 탈퇴 시 고객님의 개인정보 및 쿠폰 정보는 모두 삭제되어
								더 이상 혜택을 받을 수 없으며,<br> 재가입 이후에도 복구가 불가능합니다.<br> 탈퇴 후,
								어떠한 방법으로도 기존의 개인정보를 복원할 수 없습니다.<br> 삭제되는 기록은 다음과 같습니다.<br>
								- 회원정보, 관심매장, 관심 메뉴, 미사용 쿠폰
							</p>

							<!-- 테이블 끝 -->
						</div>
						<!-- 선택 끝 -->
					</div>
					<label for="clsbizRsn">계정 확인 </label> <input type="text" readonly
						value="${user.mbrEmlAddr}" />
				<form action="/cust/deleteMbr" method="get">
					<div>
						<button type="submit" id="deleteMbr" class="btn btn-danger modal-check" data-dismiss="modal">회원탈퇴</button>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////  회원 탈퇴 모달 끝  //// -->





<!-- 
1. 마이페이지에 오면 모달이 띄워져 있음

2. 확인 버튼을 클릭
 -->
<!-- 비밀번호 확인 모달 -->
<div class="modal fade" id="pswdCheck">
   <div class="modal-dialog">
      <div class="modal-content">

         <!--                   Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">비밀번호 확인</h4>
           <div>
			  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
         </div>

         <!--                   Modal body -->
         <div class="modal-body">
            <div class="form-group">
               <label for="pswdInput">비밀번호를 입력하세요.</label> <input type="password"
                  class="text-input" id="pswdInput" name="pswdInput"
                  placeholder="비밀번호를 입력하세요." />
            </div>
         </div>

         <!--                   Modal footer -->
         <div class="modal-footer">
            <button type="button" id="ModalBtnCheck" class="btn-active">확인</button>
         </div>

      </div>
   </div>
   <!-- modal창 끝-->
</div>


