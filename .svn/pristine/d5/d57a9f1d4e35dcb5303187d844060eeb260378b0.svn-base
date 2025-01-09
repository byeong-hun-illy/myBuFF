package com.buff.frcs.controller;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.frcs.service.FrcsMyPageService;
import com.buff.vo.FrcsVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.controller.frcs
* @fileName     : FrcsMyPageController.java
* @author       : 김현빈
* @date         : 2024-09-12
* @description  : 
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024-09-12		김현빈				?
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsMyPageController {
	
	@Inject
	ComService comService;
	
	@Inject
	FrcsMyPageService frcsMyPageService;
	
	//비밀번호 인코딩을 위해서 DI
	@Inject
	PasswordEncoder passwordEncoder;
	
	/** 가맹점 진입페이지
	 * 요청URI : /frcs/MyPage
	 * 요청파라미터 : 
	 * 요청방식 : get
	 */
	@GetMapping("/myPage")
	public String myPage(Model model) {
		
		model.addAttribute("bk", this.comService.selectCom("BK"));
		
		return "frcs/myPage";
	}
	
	/** 가맹점 마이페이지 조회
	 * 요청URI : /frcs/myPageAjax
	 * 요청파라미터 : 
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/myPageAjax")
	public FrcsVO myPageAjax(@RequestBody String mbrId) {
		log.info("myPageAjax : -> mbrId : " + mbrId);
		
		FrcsVO frcsVO = this.frcsMyPageService.selectFrcsMyPage(mbrId);
		log.info("frcsVO : -> " + frcsVO);
		
//		String addr = frcsVO.getBzentVO().getBzentAddr();
//		
//		String rgnNo = this.comService.rgnNoSearch(addr);
//		
//		frcsVO.getBzentVO().setRgnNo(rgnNo);
		
		return frcsVO;
	}
	
	/** 가맹점 마이페이지 정보 수정
	 * 요청URI : /frcs/updateMyPageAjax
	 * 요청파라미터 : 
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/updateMyPageAjax")
	public int updateFrcsMyPage(@RequestBody FrcsVO frcsVO) {		
		log.info("frcsVO : " + frcsVO);
		
		// 비밀번호 인코딩 처리
//	    if (frcsVO.getBzentVO() != null && frcsVO.getBzentVO().getMbrVO() != null) {
//	        String plainPassword = frcsVO.getBzentVO().getMbrVO().getMbrPswd();
//	        if (plainPassword != null && !plainPassword.isEmpty()) {
//	            String encodedPassword = passwordEncoder.encode(plainPassword);
//	            frcsVO.getBzentVO().getMbrVO().setMbrPswd(encodedPassword);
//	        }
//	    }
		// 비밀번호 인코딩 처리
		// 1. memberVO에서 비밀번호 추출
		String pswdEncoding = frcsVO.getBzentVO().getMbrVO().getMbrPswd();
		// 2. 추출한 비밀번호 인코딩
		pswdEncoding = passwordEncoder.encode(pswdEncoding);
		// 3. 인코딩 된 비밀번호를 memberVO에 적용
		frcsVO.getBzentVO().getMbrVO().setMbrPswd(pswdEncoding);
		
	    
	    String addr = frcsVO.getBzentVO().getBzentAddr();
	    String rgnNo = this.comService.rgnNoSearch(addr);
	    frcsVO.getBzentVO().setRgnNo(rgnNo);
		
		int result = this.frcsMyPageService.updateFrcsMyPage(frcsVO);
		log.info("result 가맹점 수정작업 : -> " + result);
		
		return result;
	}
	
	/** 가맹점 폐업신청
	 * 요청URI : /frcs/insertFrcsClsbizAjax
	 * 요청파라미터 : 
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/insertFrcsClsbizAjax")
	public int insertFrcsClsbiz(@RequestBody FrcsVO frcsVO) {
		log.info("frcsVO" + frcsVO);
		
		int result = this.frcsMyPageService.insertFrcsClsbiz(frcsVO);
		log.info("result 가맹점 폐업신청 : -> " + result);
		
		return result;
	}
	
	/** 가맹점 마이페이지 관리자 정보 조회
	 * 요청URI : /frcs/selectFrcsMngrAjax
	 * 요청파라미터 : 
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/selectFrcsMngrAjax")
	public FrcsVO selectFrcsMngr(@RequestBody String mbrId) {
		log.info("selectFrcsMngrAjax : -> mbrId : " + mbrId);
		FrcsVO frcsVO = this.frcsMyPageService.selectFrcsMngr(mbrId);
		log.info("frcsVO : -> " + frcsVO);
		
		return frcsVO;
	}
	
}
