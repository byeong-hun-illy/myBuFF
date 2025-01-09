/*******************************************
  @fileName    : value.js
  @author      : 송예진
  @date        : 2024. 09. 15
  @description : 일자나 전화번호를 처리하기 위해 만든 함수
********************************************/

 // Date 객체를 yyyyMMdd 형식으로 변환하는 함수
 // date에서 value값으로 가져올 때 사용 (date > str)
function dateToStr(dt) {
	let date = new Date(dt)
    let year = date.getFullYear();
    let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줌
    let day = date.getDate().toString().padStart(2, '0');
    return `${year}${month}${day}`;
}

// DB에서 일자를 가져올 때
// 테이블에서 YYYY-MM-DD형식으로 표현하기 위한 함수
function strToDate(str){
	 // str이 null이거나 빈 문자열인 경우 '-' 반환
    if (!str || str.trim() === '') {
        return '-';
    }

    // 문자열에서 년, 월, 일을 추출
    let year = str.substring(0, 4);
    let month = str.substring(4, 6);
    let day = str.substring(6, 8);
    
    let strDate = `${year}-${month}-${day}`;
    // YYYY-MM-DD 형식으로 반환
    return strDate;
}

// DT 에서 Str
function dtToStr(ajmtDt) {
    const date = new Date(ajmtDt);  // 문자열을 Date 객체로 변환
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');  // 월은 0부터 시작하므로 +1, 2자리로 맞춤
    const day = String(date.getDate()).padStart(2, '0');  // 일도 2자리로 맞춤

    return `${year}-${month}-${day}`;  // yyyy-mm-dd 형식으로 반환
}




// 전화번호를 3개의 배열로 반환하는 함수
function splitTel(phoneNumber) {
    // 전화번호에서 숫자만 남기기
//    phoneNumber = phoneNumber.replace(/[^0-9]/g, '');

    let firstPart, secondPart, thirdPart;
	if(phoneNumber.length === 7){
		firstPart = '';
		secondPart = phoneNumber.substring(0, 3); // 앞의 3자리 (010)
        thirdPart = phoneNumber.substring(3, 7); // 중간 4자리 (3213)
	} else if(phoneNumber.length === 8){
		firstPart = '';
		secondPart = phoneNumber.substring(0, 4); // 앞의 3자리 (010)
        thirdPart = phoneNumber.substring(4, 8); // 중간 4자리 (3213)
	}else if (phoneNumber.length === 11) { // 000-0000-0000
        firstPart = phoneNumber.substring(0, 3); // 앞의 3자리 (010)
        secondPart = phoneNumber.substring(3, 7); // 중간 4자리 (3213)
        thirdPart = phoneNumber.substring(7, 11); // 마지막 4자리 (2456)
    } else if (phoneNumber.length === 10) {
    	if (phoneNumber.startsWith("02")) { //02-0000-0000
            // 서울 지역번호 (02)
            firstPart = phoneNumber.substring(0, 2); // 앞의 2자리
            secondPart = phoneNumber.substring(3, 6); // 중간 4자리 
            thirdPart = phoneNumber.substring(6, 9); // 마지막 4자리
        } else { // 000-000-0000
	        firstPart = phoneNumber.substring(0, 3); // 앞의 3자리 (044)
	        secondPart = phoneNumber.substring(3, 6); // 중간 3자리 (235)
	        thirdPart = phoneNumber.substring(6, 10); // 마지막 3자리 (6435)
        }
    } else { //00-000-000
	        firstPart = phoneNumber.substring(0, 2); // 앞의 2자리 (예: 02)
	        secondPart = phoneNumber.substring(2, 5); // 중간 3자리 (예: 123)
	        thirdPart = phoneNumber.substring(5, 9); // 마지막 4자리 (예: 4567)
    }
    return [firstPart, secondPart, thirdPart];
}

// 전화번호를 하이픈 붙여 반환하는 함수
function telToStr(phoneNumber) {
    // 전화번호에서 숫자만 남기기
    //phoneNumber = phoneNumber.replace(/[^0-9]/g, '');

    let firstPart, secondPart, thirdPart;

    if(phoneNumber.length === 7){
		firstPart = '';
		secondPart = phoneNumber.substring(0, 3); // 앞의 3자리 (010)
        thirdPart = phoneNumber.substring(3, 7); // 중간 4자리 (3213)
        return secondPart+"-"+thirdPart;
	} else if(phoneNumber.length === 8){
		firstPart = '';
		secondPart = phoneNumber.substring(0, 4); // 앞의 3자리 (010)
        thirdPart = phoneNumber.substring(4, 8); // 중간 4자리 (3213)
        return secondPart+"-"+thirdPart;
	}else if (phoneNumber.length === 11) { // 000-0000-0000
        firstPart = phoneNumber.substring(0, 3); // 앞의 3자리 (010)
        secondPart = phoneNumber.substring(3, 7); // 중간 4자리 (3213)
        thirdPart = phoneNumber.substring(7, 11); // 마지막 4자리 (2456)
    } else if (phoneNumber.length === 10) {
    	if (phoneNumber.startsWith("02")) { //02-0000-0000
            // 서울 지역번호 (02)
            firstPart = phoneNumber.substring(0, 2); // 앞의 2자리
            secondPart = phoneNumber.substring(3, 6); // 중간 4자리 
            thirdPart = phoneNumber.substring(6, 9); // 마지막 4자리
        } else { // 000-000-0000
	        firstPart = phoneNumber.substring(0, 3); // 앞의 3자리 (044)
	        secondPart = phoneNumber.substring(3, 6); // 중간 3자리 (235)
	        thirdPart = phoneNumber.substring(6, 10); // 마지막 3자리 (6435)
        }
    } else { //00-000-000
	        firstPart = phoneNumber.substring(0, 2); // 앞의 2자리 (예: 02)
	        secondPart = phoneNumber.substring(2, 5); // 중간 3자리 (예: 123)
	        thirdPart = phoneNumber.substring(5, 9); // 마지막 4자리 (예: 4567)
    }
    return firstPart+"-"+secondPart+"-"+thirdPart;
}

 /*************************************************************************************
			날짜 비교
**************************************************************************************/
// 날짜 비교 함수
function isPastOrToday(deliYmd) {
	// 오늘 날짜를 YYYYMMDD 형식으로 구하기
	const today = new Date();
	const year = today.getFullYear();
	const month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
	const day = ('0' + today.getDate()).slice(-2);
	const todayYmd = `${year}${month}${day}`; // YYYYMMDD 형식
	
    return deliYmd <= todayYmd; // deliYmd가 오늘 또는 이전 날짜이면 true 반환
}

 /*************************************************************************************
			계좌번호 가리기
**************************************************************************************/
function maskActno(actno) {
    if (actno == null || actno.length <= 6) {
        return actno; // actno가 6자리 이하일 경우 마스킹하지 않음
    }
    let visiblePart = actno.substring(0, actno.length - 6); // 앞부분 그대로
    let maskedPart = "******"; // 마지막 6자리는 마스킹
    return visiblePart + maskedPart; // 합쳐서 반환
}
