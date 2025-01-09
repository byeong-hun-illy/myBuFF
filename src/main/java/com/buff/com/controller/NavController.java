package com.buff.com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.vo.NavVO;

/**
* @packageName  : com.buff.com.controller
* @fileName     : NavController.java
* @author       : 송예진
* @date         : 2024.10.11
* @description  : 메뉴 검색
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        송예진     	  			최초 생성
*/
@Controller
public class NavController {
	
	@Autowired
	ComService comService;
	
	@ResponseBody
	@GetMapping("/nav/search")
	public List<NavVO> selectNav(@RequestParam String navType){
		return this.comService.selectNav(navType);
	}
}
