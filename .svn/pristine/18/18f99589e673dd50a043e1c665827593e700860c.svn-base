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
import com.buff.hdofc.service.HdofcCnptService;
import com.buff.hdofc.service.MngrService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcCnptController.java
* @author       : 송예진
* @date         : 2024.09.24
* @description  : 거래처 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.24        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/cnpt")
@Controller
@Slf4j
public class HdofcCnptController {
 
	@Autowired
	ComService comService;
	
	@Autowired
	MngrService mngrService;
	
	@Autowired
	HdofcCnptService cnptService;
	
	/**
	* @methodName  : selectCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param model
	* @return      : 거래처 조회 페이지로 이동
	*/
	@GetMapping("/list")
	public String selectCnpt(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN")); // 지역
		model.addAttribute("mngr", this.mngrService.selectMngrSelect()); // 관리자
		return "hdofc/cnpt/selectCnpt";
	}
	
	/**
	* @methodName  : selectCnptAjax
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param map
	* @return      : 거래처 조회
	*/
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectCnptAjax(@RequestParam Map<String,Object> map) {
	    int size = 10;
	    map.put("size", size);
	    List<BzentVO> bzentlist = this.cnptService.selectCnpt(map); // 데이터
	    Map<String, Object> response = this.cnptService.selectTotalCnpt(map); // map 갯수를 포함한 map
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<BzentVO>(total, currentPage, size, bzentlist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	
	///////////////////////// 추가
	
	@GetMapping("/regist")
	public String insertCnpt(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/cnpt/selectCnptDtl";
	}
	
	@GetMapping("/preList")
	@ResponseBody
	public ArticlePage<MemberVO> selectCnptMbr(@RequestParam Map<String,Object> map){
		int size = 5;
		map.put("size", size);
		List<MemberVO> memberVO = this.cnptService.selectCnptMbr(map);
		int total = this.cnptService.selectTotalCnptMbr(map);
		int currentPage = Integer.parseInt((String) map.get("currentPage"));
		
		return new ArticlePage<MemberVO>(total, currentPage, size, memberVO, map);
	}
	
	@PostMapping("/registAjax")
	@ResponseBody
	public String insertCnptAjax(@RequestBody BzentVO bzentVO) {
		int cnt = this.cnptService.insertCnpt(bzentVO);
		String bzentNo = bzentVO.getBzentNo();
		return bzentNo;
	}
	
	////////////////////////// 상세
	@GetMapping("/dtl")
	public String insertCnpt(Model model, @RequestParam String bzentNo) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/cnpt/selectCnptDtl";
	}
	
	/**
	* @methodName  : selectCnptDtlAjax
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 가맹점 상세
	*/
	@PostMapping("/dtlAjax")
	@ResponseBody
	public Map<String, Object> selectCnptDtlAjax(@RequestParam String bzentNo){
		Map<String, Object> map = new HashMap<String, Object>();
		BzentVO bzentVO = this.cnptService.selectCnptDtl(bzentNo);
		map.put("cnpt", bzentVO);
		return map;
	}
	
	/**
	* @methodName  : updateCnptAjax
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 수정
	*/
	@PostMapping("/updateAjax")
	@ResponseBody
	public int updateCnptAjax(@RequestBody BzentVO bzentVO) {
		return this.cnptService.updateBzent(bzentVO);
	}
	
	/**
	* @methodName  : deleteCnptAjax
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 재고정보없으면 삭제
	*/
	@PostMapping("/deleteAjax")
	@ResponseBody
	public int deleteCnptAjax(@RequestParam String bzentNo) {
		return this.cnptService.deleteCnpt(bzentNo);
	}
}
