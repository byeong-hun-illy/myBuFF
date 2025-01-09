package com.buff.cust.controller;

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

import com.buff.cust.service.CustHomeService;
import com.buff.cust.service.CustOrdrService;
import com.buff.vo.BzentVO;
import com.buff.vo.CouponVO;
import com.buff.vo.MenuVO;
import com.buff.vo.OrdrVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/cust/ordr")
@Slf4j
@PreAuthorize("hasRole('ROLE_CUST')")
public class CustOrdrController {
	
	@Autowired
	CustOrdrService ordrService;
	
	@Autowired
	CustHomeService HomeServcie;
	
	/**
	 * @methodName  : insertOrdr
	 * @author      : 서윤정
	 * @date        : 2024.09.12
	 * @param : BzentVO
	 * @return 고객 _ 주문 시 가맹점 조회,
	 * 모달로 표현시, 가맹점 전체 갯수 조회 가능, 카드로 가맹점의 정보 조회
	 * 
	 */
	@GetMapping("/regist")
	public String insertOrdr(@RequestParam Map<String, Object> map, Model model, Principal principal) {
		
		String mbrId = principal.getName();
		map.put("mbrId", mbrId);

		List<BzentVO> bzentVOList = HomeServcie.selectOrdrStore(map);
		int total = HomeServcie.getTotal(map);
		log.info("selectStore -> total :" + total);
		 
		model.addAttribute("bzentVOList", bzentVOList);
		
		model.addAttribute("total", total);

		return "cust/main/insertOrdr";
	}

	/**
	* @methodName  : selectFrcsMenu
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param map
	* @return      : 메뉴 조회
	*/
	@ResponseBody
	@GetMapping("/selectMenu")
	public List<MenuVO> selectFrcsMenu(@RequestParam Map<String, Object> map) {
		return this.ordrService.selectOrdrMenu(map);
	}
	
	/**
	* @methodName  : selectCoupon
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param mbrId
	* @return      : 고객이 사용할 수 있는 쿠폰 전체 조회
	*/
	@ResponseBody
	@PostMapping("/selectCoupon")
	public List<CouponVO> selectCoupon(@RequestParam String mbrId){
		return this.ordrService.selectCoupon(mbrId);
	}
	
	/**
	* @methodName  : insertOrdr
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param ordrVO 
	* @return      : 주문
	*/
	@ResponseBody
	@PostMapping("/insertOrdr")
	public String insertOrdr(@RequestBody OrdrVO ordrVO) {
		int cnt = this.ordrService.insertOrdr(ordrVO);
		return ordrVO.getOrdrNo();
	}
}
