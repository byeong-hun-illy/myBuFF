<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/resources/js/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="/resources/css/global/join.css">

<div class="wrap join-wrap">

	<form id="joinForm" name="joinForm" action="/joinSubmit" method="post">
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title join" id="joinTitle">회원가입</div>
		<!-- /.wrap-title -->
			
		<div class=join-inner>
			<!-- table-wrap -->
			<div class="table-wrap">
				<table class="table-join">
					<tbody>
						<!-- 
						1. type=admin
						  - memberTypeSection의 mbrType1가 remove 됨
						  
						2. type=member
						  - memberTypeSection의 mbrType1가 remove가 아님
						
						3. type이 admin에서 type이 member로 하려면 비동기가 아니라 동기라는 것!
						 -->
						<c:if test="${param.type == 'member'}">
							<tr class="memberTypeSection member" style="visibility: collapse;">
								<th>회원 유형</th>
								<td class="radio-wrap">
									<div class="radio-cont">
										<input type="radio" id="mbrType1" name="mbrType" value="MBR01" checked />
					    				<label for="mbrType1">고객</label>
				    				</div>
									<input type="hidden" id="addrFirstTwoChars" name="addrFirstTwoChars" />
							    </td>
							</tr>
						</c:if>
	    				<c:if test="${param.type == 'admin'}">
							<tr class="memberTypeSection">
								<th>회원 유형</th>
								<td class="radio-wrap">
<!-- 					    				<div class="radio-cont"> -->
<!-- 									    	<input type="radio" id="mbrType2" name="mbrType" value="MBR02" required/> -->
<!-- 									    	<label for="mbrType2">가맹점 담당자</label> -->
<!-- 								    	</div> -->
					    				<div class="radio-cont">
									    	<input type="radio" id="mbrType3" name="mbrType" value="MBR03" required/>
									    	<label for="mbrType3">거래처 담당자</label>
								    	</div>
								    	<div class="radio-cont">
									    	<input type="radio" id="mbrType4" name="mbrType" value="MBR04" required />
									    	<label for="mbrType4">본사 관리자</label><br />
								    	</div>
								    	<span id="mbrTypeError" class="error-message"></span> <!-- 회원 유형 오류 메시지 영역 -->
									<!-- 주소에서 앞 두 글자 자동 추출하여 숨겨진 필드로 전송 -->
									<input type="hidden" id="addrFirstTwoChars" name="addrFirstTwoChars" />
							    </td>
							</tr>
				    	</c:if>
						<tr>
							<th>회원 ID</th>
							<td>
								<div class="td-flex">
									<input type="text" id="mbrId" name="mbrId" class="text-input" placeholder="입력해주세요">
									<button type="button" class="btn-border" id="checkIdDuplicateBtn">중복검사</button>
								</div>
								<span id="idError" class="error-message"></span> <!-- 오류 메시지 영역 -->								
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="mbrPswd" name="mbrPswd" class="text-input" placeholder="입력해주세요">
								<span id="passwordError" class="error-message"></span> <!-- 오류 메시지 영역 -->
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<!-- 비밀번호 확인 text폼 만들기 -->
								<div class="td-flex">
									<input type="password" id="mbrPswd2" class="text-input" placeholder="입력해주세요">
									<button type="button" class="btn-border" id="checkPswdDuplicateBtn">확인</button>
								</div>	
								<span id="passwordError2" class="error-message"></span> <!-- 오류 메시지 영역 -->
							</td>
						</tr>
						<tr>
							<th>회원명</th>
							<td>
								<input type="text" id="mbrNm" name="mbrNm" class="text-input" placeholder="입력해주세요">
								<span id="nameError" class="error-message mt-2 mb-2"></span> <!-- 회원명 오류 메시지 영역 -->
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>
								<input type="date" id="beforeMbrBrdt" name="beforeMbrBrdt" class="text-input" placeholder="입력해주세요">
								<span id="birthDateError" class="error-message" style="color:red;"></span> <!-- 생년월일 오류 메시지 영역 -->
							</td>
							<td><input type="hidden" id="mbrBrdt" name="mbrBrdt" class="text-input" placeholder="입력해주세요"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<input type="hidden" id="mbrTelno" name="mbrTelno" class="text-input">
								<div class="tel-wrap">
									<input type="text" id="mbrTelno1" name="mbrTelno1" class="input-tel" maxlength="3" > - 
									<input type="text" id="mbrTelno2" name="mbrTelno2" class="input-tel" maxlength="4" > - 
									<input type="text" id="mbrTelno3" name="mbrTelno3" class="input-tel" maxlength="4" >
								</div>
								<span id="telError" class="error-message" style="color:red;"></span> <!-- 전화번호 오류 메시지 영역 -->
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" id="mbrEmlAddr" name="mbrEmlAddr" class="text-input" placeholder="입력해주세요">
								<span id="emailError" class="error-message"></span> <!-- 이메일 오류 메시지 영역 -->
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<div class="addr-wrap" style="margin-bottom: 10px;">
									<input class="input-zip" id="mbrZip" name="mbrZip" type="text" placeholder="우편번호" readonly>
									<button class="btn-border" type="button" onclick="openZipSearch()">우편번호 검색</button>
								</div>
								<div class="addr-wrap" style="margin-bottom: 10px;">
									<input class="input-addr" id="mbrAddr" name="mbrAddr" type="text" placeholder="주소" readonly>
								</div>
								<div class="addr-wrap">
									<input class="input-addr" id="mbrDaddr" name="mbrDaddr" type="text" placeholder="상세주소">
								</div>
								<span id="addrError" class="error-message" style="color:red;"></span> <!-- 통합된 주소 오류 메시지 영역 -->
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- table-wrap -->
			<sec:csrfInput />
		</div>
		<!-- /.join-inner -->
		
	</div>
	<!-- /.wrap-cont -->
	
	<div class="btn-wrap">
		<button type="button" id="submitBtn" class="btn-submit">가입하기</button>
	</div>
	
	</form>
	
</div>
<!-- /.wrap -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
//다음 api
function openZipSearch(){
	new daum.Postcode({
	    oncomplete: function(data) {
	    	$('#mbrZip').val(data.zonecode);
	    	$('#mbrAddr').val(data.address);
	    	$('#mbrDaddr').val(data.buildingName);
	    	$('#mbrDaddr').focus();
	    }
	}).open();
}

/* function goLoginPage() {
	// URL에서 파라미터 값을 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const userType = urlParams.get('type');
    
    // 관리자인 경우 /admin/login, 일반 회원인 경우 /login으로 이동
    if (userType === 'admin') {
        window.location.href = "/admin/login"; // 관리자 로그인 페이지로 이동
    } else {
        window.location.href = "/login"; // 일반 회원 로그인 페이지로 이동
    }
} */



$(document).ready(function(){
	// URL에서 파라미터 값을 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const userType = urlParams.get('type');
    
	// userType이 admin일 때만 클릭 시 콘솔에 메시지를 출력하는 함수
	function cnptAuto() {
		if (userType === 'admin') {
			console.log("안녕!");
			
			// 각 필드에 미리 정의된 값 넣기
			$('input[name="mbrType"][value="MBR03"]').prop('checked', true); // 거래처 담당자 선택
			$('#mbrId').val("buff001"); // 회원 ID
			$('#mbrPswd').val("q1q1"); // 비밀번호
			$('#mbrPswd2').val("q1q1"); // 비밀번호 확인
			$('#mbrNm').val("이상혁"); // 회원명
			$('#beforeMbrBrdt').val("1996-05-07"); // 생년월일 yyyy-mm-dd 형식
			$('#mbrTelno1').val("010"); // 전화번호 첫 부분
			$('#mbrTelno2').val("1557"); // 전화번호 중간 부분
			$('#mbrTelno3').val("1557"); // 전화번호 마지막 부분
			$('#mbrEmlAddr').val("eotkdgur@naver.com"); // 이메일
			$('#mbrZip').val("06100"); // 우편번호
			$('#mbrAddr').val("서울 강남구 선릉로 627"); // 주소
			$('#mbrDaddr').val("T1 사옥"); // 상세주소
		}
	}
	
	// 회원가입 타이틀에 클릭 이벤트 연결
    $("#joinTitle").on("click", cnptAuto);
    
    $(".memberTypeSection.member").hide();  // 회원 유형 섹션 숨기기
    
	// 관리자라면 특정 라디오 버튼만 표시
    if (userType === 'admin') {
        // 관리자는 회원 유형을 제외한 나머지만 선택할 수 있게 유지
        $("#mbrType1").remove();  // 고객 라디오 버튼 제거
        $("label[for='mbrType1']").remove();  // 고객 라벨 제거
    }
	
	var isIdValid = false; // 아이디 중복 검사에 대한 유효성 상태 변수
	var isPswdValid = false; // 아이디 중복 검사에 대한 유효성 상태 변수
	var isFormValid = true; // 전체 폼에 대한 유효성 상태 변수
	
	//폼 전송 시 전화번호를 합쳐서 mbrTelno에 설정
	function phoneNumber() {
	    var telno1 = $('#mbrTelno1').val();
	    var telno2 = $('#mbrTelno2').val();
	    var telno3 = $('#mbrTelno3').val();
	    var fullTelno = telno1 + telno2 + telno3;
	    console.log('fullTelno 합쳐진 전화번호 -> ', fullTelno);
	    $('#mbrTelno').val(fullTelno);
	}
	// 생년월일 yyyy-mm-dd -> yyyymmdd로 변환
	function formatBirthDate() {
	    var birthDate = $('#beforeMbrBrdt').val(); // yyyy-mm-dd
	    var formattedDate = birthDate.replace(/-/g, "");
        console.log('formattedDate 변환된 생년월일 -> ', formattedDate);
        $('#mbrBrdt').val(formattedDate); // yyyymmdd로 값 설정
	}
	
	// 아이디 입력 필드에 입력 이벤트 추가
	$("#mbrId").on("input", function() {
		// 아이디가 변경되면 중복 검사 결과 초기화
		isIdValid = false;
		$('#idError').text(''); // 오류 메시지 지우기
	});
	
	// 아이디 중복 검사 버튼 클릭 시 검사 실행
    $("#checkIdDuplicateBtn").on("click", function() {
        var mbrId = $("#mbrId").val();
        
        if (mbrId.length >= 4) {  // 아이디가 4글자 이상일 때만 중복 검사
            $.ajax({
                url: "/checkIdDuplicate",
                contentType:"application/json;charset=utf-8",
                data: JSON.stringify({ "mbrId": mbrId }), 
                dataType:"json",
                type: "POST",
                beforeSend:function(xhr){
                    xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                },
                success: function(result) {
                    console.log("result : " + result.status);
                    if (result.status === "no") {
                        $("#idError").text("이미 사용 중인 아이디입니다.").css("color", "red");
                        isIdValid = false;  // 아이디가 중복될 경우 폼 제출을 막음
                    } else {
                        $("#idError").text("사용 가능한 아이디입니다.").css("color", "green");
                        isIdValid = true;   // 중복된 아이디가 아닐 경우 폼 제출 허용
                    }
                },
                error: function() {
                    $("#idError").text("아이디 중복 확인 중 오류가 발생했습니다.");
                    isIdValid = false;  // 오류가 발생한 경우 폼 제출을 막음
                }
            });
        } else {
            $("#idError").text("아이디는 4글자 이상이어야 합니다.").css("color", "red");
            isIdValid = false;  // 유효하지 않은 경우 폼 제출을 막음
        }
    });
	
	$("#checkPswdDuplicateBtn").on("click", function() {
		var mbrPswd = $('#mbrPswd').val();
        var mbrPswd2 = $('#mbrPswd2').val(); // 비밀번호 확인 필드
        
		// 비밀번호 또는 비밀번호 확인이 비어 있는지 확인
        if (!mbrPswd || !mbrPswd2) {
            $('#passwordError2').text('비밀번호를 입력하지 않으셨습니다.').css("color", "red");
            isPswdValid = false;
        } 
        // 비밀번호와 비밀번호 확인 값이 일치하는지 확인
        else if (mbrPswd !== mbrPswd2) {
            $('#passwordError2').text('비밀번호가 일치하지 않습니다.').css("color", "red");
            isPswdValid = false;
        } 
        // 비밀번호가 일치할 때
        else {
            $('#passwordError2').text('비밀번호가 일치합니다.').css("color", "green");
            isPswdValid = true;
        }
	});
	
	$("#submitBtn").on("click",function(event){
		event.preventDefault();
		phoneNumber(); // 전화번호 합치기
		formatBirthDate(); // 생년월일 변환
		
		isFormValid = true; // 폼 검사가 시작될 때 true로 설정
		
		// 아이디가 유효하지 않으면 폼 제출 중단
        if (!isIdValid) {
            $('#idError').text('아이디 중복 검사를 통과하지 못했습니다.').css("color", "red");
            return;
        }
		
		// 비밀번호 확인 검사를 하지 않은 경우
        if (!isPswdValid) {
            $('#passwordError2').text('비밀번호 확인을 먼저 진행해주세요.').css("color", "red");
            return; // 폼 제출 중단, 다른 검사는 진행하지 않음
        }
		
		// 회원가입 유효성 검사 시작 ///////////////////////////////////////////////////////////////////////
		var mbrId = $('#mbrId').val();
        var mbrPswd = $('#mbrPswd').val();
        var mbrEmlAddr = $('#mbrEmlAddr').val();
        var mbrNm = $('#mbrNm').val(); 
        var telno1 = $('#mbrTelno1').val(); // 첫 번째 전화번호 부분 (2~3글자)
        var telno2 = $('#mbrTelno2').val(); // 두 번째 전화번호 부분 (3~4글자)
        var telno3 = $('#mbrTelno3').val(); // 세 번째 전화번호 부분 (4글자)
        var birthDate = $('#beforeMbrBrdt').val(); // 생년월일 가져오기
        var mbrZip = $('#mbrZip').val(); // 우편번호
        var mbrAddr = $('#mbrAddr').val(); // 주소
        
        // 아이디 유효성 검사: 4~12자, 소문자로 시작, 숫자 포함
        var idRegex = /^[a-z0-9]{4,12}$/;
        if (!idRegex.test(mbrId)) {
            $('#idError').text('4~12자이며, 소문자로 시작하고 숫자를 포함해야 합니다.').css("color", "red");
            isFormValid = false;
        } else {
            $('#idError').text(''); // 오류 메시지 지우기
        }

        // 비밀번호 유효성 검사: 4~12자, 알파벳과 숫자 포함
        var pswdRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;
        if (!pswdRegex.test(mbrPswd)) {
            $('#passwordError').text('4~12자이며, 알파벳과 숫자를 포함해야 합니다.');
            isFormValid = false;
       	} else {
            $('#passwordError').text(''); // 오류 메시지 지우기
        }
        
     	// 이메일 유효성 검사
        var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
        if (!emailRegex.test(mbrEmlAddr)) {
            $('#emailError').text('유효한 이메일 주소를 입력해주세요.').addClass('visible');
            isFormValid = false;
        } else {
            $('#emailError').text(''); // 오류 메시지 지우기
        }
        
     	// 선택된 회원 유형 가져오기
        var mbrType = $('input[name="mbrType"]:checked').val();
        if (!mbrType) {
            console.log('mbrType 선택 안됨'); // 콘솔 로그로 확인
            $('#mbrTypeError').text('회원 유형을 선택해주세요.');
            isFormValid = false;
        } else {
            console.log('mbrType 선택됨 -> ', mbrType); // 선택된 값 로그로 확인
            $('#mbrTypeError').text(''); // 오류 메시지 지우기
        }

        // 회원명 유효성 검사: 한글 2~10자
        var nameRegex = /^[가-힣]{2,10}$/;
        if (!nameRegex.test(mbrNm)) {
            $('#nameError').text('회원명은 한글 2~10자이어야 합니다.');
            isFormValid = false;
        } else {
            $('#nameError').text(''); // 오류 메시지 지우기
        }
        
     	// 전화번호 유효성 검사: 각 부분에 대해 검사
        var telRegex1 = /^[0-9]{2,3}$/; // 첫 번째 부분 2~3자리 숫자
        var telRegex2 = /^[0-9]{3,4}$/; // 두 번째 부분 3~4자리 숫자
        var telRegex3 = /^[0-9]{4}$/; // 세 번째 부분 4자리 숫자

        // 각 부분 검사 후 하나의 오류 메시지로 출력
        if (!telRegex1.test(telno1) || !telRegex2.test(telno2) || !telRegex3.test(telno3)) {
            $('#telError').text('전화번호는 2~3자리 - 3~4자리 - 4자리 숫자여야 합니다.');
            isFormValid = false;
        } else {
            $('#telError').text(''); // 오류 메시지 지우기
        }
        
     	// 생년월일 필수 입력 유효성 검사
        if (!birthDate) {
            $('#birthDateError').text('생년월일은 필수 항목입니다.');
            isFormValid = false;
        } else {
            $('#birthDateError').text(''); // 오류 메시지 지우기
        }
     	
     	// 우편번호와 주소 통합 유효성 검사
        if (!mbrZip || !mbrAddr) {
            $('#addrError').text('우편번호와 주소는 필수 항목입니다.');
            isFormValid = false;
        } else {
        	// 아이디가 중복되지 않으면 오류 메시지 초기화
            $('#addrError').text(''); // 오류 메시지 지우기
        }
     	
     	// 텍스트 입력 시 오류 메시지 제거
//         $("#mbrId").on("input", function() {
//             $('#idError').text(''); // 아이디 오류 메시지 제거
//         });
//         $("#mbrPswd").on("input", function() {
//             $('#passwordError').text(''); // 비밀번호 오류 메시지 제거
//         });
//         $("#mbrNm").on("input", function() {
//             $('#nameError').text(''); // 회원명 오류 메시지 제거
//         });
//         $("#beforeMbrBrdt").on("input", function() {
//             $('#birthDateError').text(''); // 생년월일 오류 메시지 제거
//         });
//         $("#mbrEmlAddr").on("input", function() {
//             $('#emailError').text(''); // 이메일 오류 메시지 제거
//         });
//         $("#mbrTelno1, #mbrTelno2, #mbrTelno3").on("input", function() {
//             $('#telError').text(''); // 전화번호 오류 메시지 제거
//         });
//         $("#mbrZip, #mbrAddr").on("input", function() {
//             $('#addrError').text(''); // 주소 오류 메시지 제거
//         });
     	
     	// 회원가입 유효성 검사 끝 ///////////////////////////////////////////////////////////////////////
     	
     	// mbrType 값이 없으면 기본적으로 MBR01로 설정 (회원일 때)
        var mbrTypeValue = $("input[name='mbrType']").val();
        console.log("mbrType 값: ", mbrTypeValue);

        if (!mbrTypeValue) {
            console.log("mbrType 선택 안됨");
            $("#mbrTypeError").text("회원 유형을 선택해주세요.").css("color", "red");
            return false;  // 폼 제출 중단
        }
     	
        if (isIdValid && isPswdValid && isFormValid) {
            // 유효성 검사 통과 시 폼 제출
            $("#joinForm").off('submit').submit();  // 이벤트 핸들러 제거 후 폼 제출
        }
	});
});
	
</script>