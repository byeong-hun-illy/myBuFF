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

import com.buff.hdofc.service.HdofcMainService;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.hdofc.HdofcAmtVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcMainController.java
* @author       : 송예진
* @date         : 2024.09.19
* @description  : 메인 화면 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.21        송예진     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc")
@Controller
public class HdofcMainController {
	
	@Autowired
	HdofcMainService mainService;
	
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("cnt", this.mainService.selectCnt());
		
		List<HdofcAmtVO> chkList = this.mainService.selectChkGrade();
		
		// ObjectMapper를 사용하여 List를 JSON 문자열로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    String chkListJson;
		try {
			chkListJson = objectMapper.writeValueAsString(chkList);
			model.addAttribute("chk", chkListJson);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("dscsn", this.mainService.selectDscsn());
		model.addAttribute("qs", this.mainService.selectQs());
		model.addAttribute("evt", this.mainService.selectEvent());
		
		return "hdofc/main/home";
	}
	
	/**
	* @methodName  : selectFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param map
	* @return      : 상담 예정인 사람들의 날짜와 이름을 가져옴
	*/
	@ResponseBody
	@PostMapping("/getEvent")
	public List<FrcsDscsnVO> selectFrcsDscsn(@RequestBody Map<String, Object> map){
		return this.mainService.selectDscsnEvent(map);
	}
	
	/**
	* @methodName  : selectClcln
	* @author      : 송예진
	* @date        : 2024.10.11
	* @param date
	* @return      : 매출 정보를 년/월/일 로 가져옴
	*/
	@ResponseBody
	@PostMapping("/getAmt")
	public Map<String, Object> selectClcln(@RequestParam String date){
		return this.mainService.selectAmt(date);
	}
	
	@GetMapping("/nav")
	public String selectNavSearch() {
		return "com/selectNav";
	}
}
