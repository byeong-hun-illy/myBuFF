<%--
 	@fileName    : insertDscsn.jsp
 	@programName : 가맹점 문의 신청 화면
 	@description : 로그인한 고객이 가맹지점 상담 문의 하는 화면
 	@author      : 서윤정
 	@date        : 2024. 09. 11
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<link href="/resources/cust/css/insertDscsn.css" rel="stylesheet">

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.memberVO" var="user"/>
</sec:authorize>

<style>
.chk-txt {
    display: flex;
    flex-direction: column;
    gap: 10px;
    line-height: 1.5;
}
</style>


<div class="wrap">

	<div class="wrap-cont">

		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">창업 절차</div>
		<!-- /.wrap-title -->

		<div class="dscsn-info">
			<div class="info-box">
				<div class="info-icon">
					<span class="material-symbols-outlined">edit_document</span>
				</div>
				<div class="info-txt">
					가맹 상담 신청
				</div>
			</div>
			
			<div class="triangle"></div>

			<div class="info-box">
				<div class="info-icon">
					<span class="material-symbols-outlined">person</span>
				</div>
				<div class="info-txt">
					1:1 인터뷰
				</div>
			</div>

			<div class="triangle"></div>
			
			<div class="info-box">
				<div class="info-icon">
					<span class="material-symbols-outlined">contract_edit</span>
				</div>
				<div class="info-txt">
					가맹 계약
				</div>
			</div>
		</div>
		<!-- /.dscsn-info -->
		
		<div class="chk-wrap">
			
			<div class="chk-title">
				상담 신청 동의
			</div>
				
			<div class="chk-txt">
				<strong>개인정보 수집·이용에 관한 사항(필수)</strong>
				<p>회사는 가맹 상담을 위해 아래와 같이 개인정보를 수집하고 있습니다. 회원님은 동의를 거부할 권리를 가지고 있으며 동의하지 않을 경우 가맹 서비스 이용에 제한이 있을 수 있습니다.</p>
				<p>1. 수집 항목 : 이름, 생년월일, 휴대폰번호(연락처), 이메일주소, 희망지역, 가맹관련 내용</p>
				<p>2. 수집 방법 : 버프 홈페이지 내 가맹 페이지에서 고객 직접 작성</p>
				<p>3. 이용 목적 : 회사의 가맹 상담을 희망하는 고객을 대상으로 상담 진행</p>
				<p>4. 보유 기간 : 1년 - 개인정보 수집 및 이용목적 달성시 지체없이 파기합니다.</p>
				<div class="chk-radio">
	                <input type="radio" class="radio-btn" id="chk02" name="chk">   
	                <label for="chk02"> 미동의</label>
	                <input type="radio" class="radio-btn" id="chk01" name="chk">   
	                <label for="chk01"> 동의</label>
				</div>
			</div>
			
			
		</div>
		
	</div>
	<!-- /.wrap-cont -->
	
</div>
<!-- /.wrap -->

<sec:authorize access="isAuthenticated()">
   	<form id="inquiryForm">
	    <div class="inquiry-wrap">
	    	
	    	<div class="inquiry-cont txt">
	    		버프와 함께할 파트너를 모십니다!
	    	</div>
	    	
	    	<div class="inquiry-cont">
	    		<p class="select-label">희망 지역</p>
			 	<!-- 지역 선택 셀렉트 영역 -->
				<select name="rgnNo" id="rgnNo" class="select2-custom">
					<option value="" selected>선택해주세요</option>
					<option value="RGN11" <c:if test="${param.rgnNo == 'RGN11'}">selected</c:if>>서울특별시</option>
					<option value="RGN21" <c:if test="${param.rgnNo == 'RGN21'}">selected</c:if>>부산광역시</option>
					<option value="RGN22" <c:if test="${param.rgnNo == 'RGN22'}">selected</c:if>>대구광역시</option>
					<option value="RGN23" <c:if test="${param.rgnNo == 'RGN23'}">selected</c:if>>인천광역시</option>
					<option value="RGN24" <c:if test="${param.rgnNo == 'RGN24'}">selected</c:if>>광주광역시</option>
					<option value="RGN25" <c:if test="${param.rgnNo == 'RGN25'}">selected</c:if>>대전광역시</option>
					<option value="RGN26" <c:if test="${param.rgnNo == 'RGN26'}">selected</c:if>>울산광역시</option>
					<option value="RGN29" <c:if test="${param.rgnNo == 'RGN29'}">selected</c:if>>세종특별자치시</option>
					<option value="RGN31" <c:if test="${param.rgnNo == 'RGN31'}">selected</c:if>>경기도</option>
					<option value="RGN32" <c:if test="${param.rgnNo == 'RGN32'}">selected</c:if>>강원도</option>
					<option value="RGN33" <c:if test="${param.rgnNo == 'RGN33'}">selected</c:if>>충청북도</option>
					<option value="RGN34" <c:if test="${param.rgnNo == 'RGN34'}">selected</c:if>>충청남도</option>
					<option value="RGN35" <c:if test="${param.rgnNo == 'RGN35'}">selected</c:if>>전라북도</option>
					<option value="RGN36" <c:if test="${param.rgnNo == 'RGN36'}">selected</c:if>>전라남도</option>
					<option value="RGN37" <c:if test="${param.rgnNo == 'RGN37'}">selected</c:if>>경상북도</option>
					<option value="RGN38" <c:if test="${param.rgnNo == 'RGN38'}">selected</c:if>>경상남도</option>
					<option value="RGN39" <c:if test="${param.rgnNo == 'RGN39'}">selected</c:if>>제주특별자치도</option>
				</select>
			</div>
			
			<!-- 검색 시작 search-cont -->
	        <div class="inquiry-cont">
        		<p class="select-label">상담 희망일</p>
		        <div class="search-date-wrap">
		            <input type="date" id="bgngYmd" name="bgngYmd" required>
		        </div>
	        </div>
	        
		</div>
		<!-- /.inquiry-wrap -->
	</form>
</sec:authorize>

<sec:authorize access="isAnonymous()">
     <div class="inquiry-wrap">
     	<div class="inquiry-cont txt">
    		로그인 후 가맹점 문의를 하실 수 있습니다!
    	</div>
    	<a href="/login" class="move-login">로그인 <span class="go-icon material-symbols-outlined">east</span></a>
     </div>
</sec:authorize>

<script>
let mbrId = "${user.mbrId}";
let isSubmitted = false; // 신청서 제출 여부를 추적하는 변수

$(document).ready(function() {
	
	select2Custom();
	
	$.ajax({
		url: "/buff/selectDscsn",
		type: "GET",
		data: {mbrId:mbrId},
		success: function(res){
			console.log(res);
			console.log(mbrId);

			str = "";
			
			// 가맹점 상담 신청을 안한 경우 조회 결과 0
			if(res.length < 1 && mbrId != ""){ 
				str += `
					<div class="inquiry-cont">
		            	<button type="submit" class="insert-btn">상담 신청</button>
		        	</div>
				`
				$('.inquiry-wrap').append(str); // 상담 버튼 추가
			} else if (res != "" && mbrId != "" ) { // 가맹점 신청한 경우 
				
				$('#rgnNo').val(res.RGN_NO);
				$('#select2-rgnNo-container').text(res.RGN_NM);
				$('#bgngYmd').val(res.DSCSN_PLAN_YMD);
				
				str += `
					<div class="inquiry-cont">
		            	<div class="confirm-btn">상담 신청 완료</div>
		        	</div>
				`
				$('.inquiry-wrap').append(str); // 상담 완료 버튼 추가
			}		
			
		}
	})

	
	
}); // 전체 끝

//신청서 제출
$('#inquiryForm').on('submit', function(e) {
	
	if(!$('#chk01').is(':checked')){
		
		// SweetAlert로 메시지 표시
        Swal.fire({
        	icon: "error",
            title: "상담 신청 동의를 체크해주세요",
            showConfirmButton: true  // 확인 버튼이 있을 때까지 모달 유지
        }).then(function() {
            // 3초 후에 새로고침
            setTimeout(function() {
            }, 1000); // 3000ms = 3초
        });
        
        return false;
	
	} else {

    	e.preventDefault(); // 기본 폼 제출 방지

        // 폼 데이터 수집
        var jsonData = {
            "rgnNo": $('#rgnNo').val(),
            "dscsnPlanYmd": $('#bgngYmd').val(),
            "mbrId": mbrId
        };
    	
    	console.log(jsonData);

        $.ajax({
            url: "/cust/insertDscsnPost", // 요청 URL
            type: "POST",
            contentType: "application/json;charset=utf-8", // JSON 형식으로 전송
            data: JSON.stringify(jsonData), // JSON 문자열로 변환
            dataType: "text",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
            	
                let strIcon = "";
                let strTitle = "";
                let strText = "";

                if (result == 1) {
                	
                	strIcon = "success";
                    strTitle = "가맹점 상담 신청 완료";
                    strText = "마이페이지에서 가맹점 상담 내역을 조회하세요.";
                    isSubmitted = true;  
                    
                    $('.insert-btn').text("상담 신청 완료");  
                    $('.insert-btn').css("background","#aaa");  
                    
                } else {
                	
                    strIcon = "info";
                    strTitle = "상담신청이 완료 되었습니다";
                    strText = "마이페이지에서 가맹 지점 신청서를 확인하세요.";
                    
                }

                // SweetAlert로 메시지 표시
                Swal.fire({
                    icon: strIcon,
                    title: strTitle,
                    text: strText
                });
                
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                Swal.fire({
                    icon: 'error',
                    title: '가맹 신청서 등록 실패',
                    text: '다시 시도해 주세요.'
                });
            } // error 끝
            
        }); //ajax 끝
	}
    
}); // inquiryForm 끝

</script>