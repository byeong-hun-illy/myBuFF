package com.buff.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
* @packageName  : com.buff.security
* @fileName     : CustomAuthenticationFailureHandler.java
* @author       : 송예진
* @date         : 2024.10.15
* @description  : 로그인 실패 시에 로그인한 경로에 따라 이동되는 에러 페이지를 별개로 설정
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.15        송예진     	  			최초 생성
*/
@Component
@Slf4j
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        String loginPath = request.getHeader("Referer");
        log.info("경로 >>>"+loginPath);
        // 로그인 경로에 따라 실패 URL 설정
        if (loginPath.contains("/admin/login")) {
            response.sendRedirect("/admin/login?error=true");
        } else if (loginPath.contains("/login")) {
            response.sendRedirect("/login?error=true");
        } else {
            // 기본 실패 URL 처리
            response.sendRedirect("/login?error=true");
        }
    }
}

