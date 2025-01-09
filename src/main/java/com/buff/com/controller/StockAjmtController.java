package com.buff.com.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.StockAjmtService;
import com.buff.hdofc.service.HdofcGdsService;
import com.buff.util.ArticlePage;
import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/com/stockAjmt")
public class StockAjmtController {

	@Autowired
	StockAjmtService ajmtService;
	
	/**
	* @methodName  : selectStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param map   : 필수 bzent_no
	* @return      : 재고 조정 조회
	*/
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectStockAjmt(@RequestParam Map<String,Object> map) {
	    int size = 10;
	    // 사이즈를 다르게 주고싶은 경우에 직접 map을 보내게 했음 만약 없으면 10으로 넣음
 		if(map.containsKey("size")) {
 			size = Integer.parseInt((String) map.get("size"));
 		} else {
 			map.put("size", size);
 		}
	    List<StockAjmtVO> ajmtList = this.ajmtService.selectStockAjmt(map);
	    Map<String, Object> response = this.ajmtService.selectTotalStockAjmt(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<StockAjmtVO>(total, currentPage, size, ajmtList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : deleteStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param ajmtNo
	* @return      : 재고 조정 삭제 ajmt01과 ajmt02만 가능
	*/
	@PostMapping("/deleteAjax")
	@ResponseBody
	public int deleteStockAjmt(@RequestParam String ajmtNo) {
		return this.ajmtService.deleteAjmt(ajmtNo);
	}
	
	/**
	* @methodName  : insertStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param stockAjmtVO
	* @return      : ajmt02 로 상품 조정 (폐기처리)
	*/
	@PostMapping("/insertAjax")
	@ResponseBody
	public int insertStockAjmt(@RequestBody StockAjmtVO stockAjmtVO) {
		return this.ajmtService.insertAjmt(stockAjmtVO);
	}
	
	/**
	* @methodName  : selectStockAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 리스트 Ajax
	*/
	@ResponseBody
	@GetMapping("/stockListAjax")
	public Map<String, Object> selectStockAjax(@RequestParam Map<String, Object> map){
		int size = 10;
		// 사이즈를 다르게 주고싶은 경우에 직접 map을 보내게 했음 만약 없으면 10으로 넣음
		if(map.containsKey("size")) {
			size = Integer.parseInt((String) map.get("size"));
		} else {
			map.put("size", size);
		}
		// 데이터
	    List<GdsVO> gdslist = this.ajmtService.selectStock(map);
	    // 구분 숫자를 담은 데이터
	    Map<String, Object> response = this.ajmtService.selectTotalStock(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<GdsVO>(total, currentPage, size, gdslist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
}
