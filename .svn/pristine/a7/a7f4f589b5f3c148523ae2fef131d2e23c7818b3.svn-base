package com.buff.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.buff.com.service.MemberService;
import com.buff.security.CustomUser;
import com.buff.security.CustomUserDetailsService;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;


/**
* @packageName  : com.buff.controller
* @fileName     : FindController.java
* @author       : 이병훈 
* @date         : 2024.09.13
* @description  : ID찾기 및 비밀번호 찾기를 위한 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/

@Slf4j
@RequestMapping("/find")
@RestController
public class FindController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	/**
	* @methodName  : selectId
	* @author      : 이병훈 
	* @date        : 2024.09.14
	* @param userName : 회원 명
	* @param userEmail : 회원 이메일
	* @return : 회원 ID
	*/
	@PostMapping("/idAjax")
	@ResponseBody
	public String selectId(@RequestParam String userName,
						   @RequestParam String userEmail) {
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMbrNm(userName);
		memberVO.setMbrEmlAddr(userEmail);
		
		String mbrId = this.memberService.selectId(memberVO);
		
		return mbrId;
	}
	
	/**
	* @methodName  : selectPswd
	* @author      : 이병훈
	* @date        : 2024.09.14
	* @param userId : 회원 아이디
	* @param userName : 회원 명
	* @param userEmail : 회원 이메일
	* @return : 비밀번호 찾기 결과 메세지
	* 
	* {
		    "mbrId": "shymuhxy",
		    "mbrNm": "신유진",
		    "mbrEmlAddr": "zan9301@naver.com"
		}
	*/
	@GetMapping("/pswdAjax")
	public String selectPswd(@RequestParam String mbrId,
					    	 @RequestParam String mbrNm,
					    	 @RequestParam String mbrEmlAddr
							 ) {
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMbrId(mbrId);
		memberVO.setMbrNm(mbrNm);
		memberVO.setMbrEmlAddr(mbrEmlAddr);
		
		log.info("selectePswd->memberVO : " + memberVO);
		
		// 그냥 비밀번호 찾기
//		String mbrPswd = this.memberService.selectPswd(memberVO);
		
		 // 임시 비밀번호 생성
	    String tempPswd = this.memberService.generateTempPassword();

	    // 임시 비밀번호를 암호화
	    String encodedTempPswd = passwordEncoder.encode(tempPswd);

	    // 암호화된 비밀번호를 MemberVO에 설정
	    memberVO.setMbrPswd(encodedTempPswd);

	    // DB에 암호화된 비밀번호를 업데이트
	    this.memberService.updatePswd(memberVO);
		
	    //mbrEmlAddr : zan9301@naver.com, tempPswd : YbmyoADf
	    log.info("mbrEmlAddr : " + memberVO.getMbrEmlAddr() + ", tempPswd : " + tempPswd);
	    
	    
	    // 이메일로 임시 비밀번호 전송
		String resultMsg;
		try {
			 this.memberService.sendEmailWithTempPswd(memberVO.getMbrEmlAddr(), tempPswd);
			 resultMsg = "임시 비밀번호가 이메일로 전송되었습니다.";
		} catch (Exception e) {
			log.error("임시 비밀번호 전송 중 오류 발생 : " + e.getMessage());
			 resultMsg = "입력한 정보로 일치하는 비밀번호를 찾을 수 없습니다.";
		}
		
		return resultMsg;
	}
	
	/**
	* @methodName  : checkPswd
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param pswd  : 사용자 입력 패스워드
	* @param authentication : 스프링 시큐리티에 담긴 사용자의 인증 정보
	* @return : 비밀번호 비교 결과 
	* 
	* inputPswd : java
	*/
	@PostMapping("/checkPswd")
	@ResponseBody
	public String checkPswd(@RequestParam("inputPswd") String inputPswd,
											Authentication authentication){
		
		log.info("checkPswd->inputPswd : " + inputPswd);
		
		// 현재 로그인 된 사용자의 정보를 Authentication에서 가져옴
		//private MemberVO memberVO;
		CustomUser user = (CustomUser) authentication.getPrincipal();
		
		MemberVO memberVO = user.getMemberVO();
		
		log.info("memberVO : " + memberVO);
		// DB에서 가져온 사용자의 암호화된 비밀번호
		String storedPswd = memberVO.getMbrPswd();
		
		log.info("inputPswd : " + inputPswd + " vs storedPswd : " + storedPswd);
		
		
		// 입력한 비밀번호와 암호화된 비밀번호를 비교
		if(passwordEncoder.matches(inputPswd, storedPswd)) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
}
