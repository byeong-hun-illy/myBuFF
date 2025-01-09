package com.buff.cnpt.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cnpt.service.CnptService;
import com.buff.com.mapper.ComMapper;
import com.buff.cust.mapper.MemberMapper;
import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasRole('ROLE_CNPT')")
@RequestMapping("/cnpt")
@Slf4j
@Controller
public class CnptController {
	
	@Autowired
	CnptService cnptService;
	
	@Autowired
	ComMapper comMapper;
	
	@Autowired
	MemberMapper membermapper;

	/**
	* @methodName  : selectInfo
	* @author      : 이병훈
	* @date        : 2024.09.17
	* @param bzentNo : 거래처 번호
	* @param model
	* @return	   : 거래처 정보 및 담당자 정보
	*/
	@GetMapping("/selectCnpt")
	public String selectInfo(Principal principal, Model model) {
		// Principal를 이용하여 로그인한 사용자 정보 가져오기(bzentNo)
		String mbrId = principal.getName();
		MemberVO memberVO = this.membermapper.getLogin(mbrId);
		String bzentNo = memberVO.getBzentNo();
		
		BzentVO bzentVO = cnptService.selectCnpt(bzentNo);
		log.info("bzentVO : " + bzentVO);
		
		// JSP에 전달한 데이터 모델 추가
		model.addAttribute("bzentVO", bzentVO);
		model.addAttribute("bankVO", this.comMapper.selectCom("BK"));
		
		// JSP 페이지로 이동
		return "cnpt/mypage/selectCnpt";
		
	}
	
	/**
	* @methodName  : updateCnpt
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param bzentVO : 수정된 거래처 정보
	* @param model
	* @return : 수정 성공/실패 여부
	*/
	@PostMapping("/updateCnpt")
	@ResponseBody
	public String updateCnpt(@RequestBody BzentVO bzentVO, Model model) {

			log.info("updateCnpt -- bzentVO : " + bzentVO);
			
			// 수정된 정보를 DB에 UPDATE
			cnptService.updateCnpt(bzentVO);
			
			// 업데이트 이후 새로운 정보 불러오기
			BzentVO updateInfo = cnptService.selectCnpt(bzentVO.getBzentNo());
			model.addAttribute("bzentVO", updateInfo);
			model.addAttribute("bankVO", this.comMapper.selectCom("BK"));
			
			log.debug("Update bzentVO : " + updateInfo);
			
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
	@PostMapping("/updateCnptMngr")
	@ResponseBody
	public String updateCnptMngr(@RequestBody MemberVO memberVO
			, Principal principal
			, Model model) {
		
			//로그인 한 아이디를 가져옴
			String mbrId = principal.getName();
			memberVO.setMbrId(mbrId);
			
			log.info("memberVO : " + memberVO);
			
			// 담당자 정보 수정 로직 처리, mbrId
			cnptService.updateMngr(memberVO);
			
			// 수정된 정보를 다시 조회
			BzentVO bzentInfo = cnptService.selectCnpt(memberVO.getMbrId());
			model.addAttribute("bzentVO", bzentInfo);
			
			// 성공적으로 수정된 경우 담당자 정보 조회 페이지로 이동
			return "success";
			
	}
	
	
}
