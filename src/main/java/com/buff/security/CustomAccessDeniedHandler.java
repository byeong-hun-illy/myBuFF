package com.buff.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.security
* @fileName     : CustomAccessDeniedHandler.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 권한 접근 거부일 경우, 처리하는 메소드
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	
	@Override	
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("handle에 왔다");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("remoteAddr", request.getRemoteAddr());
		map.put("requestURI", request.getRequestURI());
		map.put("serverName", request.getServerName());
		map.put("serverPort",request.getServerPort());
		map.put("contextPath",request.getContextPath());
		
		log.info("map : " + map);
		
		response.sendRedirect("/accessError");
	}
	
	
	
}




