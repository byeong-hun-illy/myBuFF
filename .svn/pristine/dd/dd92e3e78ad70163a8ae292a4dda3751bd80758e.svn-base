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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.frcs.service.FrcsMenuSlsService;
import com.buff.vo.MenuVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsMenuSlsController.java
* @author       : 정현종
* @date         : 2024.10.07
* @description  : 가맹점 메뉴 매출 Controller
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.07        정현종     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsMenuSlsController {
	
	@Autowired
	FrcsMenuSlsService frcsMenuSlsService;
	
	@Autowired
	ComService comservice;
	
	/**
	* @methodName  : selectFrcsMenuSlsList
	* @author      : 정현종
	* @date        : 2024.10.07
	* @param model
	* @param principal
	* @param menuType
	* @param menuNm
	* @param startYmd
	* @param endYmd
	* @return	   : 검색조건에 맞는 기간별 메뉴 매출 조회 리스트
	*/
	@GetMapping("/menuSlsList")
	public String selectFrcsMenuSlsList(Model model, Principal principal,
			@RequestParam(name = "menuType", required = false, defaultValue = "") String menuType, // 메뉴 유형
			@RequestParam(name = "menuNm", required = false, defaultValue = "") String menuNm,     // 메뉴 명
			@RequestParam(name = "startYmd", required = false, defaultValue = "") String startYmd, // 시작 날짜
			@RequestParam(name = "endYmd", required = false, defaultValue = "") String endYmd      // 끝 날짜
			) {
		
		// 로그인한 아이디
		String mbrId = principal.getName();
		log.info("selectFrcsMenuSlsList -> mbrId :" + mbrId);
		
		// 파라미터
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId); // 로그인한 아이디
		map.put("startYmd", startYmd); // 시작 날짜
		map.put("endYmd", endYmd); // 끝 날짜
		map.put("menuType", menuType); // 메뉴 유형
		map.put("menuNm", menuNm); // 메뉴 명
		log.info("selectFrcsMenuSlsList -> map :" + map);
		
		// 검색조건에 맞는 총 전체 행의 수
		int total = this.frcsMenuSlsService.selectTotalFrcsMenuSlsList(map); // 전체
		log.info("selectFrcsMenuSlsList -> total :" + total);
		
		// 검색조건에 맞는 단품,세트,사이드,음료 행의 수 
		int singleMenuCnt = this.frcsMenuSlsService.selectTotalSingle(map); // 단품
		int setMenuCnt = this.frcsMenuSlsService.selectTotalSet(map); // 세트
		int sideMenuCnt = this.frcsMenuSlsService.selectTotalSide(map); // 사이드
		int drinkMenuCnt = this.frcsMenuSlsService.selectTotalDrink(map); // 음료
		
		// 검색조건에 맞는 메뉴 매출 리스트
		List<MenuVO> frcsMenuSlsList = this.frcsMenuSlsService.selectFrcsMenuSlsList(map);
		log.info("selectFrcsMenuSlsList -> frcsMenuSlsList :" + frcsMenuSlsList);
		
		// 모델 속성 추가
		model.addAttribute("frcsMenuSlsList", frcsMenuSlsList);
		model.addAttribute("total", total);
		model.addAttribute("singleMenuCnt", singleMenuCnt);
		model.addAttribute("setMenuCnt", setMenuCnt);
		model.addAttribute("sideMenuCnt", sideMenuCnt);
		model.addAttribute("drinkMenuCnt", drinkMenuCnt);
		model.addAttribute("menu", this.comservice.selectCom("MENU"));
		
		return "frcs/selectFrcsMenuSlsList";
	}
	
	/**
	* @methodName  : selectFrcsMenuSlsListAjax
	* @author      : 정현종
	* @date        : 2024.10.07
	* @param params
	* @return	   : 메뉴별 매출 비율 차트(전체)
	*/
	@ResponseBody
	@PostMapping("/menuSlsListAjax")
	public List<MenuVO> selectFrcsMenuSlsListAjax(@RequestBody Map<String, Object> params) {
	    log.info("menuSlsListAjax -> params : " + params);

	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("bzentNo", params.get("bzentNo")); // 사업체 번호
	    map.put("startYmd", params.get("startYmd")); // 시작 날짜
	    map.put("endYmd", params.get("endYmd"));  // 끝 날짜
	    map.put("menuType", params.get("menuType"));  // 메뉴 유형

	    log.info("menuSlsListAjax -> map : " + map);

	    List<MenuVO> frcsMenuSlsList = this.frcsMenuSlsService.selectFrcsMenuSlsListAjax(map);
	    log.info("menuSlsListAjax -> frcsMenuSlsList : " + frcsMenuSlsList);
	    return frcsMenuSlsList;
	}
	
	/**
	* @methodName  : selectFrcsMenuTypeSlsListAjax
	* @author      : 정현종
	* @date        : 2024.10.15
	* @param params
	* @return	   : 메뉴별 매출 비율 차트(세트,단품,사이드,음료 선택시)
	*/
	@ResponseBody
	@PostMapping("/selectFrcsMenuTypeSlsListAjax")
	public List<MenuVO> selectFrcsMenuTypeSlsListAjax(@RequestBody Map<String, Object> params) {
		log.info("menuSlsListAjax -> params : " + params);
		 
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("bzentNo", params.get("bzentNo")); // 사업체 번호
	    map.put("startYmd", params.get("startYmd")); // 시작 날짜  
	    map.put("endYmd", params.get("endYmd")); // 끝 날짜 
	    map.put("menuType", params.get("menuType")); // 메뉴 유형
	    
	    log.info("menuSlsListAjax -> map : " + map);
	    
	    List<MenuVO> frcsMenuTypeSlsList = this.frcsMenuSlsService.selectFrcsMenuTypeSlsListAjax(map);
	    log.info("menuSlsListAjax -> frcsMenuSlsList : " + frcsMenuTypeSlsList);
	    return frcsMenuTypeSlsList;
	}
}
