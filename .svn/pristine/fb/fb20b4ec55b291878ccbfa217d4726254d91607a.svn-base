package com.buff.frcs.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.buff.com.service.ComService;
import com.buff.frcs.service.FrcsPoService;
import com.buff.util.ArticlePage;
import com.buff.vo.GdsVO;
import com.buff.vo.PoVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.controller.frcs
* @fileName     : FrcsPoController.java
* @author       : 김현빈
* @date         : 2024-09-12
* @description  : 
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024-09-20		김현빈				?
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsPoController {
	
	@Autowired
	FrcsPoService frcsPoService;
	
	@Autowired
	ComService comService;
	
	/** 가맹점 발주관리 페이지
	 * 요청URI : /frcs/frcsPoList
	 * 요청파라미터 : 
	 * 요청방식 : get
	 * 
	 */
	@GetMapping("/frcsPoList")
	public String selectFrcsPoList(Model model, Principal principal, 
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage, 
			@RequestParam(value="deli", required=false, defaultValue="") String deli, 
			@RequestParam(value="bgngYmd", required=false, defaultValue="") String bgngYmd,
	        @RequestParam(value="expYmd", required=false, defaultValue="") String expYmd
			) {
		//principal => CustomUser
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("mbrId", mbrId);
		map.put("deli", deli);
		map.put("bgngYmd", bgngYmd);
	    map.put("expYmd", expYmd);
		
		//list -> map :{deli=, mbrId=3r1x9ega, bgngYmd=2024-05-01, expYmd=2024-06-08, currentPage=1}
		log.info("list -> map :" + map);
		
		List<PoVO> poVOList = this.frcsPoService.selectFrcsPoList(map);
		log.info("list -> poVOList :" + poVOList);
		
		// 전체 행의 수
		int total = this.frcsPoService.poTotalCnt(map);
		log.info("list -> total : " + total);
		
		// 발주 유형 별 갯수
		Map<String, Object> tapMaxTotal = this.frcsPoService.tapMaxTotal(mbrId);
	    log.info("tapMaxTotal -> :" + tapMaxTotal);
		
		// 페이지네이션 객체
		ArticlePage<PoVO> articlePage = 
				new ArticlePage<PoVO>(total, currentPage, 10, poVOList, map);
		
//		model.addAttribute("poVOList", poVOList);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("deli", this.comService.selectCom("DELI"));
		
		model.addAttribute("total", total);
		model.addAttribute("tapMaxTotal", tapMaxTotal);
		
		log.info("야야야야야ㅑ야야양야ㅑ야야야야야야야야야야ㅑ야양야ㅑ야야야야야야야야   bgngYmd: " + bgngYmd);
		log.info("야야야야야ㅑ야야양야ㅑ야야야야야야야야야야ㅑ야양야ㅑ야야야야야야야야   expYmd: " + expYmd);
		
		return "frcs/frcsPoList";
	}
	
	/** 가맹점 발주 내역 상세 페이지
	 * 요청URI : /frcs/frcsPoList/detail?poNo={param.poNo}
	 * 요청파라미터 : poNo
	 * 요청방식 : get
	 * 
	 */	
	// 여러 개의 발주 상세 조회 페이지 매핑
    @GetMapping("/frcsPoList/detail")
    public String getFrcsPoDetail(@RequestParam("poNo") String poNo, Model model) {
        // 서비스에서 발주 상세정보 리스트를 조회
        List<GdsVO> gdsVOList = frcsPoService.selectFrcsPoDetail(poNo);
        
        // 조회된 리스트를 모델에 담아 JSP에 전달
        model.addAttribute("gdsVOList", gdsVOList);
        model.addAttribute("gd", this.comService.selectCom("GD"));

        // frcsPoDetail.jsp 페이지로 이동
        return "frcs/frcsPoDetail";
    }
	
}










