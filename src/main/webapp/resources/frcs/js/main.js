 /*************************************************************************************
			본사 납품 조회  ------------------------------------------- 공통(본사, 거래처)
**************************************************************************************/
function updateOrdrAjax(){
	// 서버전송
	$.ajax({
		url : "/frcs/ordr",
		type : "POST",
		data: { frcsNo : bzentNo },  // 객체 형태로 전송
		// csrf설정 secuity설정된 경우 필수!!
		beforeSend:function(xhr){ 
			xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
		},
		success : function(res){
		console.log(res);
			if(res>0){
					Swal.fire({
					  title: "완료",
					  text: "주문에 따라 정상적으로 재고가 출고되었습니다.",
					  icon: "success"
					});
			} else{
				Swal.fire({
				  title: "에러",
				  text: "출고할 내역이 없습니다",
				  icon: "error"
				});
			}
		} // success 끝
	});		
}