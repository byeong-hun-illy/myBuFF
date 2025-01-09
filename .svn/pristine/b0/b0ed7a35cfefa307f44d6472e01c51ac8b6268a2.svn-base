package com.buff.hdofc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcCouponController.java
* @author       : 정기쁨
* @date         : 2024.09.14
* @description  : 쿠폰조회, 쿠폰추가, 쿠폰삭제, 쿠폰상세조회
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.14        정기쁨     	  	   최초 생성
*/
@Slf4j
@RequestMapping("/hdofc/coupon")
@Controller
public class HdofcCouponController {

	
	@GetMapping("/selectCouponList")
	public String selectCouponList() {
		
		log.info("selectCouponList으로 접근 완료");
		
		return "hdofc/coupon/selectCouponList";
	}
	
}
