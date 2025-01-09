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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.cust.mapper.MemberMapper;
import com.buff.frcs.service.FrcsSlsService;
import com.buff.util.ArticlePage;
import com.buff.vo.OrdrVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsSlsController.java
* @author       : 정현종
* @date         : 2024.10.03
* @description  : 가맹점 기간별 매출 Controller
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.03        정현종     	  			최초 생성
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsSlsController {
	
	@Autowired
	FrcsSlsService frcsSlsService;
	 
	@Autowired
	ComService comservice;
	
	@Autowired
	MemberMapper memberMapper;
	
	/**
	* @methodName  : selectFrcsPeriodSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param       : model, principal, startYmd, endYmd, currentPage
	* @return	   : 검색조건에 맞는 기간별 매출 조회 리스트
	*/
	@GetMapping("/periodSlsList")
	public String selectFrcsPeriodSlsList(Model model, Principal principal,
			@RequestParam(name = "startYmd", required = false, defaultValue = "") String startYmd, // 시작 날짜
			@RequestParam(name = "endYmd", required = false, defaultValue = "") String endYmd, // 끝 날짜
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage // 현재 페이지
			) {
		
		// 로그인한 아이디
		String mbrId = principal.getName();
		log.info("selectFrcsPeriodSlsList -> mbrId :" + mbrId);
		
		// 페이징 크기
		int size = 5;
		
		// 파라미터
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId); // 로그인한 아이디
		map.put("startYmd", startYmd); // 시작 날짜
		map.put("endYmd", endYmd); // 끝 날짜
		map.put("currentPage", currentPage); // 현재 페이지
		map.put("size", size); // 페이징 크기
		log.info("selectFrcsPeriodSlsList -> map :" + map);
		
		// 검색조건에 맞는 총 행의 수
		int total = this.frcsSlsService.selectTotalFrcsPeriodSlsList(map);
		log.info("selectFrcsPeriodSlsList -> total :" + total);
		
		// 검색조건에 맞는 기간별 매출 리스트
		List<OrdrVO> periodFrcsSlsList = this.frcsSlsService.selectFrcsPeriodSlsList(map);
		log.info("selectFrcsPeriodSlsList -> periodFrcsSlsList :" + periodFrcsSlsList);
		
		// 페이징
		ArticlePage<OrdrVO> articlePage = new ArticlePage<OrdrVO>(total, currentPage, size, periodFrcsSlsList, map);
		log.info("selectFrcsPeriodSlsList -> articlePage :" + articlePage);
		
		// 검색조건에 맞는 총 매출액
		long totalOrdrAmt = this.frcsSlsService.selectFrcsPeriodSlsTotalAmt(map);
		log.info("selectFrcsPeriodSlsList -> totalOrdrAmt :" + totalOrdrAmt);
		
		// 당일 매출 금액
		long dailySales = this.frcsSlsService.selectdailySales(map);
		log.info("selectFrcsPeriodSlsList -> dailySales :" + dailySales);
		
		// 최고 일일 매출 금액
		long maxDailySales = this.frcsSlsService.selectmaxDailySales(map);
		log.info("selectFrcsPeriodSlsList -> maxDailySales :" + maxDailySales);
		
		// 모델 속성 추가
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("totalOrdrAmt", totalOrdrAmt);
		model.addAttribute("dailySales", dailySales);
		model.addAttribute("maxDailySales", maxDailySales);
		
		return "frcs/selectFrcsPeriodSlsList";
	}
	
	/**
	* @methodName  : selectFrcsSls
	* @author      : 정현종
	* @date        : 2024.10.14
	* @param 	   : date
	* @return      : 가맹점 매출
	*/
	@ResponseBody
	@PostMapping("/getAmt")
	public List<OrdrVO> selectfrcsSlsList(Principal principal, @RequestParam String date){
		
		// 로그인한 아이디
		String mbrId = principal.getName();
		log.info("selectfrcsSlsList -> mbrId :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);
		map.put("date", date);
		log.info("selectfrcsSlsList -> map :" + map);
		
		List<OrdrVO> frcsSlsList =  this.frcsSlsService.selectfrcsSlsList(map);
		log.info("selectfrcsSlsList -> frcsSlsList :" + frcsSlsList);

		return frcsSlsList;
	}
}
