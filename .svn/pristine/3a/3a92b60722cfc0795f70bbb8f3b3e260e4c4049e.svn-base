<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<div class="login-box" style="margin-left:25%;">
	<div class="login-logo">
		<a href="../../index2.html"><b>Admin</b>LTE</a>
	</div>
	<div class="card">
		<div class="card-body login-card-body">
			<p class="login-box-msg">Sign in to start your session</p>
			<!-- 
			[스프링 시큐리티 로그인 폼 규칙]
			1. 아이디   : name속성값이 username
			2. 비밀번호 : name속성값이 password
			3. form태그의 action속성값이 /login, method속성값이 post
			4. csrf 처리
			5. submit 버튼
			 -->
			<form action="/login" method="post">
				<div class="input-group mb-3">
					<input type="text" class="form-control" 
						placeholder="아이디" 
						name="username" id="username" />
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-user"></span>
						</div>
					</div>
				</div>
				<div class="input-group mb-3">
					<input type="password" class="form-control" 
						placeholder="비밀번호" 
						name="password" id="password" />
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-lock"></span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<div class="icheck-primary">
							<!-- 로그인 상태 유지 체크박스
							체크 시 : PERSISTENT_LOGINS에 로그인 로그 정보가 insert
							 -->
							<input type="checkbox" id="remember-me"
								name="remember-me" /> 
							<label for="remember-me">자동 로그인</label>
						</div>
					</div>
					<div class="col-4">
						<button type="submit" class="btn btn-primary btn-block">Sign
							In</button>
					</div>
				</div>
				<!-- csrf : Cross Site(크로스 사이트) Request(요청) Forgery(위조) -->
				<sec:csrfInput/>
			</form>
		</div>
	</div>
	
	
	
	
	
</div>