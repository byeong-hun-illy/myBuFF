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
import com.buff.hdofc.service.HdofcFrcsDscsnService;
import com.buff.util.ArticlePage;
import com.buff.vo.FrcsDscsnVO;

@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/frcs/dscsn")
@Controller
public class HdofcFrcsDscsnController {

	@Autowired
	HdofcFrcsDscsnService dscsnService;
	
	@Autowired
	ComService comService;
	
	@GetMapping("/list")
	public String selectFrcsDscsn(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("dsc", this.comService.selectCom("DSC"));
		return "hdofc/frcs/selectFrcsDscsn";
	}
	
	/**
	* @methodName  : selectFrcsDscsnAjax
	* @author      : 송예진
	* @date        : 2024.09.12
	* @param       : currentPage - 현재 페이지
	* @param       : map - 검색 조건
	* @return      : articlePage, (구분용) 숫자 정보
	*/
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectFrcsDscsnAjax(@RequestParam Map<String,Object> map) {
	    int size = 10;
	    map.put("size", size);
	    List<FrcsDscsnVO> frcsDscsnList = this.dscsnService.selectFrcsDscsn(map);
	    Map<String, Object> response = this.dscsnService.selectTotalFrcsDscsn(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));

	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<FrcsDscsnVO>(total, currentPage, size, frcsDscsnList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	@GetMapping("/dtl")
	public String selectFrcsDscsnDtl(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/frcs/selectFrcsDscsnDtl";
	};
	
	/**
	* @methodName  : selectFrcsDscsnDtlAjax
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param dscsnCode
	* @return      : 가맹점 상담 상세
	*/
	@GetMapping("/dtlAjax")
	@ResponseBody
	public FrcsDscsnVO selectFrcsDscsnDtlAjax(@RequestParam String dscsnCode) {
		FrcsDscsnVO frcsDscsnVO = this.dscsnService.selectFrcsDscsnDtl(dscsnCode);
		return frcsDscsnVO;
	}
	
	/**
	* @methodName  : updateFrcsDscsnAjax
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO
	* @return      : 상담 수정
	*/
	@PostMapping("/updateAjax")
	@ResponseBody
	public int updateFrcsDscsnAjax(@RequestBody FrcsDscsnVO frcsDscsnVO) {
		return this.dscsnService.updateFrcsDscsn(frcsDscsnVO);
	}
}
