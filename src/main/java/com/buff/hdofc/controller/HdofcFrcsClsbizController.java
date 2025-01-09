package com.buff.hdofc.controller;

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
import com.buff.hdofc.service.HdofcFrcsClsbizService;
import com.buff.hdofc.service.HdofcFrcsService;
import com.buff.hdofc.service.MngrService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.FrcsVO;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcFrcsClsbizController.java
* @author       : 송예진
* @date         : 2024.09.21
* @description  : 본사가 관리하는 가맹점 폐업 관리 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.21        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/frcs/clsbiz")
@Controller
public class HdofcFrcsClsbizController {
	
	@Autowired
	HdofcFrcsService frcsService;
	
	@Autowired
	ComService comService;
	
	@Autowired
	HdofcFrcsClsbizService clsbizService;
	
	@Autowired
	MngrService mngrService;
	
	/**
	* @methodName  : selectFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param model
	* @return      : 폐업 리스트로 이동
	*/
	@GetMapping("/list")
	public String selectFrcsClsbiz(Model model) {
		// 검색 조건
		model.addAttribute("mngr", this.mngrService.selectMngrSelect());
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("rsn", this.comService.selectCom("CR"));
		model.addAttribute("cls", this.comService.selectCom("CLS"));
		return "hdofc/frcs/selectFrcsClsbiz";
	}
	
	@ResponseBody
	@GetMapping("/listAjax")
	public Map<String, Object> selectFrcsClsbizAjax(@RequestParam Map<String, Object> map){
		int size = 10;
		map.put("size", size);
		List<FrcsVO> frcsList = this.clsbizService.selectFrcsClsbiz(map);
		Map<String, Object> response = this.clsbizService.selectTotalFrcsClsbiz(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<FrcsVO>(total, currentPage, size, frcsList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : selectFrcsClsbizDtl
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param frcsNo
	* @return      : 폐업 상세
	*/
	@ResponseBody
	@GetMapping("/dtlAjax")
	public FrcsVO selectFrcsClsbizDtl(@RequestParam String frcsNo) {
		return this.clsbizService.selectFrcsClsbizDtl(frcsNo);
	}

	/**
	* @methodName  : updateOneFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param frcsNo
	* @return      : 폐업 하나 변경
	*/
	@ResponseBody
	@PostMapping("/updateOne")
	public int updateOneFrcsClsbiz(@RequestParam String frcsNo) {
		return this.clsbizService.updateFrcsClsbiz(frcsNo);
	}

	@ResponseBody
	@PostMapping("/clclnChk")
	public int updateClclnChk() {
		return this.clsbizService.updateClclnChk();
	}
}
