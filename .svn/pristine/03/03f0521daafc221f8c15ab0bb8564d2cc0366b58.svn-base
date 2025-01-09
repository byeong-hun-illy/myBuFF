package com.buff.cust.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cust.mapper.CustCenterMapper;
import com.buff.cust.service.CustCenterService;
import com.buff.cust.service.CustMyPageService;
import com.buff.util.ArticlePage;
import com.buff.vo.FaqVO;
import com.buff.vo.NoticeVO;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * 고객 -> 고객센터 , 1:1 문의, 공지사항 조회,  faq 조회를 하는 controller
 * 
 * 
 * 
* @packageName  : com.buff.controller.cust
* @fileName     : CustCenterController.java
* @author       : 서윤정
* @date         : 2024.09.13
* @description  : 고객센터 - 공지사항, FAQ 조회
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     서윤정  			최초 생성
*/
@Slf4j
@RequestMapping("/center")
@Controller
public class CustCenterController {
	
	@Autowired
	CustMyPageService myPageService;
	
	@Autowired
	CustCenterService centerService;
	
	@Autowired
	CustCenterMapper centerMapper;
	
	
	

	@GetMapping("/selectNotice")
	public String selectNotice(Model model,
			@RequestParam(value="noticeCategory", defaultValue="") String noticeCategory,
			@RequestParam(value = "keyword", defaultValue = "") String keyword
			) {
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeCategory", noticeCategory);
		map.put("keyword", keyword);
		
		List<NoticeVO> noticeVOList = this.centerService.selectNotice(map);
		
		model.addAttribute("noticeVOList", noticeVOList);
		model.addAttribute("noticeCategory", noticeCategory);
		model.addAttribute("keyword", keyword);
		
		return "cust/custCenter/selectNotice";
	}
	
	@GetMapping("/selectNoticeDetail")
	public String selectNoticeDetail(@RequestParam("ntcSeq") int ntcSeq, Model model) {
		this.centerService.inqCnt(ntcSeq);
		NoticeVO noticeVO = this.centerService.selectNoticeDetail(ntcSeq);
		
		model.addAttribute("noticeVO", noticeVO);
		
		log.info("selectNoticeDetail-> ntcSeq" + ntcSeq); 
		
		return "cust/custCenter/selectNoticeDetail";
	}
	
	
	@GetMapping("/selectFaq")
	public String selectFaq(@RequestParam(value = "faqCategory", required = false) String faqCategory , Model model) {
		List<FaqVO> faqVOList = centerService.selectFaq(faqCategory);
		
		model.addAttribute("faqVOList", faqVOList);
		
		return "cust/custCenter/selectFaq";
	}
	
	@GetMapping("/insertQs")
	public String insertQs(Model model, Principal principal)  {
		String mbrId = principal.getName();
		
		List<QsVO> qsVOList = myPageService.myQs(mbrId);
		
		model.addAttribute("qsVOList",qsVOList);
		
		return "cust/custCenter/insertQs";
	}
	
	
	
	
	/**
	* @methodName  : selectBoard
	* @author      : 정기쁨
	* @date        : 2024.10.05
	* 고객사이트 게시판이 모아져있는 페이지 (공지사항, FAQ, 1:1)
	*/
	@GetMapping("/selectBoard")
	public String selectBoard(Model model,
			Principal principal,
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
			@RequestParam(value="noticeCategory", defaultValue="") String noticeCategory,
			@RequestParam(value= "keyword", defaultValue = "") String keyword,
			@RequestParam(value="faqCategory", required = false) String faqCategory
		) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeCategory", noticeCategory);
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		
		List<NoticeVO> noticeVOList = this.centerService.selectNotice(map);
		log.info("selectBoard -> noticeVOList " + noticeVOList);

		int total = this.centerService.noticeTotalCnt(map);

		List<FaqVO> faqVOList = centerService.selectFaq(faqCategory);
		log.info("selectBoard -> faqVOList : " + faqVOList);
		
		
		log.info("selectBoard -> total " + total);
		
		ArticlePage<NoticeVO> articlePage = 
				new ArticlePage<NoticeVO>(total, currentPage, 10, noticeVOList, map);
		
		//1:1문의 비로그인 회원은 문의 작성 안됨.
		if(principal!=null) {
			String mbrId = principal.getName();
			List<QsVO> qsVOList = myPageService.myQs(mbrId);
			log.info("selectBoard -> qsVOList : " + qsVOList );
			model.addAttribute("qsVOList",qsVOList);
			
		}else {
			model.addAttribute("qsVOList",null);
		}
		
		
//		model.addAttribute("noticeVOList", noticeVOList);
		model.addAttribute("faqVOList", faqVOList);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("noticeCategory", noticeCategory);
		model.addAttribute("keyword", keyword);
		
		
		
		return "cust/custCenter/selectBoard";
	}
	
	
	//문의내역 수정  
	@PostMapping("/updateQs")
	@ResponseBody
	public QsVO updateQs(Principal principal, @RequestParam(value="qsSeq") String qsSeq ) {
		
		String mbrId = principal.getName();
		
		log.info("selectQsDetail -> qsSeq : ", qsSeq);
		log.info("selectQsDetail -> mbrId : "+mbrId);
		
		 Map<String, Object> map = new HashMap<String, Object>();
	      map.put("qsSeq", qsSeq);
	      map.put("mbrId", mbrId);
	      
	      QsVO qsVO = centerService.selectQsDetail(map);
	      log.info("selectQsDetail -> qsVO : ", qsVO);
		
		return qsVO;
	}
	
	
	
	
	
	
	
}




















