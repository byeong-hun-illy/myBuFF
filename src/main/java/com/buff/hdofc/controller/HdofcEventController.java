package com.buff.hdofc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.buff.hdofc.service.HdofcEventService;
import com.buff.util.ArticlePage;
import com.buff.vo.CouponGroupVO;
import com.buff.vo.EventVO;
import com.buff.vo.FileDetailVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcEventController.java
* @author       : 정기쁨
* @date         : 2024.09.14
* @description  : 이벤트 조회, 이벤트 등록, 이벤트 삭제, 이벤트 상세조회
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.14        정기쁨     	  	   최초 생성
*/
@Slf4j
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/event")
@Controller
public class HdofcEventController {

	@Inject
	HdofcEventService hdofcEventService;
	
	/**
	* @methodName  : selectEventList
	* @author      : 정기쁨
	* @date        : 2024. 09. 15
	* 이벤트 조회
	*/
	@GetMapping("/selectEventList")
	public String selectEventList(Model model) {

		// 전체 쿠폰 조회
		List<CouponGroupVO> couponGroupVOList = this.hdofcEventService.selectCouponGroupList();
		model.addAttribute("couponGroupVOList",couponGroupVOList);

		// 전체 사원 조회
		List<MngrVO> mngrVOList = this.hdofcEventService.selectMngrList();
		model.addAttribute("mngrVOList",mngrVOList);
		
		// 이벤트 타입 별 갯수
	    int all = this.hdofcEventService.selectAll(); // 전체 이벤트 갯수
	    int waiting = this.hdofcEventService.selectWaiting(); // 대기 중인 이벤트 갯수
	    int cancelled = this.hdofcEventService.selectCancelled(); // 취소 된 이벤트 갯수
	    int scheduled = this.hdofcEventService.selectScheduled(); // 예정 된 이벤트 갯수
	    int progress = this.hdofcEventService.selectProgress(); // 진행 중인 이벤트 갯수
	    int completed = this.hdofcEventService.selectCompleted(); // 완료 된 이벤트 갯수
	    model.addAttribute("all", all);
	    model.addAttribute("waiting", waiting);
	    model.addAttribute("cancelled", cancelled);
	    model.addAttribute("scheduled", scheduled);
	    model.addAttribute("progress", progress);
	    model.addAttribute("completed", completed);
	    
	    log.info("waiting"+waiting);
		
		return "hdofc/event/selectEventList";
	}
	
	/**
	 * @methodName  : listAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 17
	 * @param       : currentPage - 현재 페이지
	 * @param       : map - 검색 조건
	 * @return      : articlePage, (구분용) 이벤트 타입에 따른 정보
	 */
	@ResponseBody
	@GetMapping("/listAjax")
	public Map<String, Object> listAjax(@RequestParam Map<String,Object> map) {
		
	    // 페이징을 위한 데이터
	    int total = this.hdofcEventService.selectTotal(map); // 검색조건에 현재 게시판 갯수
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
		int size = 10;
		map.put("size", size);
		List<EventVO> eventVOList = this.hdofcEventService.selectEventList(map); // 전체 이벤트 조회
	    
		// 응답 데이터를 담을 Map 생성
	    Map<String, Object> response = new HashMap<>();
	    response.put("articlePage", new ArticlePage<EventVO>(total, currentPage, size, eventVOList, map));
	    
		return response;  // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	 * @methodName  : menuModalAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 17
	 * @param       : {menuType: menuType}
	 * @return      : 
	 */
	@ResponseBody
	@GetMapping("/menuModalAjax")
	public Map<String, Object> menuModalAjax(
			@RequestParam(value="menuType", required = false, defaultValue = "") String menuType
		){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<MenuVO> menuVOList = this.hdofcEventService.selectMenuList(menuType);
		int total = this.hdofcEventService.selectTotalMENU();
		int set = this.hdofcEventService.selectMENU01();
		int hambur = this.hdofcEventService.selectMENU02();
		int side = this.hdofcEventService.selectMENU03();
		int drink = this.hdofcEventService.selectMENU04();
		map.put("menuVOList",menuVOList);
		map.put("total",total);
		map.put("set",set);
		map.put("hambur",hambur);
		map.put("side",side);
		map.put("drink",drink);
		
		return map;  // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : eventInsert
	* @author      : 정기쁨
	* @date        : 2024. 09. 15
	* 이벤트 추가 페이지
	*/
	@ResponseBody
	@PostMapping("/eventInsert")
	public String eventInsert(
		@ModelAttribute EventVO eventVO, 
		@RequestParam(value="uploadFile", required = false, defaultValue = "") MultipartFile[] uploadFile
	){
		log.info("EventVO : "+eventVO); // uploadFile=[org.spring...)
		if(uploadFile!=null) {
			eventVO.setUploadFile(uploadFile);
		}

		// 일자 문자열로 바꾸기
		String bgngYmd = eventVO.getBgngYmd().replace("-", "");
		String expYmd = eventVO.getExpYmd().replace("-", "");
		eventVO.setBgngYmd(bgngYmd);
		eventVO.setExpYmd(expYmd);
		
		// 이벤트 추가 서비스 호출
		String eventNo = this.hdofcEventService.eventInsert(eventVO);
		
	    return eventNo;
	}
	
	/**
	* @methodName  : selectEventDetail
	* @author      : 정기쁨
	* @date        : 2024. 09. 20
	* 이벤트 상세 및 등록 페이지
	*/
	@GetMapping("/selectEventDetail")
	public String selectEventDetail(Model model, 
			@RequestParam(value = "eventNo", required = false, defaultValue = "") String eventNo
		){
		if(!eventNo.isEmpty()){
			EventVO eventVO = this.hdofcEventService.selectEventDetail(eventNo);
			model.addAttribute("eventVO",eventVO);
		}
		return "hdofc/event/selectEventDetail";
	}
	
	/**
	 * @methodName  : updateEventAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 20
	 * 최상위관리자: 이벤트 승인여부 처리
	 */
	@ResponseBody
	@PostMapping("/updateEventAjax")
	public int updateEventAjax(@RequestBody EventVO eventVO) {
		
		log.info("updateEventAjax => eventVO :"+eventVO);
		
		int result = this.hdofcEventService.updateEventAjax(eventVO);
		
		log.info("updateEventAjax => result : "+eventVO);
		
		return result;
	}
	
	/**
	 * @methodName  : updateEventAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 20
	 * 일반관리자: 이벤트 수정
	 */
	@ResponseBody
	@PostMapping("/updateEventDtlAjax")
	public int updateEventDtlAjax(@ModelAttribute EventVO eventVO, 
	@RequestParam(value="uploadFile", required = false, defaultValue = "") MultipartFile[] uploadFile
	){
		log.info("updateEventDtlAjax : "+eventVO); // uploadFile=[org.spring...)
		if(uploadFile!=null) {
			eventVO.setUploadFile(uploadFile);
		}
		// 일자 문자열로 바꾸기
		String bgngYmd = eventVO.getBgngYmd().replace("-", "");
		String expYmd = eventVO.getExpYmd().replace("-", "");
		eventVO.setBgngYmd(bgngYmd);
		eventVO.setExpYmd(expYmd);
		// 서비스 호출
		int result = this.hdofcEventService.updateEventDtlAjax(eventVO);
		return result; 
	}
	
	/**
	 * @methodName  : selectFileImgList
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 22
	 * 파일 이미지 불러오기
	 */
	@ResponseBody
	@GetMapping("/selectFileImgList")
	public List<EventVO> selectFileImgList(@RequestParam String eventNo){
		log.info(eventNo);
		List<EventVO> eventVOList = this.hdofcEventService.selectFileImgList(eventNo);
	    for(EventVO event : eventVOList) {
	        for (FileDetailVO fileDetail : event.getFileDetailVOList()) {
	            log.info("File Save Location: " + fileDetail.getFileSaveLocate());
	        }
	    }
		return eventVOList;
	}
	
	/**
	 * @methodName  : eventDelete
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 23
	 * 이벤트 삭제
	 */
	@ResponseBody
	@GetMapping("/eventDelete")
	public int eventDelete(@ModelAttribute EventVO eventVO) {
		int result = this.hdofcEventService.eventDelete(eventVO);
		log.info("eventDelete : ",result);
		return result; 
	}
	
	/**
	 * @methodName  : selectCouponList
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 24
	 * 쿠폰 리스트 작성
	 */
	@ResponseBody
	@GetMapping("/selectCouponList")
	public Map<String, Object> selectCouponList(@RequestParam String couponCode) {
		Map<String, Object> map = this.hdofcEventService.selectCouponList(couponCode);
		return map;
	}
}














