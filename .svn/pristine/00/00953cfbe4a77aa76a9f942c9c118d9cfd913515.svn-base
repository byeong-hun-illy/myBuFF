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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.hdofc.service.HdofcAnalyzeService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.ComVO;
import com.buff.vo.MenuVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcAnalyzeController.java
* @author       : 김현빈
* @date         : 2024.10.05
* @description  : 본사 매출 영업분석
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.05               김현빈     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/analyze")
@Controller
@Slf4j
public class HdofcAnalyzeController {
	
	@Inject
	HdofcAnalyzeService hdofcAnalyzeService;
	
	@Inject
	ComService comService;
	
	/** 본사 영업분석 관리 페이지
	 * 요청URI : /hdofc/analyze/selectAnalyzeList
	 * 요청파라미터 : map
	 * 요청방식 : get
	 * 
	 */
	@GetMapping("/selectAnalyzeList")
	public String selectAnalyzeList(Model model, Principal principal, 
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage, 
			@RequestParam(value="menuType", required=false, defaultValue="") String menuType, 
			@RequestParam(value="menuSearch", required=false, defaultValue="") String menuSearch, 
			@RequestParam(value="bgngYmd", required=false, defaultValue="") String bgngYmd,
	        @RequestParam(value="expYmd", required=false, defaultValue="") String expYmd
			) {
		
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("menuType", menuType);
		map.put("menuSearch", menuSearch);
		map.put("bgngYmd", bgngYmd);
		map.put("expYmd", expYmd);
		log.info("map -> :" + map);
		
		List<MenuVO> menuVOList = this.hdofcAnalyzeService.selectAnalyzeList(map);
		log.info("menuVOList -> :" + menuVOList);
		
		int total = this.hdofcAnalyzeService.menuTotalCnt(map);
		log.info("total -> :" + total);
		
		Map<String, Object> tapMaxTotal = this.hdofcAnalyzeService.tapMaxTotal();
		log.info("tapMaxTotal -> :" + tapMaxTotal);
		
		MenuVO bestMenu = this.hdofcAnalyzeService.selectBestMenu(map);
		log.info("bestMenu -> :" + bestMenu);
		
		MenuVO bestDay = this.hdofcAnalyzeService.selectBestDay(map);
		log.info("bestDay -> :" + bestDay);
		
		MenuVO bestTime = this.hdofcAnalyzeService.selectBestTime(map);
		log.info("bestTime -> :" + bestTime);
		
		MenuVO totalAmt = this.hdofcAnalyzeService.selectTotalAmt(map);
		log.info("totalAmt -> :" + totalAmt);
		
		ArticlePage<MenuVO> articlePage = 
				new ArticlePage<MenuVO>(total, currentPage, 10, menuVOList, map);
		
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("menu", this.comService.selectCom("MENU"));
		model.addAttribute("total", total);
		model.addAttribute("tapMaxTotal", tapMaxTotal);
		model.addAttribute("bestMenu", bestMenu);
		model.addAttribute("bestDay", bestDay);
		model.addAttribute("bestTime", bestTime);
		model.addAttribute("totalAmt", totalAmt);
		
		return "hdofc/analyze/selectAnalyzeList";
	}
	
	/** 본사 영업분석 관리 페이지
	 * 요청URI : /hdofc/analyze/selectFrcsAnalyzeList
	 * 요청파라미터 :
	 * 요청방식 : get
	 */
	@GetMapping("/selectFrcsAnalyzeList")
	public String selectFrcsAnalyzeList(Model model) {
		// 지역 조회
		List<ComVO> rgn = this.hdofcAnalyzeService.selectCom("RGN");
		model.addAttribute("rgn",rgn);
		return "hdofc/analyze/selectFrcsAnalyzeList";
	}
	
	/** 지역 셀렉트 박스에 따른 가맹점 조회
	 * 요청URI : /hdofc/analyze/selectBzentList
	 * 요청파라미터 : rgn
	 * 요청방식 : get
	 */
	@ResponseBody
	@GetMapping("/selectBzentList")
	public List<BzentVO> selectBzentList(Model model,	@RequestParam String rgnNo) {
		// 지역에 따른 가맹점 목록
		List<BzentVO> bzentVOList = this.hdofcAnalyzeService.selectBzentList(rgnNo);
		return bzentVOList;
	}

	/** 지역 셀렉트 박스에 따른 가맹점 조회
	 * 요청URI : /hdofc/analyze/selectFrcsAnalyzeAjax
	 * 요청파라미터 : let data = {"currentPage":currentPage, "sort":sort, "orderby":orderby, 
	 * 						  "rgnNo":rgnNo, "bzentNo":bzentNo, "bgngYmd":bgngYmd, "expYmd":expYmd};
	 * 요청방식 : get
	 */
	@ResponseBody
	@PostMapping("/selectFrcsAnalyzeAjax")
	public Map<String, Object> selectFrcsAnalyzeAjax(Model model, @RequestBody Map<String, Object> map) {
		// 검색조건과 페이징 처리
		Map<String, Object> response = this.hdofcAnalyzeService.selectFrcsAnalyzeAjax(map);
		return response;
	}
	
}


























