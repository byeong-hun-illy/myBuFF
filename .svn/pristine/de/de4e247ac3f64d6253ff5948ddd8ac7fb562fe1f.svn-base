package com.buff.hdofc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.buff.com.service.ComService;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcStockAjmtController.java
* @author       : 송예진
* @date         : 2024.10.07
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.07        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/stockAjmt")
@Controller
@Slf4j
public class HdofcStockAjmtController {
	
//	@Inject
//	HdofcStockAjmtService hdofcStockAjmtService;
	
//	@Autowired
//	ComService comService;
	
	/*
	 
	 
	 ((( 상품 소모량 했던 메소드 주석으로 가려둡니다 ))))
	 
	 
	@GetMapping("/selectStockAjmtList")
	public String selectStockAjmtList(Model model, Principal principal, 
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage
			) {
		
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		log.info("map -> :" + map);
		
		List<GdsVO> gdsVOList = this.hdofcStockAjmtService.selectStockAjmtList(map);
		log.info("gdsVOList -> :" + gdsVOList);
		
		int total = this.hdofcStockAjmtService.stockAjmtTotalCnt(map);
		log.info("total -> :" + total);
		
		ArticlePage<GdsVO> articlePage = 
				new ArticlePage<GdsVO>(total, currentPage, 10, gdsVOList, map);
		
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("gd", this.comService.selectCom("GD"));
		model.addAttribute("total", total);
		
		return "hdofc/stockAjmt/selectStockAjmtList";
	}
	
	*/
	
	@GetMapping("/list")
	public String selectStockAjmt(Model model) {
		return "hdofc/gds/selectStockAjmt";
	}
	
	@GetMapping("/regist")
	public String insertStockAjmt() {
		return "hdofc/gds/insertStockAjmt";
	}
	
}
