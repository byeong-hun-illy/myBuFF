package com.buff.frcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.FrcsClclnService;
import com.buff.vo.FrcsClclnVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsFrcsClclnController.java
* @author       : 송예진
* @date         : 2024.10.06
* @description  : 가맹점 월간정산
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.06        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_FRCS')")
@Controller
@RequestMapping("/frcs/frcsClcln")
@Slf4j
public class FrcsFrcsClclnController {
	
	@Autowired
	FrcsClclnService clclnService;
	
	@GetMapping("/list")
	public String selectFrcsClcln(Model model) {
	    return "frcs/clcln/selectFrcsClcln";
	}
	
	@GetMapping("/dtl")
	public String selectFrcsClclnDtl() {
		return "frcs/clcln/selectFrcsClclnDtl";
	}
	
	@PostMapping("/updateClcln")
	@ResponseBody
	public int updateClcln(@RequestBody FrcsClclnVO frcsClclnVO) {
		return this.clclnService.updateFrcsClcln(frcsClclnVO);
	}
	

}
