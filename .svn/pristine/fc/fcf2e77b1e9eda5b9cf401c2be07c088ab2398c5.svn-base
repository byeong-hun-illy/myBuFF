/**
 * 

 $(document).ready(function() {

	let mbrId = "${user.mbrId}";
	
	var mapContainer = document.getElementById('map'), mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667),
		level : 6
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);
	var geocoder = new kakao.maps.services.Geocoder();

	<c:forEach var="bzentVO" items="${bzentVOList}">
	// 주소로 지도에 마커 표시
	geocoder.addressSearch('${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}',
	function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y,
					result[0].x);
			var marker = new kakao.maps.Marker({
				map : map,
				position : coords
			});

			var infowindow = new kakao.maps.InfoWindow(
					{
						content : '<div style="width:150px;text-align:center;padding:6px 0;">${bzentVO.bzentNm}지점</div>'
					});
			infowindow.open(map, marker);
		}
	});
	</c:forEach>

	// 카드 클릭 시 해당 주소로 이동하는 함수
	function moveToLocation(address) {
		geocoder.addressSearch(address, function(result, status) {
			
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				map.setCenter(coords); // 지도 중심 이동
			} // if 끝

		});
		
	} //moveToLocation
	
	// 관심 매장 등록, 삭제 
	
	// 로그인 안한 고객은 관심 매장 설정 안됨.
	function noLogin(){
		
		Swal.fire({
		    icon: 'error',
		    text: '로그인 후 이용가능합니다.'
	   	});
	
	 };	
	
	// 관심 매장 설정
	$(document).on('click', '.likeBtn', function() {
		// 방금 클릭한 버튼을 가져온다. 
		let btn = $(this);
		
		// 해당 버튼의 value값 가져오기
	    let bzentNo = btn.val();
	    console.log("bzentNo :" , bzentNo);
	
	    $.ajax({
	        url: "/cust/selectStoreAjax",
	        type: "POST",
	        data: {bzentNo: bzentNo},
	        dataType: "json",  
	        beforeSend:function(xhr){
		         xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	},
	        success: function(response) {
	            if (response.isDuplicate === 'Y') {
	                Swal.fire({
	                	icon: 'success', 
	                	title: '관심 매장 등록', 
	                	text: '관심 등록이 완료되었습니다.'
	                });
	                	btn.css('background-color', 'antiquewhite');
	            } else {
	                Swal.fire({
	                	icon: 'warning', 
	                	title: '관심 매장 삭제', 
	                	text: '관심 매장 해제되었습니다.'
	                });
	                	btn.css('background-color', 'initial');
	            }
	        },
	        error: function(xhr, status, error) {
	            Swal.fire({icon: 'error', title: '등록 실패', text: '관심 매장 등록에 실패했습니다.'});
	        }
	    }); // ajax 끝
	    
	}); // .likeBtn 끝

});

 */