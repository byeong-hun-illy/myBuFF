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

import com.buff.com.mapper.ComMapper;
import com.buff.com.service.ComService;
import com.buff.hdofc.service.HdofcFrcsCheckService;
import com.buff.hdofc.service.HdofcFrcsClsbizService;
import com.buff.hdofc.service.HdofcFrcsService;
import com.buff.hdofc.service.MngrService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.FrcsCheckVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.FrcsVO;
import com.buff.vo.MngrVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.controller.hdofc
* @fileName     : FrcsController.java
* @author       : 송예진
* @date         : 2024.09.12
* @description  : 관리자가 다루는 가맹점 관련 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc")
@Controller
@Slf4j
public class HdofcFrcsController {

	@Autowired
	HdofcFrcsService frcsService;
	
	@Autowired
	ComService comService;

	@Autowired
	MngrService mngrService;
	
	@Autowired
	HdofcFrcsClsbizService clsbizService;
	
	@Autowired
	HdofcFrcsCheckService checkService;
	
// <----------------------------- 가맹점 조회 시작 ------------------------------>
	/**
	* @methodName  : selectFrcs
	* @author      : 송예진
	* @date        : 2024.09.12
	* @param currentPage 현재 페이지
	* @param 검색 조건 map
	* @return 가맹점 조회조건에 맞는 페이징 처리된 리스트
	*/
	@GetMapping("/frcs/list")
	public String selectFrcs(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("mngr", this.mngrService.selectMngrSelect());
		return "hdofc/frcs/selectFrcs";
	}
	
	/**
	* @methodName  : selectFrcsAjax
	* @author      : 송예진
	* @date        : 2024.09.12
	* @param       : currentPage - 현재 페이지
	* @param       : map - 검색 조건
	* @return      : articlePage, (구분용) all, open, cls 정보
	*/
	@GetMapping("/frcs/listAjax")
	@ResponseBody
	public Map<String, Object> selectFrcsAjax(@RequestParam Map<String,Object> map) {
	    int size = 10;
	    map.put("size", size);
	   
	    List<FrcsVO> frcsList = this.frcsService.selectFrcs(map);
	    Map<String, Object> response = this.frcsService.selectTotalFrcs(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<FrcsVO>(total, currentPage, size, frcsList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
// <----------------------------- 가맹점 조회 끝 ------------------------------>
	
	
// <----------------------------- 가맹점 상세 조회 시작 ------------------------------>
	/**
	* @methodName  : selectFrcsDtl
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 가맹점 번호를 받아 상세정보 조회
	* @return      : 상세 정보를 조회 이동
	*/
	@GetMapping("/frcs/list/dtl")
	public String selectFrcsDtl(Model model, @RequestParam("frcsNo") String frcsNo) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/frcs/selectFrcsDtl";
	}
	
	@ResponseBody
	@PostMapping("/frcs/list/dtlAjax")
	public Map<String, Object> selectFrcsDtlAjax(@RequestParam String frcsNo){
		Map<String, Object> map = new HashMap<String, Object>();
		FrcsVO frcsVO = this.frcsService.selectDtlFrcs(frcsNo);
		map.put("frcs", frcsVO);
		
		// 점검 정보
		List<FrcsCheckVO> frcsCheckVO = this.checkService.selectFrcsDtlCheckList(frcsNo);
		String avgStr = this.checkService.selectAvgScr(frcsNo);
		
		map.put("check", frcsCheckVO);
		map.put("avg", avgStr);
		
		// 폐업 정보
		FrcsVO clsbiz = this.clsbizService.selectFrcsClsbizDtl(frcsNo);
		map.put("clsbiz", clsbiz);
		return map;
	}
	
	/**
	* @methodName  : selectMngr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 검색 조건
	* @return      : 재직 중인 관리자
	*/
	@GetMapping("/mngrModalList")
	@ResponseBody
	public ArticlePage<MngrVO> selectMngr(@RequestParam Map<String,Object> map){
		int size = 5;
	    int total = this.mngrService.selectTotalMngr(map);
	    map.put("size", size);
	    List<MngrVO> mngrList = this.mngrService.selectMngr(map);
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    return new ArticlePage<MngrVO>(total, currentPage, size, mngrList, map);
	}
	
	/**
	* @methodName  : updateBzentMbr
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param       : bzentVO (bzentNo, mbrId)
	* @return      : 사업체에 가맹점주 아이디를 변경
	*/
	@PostMapping("/frcs/list/dtl/update")
	@ResponseBody
	public int updateBzent(@RequestBody Map<String, Object> map) {
		return this.frcsService.updateAllBzent(map);
	}
	// <----------------------------- 가맹점 상세 조회 끝 ------------------------------>
	
	// <----------------------------- 가맹점 추가 시작 ------------------------------>
	/**
	* @methodName  : inserJtForm
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param model
	* @return      : insert 폼으로 이동
	*/
	@GetMapping("/frcs/regist")
	public String insertForm(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/frcs/selectFrcsDtl";
	}
	
	/**
	* @methodName  : selectPreFrcsMbr
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param map
	* @return      : 상담한 고객 정보 가져오기
	*/
	@GetMapping("/preFrcsList")
	@ResponseBody
	public ArticlePage<FrcsDscsnVO> selectPreFrcsMbr(@RequestParam Map<String,Object> map){
		int size = 5;
	    int total = this.frcsService.selectTotalPreFrcsMbr(map);
	    map.put("size", size);
	    List<FrcsDscsnVO> mbrList = this.frcsService.selectPreFrcsMbr(map);
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    return new ArticlePage<FrcsDscsnVO>(total, currentPage, size, mbrList, map);
	}
	
	/**
	* @methodName  : insertFrcs
	* @author      : 송예진
	* @date        : 2024.09.16
	* @param map
	* @return      : 추가하기
	*/
	@PostMapping("/frcs/registAjax")
	@ResponseBody
	public String insertFrcs(@RequestBody Map<String, Object> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		// Map 데이터를 VO로 변환
	    FrcsVO frcsVO = objectMapper.convertValue(map.get("frcsVO"), FrcsVO.class);
	    BzentVO bzentVO = objectMapper.convertValue(map.get("bzentVO"), BzentVO.class);
	    FrcsDscsnVO frcsDscsnVO = objectMapper.convertValue(map.get("frcsDscsnVO"), FrcsDscsnVO.class);
	    
		return this.frcsService.insertBzentFrcs(frcsVO, bzentVO, frcsDscsnVO);
	}
	// <----------------------------- 가맹점 추가 끝 ------------------------------>
}
