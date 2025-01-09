/**
 * 고객 페이지 js 모음
 */
 $(document).ready(function() {
	// 스크롤 처리
	var lastScrollTop = 0;
	var $headerTop = $('.header-wrap.top');
	
	$(window).scroll(function() {
	    var currentScrollTop = $(this).scrollTop();
	    
	    if (currentScrollTop > lastScrollTop) {
	        // 스크롤을 내릴 때 - 슬라이드 업
	        $headerTop.slideUp(20);
	    } else {
	        // 스크롤을 올릴 때 - 슬라이드 다운
	        $headerTop.slideDown(20);
	    }
	    lastScrollTop = currentScrollTop;
	});

});

 // 로그아웃 처리
function logoutSubmit() {
  document.getElementById('logoutForm').submit();
}