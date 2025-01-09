package com.buff.hdofc.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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
import com.buff.hdofc.service.HdofcQsService;
import com.buff.util.ArticlePage;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcQsController.java
* @author       : 김현빈
* @date         : 2024.10.01
* @description  : 문의사항 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        김현빈  	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/qs")
@Controller
@Slf4j
public class HdofcQsController {
	
	@Inject
	HdofcQsService hdofcQsService;
	
	@Inject
	ComService comService;
	
	/** 문의사항 리스트 관리 페이지
	 * 요청URI : /hdofc/qs/selectQsList
	 * 요청파라미터 : map
	 * 요청방식 : get
	 */
	@GetMapping("/selectQsList")
	public String selectQsList(Model model, Principal principal, 
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage, 
			@RequestParam(value="qsType", required=false, defaultValue="") String qsType, 
			@RequestParam(value="bgngYmd", required=false, defaultValue="") String bgngYmd, 
	        @RequestParam(value="expYmd", required=false, defaultValue="") String expYmd, 
			@RequestParam(value="qsTtl", required=false, defaultValue="") String qsTtl 
//			@RequestParam(value="qsCn", required=false, defaultValue="") String qsCn 
			) {
		
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("qsType", qsType);
		map.put("bgngYmd", bgngYmd);
		map.put("expYmd", expYmd);
		map.put("qsTtl", qsTtl);
//		map.put("qsCn", qsCn);
		map.put("mbrId", mbrId);
		log.info("map -> :" + map);
		
		List<QsVO> qsVOList = this.hdofcQsService.selectQsList(map);
		log.info("qsVOList -> :" + qsVOList);
		
		int total = this.hdofcQsService.qsTotalCnt(map);
		log.info("total -> :" + total);
		
		Map<String, Object> tapMaxTotal = this.hdofcQsService.tapMaxTotal();
		log.info("tapMaxTotal -> :" + tapMaxTotal);
		
		ArticlePage<QsVO> articlePage = 
				new ArticlePage<QsVO>(total, currentPage, 10, qsVOList, map);
		
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("qsType", this.comService.selectCom("QS"));
		model.addAttribute("total", total);
		model.addAttribute("tapMaxTotal", tapMaxTotal);
		
		return "hdofc/qs/selectQsList";
	}
	
	/** 문의사항 상세보기 관리 페이지
	 * 요청URI : /hdofc/qs/selectQsDetail
	 * 요청파라미터 : qsSeq
	 * 요청방식 : get
	 */
	@GetMapping("/selectQsDetail")
	public String selectQsDetail(@RequestParam("qsSeq") String qsSeq, Model model, Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		QsVO qsVO = this.hdofcQsService.selectQsDetail(qsSeq);
		log.info("qsVO -> :" + qsVO);
		
		model.addAttribute("qsVO", qsVO);
		model.addAttribute("qs", this.comService.selectCom("QS"));
		
		return "hdofc/qs/selectQsDetail";
	}
	
	/** 문의사항 댓글 등록 및 삭제 작업
	 * 요청URI : /hdofc/qs/updateQsDetailAns
	 * 요청파라미터 : qsVO
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/updateQsDetailAns")
	public int updateQsDetailAns(@RequestBody QsVO qsVO, Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		log.info("qsVO -> :" + qsVO);
		
		qsVO.setMngrId(mbrId);
		log.info("mbrId -> :" + mbrId);
		
		int result = this.hdofcQsService.updateQsDetailAns(qsVO);
		log.info("result 댓글 등록 및 수정작업 : -> " + result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/deleteQs")
	public int deleteQs(@RequestBody String qsSeq) {
		log.info("qsSeq -> :" + qsSeq);
		
		int result = this.hdofcQsService.deleteQs(qsSeq);
		log.info("result 문의사항 삭제작업 : -> " + result);
		
		return result;
	}
	
}
