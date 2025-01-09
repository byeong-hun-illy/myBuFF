package com.buff.frcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.buff.frcs.service.FrcsStockAjmtService;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsStockAjmtController.java
* @author       : 정현종
* @date         : 2024.09.30
* @description  : 가맹점 재고 조정 내역 조회 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30        정현종     	  			최초 생성
* 2024.10.07        송예진     	  			재고 조정 수정
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs/stockAjmt")
@Slf4j
@Controller
public class FrcsStockAjmtController {

	@Autowired
	FrcsStockAjmtService frcsStockAjmtService;
	
	/**
	* @methodName  : selectStockAjax
	* @author      : 
	* @date        : 
	* @param model
	* @return	   : 재고 조정 현황 이동
	*/
	@GetMapping("/list")
	public String selectStockAjax(Model model) {
		return "frcs/gds/selectStockAjmt";
	}
	
	/**
	* @methodName  : insertStockAjmt
	* @author      : 
	* @date        : 
	* @param model
	* @return      : 재고 조정 등록이동
	*/
	@GetMapping("/regist")
	public String insertStockAjmt(Model model) {
		return "frcs/gds/insertStockAjmt";
	}
	
	/*
	
	
	* @methodName  : selectFrcsStockAjmtList
	* @author      : 
	* @date        : 2024.09.30
	* @param       : model, map(principal, gdsClass, gdsType, gdsNm, tartYmd, endYmd
	* 					       ,ajmtType, ajmtRsn, currentPage)
	* @return	   : 재고 조정 내역 조회
	
	@GetMapping("/stockAjmtList")
	public String selectFrcsStockAjmtList(Model model, Principal principal,
			@RequestParam(name = "ajmtType", required = false, defaultValue = "") String ajmtType,
			@RequestParam(name = "startYmd", required = false, defaultValue = "") String startYmd,
			@RequestParam(name = "endYmd", required = false, defaultValue = "") String endYmd,
			@RequestParam(name = "ajmtRsn", required = false, defaultValue = "") String ajmtRsn,
			@RequestParam(name = "gdsClass", required = false, defaultValue = "") String gdsClass,
			@RequestParam(name = "gdsType", required = false, defaultValue = "") String gdsType,
			@RequestParam(name = "gdsNm", required = false, defaultValue = "") String gdsNm,
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage
			) {
		
		//principal.getName() : 로그인 한 아이디
		String mbrId = principal.getName();
		log.info("mbrId : " + mbrId);		
		
		int size = 10;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);              // 아이디
		map.put("ajmtType", ajmtType);        // 조정유형(주문,폐기)
		map.put("startYmd", startYmd);        // 조정기간(시작)
		map.put("endYmd", endYmd);            // 조정기간(끝)
		map.put("ajmtRsn", ajmtRsn);          // 조정사유
		map.put("gdsClass", gdsClass);        // 상품 대유형
		map.put("gdsType", gdsType);          // 상품 소유형
		map.put("gdsNm", gdsNm);              // 상품명
		map.put("currentPage", currentPage);  // 현재페이지
		map.put("size", size);                // 페이징 크기
		
		// 재고 조정 내역
		List<GdsVO> stockAjmtList = this.frcsStockAjmtService.selectFrcsStockAjmtList(map);
		log.info("stockAjmtList -> " + stockAjmtList);
		
		// 전체 행의 수
		int total = this.frcsStockAjmtService.selectTotalFrcsStockAjmt(map);
		
		// 전체 유형 수
		int all = this.frcsStockAjmtService.selectAllStockAjmtCount(map);
		
		// 주문 유형 행의 수
		int order = this.frcsStockAjmtService.selectOrderStockAjmtCount(map);
		
		// 폐기 유형 행의 수
		int dispose = this.frcsStockAjmtService.selectDisposeStockAjmtCount(map);
		
		// 페이징
		ArticlePage<GdsVO> articlePage = new ArticlePage<GdsVO>(total, currentPage, size, stockAjmtList, map);
		
		// 모델 속성추가
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("all", all);
		model.addAttribute("order", order);
		model.addAttribute("dispose", dispose);
		
		// jsp
		return "frcs/selectFrcsStockAjmtList";
	}
	
	*/
	
}
