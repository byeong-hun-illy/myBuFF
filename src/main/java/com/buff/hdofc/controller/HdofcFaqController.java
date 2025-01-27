package com.buff.hdofc.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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
import com.buff.hdofc.service.HdofcFaqService;
import com.buff.util.ArticlePage;
import com.buff.vo.ComVO;
import com.buff.vo.FaqVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcFaqController.java
* @author       : 김현빈
* @date         : 2024.09.30
* @description  : Faq crud Controller
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30               김현빈     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/faq")
@Controller
@Slf4j
public class HdofcFaqController {
	
	@Inject
	HdofcFaqService hdofcFaqService;
	
	@Autowired
	ComService comService;
	
	/** FAQ 리스트 관리 페이지
	 * 요청URI : /hdofc/faq/selectFaqList
	 * 요청파라미터 : map
	 * 요청방식 : get
	 * 
	 */
	@GetMapping("/selectFaqList")
	public String selectFaqList(Model model, Principal principal,
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage, 
			@RequestParam(value="qsType", required=false, defaultValue="") String qsType, 
			@RequestParam(value="faqTtl", required=false, defaultValue="") String faqTtl 
//			@RequestParam(value="faqCn", required=false, defaultValue="") String faqCn 
			) {
		
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("qsType", qsType);
		map.put("faqTtl", faqTtl);
//		map.put("faqCn", faqCn);
		map.put("mbrId", mbrId);
		
		log.info("list -> map :" + map);
		
		List<FaqVO> faqVOList = this.hdofcFaqService.selectFaqList(map);
		log.info("list -> faqVOList :" + faqVOList);
		
		int total = this.hdofcFaqService.faqTotalCnt(map);
		log.info("list -> total : " + total);
		
		Map<String, Object> tapMaxTotal = this.hdofcFaqService.tapMaxTotal();
		log.info("tapMaxTotal -> :" + tapMaxTotal);
		
		ArticlePage<FaqVO> articlePage = 
				new ArticlePage<FaqVO>(total, currentPage, 10, faqVOList, map);
		
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("qsType", this.comService.selectCom("QS"));
		model.addAttribute("total", total);
		model.addAttribute("tapMaxTotal", tapMaxTotal);
		
		return "hdofc/faq/selectFaqList";
	}
	
	/** FAQ 상세보기 관리 페이지
	 * 요청URI : /hdofc/faq/selectFaqDetail
	 * 요청파라미터 : faqSeq
	 * 요청방식 : get
	 * 
	 */
	@GetMapping("/selectFaqDetail")
	public String selectFaqDetail(@RequestParam("faqSeq") String faqSeq, Model model, Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId(selectFaqDetail) -> :" + mbrId);
		
		FaqVO faqVO = hdofcFaqService.selectFaqDetail(faqSeq);
		log.info("faqVO(selectFaqDetail) -> :" + faqVO);
		
		model.addAttribute("faqVO", faqVO);
		model.addAttribute("qsType", this.comService.selectCom("QS"));
		
		return "hdofc/faq/selectFaqDetail";
	}
	
	/** FAQ 수정 처리
	 * 요청URI : /hdofc/faq/updateFaqDetail
	 * 요청 파라미터 : 
	 * 요청방식 : POST
	 */
	@ResponseBody
	@PostMapping("/updateFaqDetail")
	public int updateFaqDetail(@RequestBody FaqVO faqVO, Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId(updateFaqDetail) -> :" + mbrId);
		
		log.info("faqVO(updateFaqDetail) : " + faqVO);
		
		faqVO.setMngrId(mbrId);
		log.info("mbrId(updateFaqDetail) -> :" + mbrId);
		
		int result = this.hdofcFaqService.updateFaqDetail(faqVO);
		log.info("result FAQ 수정작업 : -> " + result);
		
		return result;
	}
	
	/** FAQ 수정 처리
	 * 요청URI : /hdofc/faq/insertFaqList
	 * 요청 파라미터 : 
	 * 요청방식 : GET
	 */
	// GET 요청에 대해 insertFaqList 페이지로 이동
    @GetMapping("/insertFaqList")
    public String insertFaqListForm(Model model, Principal principal) {
    	String mbrId = principal.getName();
    	model.addAttribute("mbrId", mbrId);
		log.info("mbrId -> :" + mbrId);
		
		MemberVO memberVO = this.hdofcFaqService.selectMbrNm(mbrId);
		model.addAttribute("memberVO", memberVO);
		log.info("memberVO -> :" + memberVO);
		
		List<ComVO> qs = this.comService.selectCom("QS");
		model.addAttribute("qs", qs);
		log.info("qs -> :" + qs);
		
        return "hdofc/faq/insertFaqList"; // 이동할 JSP 페이지 (예: insertFaqList.jsp)
    }
	
	/** FAQ 수정 처리
	 * 요청URI : /hdofc/faq/insertFaqList
	 * 요청 파라미터 : 
	 * 요청방식 : POST
	 */
	@ResponseBody
	@PostMapping("/insertFaqList")
	public int insertFaqList(@RequestBody FaqVO faqVO, Model model, Principal principal) {
		String mbrId = principal.getName();
		log.info("mbrId -> :" + mbrId);
		
		log.info("faqVO : " + faqVO);
		
		model.addAttribute("mbrId", mbrId);
		
		faqVO.setMngrId(mbrId);
		log.info("mbrId -> :" + mbrId);
		
		
		int result = this.hdofcFaqService.insertFaqList(faqVO);
		log.info("result FAQ 등록작업 : -> " + result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/deleteFaq")
	public int deleteFaq(@RequestBody String faqSeq) {
		log.info("faqSeq -> :" + faqSeq);
		
		int result = this.hdofcFaqService.deleteFaq(faqSeq);
		log.info("result -> :" + result);
		
		return result;
	}
	
}
