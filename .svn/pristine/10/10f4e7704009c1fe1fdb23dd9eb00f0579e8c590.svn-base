package com.buff.com.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.MemberService;

/**
* @packageName  : com.buff.com.controller
* @fileName     : ErrorController.java
* @author       : 송예진
* @date         : 2024.10.05
* @description  : 로그인 시 에러 처리 페이지
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.05        송예진     	  			최초 생성
*/
@Controller
@RequestMapping("/error")
public class ErrorController {
	
	// 주로 거래처, 본사
	// 고객 페이지에 접근 시에 고객 권한이 없으면 뜨는 페이지
	@GetMapping("/cust")
	public String accessErrorCustPage() {
		return "error/cust";
	}
	
	// 고객
	// 관리자 로그인을 접근 시에 이동
	@GetMapping("/admin")
	public String accessErrorAdminPage() {
		return "error/admin";
	}
	
	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@PostMapping("/addCust")
	public int insertRoleCust(@RequestParam String mbrId) {
	    int result = this.memberService.insertRoleCust(mbrId);  // DB에 ROLE_CUST 추가

	    // 현재 로그인한 결과에 CUST권한은 포함되지 않기 때문에 ROLE_CUST를 추가시킴
	    if (result > 0) {
	        // 현재 Authentication 객체 가져오기
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        // 기존 권한 리스트 복사
	        List<GrantedAuthority> updatedAuthorities = new ArrayList<>(auth.getAuthorities());
	        // ROLE_CUST 권한 추가
	        updatedAuthorities.add(new SimpleGrantedAuthority("ROLE_CUST"));
	        // 새로운 Authentication 객체 생성
	        Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuthorities);
	        // SecurityContext에 새로운 Authentication 설정
	        SecurityContextHolder.getContext().setAuthentication(newAuth);
	    }

	    return result;
	}
}
