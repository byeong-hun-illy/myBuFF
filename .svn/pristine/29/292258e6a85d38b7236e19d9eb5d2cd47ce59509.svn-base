package com.buff.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.security
* @fileName     : CustomLoginSuccessHandler.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 로그인 성공을 처리하는 메소드
* 				  로그인 한 사용자가 어떤 권한을 가지고 있는지 확인하고,
* 				  그에 해당하는 페이지로 redirect 이동
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
public class CustomLoginSuccessHandler extends 
	SavedRequestAwareAuthenticationSuccessHandler {
	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication auth)
			throws ServletException, IOException {
		//~했을때.로그인을.성공
		log.info("로그인 성공!");
		
		User costomUser = (User)auth.getPrincipal();
		
		log.info("username : " + costomUser.getUsername());
		
		super.onAuthenticationSuccess(request, response, auth);
		
		// 로그인한 사람이 어떠한 권한을 가지고 있는지 확인
		// 본사 / 거래처 / 가맹점주 / 고객
		List<String> roleNames = new ArrayList<String>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.info("roleNames >> "+roleNames);
		
		// 각 권한에 맞게 redirect 이동
		HttpSession sesn = request.getSession();
		
		String refererUrl = request.getHeader("Referer");
		
		log.info("url >>>>> " + refererUrl);
		
		
		if (refererUrl.contains("/admin/login")) { // 관리자 로그인 페이지
			if(roleNames.contains("ROLE_HDOFC")) {
				sesn.setAttribute("loc","/hdofc/main");
			} else if(roleNames.contains("ROLE_CNPT")) {
				sesn.setAttribute("loc","/cnpt/main");
			} else if(roleNames.contains("ROLE_FRCS")) {
				sesn.setAttribute("loc","/frcs/main");
			} else if(roleNames.contains("ROLE_CUST")) {
				sesn.setAttribute("loc","/error/admin");
			} else {
				sesn.setAttribute("loc","/admin/login?error=true");
			}
        } else { // 고객 페이지
        	if(roleNames.contains("ROLE_CUST")) {
    			sesn.setAttribute("loc","/buff/home");
    		} else {
    			sesn.setAttribute("loc","/error/cust");
    		}
        }
		
		/*
		 1. 목적지가 없을 때 
		 	최종 목적지 : / =>  tiles의  header
		 2. 목적지가 있을 때
		 	최종 목적지 : 가는 도중의 목적지 => tiles의  header
		 */
//		if(roleNames.contains("ROLE_HDOFC")) {
//			sesn.setAttribute("loc","/hdofc/main");
//			log.info("본사");
//		} else if(roleNames.contains("ROLE_CNPT")) {
//			sesn.setAttribute("loc","/cnpt/main");
//		} else if(roleNames.contains("ROLE_FRCS")) {
//			sesn.setAttribute("loc","/frcs/main");
//		} else if(roleNames.contains("ROLE_CUST")) {
//			sesn.setAttribute("loc","/buff/home");
//		} else {
//			sesn.setAttribute("loc","/login");
//		}
//		
	}
	
}










