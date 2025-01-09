<%--
 	@fileName    : selectStore.jsp
 	@programName : 메인홈화면
 	@description : 고객이 모든 매장 정보와 관심 매장을 설정할 수 잇음.
 	@author      : 서윤정
 	@date        : 2024. 09. 16
--%>
<%@page import="com.buff.vo.BzentVO"%>
<%@page import="com.buff.util.Telno"%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 

<link href="/resources/cust/css/selectStore.css" rel="stylesheet">

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="user"/>
</sec:authorize>


<div class="wrap">
	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">매장 소개</div>
		<!-- /.wrap-title -->
		
		<!-- 지도 & 매장목록 영역 -->
		<div class="wrap-inner">
			
			<!-- map 영역 -->
			<div id="map" style="width: 100%; height: 800px; border: 1px solid var(--gray--4);"></div>
		
			<!-- 매장 목록 시작 -->
			<div class="store-list">
				<!-- 검색 영역 시작 -->
				<div class="cont">
					<form id="selectStoreForm" method="get" action="/buff/selectStore">
						<div class="search-wrap" style="gap: 10px;">
							<div class="search-cont">
								<p class="search-title">지역</p>
								<select class="select2-custom" name="rgnNo" id="rgnNo" onchange="this.form.submit()">
									<option value="" selected>전체</option>
									<option value="RGN11"
										<c:if test="${param.rgnNo == 'RGN11'}">selected</c:if>>서울특별시</option>
									<option value="RGN21"
										<c:if test="${param.rgnNo == 'RGN21'}">selected</c:if>>부산광역시</option>
									<option value="RGN22"
										<c:if test="${param.rgnNo == 'RGN22'}">selected</c:if>>대구광역시</option>
									<option value="RGN23"
										<c:if test="${param.rgnNo == 'RGN23'}">selected</c:if>>인천광역시</option>
									<option value="RGN24"
										<c:if test="${param.rgnNo == 'RGN24'}">selected</c:if>>광주광역시</option>
									<option value="RGN25"
										<c:if test="${param.rgnNo == 'RGN25'}">selected</c:if>>대전광역시</option>
									<option value="RGN26"
										<c:if test="${param.rgnNo == 'RGN26'}">selected</c:if>>울산광역시</option>
									<option value="RGN29"
										<c:if test="${param.rgnNo == 'RGN29'}">selected</c:if>>세종특별자치시</option>
									<option value="RGN31"
										<c:if test="${param.rgnNo == 'RGN31'}">selected</c:if>>경기도</option>
									<option value="RGN32"
										<c:if test="${param.rgnNo == 'RGN32'}">selected</c:if>>강원도</option>
									<option value="RGN33"
										<c:if test="${param.rgnNo == 'RGN33'}">selected</c:if>>충청북도</option>
									<option value="RGN34"
										<c:if test="${param.rgnNo == 'RGN34'}">selected</c:if>>충청남도</option>
									<option value="RGN35"
										<c:if test="${param.rgnNo == 'RGN35'}">selected</c:if>>전라북도</option>
									<option value="RGN36"
										<c:if test="${param.rgnNo == 'RGN36'}">selected</c:if>>전라남도</option>
									<option value="RGN37"
										<c:if test="${param.rgnNo == 'RGN37'}">selected</c:if>>경상북도</option>
									<option value="RGN38"
										<c:if test="${param.rgnNo == 'RGN38'}">selected</c:if>>경상남도</option>
									<option value="RGN39"
										<c:if test="${param.rgnNo == 'RGN39'}">selected</c:if>>제주특별자치도</option>
								</select>
							</div>
							<div class="search-cont">
								<p class="search-title">검색어</p>
								<div class="search-input-btn store-search">
									<input type="text" name="keyword" placeholder="검색어를 입력해주세요"
										class="search-input" style="width: 220px;"
										value="${param.keyword}" />
									<button type="submit" class="search-btn"></button>
								</div>
							</div>
						</div>
					</form>
				</div>
			
				<!-- 카드 영역 시작 -->
				<div class="cont">
					
					<div class="info-txt">매장을 선택해주세요!</div>
					
					<div class="store-cont">
						<c:if test="${empty bzentVOList}">
							<div class="no-list">
								<span class="no-icon material-symbols-outlined">error</span>
 								매장 검색 결과가 없습니다
							</div>
						</c:if>
						<c:forEach var="bzentVO" items="${bzentVOList}">
							<div class="store-box" data-no="${bzentVO.bzentNo}" data-open="${bzentVO.openTm}" data-cls="${bzentVO.ddlnTm}" onmouseover="moveToLocation('${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}')">
								<div class="store-nm">
									<sec:authorize access="isAuthenticated()">
										<button type="button" value="${bzentVO.bzentNo}" class="likeBtn star-btn">
											<span id="starIcon" class="${bzentVO.favChk==0 ? 'star-icon02' : 'star-icon01'} material-symbols-outlined">star</span>
										</button>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
										<button type="button" value="${bzentVO.bzentNo}" onclick="noLogin()" class="star-btn">
											<span class="star-icon01 material-symbols-outlined">star</span>
										</button>
									</sec:authorize>
									${bzentVO.bzentNm}지점
								</div> 
								<p class="store-addr">${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}</p>
								<p class="store-tel">${bzentVO.bzentTelno}</p>
<%-- 								<p class="store-time">${bzentVO.openTm} ~ ${bzentVO.ddlnTm}</p> --%>
							</div>
						</c:forEach>
					</div>
				</div>
			
			</div>
			<!-- /.store-list -->
			
		</div>
		<!-- /.wrap-inner -->
		
	</div>
	<!-- /.wrap-cont -->
	
</div>


<!-- 상세 매장 정보 -->
<!-- 재고조정을 위해 상품을 출력 -->
<!-- 메뉴에서 상품 추가 -->
<div class="modal fade" id="ccModal" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-ml modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header align-items-center justify-content-between">
        <div>
          <h4 class="modal-title"></h4>
        </div>
        <div>
          <!-- Bootstrap 5에서는 data-dismiss를 data-bs-dismiss로 변경 -->
          <button type="button" class="btn-icon" data-bs-dismiss="modal">
            <span class="material-symbols-outlined icon-btn">close</span>
          </button>
        </div>
      </div>
      <div class="modal-body">
        <div class="modal-cont">
          <div class="cont-title">
                            주소
          </div>
          <div class="cont-cont" id="st-addr">
          	<p id="st-a"></p>
          	<p id="st-d"></p>
          </div>
        </div>
        <div class="modal-cont">
          <div class="cont-title">
           	 연락처
          </div>
          <div class="cont-cont" id="st-tel">
          </div>
        </div>
        <div class="modal-cont">
          <div class="cont-title">
                           이용시간
          </div>
          <div class="cont-cont" id="st-time">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        	주문하기
      </div>
    </div>
  </div>
  <!-- modal-dialog -->
</div>
<!-- modal -->




<script src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14c0b956a84a09b67adecf3f85c6bf79&libraries=services"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Bootstrap JS (Popper.js 포함) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
	let bzentNo = '';
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

	 var modal = new bootstrap.Modal(document.getElementById('ccModal'));
	 
	 $(document).on('click', '.store-box', function(){
	 	if ($(event.target).closest('.star-btn').length > 0) {
	        return;  // star-btn 클릭 시 모달이 뜨지 않도록 함
	    }
		 bzentNo = $(this).data("no");
		 let bzentNm = $(this).find('.store-nm').html().trim();
		 let bzentAddr = $(this).find('.store-addr').text().trim();
	    let addrParts = bzentAddr.match(/(.*동\s*\d+-?\d*)(.*)/);
		 
		 let bzentTel = $(this).find('.store-tel').text().trim();
		 let open = $(this).data("open");
		 let cls = $(this).data("cls");
		 
		 $('.modal-title').html(bzentNm);
		 if(addrParts){
		    let dongAddr = addrParts[1].trim();  // 동과 번지
		    let roadAddr = addrParts[2].trim();  // 도로명 주소
		     $('#st-d').show();
		     $('#st-a').html(dongAddr); 
		     $('#st-d').html(roadAddr); 
		 }else {
		     $('#st-a').html(bzentAddr); 
		     $('#st-d').hide();
		 }
	     $('#st-tel').html(bzentTel);   
	     $('#st-time').html(open + " ~ " + cls); 
		 modal.show();
		 
	 })
	 
	 //주문하기 이동
	 $('.modal-footer').on('click', function(){
		 location.href="/cust/ordr/regist?bzentNo="+bzentNo;
	 })
	 
	 
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
	                
	                btn.children('#starIcon').removeClass('star-icon01');
	                btn.children('#starIcon').addClass('star-icon02');
	                
	            } else {
	                Swal.fire({
	                	icon: 'warning', 
	                	title: '관심 매장 삭제', 
	                	text: '관심 매장 해제되었습니다.'
	                });
	                
	                btn.children('#starIcon').removeClass('star-icon02');
	                btn.children('#starIcon').addClass('star-icon01');
	                
	            }
	        },
	        error: function(xhr, status, error) {
	            Swal.fire({icon: 'error', title: '등록 실패', text: '관심 매장 등록에 실패했습니다.'});
	        }
	    }); // ajax 끝
	    
	}); // .likeBtn 끝


$(function(){ 
	select2Custom(); 
});

</script>

<style>
/* 셀렉트 커스텀 */
.select2-selection[aria-labelledby="select2-rgnNo-container"] {
	width: 200px !important;
}
.select2-selection[aria-labelledby="select2-rgnNo-container"] .select2-dropdown {
	width: 198px !important;
}

</style>