package com.buff.hdofc.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cnpt.service.CnptService;
import com.buff.com.service.ComService;
import com.buff.hdofc.service.MngrService;
import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

@Controller
@RequestMapping("/hdofc/myPage")
public class HdofcMyPageController {

	@Autowired
	CnptService cnptService;
	
	@Autowired
	ComService comService;
	
	@Autowired
	MngrService mngrService;
	
	@GetMapping("/")
	public String selectMyPage(Model model, Principal principal) {
		
		//로그인 한 아이디를 가져옴
		String mbrId = principal.getName();
		
		// 서비스에서 거래처 정보 및 거래처 담당자 정보 가져오기
		BzentVO bzentVO = cnptService.selectCnpt("HO0001");
		
		// 회원 정보와 관리자 정보 가져오기
		model.addAttribute("mngr", this.mngrService.selectMngrInfo(mbrId));
		
		
		// JSP에 전달한 데이터 모델 추가
		model.addAttribute("bzentVO", bzentVO);
		model.addAttribute("bankVO", this.comService.selectCom("BK"));
		
		// JSP 페이지로 이동
		return "hdofc/mypage/selectMyPage";
	}
	
	
	@PostMapping("/updateHdofc")
	@ResponseBody
	public String updateHdofc(@RequestBody BzentVO bzentVO, Model model) {
			// 수정된 정보를 DB에 UPDATE
			cnptService.updateCnpt(bzentVO);
			
			// 수정이 완료된 후, 페이지 이동
			return "success";
	
	}
	
	/**
	* @methodName  : updateCnptMngr
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param memberVO : 거래처 담당자 정보가 담긴 VO객체
	* @param model
	* @return : 수정후 거래처 담당자 정보 페이지로 이동
	* 
	* {
		    "mbrNm": "이서준",
		    "mbrZip": "10410",
		    "mbrAddr": "인천광역시 연수구 송도동 789",
		    "mbrDaddr": "303호",
		    "mbrTelno": "01012340410"
		}
	*/
	@PostMapping("/updateMbr")
	@ResponseBody
	public String updateMbr(@RequestBody MemberVO memberVO
			, Principal principal
			, Model model) {
		
			//로그인 한 아이디를 가져옴
			String mbrId = principal.getName();
			memberVO.setMbrId(mbrId);
			// 담당자 정보 수정 로직 처리, mbrId
			cnptService.updateMngr(memberVO);
			
			return "success";
			
	}
	
}
