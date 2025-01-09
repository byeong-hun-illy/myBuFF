package com.buff.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.security
* @fileName     : CustomLogoutSuccessHandler.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 로그아웃 처리하는 메소드
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request
			, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		
		// auth : 로그인 정보가 담긴 인증 객체
		if(auth != null && auth.getDetails()!=null) {
			try {
				// 현재 세션을 무효화 하여, 사용자의 세션 정보를 삭제
				request.getSession().invalidate();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		// 로그아웃 성공 시 HTTP상태 코드를 200 (성공)으로 설정
		response.setStatus(HttpServletResponse.SC_OK);
		
		// 로그아웃 후 루트 페이지("/")로 리다이렉트
		response.sendRedirect("/");

	}

}
