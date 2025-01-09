 package com.buff.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	/**
	 * 
	* @methodName  : accessDenied
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @param auth : 권한 객체를 받는 파라미터
	* @param model : 정보를 담을 model 객체
	* @return
	 */
	
	//접근access 거부denied 처리자handler 의 URI를 지정
	// 요청URI : /accessError
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "권한 없음..");
		
		//forwarding
		//security 폴더의 accessError.jsp를 forwarding함
		return "accessError";
	}
	
}
