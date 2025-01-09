package com.buff.hdofc.controller;

import java.util.ArrayList;
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

import com.buff.hdofc.service.HdofcMngrService;
import com.buff.vo.BzentVO;
import com.buff.vo.ComVO;
import com.buff.vo.MemberVO;

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
@RequestMapping("/hdofc/mngr")
@Controller
public class HdofcMngrController {
	
	@Inject
	HdofcMngrService hdofcMngrService;
	
	/**
	* @methodName  : selectMngrList
	* @author      : 정기쁨
	* @date        : 2024. 09. 28
	* 사원 목록
	*/
	@GetMapping("/selectMngrList")
	public String selectMngrList() {
		return "hdofc/mngr/selectMngrList";
	}
	
	/**
	* @methodName  : selectMngrAjax
	* @author      : 정기쁨
	* @date        : 2024. 09. 28
	* 검색, 페이징 처리
	*/
	@ResponseBody
	@GetMapping("/selectMngrAjax")
	public Map<String, Object> selectMngrAjax(@RequestParam Map<String,Object> map){
		Map<String, Object> response = this.hdofcMngrService.selectNoticeAjax(map);
		return response;
	}
	
	/**
	* @methodName  : selectMngrDtl
	* @author      : 정기쁨
	* @date        : 2024. 09. 30
	* 사원 상세
	*/
	@GetMapping("/selectMngrDtl")
	public String selectMngrDtl(Model model,@RequestParam String mngrId) {
		// 사원정보에 필요한 데이터 조회 (사원정보조회, 사원담당업체조회)
		Map<String, Object> mngrMap = this.hdofcMngrService.MngrDtl(mngrId);
		model.addAttribute("mngrMap",mngrMap);
		
		// 지역 번호 select
		List<ComVO> rgn = this.hdofcMngrService.selectCom("RGN");
		model.addAttribute("rgn",rgn);
		
		return "hdofc/mngr/selectMngrDtl";
	}
	
	/**
	* @methodName  : updateMngrInfo
	* @author      : 정기쁨
	* @date        : 2024. 09. 30
	* 사원 정보 변경
	*/
	@ResponseBody
	@PostMapping("/updateMngrInfo")
	public int updateMngrInfo(@RequestBody MemberVO memberVO) {
		int result = this.hdofcMngrService.updateMngrInfo(memberVO);
		return result;
	}
	
	/**
	* @methodName  : updateMngrBzent
	* @author      : 정기쁨
	* @date        : 2024. 09. 30
	* 사원 담당 업체 변경 (추가)
	*/
	@ResponseBody
	@PostMapping("/updateMngrBzent")
	public int updateMngrBzent(@RequestBody BzentVO bzentVO) {
		int result = this.hdofcMngrService.updateMngrBzent(bzentVO);
		return result;
	}
	
	/**
	 * @methodName  : deleteMngrBzent
	 * @author      : 정기쁨
	 * @date        : 2024. 09. 30
	 * 사원 담당 업체 변경 (삭제)
	 */
	@ResponseBody
	@PostMapping("/deleteMngrBzent")
	public void deleteMngrBzent(@RequestBody Map<String,Object> map) {
		System.out.println("map => "+map);
	    this.hdofcMngrService.deleteMngrBzent(map);
	}
	
	/**
	 * @methodName  : selectBzentAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 10. 01
	 * 업체 리스트 출력
	 */
	@ResponseBody
	@PostMapping("/selectBzentAjax")
	public Map<String, Object> selectBzentAjax(@RequestBody Map<String,Object> map){
		Map<String, Object> response = this.hdofcMngrService.selectBzentAjax(map);
		return response;
	}
	
	/**
	 * @methodName  : updateAuthAjax
	 * @author      : 정기쁨
	 * @date        : 2024. 10. 02
	 * 사원 권한 승인
	 */
	@ResponseBody
	@PostMapping("/updateAuthAjax")
	public int updateAuthAjax(@RequestBody List<String> selectedArr){
		List<MemberVO> memberVOList = new ArrayList<>();
	    for (String selected : selectedArr) {
	        MemberVO memberVO = new MemberVO();
	        memberVO.setMbrId(selected);
	        memberVOList.add(memberVO);
	    }
	    int result = this.hdofcMngrService.updateAuthAjax(memberVOList);
	    return result;
	}
	
}	














