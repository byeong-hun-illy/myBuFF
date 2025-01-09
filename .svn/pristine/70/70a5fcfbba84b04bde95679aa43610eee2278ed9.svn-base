package com.buff;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff
* @fileName     : HomeController.java
* @author       : 정기쁨
* @date         : 2024.09.12
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정기쁨  	  			최초 생성
*/
@Slf4j
@Controller
public class HomeController {
	
	
	/**
	* @methodName  : UIElementsLibrary
	* @author      : 정기쁨
	* @date        : 2024.09.12
	* @description : ui 요소를 모아둔 라이브러리로 접근하는 메소드입니다!
	*/
	@GetMapping("/library/UIElementsLibrary")
	public String UIElementsLibrary() {
		log.info("UI 라이브러리 페이지입니다");
		return "library/UIElementsLibrary";
	}
	
	/**
	* @methodName  : hme
	* @author      : 송예진
	* @date        : 2024.09.12
	* @description : 사이트 자체 첫 화면으로 고객과 관리자를 선택하는 페이지로 접근하는 메소드입니다!
	*/
	@GetMapping("/")
	public String hme(HttpServletRequest request) {
		
		HttpSession sesn = request.getSession();
		//로그인 후 권한에 따라 분기되는 경로
		String loc = (String)sesn.getAttribute("loc");
		
		// 'loc' 값을 사용한 후 세션에서 제거
		sesn.removeAttribute("loc");
		
		log.info("메인입니다");
		
		if(loc==null) {
			// 로그인 안했을 경우 회원이랑 파트너 페이지 선택
			return "select";
		}else {
			// 로그인을 한 경우에는 해당 페이지에 맞는 세션 정보에 저장해둔 값으로 URL이동
			// CustomLoginSuccessHandler 참고
			return "redirect:"+loc;
		}
	}
	
}
