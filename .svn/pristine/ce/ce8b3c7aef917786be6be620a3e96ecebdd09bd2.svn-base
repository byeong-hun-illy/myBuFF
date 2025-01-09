package com.buff.cnpt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.buff.com.mapper.ComMapper;
import com.buff.com.service.DealService;

/**
* @packageName  : com.buff.cnpt.controller
* @fileName     : CnptDealController.java
* @author       : 송예진
* @date         : 2024.09.28
* @description  : 거래처 납품
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.28        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_CNPT')")
@RequestMapping("/cnpt/deal")
@Controller
public class CnptDealController {
	
	@Autowired
	DealService dealService;
	
	@Autowired
	ComMapper comMapper;
	
	// 발주나 납품 페이지로 이동
	@GetMapping("/list")
	public String selectDeal(Model model) {
		model.addAttribute("deli", this.comMapper.selectCom("DELI"));
		return "cnpt/deal/selectDeal";
	}
	
	/**
	* @methodName  : selectDealDtl
	* @author      : 송예진
	* @date        : 2024.09.26
	* @return      : 가맹점 상세 이동
	*/
	@GetMapping("/dtl")
	public String selectDealDtl() {
		return "cnpt/deal/selectDealDtl";
	}
	
}
