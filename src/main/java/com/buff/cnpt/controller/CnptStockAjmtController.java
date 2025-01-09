package com.buff.cnpt.controller;

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
@PreAuthorize("hasRole('ROLE_CNPT')")
@RequestMapping("/cnpt/stockAjmt")
@Controller
@Slf4j
public class CnptStockAjmtController {
	
	@GetMapping("/list")
	public String selectStockAjax(Model model) {
		return "cnpt/gds/selectStockAjmt";
	}
	
}
