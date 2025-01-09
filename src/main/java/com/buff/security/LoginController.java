package com.buff.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.security
* @fileName     : LoginController.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 로그인 폼을 보여주는 GET요청 메소드와
* 				  로그인 처리를 하는 POST요청 메소드
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
@Controller
public class LoginController {
	
	// DI, IOC 주입
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	// <security:form-login login-page="/login" />
	// 요청URI : /login
	// 요청방식 : get
	// 오류 메시지와 로그아웃 메시지를 파라미터로 사용해보자(없을 수도 있음)
	// 로그인 폼을 보여주는 GET 요청
	@GetMapping("/login")
	public String loginForm(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		//forwarding
		return "login";
	}
	
	@GetMapping("/admin/login")
	public String adminLoginForm(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		//forwarding
		return "adminLogin";
	}
	
	
	// 로그인 처리 POST 요청
//	@PostMapping("/login")
//	public String login(Authentication authentication, Model model
//			) {
//		
//		// 사용자의 권한을 반복하여 선택한 유형이 일치하는지 확인
//		List<String> roleNames = new ArrayList<String>();
//		
//		// 실제 로그인된 사용자의 권한 확인
//		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//		boolean hasRole = authorities.stream()
//			    .anyMatch(authority -> roleNames.contains(authority.getAuthority()));
//		
//		if(!hasRole) {
//			// 선택한 역활과 실제 권한이 일치하지 않으면 경고메세지
//			model.addAttribute("error", "선택한 유형과 일치한 정보가 없습니다. 다시 선택해주세요.");
//			return "login"; // 다시 로그인 폼으로 이동
//		}
//		
//		
//		authentication.getAuthorities().forEach(authority -> {
//			roleNames.add(authority.getAuthority());
//		});
//		
//		// 각 권한에 맞게 redirect 이동
//		
//		if(roleNames.contains("ROLE_HDOFC")) {
//			return "redirect:/hdofc/dashBoard";
//		} else if(roleNames.contains("ROLE_CNPT")) {
//			return "redirect:/cnpt/dashBoard";
//		} else if(roleNames.contains("ROLE_FRCS")) {
//			return "redirect:/frcs/dashBoard";
//		} else if(roleNames.contains("ROLE_CUST")) {
//			return "redirect:/cust/dashBoard";
//		} else {
//			return "login";
//		}
//		
//		
//	}
		
	
}
