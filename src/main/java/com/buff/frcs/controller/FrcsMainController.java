package com.buff.frcs.controller;

import java.security.Principal;
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

import com.buff.frcs.service.FrcsMainService;
import com.buff.frcs.service.FrcsNetProfitService;
import com.buff.frcs.service.FrcsOrdrService;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsCheckVO;
import com.buff.vo.MenuVO;
import com.buff.vo.NoticeVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsMainController.java
* @author       : 김현빈
* @date         : 2024.09.21
* @description  : 메인 화면 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.21        김현빈     	  			최초 생성
*/
@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Controller
@Slf4j
public class FrcsMainController {
	
	@Autowired
	FrcsOrdrService ordrService;
	
	@Inject
	FrcsMainService frcsMainService;
	
	@Autowired
	FrcsNetProfitService frcsNetProfitService;

	
	@GetMapping("/main")
	public String main(Model model, Principal principal) {
		
		List<EventVO> eventVOList = this.frcsMainService.selectIngEvent();
		log.info("main : -> eventVOList : " + eventVOList);
		List<NoticeVO> noticeVOList = this.frcsMainService.selectIngNotice();
		log.info("main : -> noticeVOList : " + noticeVOList);
		
		String mbrId = principal.getName();
		
		Map<String, Object> map = this.frcsMainService.selectOrderStatusCnt(mbrId);
		
		int stockCnt = this.frcsMainService.selectSfStockDown(mbrId);
		
		model.addAttribute("eventVOList", eventVOList);
		model.addAttribute("noticeVOList", noticeVOList);
		model.addAttribute("map", map);
		model.addAttribute("stockCnt", stockCnt);
		
		// 순이익 추가 건수
		model.addAttribute("profitCnt", this.frcsNetProfitService.selectInsertChk(mbrId));
		// 정산 필요 건수
		model.addAttribute("frcsClclnCnt", this.frcsMainService.selectFrcsClcln(mbrId));
		// 발주 정산 필요 건수
		model.addAttribute("poCnt", this.frcsMainService.selectPoClcln(mbrId));
		// 폐업일
		model.addAttribute("clsbiz", this.frcsMainService.selectFrcsClsbiz(mbrId));
		
		
		return "frcs/main/home";
	}
	
	@PostMapping("/ordr")
	@ResponseBody
	public int updateOrdr(@RequestParam String frcsNo) {
		return this.ordrService.updateOrdrStock(frcsNo);
	}
	
	/** 이번달 판매량 best메뉴 top3 출력
	 * author : 김현빈, 정현종
	 * 요청URI : /frcs/selectMenuQtyDesc
	 * 요청파라미터 : bzentNo
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/selectMenuQtyDesc")
	public List<MenuVO> selectMenuQtyDesc(@RequestBody String bzentNo) {
		log.info("selectMenuQtyDesc : -> bzentNo : " + bzentNo);
		
		List<MenuVO> menuVODescList = this.frcsMainService.selectMenuQtyDesc(bzentNo);
		log.info("menuVODescList : -> " + menuVODescList);
		
		return menuVODescList;
	}
	
	/** 이번달 판매량 worst메뉴 top3 출력
	 * author : 김현빈, 정현종
	 * 요청URI : /frcs/selectMenuQtyAsc
	 * 요청파라미터 : bzentNo
	 * 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/selectMenuQtyAsc")
	public List<MenuVO> selectMenuQtyAsc(@RequestBody String bzentNo) {
		log.info("selectMenuQtyAsc : -> bzentNo : " + bzentNo);
		
		List<MenuVO> menuVOAscList = this.frcsMainService.selectMenuQtyAsc(bzentNo);
		log.info("menuVOAscList : -> " + menuVOAscList);
		
		return menuVOAscList;
	}
	
	/**
	* @methodName  : selectDailysales
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectDailysales")
	public long selectDailysales(@RequestBody String bzentNo) {
		log.info("selectDailysales : -> bzentNo : " + bzentNo);
		
		long dailysales = this.frcsMainService.selectDailysales(bzentNo);
		log.info("dailysales : -> " + dailysales);
		
		return dailysales;
	}
	
	/**
	* @methodName  : selectDailysalesCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 판매 횟수
	*/
	@ResponseBody
	@PostMapping("/selectDailysalesCnt")
	public long selectDailysalesCnt(@RequestBody String bzentNo) {
		log.info("selectDailysalesCnt : -> bzentNo : " + bzentNo);
		
		long dailysalesCnt = this.frcsMainService.selectDailysalesCnt(bzentNo);
		log.info("dailysalesCnt : -> " + dailysalesCnt);
		
		return dailysalesCnt;
	}
	
	/**
	* @methodName  : selectStoreGrade
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 최근 매장점검 점수
	*/
	@ResponseBody
	@PostMapping("/selectStoreGrade")
	public int selectStoreGrade(@RequestBody String bzentNo) {
		log.info("selectStoreGrade : -> bzentNo : " + bzentNo);
		
		int storeGrade = this.frcsMainService.selectStoreGrade(bzentNo);
		log.info("selectStoreGrade : -> storeGrade : " + storeGrade);
		
		return storeGrade;
	}
	
	/**
	* @methodName  : selectStoreWarningCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 매장점검 경고 횟수
	*/
	@ResponseBody
	@PostMapping("/selectStoreWarningCnt")
	public int selectStoreWarningCnt(@RequestBody String bzentNo) {
		log.info("selectStoreWarningCnt : -> bzentNo : " + bzentNo);
		
		int storeWarningCnt = this.frcsMainService.selectStoreWarningCnt(bzentNo);
		log.info("selectStoreWarningCnt : -> storeWarningCnt : " + storeWarningCnt);
		
		return storeWarningCnt;
	}
	
	/**
	* @methodName  : selectStoreCheckList
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.12
	* @param bzentNo
	* @return	   : 매장 점검 내역
	*/
	@ResponseBody
	@PostMapping("/selectStoreCheckList")
	public List<FrcsCheckVO> selectStoreCheckList(@RequestBody String bzentNo) {
		log.info("selectStoreCheckList : -> bzentNo : " + bzentNo);
		
		List<FrcsCheckVO> frcsCheckVOList = this.frcsMainService.selectStoreCheckList(bzentNo);
		log.info("selectStoreCheckList : -> frcsCheckVOList : " + frcsCheckVOList);
		
		return frcsCheckVOList;
	}
	
	/**
	* @methodName  : selectDayAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param bzentNo
	* @return	   : 일간 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectDayAmt")
	public long selectDayAmt(@RequestBody String bzentNo) {
		log.info("selectDayAmt : -> bzentNo : " + bzentNo);
		
		long dayAmt = this.frcsMainService.selectDayAmt(bzentNo);
		log.info("selectDayAmt : -> dayAmt : " + dayAmt);
		
		return dayAmt;
	}
	
	/**
	* @methodName  : selectMonthAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param bzentNo
	* @return	   : 월간 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectMonthAmt")
	public long selectMonthAmt(@RequestBody String bzentNo) {
		log.info("selectMonthAmt : -> bzentNo : " + bzentNo);
		
		long monthAmt = this.frcsMainService.selectMonthAmt(bzentNo);
		log.info("selectMonthAmt : -> monthAmt : " + monthAmt);
		
		return monthAmt;
	}
	
	/**
	* @methodName  : selectYearAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param bzentNo
	* @return	   : 연간 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectYearAmt")
	public long selectYearAmt(@RequestBody String bzentNo) {
		log.info("selectYearAmt : -> bzentNo : " + bzentNo);
		
		long yearAmt = this.frcsMainService.selectYearAmt(bzentNo);
		log.info("selectYearAmt : -> yearAmt : " + yearAmt);
		
		return yearAmt;
	}
	
	/**
	* @methodName  : selectHourOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param bzentNo
	* @return	   : 당일 시간당 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectHourOrderAmt")
	public List<MenuVO> selectHourOrderAmt(@RequestBody String bzentNo) {
		log.info("selectHourOrderAmt : -> bzentNo : " + bzentNo);
		
		List<MenuVO> hourOrderAmt = this.frcsMainService.selectHourOrderAmt(bzentNo);
		log.info("selectHourOrderAmt : -> hourOrderAmt : " + hourOrderAmt);
		
		return hourOrderAmt;
	}
	
	/**
	* @methodName  : selectDayOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param bzentNo
	* @return	   : 이번달 일간 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectDayOrderAmt")
	public List<MenuVO> selectDayOrderAmt(@RequestBody String bzentNo) {
		log.info("selectDayOrderAmt : -> bzentNo : " + bzentNo);
		
		List<MenuVO> dayOrderAmt = this.frcsMainService.selectDayOrderAmt(bzentNo);
		log.info("selectDayOrderAmt : -> dayOrderAmt : " + dayOrderAmt);
		
		return dayOrderAmt;
	}
	
	/**
	* @methodName  : selectMonthOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param bzentNo
	* @return	   : 이번달 월간 매출 금액
	*/
	@ResponseBody
	@PostMapping("/selectMonthOrderAmt")
	public List<MenuVO> selectMonthOrderAmt(@RequestBody String bzentNo) {
		log.info("selectMonthOrderAmt : -> bzentNo : " + bzentNo);
		
		List<MenuVO> monthOrderAmt = this.frcsMainService.selectMonthOrderAmt(bzentNo);
		log.info("selectMonthOrderAmt : -> monthOrderAmt : " + monthOrderAmt);
		
		return monthOrderAmt;
	}
}
