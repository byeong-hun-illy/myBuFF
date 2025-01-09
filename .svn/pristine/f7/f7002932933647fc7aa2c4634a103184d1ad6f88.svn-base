package com.buff.hdofc.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.buff.com.service.ComService;
import com.buff.hdofc.service.HdofcMemberService;
import com.buff.util.ArticlePage;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcMemberController.java
* @author       : 김현빈
* @date         : 2024.10.10
* @description  : 회원 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.10        김현빈  	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/member")
@Controller
@Slf4j
public class HdofcMemberController {
	
	@Inject
	HdofcMemberService hdofcMemberService;
	
	@Inject
	ComService comService;
	
	/** 회원관리 리스트 페이지
	 * 요청URI : /hdofc/member/selectMemberList
	 * 요청파라미터 : map
	 * 요청방식 : get
	 */
	@GetMapping("/selectMemberList")
	public String selectMemberList(Model model, Principal principal, 
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage, 
			@RequestParam(value="mbrNm", required=false, defaultValue="") String mbrNm, 
			@RequestParam(value="rgnNo", required=false, defaultValue="") String rgnNo, 
			@RequestParam(value="delYn", required=false, defaultValue="") String delYn, 
			@RequestParam(value="bgngYmd", required=false, defaultValue="") String bgngYmd, 
	        @RequestParam(value="expYmd", required=false, defaultValue="") String expYmd, 
	        @RequestParam(value="sortJoinYmd", required=false, defaultValue="DESC") String sortJoinYmd
			) {
		
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("mbrNm", mbrNm);
		map.put("rgnNo", rgnNo);
		map.put("delYn", delYn);
		map.put("bgngYmd", bgngYmd);
		map.put("expYmd", expYmd);
		map.put("sortJoinYmd", sortJoinYmd);
		log.info("map -> :" + map);
		
		List<MemberVO> memberVOList = this.hdofcMemberService.selectMemberList(map);
		log.info("memberVOList -> :" + memberVOList);
		
		int total = this.hdofcMemberService.totalMember(map);
		log.info("total -> :" + total);
		
		Map<String, Object> tapMaxTotal = this.hdofcMemberService.tapMaxTotal();
		log.info("tapMaxTotal -> :" + tapMaxTotal);
		
		// 회원명 검색시 회원명 불러오는 것
		List<MemberVO> mbrNmList = this.hdofcMemberService.selectMbrNmList();
		log.info("mbrNmList -> :" + mbrNmList);
		
		ArticlePage<MemberVO> articlePage = 
				new ArticlePage<MemberVO>(total, currentPage, 10, memberVOList, map);
		
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("memberVO", memberVOList);
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("total", total);
		model.addAttribute("tapMaxTotal", tapMaxTotal);
		// 회원명 검색시 회원명 불러오는 것
		model.addAttribute("mbrNmList", mbrNmList);
		
		return "hdofc/member/selectMemberList";
	}
	
	/** 회원관리 상세보기 페이지
	 * 요청URI : /hdofc/member/selectMemberDetail
	 * 요청파라미터 : mbrId
	 * 요청방식 : get
	 */
	@GetMapping("/selectMemberDetail")
	public String selectMemberDetail(@RequestParam("mbrId") String mbrId, Model model) {
		
		MemberVO memberVO = this.hdofcMemberService.selectMemberDetail(mbrId);
		log.info("memberVO -> :" + memberVO);
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		
		return "hdofc/member/selectMemberDetail";
	}
	
}
