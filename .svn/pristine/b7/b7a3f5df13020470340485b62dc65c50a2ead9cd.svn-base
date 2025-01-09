package com.buff.frcs.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.buff.com.service.ComService;
import com.buff.frcs.service.FrcsCouponService;
import com.buff.util.ArticlePage;
import com.buff.vo.EventVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsCouponController.java
* @author       : 정현종
* @date         : 2024.09.25
* @description  : 쿠폰 사용 내역 조회 
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.25        정현종     	  			최초 생성
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsCouponController {
	
	@Autowired
	FrcsCouponService frcsCouponService;
	
	@Autowired
	ComService comService;
	
	/**
	* @methodName  : selectFrcsCouponUseList
	* @author      : 정현종
	* @date        : 2024.09.25
	* @param       : model
	* @return	   : 가맹점 쿠폰 사용 내역 조회 URL
	*/
	@GetMapping("/couponList")
	public String selectFrcsCouponUseList(Model model, Principal principal, 
			@RequestParam(name = "eventType", required = false, defaultValue = "") String eventType,
			@RequestParam(name = "bgngYmd", required = false, defaultValue = "") String bgngYmd,
			@RequestParam(name = "expYmd", required = false, defaultValue = "") String expYmd,
			@RequestParam(name = "dscntAmt", required = false, defaultValue = "") String dscntAmt,
			@RequestParam(name = "menuType", required = false, defaultValue = "") String menuType,
			@RequestParam(name = "menuNm", required = false, defaultValue = "") String menuNm,
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage 
		) {
		
		//principal == CustomUser
		//principal.getName() : 로그인 한 아이디
		String mbrId = principal.getName();
				
		// 페이징 크기
		int size = 10;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);				// 아이디
		map.put("eventType", eventType);		// 이벤트 유형
		map.put("bgngYmd", bgngYmd);			// 쿠폰 사용기간(시작)
		map.put("expYmd", expYmd);				// 쿠폰 사용기간(끝)
		map.put("dscntAmt", dscntAmt);			// 쿠폰 금액
		map.put("menuType", menuType);			// 메뉴 유형
		map.put("menuNm", menuNm);				// 메뉴 명
		map.put("currentPage", currentPage);	// 현재 페이지
		map.put("size", size);					// 페이징 크기
		
		// 쿠폰 사용 내역 조회
		List<EventVO> couponUseList = this.frcsCouponService.selectFrcsCouponUseList(map);
		log.info("selectFrcsCouponUseList->couponUseList : " + couponUseList);
		
		// 전체 행의 수
		int total = this.frcsCouponService.selectTotalFrcsCoupon(map);
		
		// 페이징 호출
		ArticlePage<EventVO> articlePage = new ArticlePage<EventVO>(total, currentPage, size, couponUseList, map);
		
		// 전체 이벤트 수
		int all = this.frcsCouponService.selectAllEventCount(map); 

		// 진행중인 이벤트 수
		int progress = this.frcsCouponService.selectProgressEventCount(map); 
				
		// 완료된 이벤트 수
		int completed = this.frcsCouponService.selectCompletedEventCount(map); 
		
		
		// 모델에 속성 추가
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("menu", this.comService.selectCom("MENU"));
		model.addAttribute("all", all);
		model.addAttribute("progress", progress);
		model.addAttribute("completed", completed);
		
		return "frcs/selectFrcsCouponUseList";
	}
	
}
