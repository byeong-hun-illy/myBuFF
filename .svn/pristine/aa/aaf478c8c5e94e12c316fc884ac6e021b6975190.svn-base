package com.buff.cnpt.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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

import com.buff.cnpt.service.CnptGdsService;
import com.buff.cnpt.service.CnptStockService;
import com.buff.com.service.ComService;
import com.buff.cust.mapper.MemberMapper;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.MemberVO;
import com.buff.vo.StockVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cnpt.controller
* @fileName     : CnptStockController.java
* @author       : 이병훈
* @date         : 2024.10.01
* @description  : 거래처 재고관련 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        이병훈     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_CNPT')")
@Slf4j
@Controller
@RequestMapping("/cnpt")
public class CnptStockController {

	@Autowired
	ComService comService;
	
	@Autowired
	CnptGdsService cnptGdsService;
	
	@Autowired
	CnptStockService cnptStockService;
	
	@Autowired
	MemberMapper memberMapper;
	
	
	/**
	* @methodName  : insertStockQty
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	* @param model
	* @return  	   : 재고 추가 페이지로 이동
	*/
	@GetMapping("/stock/insertStockQty")
	public String insertStockQty(@RequestParam(required = false) String gdsCode,
								Model model) {
		String gdsNm = "";
	    if (gdsCode != null && !gdsCode.isEmpty()) {
	        gdsNm = this.cnptStockService.selectGdsNm(gdsCode);  // 상품명이 있을 때만 조회
	    }
	    model.addAttribute("gdsCode", gdsCode);
	    model.addAttribute("gdsNm", gdsNm != null ? gdsNm : "상품명을 선택하세요");  // 기본 메시지 설정
		return "cnpt/gds/insertStockQty";
	}
	
	
	/**
	* @methodName  : insertStockQtyAjax
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param map
	* @return      : 재고 추가 페이지 출력
	*/
	@PostMapping("/stock/insertStockQtyAjax")
	@ResponseBody
	public int insertStockQtyAjax(@RequestBody Map<String, Object> map) {
		 log.info("Received gdsCode: " + map.get("gdsCode"));
		 log.info("Received stockVO: " + map.get("stockVO"));
		 log.info("Received stockAjmtVO: " + map.get("stockAjmtVO"));
		
		int result = this.cnptStockService.insertStockQty(map);
		
		return result;
			 
	}
	
	/**
	* @methodName  : selectGdsList
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param bzentNo
	* @return      : 해당 거래처의 보유 상품 리스트
	*/
	@GetMapping("/stock/selectGdsList")
	@ResponseBody
	public List<GdsVO> selectGdsList(@RequestParam String bzentNo){
		log.info("selectGdsList 컨트롤러에 들어옴");
		return this.cnptStockService.selectGdsList(bzentNo);
	}
	
	
	/**
	* @methodName  : downloadTemp
	* @author      : 이병훈
	* @date        : 2024.10.02
	* @param response
	* @param bzentNo
	* @description : 재고 양식 엑셀 파일 다운로드
	*/
	@GetMapping("/stock/downloadTemp")
	public void downloadTemp(HttpServletResponse response,
						     @RequestParam String bzentNo) {
		try {
			this.cnptStockService.downloadTemp(response, bzentNo);
		} catch (Exception e) {
			log.error("TempExcel download error : ", e);
			// 이미 전송된 응답이 있으면 초기화
			response.reset();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
	}
	

	
	/**
	* @methodName  : insertNewStock
	* @author      : 이병훈
	* @date        : 2024.10.02
	* @param model
	* @param principal
	* @return      : 신규 거래처일 경우, 신규 기초재고 입고 페이지 이동
	*/
	@GetMapping("/stock/insertNewStock")
	public String insertNewStock(Model model, Principal principal) {
		String mbrId = principal.getName();
		MemberVO memberVO = this.memberMapper.getLogin(mbrId);
		// 거래처 번호 가져오기
		String bzentNo = memberVO.getBzentNo();
		// 거래처 유형 가져오기
		String bzentType = this.cnptGdsService.selectBzentType(bzentNo);
		
		// 상품 총 목록
		List<GdsVO> gdsAllList = this.cnptStockService.selectGdsAll(bzentType);
		// log.info("gdsAllList : " + gdsAllList);
		
		model.addAttribute("mbrId", mbrId);
		model.addAttribute("bzentType", bzentType);
		model.addAttribute("gdsAllList", gdsAllList);
		// 해당 JSP로 이동
		return "cnpt/gds/insertNewStock";
		
	}
	
	/**
	* @methodName  : saveNewGds
	* @author      : 이병훈
	* @date        : 2024.10.05
	* @param map   
	* @return      : 신규 거래처가 신규 재고 등록
	*/
	@PostMapping("/stock/insertNewAll")
	@ResponseBody
	public Map<String, Object> insertNewAll(@RequestBody Map<String, Object> map,
											Principal principal){
		log.info("insertNewAll 컨트롤러 들어옴");
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			
			// 상품 정보를 먼저 추출
			List<Map<String, Object>> gdsList = (List<Map<String, Object>>) map.get("gdsList");
			
			String mbrId = principal.getName();
			
			log.info("mbrId : {}" , mbrId);
			for(Map<String, Object> gdsData : gdsList) {
				gdsData.put("mbrId", mbrId);
			}
			
			// 서비스에서 바로 처리
			this.cnptStockService.insertNewAll(gdsList);
			
			// 성공적인 응답
			response.put("status", "success");
			response.put("message", "상품 등록이 완료되었습니다.");
		}  catch (RuntimeException e) {
	        // 이미 등록된 상품일 경우 경고 메시지 전송
	        response.put("status", "error");
	        response.put("message", e.getMessage());
	        
	    }  catch (Exception e) {
			response.put("status", "error");
			response.put("message", "상품 등록 도중 오류가 발생했습니다.");
			
			return response;
		}
		return response; 
		
	}

	
	
	
}
