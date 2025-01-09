package com.buff.hdofc.controller;

import java.util.ArrayList;
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

import com.buff.hdofc.service.HdofcNoticeService;
import com.buff.vo.EventVO;
import com.buff.vo.NoticeVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.controller
* @fileName     : HdofcNoticeController
* @author       : 정기쁨
* @date         : 2024.09.25
* @description  : 공지사항 목록, 공지사항 등록, 공지사항 삭제, 공지사항 상세조회
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.25        정기쁨     	  	   최초 생성
*/
@Slf4j
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/notice")
@Controller
public class HdofcNoticeController {

	@Inject
	HdofcNoticeService hdofcNoticeService;
	
	/**
	* @methodName  : selectNoticeList
	* @author      : 정기쁨
	* @date        : 2024. 09. 15
	* 공지사항 목록
	*/
	@GetMapping("/selectNoticeList")
	public String selectNotice(){
		return "hdofc/notice/selectNoticeList";
	}
	
	/**
	* @methodName  : selectNoticeAjax
	* @author      : 정기쁨
	* @date        : 2024. 09. 15
	*  1. 테이블목록조회(검색기능포함), 2. 검색조건(담당자), 3. 전체 갯수(탭에서 사용)
	*/
	@ResponseBody
	@GetMapping("/selectNoticeAjax")
	public Map<String, Object> selectNoticeAjax(@RequestParam Map<String,Object> map) {
		Map<String, Object> response = this.hdofcNoticeService.selectNoticeAjax(map);
		return response;
	}
	
	/**
	* @methodName  : selectNoticeDetail
	* @author      : 정기쁨
	* @date        : 2024. 09. 15
	* 공지사항 상세
	*/
	@GetMapping("/selectNoticeDetail")
	public String selectNoticeDetail(
		Model model, 
		@RequestParam(value="ntcSeq",required = false, defaultValue = "") String ntcSeq
	){
		if(ntcSeq!=null) { // 파라미터에 공지사항 번호가 있는 경우
			NoticeVO noticeVO = this.hdofcNoticeService.selectNoticeDtl(ntcSeq);
			model.addAttribute("noticeVO", noticeVO);
		}
		return "hdofc/notice/selectNoticeDetail";
	}
	
	/**
	* @methodName  : noticeInsert
	* @author      : 정기쁨
	* @date        : 2024. 09. 26
	* 공지사항 추가 페이지
	*/
	@ResponseBody
	@PostMapping("/noticeInsert")
	public int noticeInsert(
		@ModelAttribute NoticeVO noticeVO, 
		@RequestParam(value="uploadFile", required = false, defaultValue = "") MultipartFile[] uploadFile
	){
		log.info("NoticeVO : "+noticeVO); // uploadFile=[org.spring...)
		if(uploadFile!=null) {
			noticeVO.setUploadFile(uploadFile);
		}
		
		int ntcSeq = this.hdofcNoticeService.noticeInsert(noticeVO); // 공지사항 추가 서비스 호출
		
	    return ntcSeq;
	}
	
	/**
	* @methodName  : updateNoticeDtlAjax
	* @author      : 정기쁨
	* @date        : 2024. 10. 12
	* 공지사항 수정 페이지
	*/
	@ResponseBody
	@PostMapping("/updateNoticeDtlAjax")
	public int updateNoticeDtlAjax(
		@ModelAttribute NoticeVO noticeVO, 
		@RequestParam(value="uploadFile", required = false, defaultValue = "") MultipartFile[] uploadFile
	){
		log.info("NoticeVO : "+noticeVO); // uploadFile=[org.spring...)
		if(uploadFile!=null) {
			noticeVO.setUploadFile(uploadFile);
		}
		
		int ntcSeq = this.hdofcNoticeService.updateNoticeDtlAjax(noticeVO); // 공지사항 수정 서비스 호출
		
	    return ntcSeq;
	}
	
	/**
	* @methodName  : deleteFixd
	* @author      : 정기쁨
	* @date        : 2024. 09. 27
	* 상단 고정 해체
	*/
	@ResponseBody
	@PostMapping("/updateFixd")
	public int updateFixd(@RequestBody List<String> selectedArr){
		
		List<NoticeVO> noticeVOList = new ArrayList<>();

	    for (String selected : selectedArr) {
	        NoticeVO noticeVO = new NoticeVO();
	        int ntcSeq = Integer.parseInt(selected);
	        noticeVO.setNtcSeq(ntcSeq);
	        noticeVOList.add(noticeVO);
	    }
	    
	    int result = this.hdofcNoticeService.updateFixd(noticeVOList);
	    
	    return result;
	}
	
	/**
	 * @methodName  : noticeDelete
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 23
	 * 공지사항 삭제
	 */
	@ResponseBody
	@GetMapping("/noticeDelete")
	public int noticeDelete(@ModelAttribute NoticeVO noticeVO) {
		int result = this.hdofcNoticeService.noticeDelete(noticeVO);
		return result; 
	}
}	














