package com.buff.hdofc.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ROLE_HDOFC')")
@Controller
@RequestMapping("/hdofc/clcln")
public class HdofcClclnController {
	
	@GetMapping("/list")
	public String selectClcln() {
		return "hdofc/clcln/selectClcln";
	}
	
	@GetMapping("/dtl")
	public String selectClclnDtl() {
		return "hdofc/clcln/selectClclnDtl";
	}
	
}
