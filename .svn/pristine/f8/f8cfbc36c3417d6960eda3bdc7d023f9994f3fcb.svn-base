package com.buff.cust.controller.backup;

import java.security.Principal;
import java.util.List;

import javax.swing.ListModel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cust.service.CustMyPageService;
import com.buff.vo.EventVO;
import com.buff.vo.FavMenuVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.OrdrVO;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasRole('ROLE_CUST')")
@Slf4j
@RequestMapping("/backup")
@Controller
public class backupController {

	@Autowired
	CustMyPageService myPageService;
	
	@GetMapping("/insertOrder")
	public String insertOrder() {
		return "cust/backup/insertOrder";
	}
	
	@GetMapping("/selectMenu")
	public String selectMenu() {
		return "cust/backup/selectMenu";
	}
	
	@GetMapping("/selectEvent")
	public String selectEvent() {
		return "cust/backup/selectEvent";
	}
	
	@GetMapping("/selectEventDtl")
	public String selectEventDtl() {
		return "cust/backup/selectEventDtl";
	}
	
	@GetMapping("/selectMyPage")
	public String selectMyPage(Principal principal, Model model) {
		
		
		String mbrId = principal.getName();
		log.info("myPageMain -> mbrId :" + mbrId);
		
		//3. 문의 내역
		List<QsVO> qsVOList = myPageService.myQs(mbrId);
		log.info("myPageMain -> qsVOList : " + qsVOList);
		
		//4. 가맹 상담
		List<FrcsDscsnVO> frcsDscsnVOList = myPageService.myDscsn(mbrId);
		log.info("myPageMain -> frcsDscsnVOList : " + frcsDscsnVOList);
		
		
		List<OrdrVO> ordrVOList = myPageService.myOrdr(mbrId);
		log.info("myPageMain -> OrdrVOList : " + ordrVOList);
		
		//1. 쿠폰
		List<EventVO> eventVOList = myPageService.myCoupon(mbrId);
		log.info("myPageMain -> eventVOList : " + eventVOList);
		
		
		
		model.addAttribute("qsVOList",qsVOList);
		model.addAttribute("frcsDscsnVOList",frcsDscsnVOList);
		model.addAttribute("ordrVOList",ordrVOList);
		model.addAttribute("eventVOList",eventVOList);
		
		return "cust/custPage/selectMyPage";
	}
	

	@GetMapping("/selectQsDtl")
	public String selectQsDtl() {
		return "cust/backup/selectQsDtl";
	}
	
	
}
