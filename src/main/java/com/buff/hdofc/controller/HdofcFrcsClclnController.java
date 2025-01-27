package com.buff.hdofc.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.FrcsClclnService;
import com.buff.util.ArticlePage;
import com.buff.vo.FrcsClclnMaxVO;
import com.buff.vo.FrcsClclnVO;

import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasRole('ROLE_HDOFC')")
@Controller
@RequestMapping("/hdofc/frcsClcln")
@Slf4j
public class HdofcFrcsClclnController {
	
	@Autowired
	FrcsClclnService clclnService;
	
	@GetMapping("/list")
	public String selectFrcsClcln(Model model) {
		// 검색 조건
		// 이번달 정산
		FrcsClclnMaxVO amt = this.clclnService.selectFrceClclnMonth();
		model.addAttribute("amt", amt);
		
		if(amt!=null) {
			
		
		// 만약에 이번달 정산이 저번달인 경우
		// 오늘 날짜 가져오기
	    LocalDate today = LocalDate.now();
	    
	    // amt에서 stDay와 enDay 가져오기 (String을 LocalDate로 변환)
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate enDay = LocalDate.parse(amt.getEnDay(), formatter);
	    // 오늘이 지난달인지 여부 확인
	    boolean isLastMonth = today.getMonthValue() == enDay.getMonthValue() + 1 || 
	                          (today.getMonthValue() == 1 && enDay.getMonthValue() == 12); // 1월일 경우 12월로 처리
	    
	    log.debug("지난달에 정산처리를 하였는가?" + isLastMonth);
	    model.addAttribute("isLastMonth", isLastMonth);
		}
	    
	    return "hdofc/clcln/selectFrcsClcln";
	}
	
	@GetMapping("/dtl")
	public String selectFrcsClclnDtl() {
		return "hdofc/clcln/selectFrcsClclnDtl";
	}
	
	@PostMapping("/registAjax")
	@ResponseBody
	public int insertFrcsClcln(@RequestParam String clclnYm){
		return this.clclnService.insertFrcsClcln(clclnYm);
	}
}
