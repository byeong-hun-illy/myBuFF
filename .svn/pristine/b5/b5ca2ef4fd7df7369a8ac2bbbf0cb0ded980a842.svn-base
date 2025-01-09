package com.buff.hdofc.controller;

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
import com.buff.com.service.DealService;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.StockPoVO;
import com.buff.vo.StockVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/deal")
@Slf4j
public class HdofcDealController {

	@Autowired
	DealService dealService;
	
	@Autowired
	ComService comService;
	
	// 발주나 납품 페이지로 이동
	@GetMapping("/list")
	public String selectDeal(Model model) {
		model.addAttribute("deli", this.comService.selectCom("DELI"));
		return "hdofc/deal/selectDeal";
	}
	
	/**
	* @methodName  : selectDealDtl
	* @author      : 송예진
	* @date        : 2024.09.26
	* @return      : 가맹점 상세 이동
	*/
	@GetMapping("/dtl")
	public String selectDealDtl() {
		return "hdofc/deal/selectDealDtl";
	}
	
	/**
	* @methodName  : insertPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @return      : 발주 페이지 이동
	*/
	@GetMapping("/regist")
	public String insertPo() {
		return "hdofc/deal/insertPo";
	}
	
	/**
	* @methodName  : selectCnptGdsAjax
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param gdsCode
	* @return      : 거래처 추가
	*/
	@PostMapping("/cnptGds")
	@ResponseBody
	public Map<String, Object> selectCnptGdsAjax(@RequestParam String gdsCode){
		Map<String, Object> map = new HashMap<String, Object>();
		List<StockVO> cnpt = this.dealService.selectCnptGds(gdsCode);
		map.put("cnpt", cnpt);
		List<GdsAmtVO> amt = this.comService.selectMinAmt(gdsCode);
		map.put("min", amt);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/registAjax")
	public int insertDealAjax(@RequestBody Map<String, List<StockPoVO>> bzentNoGroups) {
		return this.dealService.insertDealAjax(bzentNoGroups);
	}
	
}
