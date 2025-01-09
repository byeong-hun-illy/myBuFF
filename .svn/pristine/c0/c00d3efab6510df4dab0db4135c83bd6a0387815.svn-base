package com.buff.cnpt.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cnpt.service.CnptMainService;
import com.buff.com.mapper.ComMapper;
import com.buff.com.service.DealService;
import com.buff.cust.mapper.MemberMapper;
import com.buff.util.ArticlePage;
import com.buff.vo.CnptCntVO;
import com.buff.vo.MemberVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;

import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasRole('ROLE_CNPT')")
@RequestMapping("/cnpt")
@Slf4j
@Controller
public class CnptMainController {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	CnptMainService cnptMainService;
	
	@Autowired
	DealService dealService;
	
	@Autowired
	ComMapper comMapper;
	
	
	/**
	* @methodName  : main
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param model
	* @param principal
	* @return      : 거래처 메인페이지 이동
	*/
	@GetMapping("/main")
	public String main(Model model, Principal principal) {
		String mbrId = principal.getName();
		MemberVO memberVO = this.memberMapper.getLogin(mbrId);
		String bzentNo = memberVO.getBzentNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bzentNo", bzentNo);
		
		// 메인 검색 필요 갯수
		CnptCntVO cnt = this.cnptMainService.selectCnt(map);
		
		// 매출 금액 가져오기
		long totalSalesAmount = this.cnptMainService.selectTotalSalesAmount(map);
		
		// 1년간 미정산 금액 가져오기
		long totalNotClclnAmount = this.cnptMainService.selectTotalNotClclnAmount(map);
		
		// 서버로 bzentNo 값 전달
		model.addAttribute("bzentNo", bzentNo);
		model.addAttribute("cnt", cnt);
		model.addAttribute("totalAmt", totalSalesAmount);
		model.addAttribute("totalNotClclnAmt", totalNotClclnAmount);
		model.addAttribute("deli", this.comMapper.selectCom("DELI"));
		
		return "cnpt/main/cnptMainPage";
	}
	
	/**
	* @methodName  : getSalesData
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param periodData
	* @param principal
	* @return      : 매출 데이터를 반환
	*/
	@PostMapping("/main/getSalesData")
	@ResponseBody
	public Map<String, Object> getSalesData(@RequestBody Map<String, String> periodData,
											Principal principal){
		String period = periodData.get("period");
		String mbrId = principal.getName();
		MemberVO memberVO = this.memberMapper.getLogin(mbrId);
		String bzentNo = memberVO.getBzentNo();
		
		
		// 데이터 요청을 위한 Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bzentNo", bzentNo);
		map.put("period", period);
		
		// 매출 금액 가져오기
		long totalSalesAmount = this.cnptMainService.selectTotalSalesAmount(map);
		
		// 차트 데이터 가져오기
		List<PoClclnVO> chartData = this.cnptMainService.selectSaleData(map);
		
	//	log.info("period: {}", period);
		log.info("chartData: {}", chartData);
		
		Map<String, Object> salesData = new HashMap<String, Object>();
		salesData.put("totalAmount", totalSalesAmount);
		salesData.put("chartData", chartData);
		
		// 	매출 데이터를 반환
		return salesData;
		
	}
	
	/**
	* @methodName  : getProductSalesData
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param period
	* @param principal 
	* @return      : 검색 조건에 따른 상품 매출 데이터
	*/
	@GetMapping("/main/getProductSalesData")
	@ResponseBody
	public Map<String, Object> getProductSalesData(@RequestParam String period, 
												   Principal principal){
		log.info("getProductSalesData 메소드 호출됨");

		String mbrId = principal.getName();
		MemberVO memberVO = this.memberMapper.getLogin(mbrId);
		String bzentNo = memberVO.getBzentNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bzentNo", bzentNo);
		map.put("period", period);
		
		List<PoClclnVO> productSalesData = this.cnptMainService.selectProductSales(map);
		
		log.info("period: {}", period);
		log.info("productSalesData: {}", productSalesData);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("productSalesData", productSalesData);
		
	    log.info("response : {}", response);
		
		return response;
		
	}
	
	@GetMapping("/main/selectUnApprove")
	@ResponseBody
	public Map<String, Object> selectUnApproveList(@RequestParam Map<String, Object> map,
												   Principal principal){
		String mbrId = principal.getName();
		MemberVO memberVO = this.memberMapper.getLogin(mbrId);
		String bzentNo = memberVO.getBzentNo();
		
		log.info("bzentNo : {}", bzentNo);
		int size = 4;
		map.put("bzentNo", bzentNo);
		map.put("size", size);
		List<PoVO> polist = this.cnptMainService.selectUnApprove(map);
		
		Map<String, Object> response = new HashMap<String, Object>();
		  // 총 개수 가져오기 (이 부분이 DB에서 가져온 값이라고 가정)
	    int total = (polist != null) ? polist.size() : 0;
	    map.put("total", total);
	    
	    
	    // currentPage 값 검증
	    int currentPage = 1; // 기본값 설정
	    try {
	        currentPage = Integer.parseInt((String) map.getOrDefault("currentPage", "1"));
	    } catch (NumberFormatException e) {
	        log.error("Invalid currentPage value, defaulting to 1", e);
	    }
		// 분류 숫자 계산
		// 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<PoVO>(total, currentPage, size, polist, map));
	    
	    return response;
		
	}
	
}
