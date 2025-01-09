<!-- 
	고객페이지에 권한이없는 사람이 접근한 경우
 -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/global/error.css">
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let mbrId = '<c:out value="${user.mbrId}"/>';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	$('#roleAdd').on('click', function(){
		Swal.fire({
	    	  title: "확인",
	    	  html : `<p>로그인된 아이디로 회원 권한으로 가입하시겠습니까?</p>`,
	    	  icon: "warning",
	    	  showCancelButton: true,
	    	  confirmButtonColor: "#3085d6",
	    	  confirmButtonText: "확인",
	    	  cancelButtonText: "취소"
	    	}).then((result) => {
	    	  /* Read more about isConfirmed, isDenied below */
	    	  if (result.isConfirmed) {
	    			// 서버전송
	    			$.ajax({
	    				url : "/error/addCust",
	    				type : "POST",
	    				data: { mbrId : mbrId },  // JSON으로 변환
	    			// csrf설정 secuity설정된 경우 필수!!
	    				beforeSend:function(xhr){ 
	    					xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 헤더와 토큰을 설정
	    				},
	    				success : function(res){
	    					Swal.fire({
	    						  position: "center",
	    						  icon: "success",
	    						  html: "<p>회원으로 가입이 완료되었습니다.</p> <p>회원페이지로 이동합니다.</p>",
	    						  showConfirmButton: false,
	    						  timer: 1000
	    						});
	    					setTimeout(function() {
	    		        		location.href='/buff/home';
	    					}, 1000);
	    				},
	    				error: function(xhr, status, error) {
	    		        	console.error("에러 발생: ", error);
	    		        }
	    				});		
	    	  } 
	    });
	})
})
</script>
<div class="wrap">
	<div class="error-wrap">
		<div class="error-icon">
			<span class="material-symbols-outlined">warning</span>
		</div>
		<div class="error-cont">
			<div class="error-title">요청한 기능을 실행할 수 있는 권한이 없습니다.</div>
			<div class="error-cn">
				회원 권한으로 가입하시겠습니까?
			</div>
			
			<form action="/logout" method="post" style="margin-left: 5px;" id="logoutForm" class="admin">
				<button type="button" id="roleAdd" class="btn btn-active admin">회원 권한 가입</button>
						<sec:authorize access="hasRole('ROLE_FRCS')">
							<button onclick="location.href='/frcs/main'" type="button" id="mode-change" class="mode-chang color">파트너 메인  <span style="color: white;" class="material-symbols-outlined icon">east</span></button>
			            </sec:authorize>
			            <sec:authorize access="hasRole('ROLE_CNPT')">
							<button onclick="location.href='/cnpt/main'" type="button" id="mode-change" class="mode-chang color">파트너 메인  <span style="color: white;" class="material-symbols-outlined icon">east</span></button>
			            </sec:authorize>
			            <sec:authorize access="hasRole('ROLE_HDOFC')">
							<button onclick="location.href='/hdofc/main'" type="button" id="mode-change" class="mode-chang color">파트너 메인  <span style="color: white;" class="material-symbols-outlined icon">east</span></button>
			            </sec:authorize>
				<button type="submit" class="btn btn-default">로그아웃</button>
			     		<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>