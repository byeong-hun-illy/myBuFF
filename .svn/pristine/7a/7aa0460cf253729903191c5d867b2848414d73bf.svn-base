function getNavOption(){
	$.ajax({
		url : "/nav/search",
		type : "GET",
		data : { navType: navType },
		success : function(res){
			//console.log(res);
			let option = '';
			
			res.forEach(nav => {
				option += `<option value="${nav.navUrl}">${nav.path}</option>`
			});
			
			$('#navSearch').append(option);
		},
		 error: function(xhr, status, error) {
			 	console.error("Error details:", xhr, status, error);
	            Swal.fire({
	                icon: 'error',
	                title: '조회 실패',
	                text: '상품 데이터를 불러오지 못했습니다.',
	                confirmButtonText: '확인'
	            });
	        }
	// ajax 끝	
	});

}