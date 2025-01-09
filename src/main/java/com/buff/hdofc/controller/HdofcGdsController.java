package com.buff.hdofc.controller;

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

import com.buff.com.service.ComService;
import com.buff.hdofc.service.HdofcGdsService;
import com.buff.util.ArticlePage;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcGdsController.java
* @author       : 송예진
* @date         : 2024.09.25
* @description  : 본사 재고관리, 상품 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.25        송예진     	  			최초 생성
*/
@Controller
@RequestMapping("/hdofc/gds")
@PreAuthorize("hasRole('ROLE_HDOFC')")
@Slf4j
public class HdofcGdsController {
	
	@Autowired
	HdofcGdsService gdsService;
	
	@Autowired
	ComService comService;
	
	/**
	* @methodName  : selectStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param model
	* @return      : 페이지 이동
	*/
	@GetMapping("/list")
	public String selectStock(Model model) {
		return "hdofc/gds/selectStock";
	}
	
	/**
	* @methodName  : selectStockAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 리스트 Ajax
	*/
	@ResponseBody
	@GetMapping("/listAjax")
	public Map<String, Object> selectStockAjax(@RequestParam Map<String, Object> map){
		int size = 10;
		// 사이즈를 다르게 주고싶은 경우에 직접 map을 보내게 했음 만약 없으면 10으로 넣음
		if(map.containsKey("size")) {
			size = Integer.parseInt((String) map.get("size"));
		} else {
			map.put("size", size);
		}
		// 데이터
	    List<GdsVO> gdslist = this.gdsService.selectStock(map);
	    // 구분 숫자를 담은 데이터
	    Map<String, Object> response = this.gdsService.selectTotalStock(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<GdsVO>(total, currentPage, size, gdslist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : insertGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @return      : 상품 추가로 이동
	*/
	@GetMapping("/regist")
	public String insertGds() {
		return "hdofc/gds/selectStockDtl";
	}
	
	/**
	* @methodName  : insertGdsAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @return      : 상품 추가/단가추가
	*/
	@PostMapping("/registAjax")
	@ResponseBody
	public String insertGdsAjax(@RequestBody Map<String, Object> map) {
	    return this.gdsService.insertAllGds(map);
	}
	
	////////////////////////// 상세
	/**
	* @methodName  : selectStockDtl
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param model
	* @param gdsCode
	* @return 상세페이지로 이동
	*/
	@GetMapping("/dtl")
	public String selectStockDtl(Model model, @RequestParam String gdsCode) {
		return "hdofc/gds/selectStockDtl";
	}
	
	/**
	* @methodName  : selectGdsDtlAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param stockVO
	* @return 상세 내용 출력
	*/
	@PostMapping("/dtlAjax")
	@ResponseBody
	public Map<String, Object> selectGdsDtlAjax(@RequestBody StockVO stockVO){
		Map<String, Object> map = new HashMap<String, Object>();
		GdsVO gdsVO = this.gdsService.selectStockDtl(stockVO); // 상품 정보
		map.put("gds", gdsVO);
		int chk = this.gdsService.selectUpdateChk(stockVO); // 상품정보 수정가능한지 확인
		map.put("chk", chk);
		List<GdsAmtVO> min = this.comService.selectMinAmt(gdsVO.getGdsCode());
		map.put("min", min);
		return map;
	}
	
	/**
	* @methodName  : deleteGdsAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsCode
	* @return 재고가 없을때 삭제
	*/
	@PostMapping("/deleteAjax")
	@ResponseBody
	public int deleteGdsAjax(@RequestParam String gdsCode) {
		return this.gdsService.deleteGds(gdsCode);
	}
	
	/**
	* @methodName  : updateGdsAjax
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsVO
	* @return 재고가 없을 때 수정
	*/
	@PostMapping("/updateAjax")
	@ResponseBody
	public int updateGdsAjax(@RequestBody GdsVO gdsVO) {
		return this.gdsService.updateGds(gdsVO);
	}
	
	/**
	* @methodName  : updateAmtAjax
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param map
	* @return      : 안전재고 변경, 판매정보변경 (선택적으로 단가 추가)
	*/
	@PostMapping("/updateAmtAjax")
	@ResponseBody
	public int updateAmtAjax(@RequestBody Map<String, Object> map) {
		return this.gdsService.updateAllStock(map);
	}
	
	/**
	* @methodName  : deleteLastAmt
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param gdsAmtVO(bzentNo, gdsCode)
	* @return      : 잘못 입력된 최근 단가를 삭제함
	*/
	@PostMapping("/deleteLastAmt")
	@ResponseBody
	public int deleteLastAmt(@RequestBody GdsAmtVO gdsAmtVO) {
		return this.comService.deleteGdsAmt(gdsAmtVO);
	}
}
