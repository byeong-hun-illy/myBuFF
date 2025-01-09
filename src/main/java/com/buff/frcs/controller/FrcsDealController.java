package com.buff.frcs.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.buff.util.ArticlePage;
import com.buff.vo.FrcsVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockPoVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cnpt.controller
* @fileName     : FrcsDealController.java
* @author       : 송예진
* @date         : 2024.09.28
* @description  : 거래처 납품
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.28        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs/deal")
@Controller
@Slf4j
public class FrcsDealController {
	
	@Autowired
	DealService dealService;
	
	@Autowired
	ComService comService;
	
	// 발주나 납품 페이지로 이동
	@GetMapping("/list")
	public String selectDeal(Model model, Principal principal) {
		String mbrId = principal.getName();
		model.addAttribute("deli", this.comService.selectCom("DELI"));
		// clsbiz의 날짜 형식이 YYYYMMDD라 가정하고 문자열을 Date로 변환
		String clsbiz = this.comService.selectFrcsInfo(mbrId);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date clsbizDate = null;
		Date today = new Date();
		boolean isFutureDate = false; // 미래 날짜 여부
		if (clsbiz != null && !clsbiz.trim().isEmpty()) {
		    try {
		        clsbizDate = sdf.parse(clsbiz);
		        if (clsbizDate.before(today)) {
	                isFutureDate = true; // clsbizDate가 미래 날짜인 경우 true 설정
	            }
		    } catch (ParseException e) {
		        e.printStackTrace();
		    }
		}
		log.info("확인 >>>>> "+clsbiz);
		log.info("확인 >>>>> "+isFutureDate);
		 // JSP에 미래 날짜 여부를 전달
		model.addAttribute("clsbiz", isFutureDate);
		return "frcs/deal/selectDeal";
	}
	
	/**
	* @methodName  : selectDealDtl
	* @author      : 송예진
	* @date        : 2024.09.28
	* @return      : 가맹점 상세 이동
	*/
	@GetMapping("/dtl")
	public String selectDealDtl() {
		return "frcs/deal/selectDealDtl";
	}
	
	@GetMapping("/regist")
	public String insertPo() {
		return "frcs/deal/insertPo";
	}
	
	/**
	* @methodName  : selectFrcsGdsAjax
	* @author      : 송예진
	* @date        : 2024.09.29
	* @param map
	* @return      : 가맹점이 시킬 수 있는 상품 리스트
	*/
	@ResponseBody
	@GetMapping("/frcsGdsList")
	public Map<String, Object> selectFrcsGdsAjax(@RequestParam Map<String, Object> map){
		int size = 10;
		// 사이즈를 다르게 주고싶은 경우에 직접 map을 보내게 했음 만약 없으면 10으로 넣음
		if(map.containsKey("size")) {
			size = Integer.parseInt((String) map.get("size"));
		} else {
			map.put("size", size);
		}
		// 데이터
	    List<GdsVO> gdslist = this.dealService.selectFrcsGds(map);
	    // 구분 숫자를 담은 데이터
	    Map<String, Object> response = this.dealService.selectTotalFrcsGds(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<GdsVO>(total, currentPage, size, gdslist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : selectFrcsCart
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param bzentNo
	* @return      : 해당 가맹점번호를 입력하면 안전재고 이하의 제품의 물품 전체 출력
	*/
	@ResponseBody
	@PostMapping("/frcsGdsCart")
	public List<GdsVO> selectFrcsCart(@RequestParam String bzentNo){
		return this.dealService.selectFrcsSfGds(bzentNo);
	} 
	
	@ResponseBody
	@PostMapping("/registAjax")
	public int insertPo(@RequestBody Map<String, Object> map) {
		return this.dealService.insertFrcsPo(map);
	}
}
