package com.buff.frcs.controller;

import java.security.Principal;
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

import com.buff.frcs.service.FrcsNetProfitService;
import com.buff.util.ArticlePage;
import com.buff.vo.FrcsSlsVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsNetProfitController.java
* @author       : 정현종
* @date         : 2024.10.08
* @description  : 가맹점 순이익 controller
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.08        정현종     	  			최초 생성
* 2024.10.14        송예진     	  			순수익 수정
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsNetProfitController {
	
	@Autowired
	FrcsNetProfitService frcsNetProfitService;
	
	/**
	* @methodName  : selectFrcsNetProfit
	* @author      : 정현종
	* @date        : 2024.10.08
	* @param model
	* @return	   : 가맹점 순이익 조회 페이지로 이동
	*/
	@GetMapping("/netProfitList")
	public String selectFrcsNetProfitList(Model model , Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId : " + mbrId);
		model.addAttribute("cnt", this.frcsNetProfitService.selectInsertChk(mbrId));
		return "frcs/selectFrcsNetProfitList";
	}
	
	/**
	* @methodName  : selectFrcsNetProfitDtl
	* @author      : 
	* @date        : 
	* @return	   : 가맹점 순이익 상세 페이지로 이동
	*/
	@GetMapping("/netProfitDtl")
	public String selectFrcsNetProfitDtl() {
		return "frcs/selectFrcsNetProfitDtl";
	}
	
	@ResponseBody
	@GetMapping("/netProfitListAjax")
	public ArticlePage<FrcsSlsVO> selectFrcsNetProfitListAjax(@RequestParam Map<String, Object> map){
		int size = 10;
		map.put("size", size);
		List<FrcsSlsVO> frcsList = this.frcsNetProfitService.selectFrcsNetProfitList(map);
	    int total = this.frcsNetProfitService.selectTotalFrcsNetProfit(map);
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    return new ArticlePage<FrcsSlsVO>(total, currentPage, size, frcsList, map);
	}
	
	@PostMapping("/updateNetProfitAjax")
	@ResponseBody
	public int updateNetProfitAjax(@RequestBody FrcsSlsVO frcsSlsVO) {
		return this.frcsNetProfitService.updateNetProfitAjax(frcsSlsVO);
	}
	
	/**
	* @methodName  : insertSls
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param bzentNo
	* @return      : 등록
	*/
	@ResponseBody
	@PostMapping("/insertNetPorfitAjax")
	public int insertSls(@RequestParam String bzentNo) {
		return this.frcsNetProfitService.insertSls(bzentNo);
	}
	
	/**
	* @methodName  : selectDtl
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param frcsSlsVO
	* @return      : 상세
	*/
	@ResponseBody
	@PostMapping("/netProfitDtlAjax")
	public FrcsSlsVO selectDtl(@RequestBody FrcsSlsVO frcsSlsVO) {
		return this.frcsNetProfitService.selectSlsDtl(frcsSlsVO);
	}
}
