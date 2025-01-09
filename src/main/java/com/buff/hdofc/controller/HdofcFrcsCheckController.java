package com.buff.hdofc.controller;

import java.util.List;
import java.util.Map;

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
import com.buff.hdofc.service.HdofcFrcsCheckService;
import com.buff.hdofc.service.MngrService;
import com.buff.util.ArticlePage;
import com.buff.util.CheckScore;
import com.buff.vo.FrcsCheckVO;

import lombok.extern.slf4j.Slf4j;
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/frcs/check")
@Controller
@Slf4j
public class HdofcFrcsCheckController {
	
	@Autowired
	HdofcFrcsCheckService checkService;
	
	@Autowired
	ComService comService;
	
	@Autowired
	MngrService mngrService;
	
	/**
	* @methodName  : insertCheckForm
	* @author      : 송예진
	* @date        : 2024.09.19
	* @return      : 점검 추가 페이지
	*/
	@GetMapping("/regist")
	public String insertCheckForm(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("mngr", this.mngrService.selectMngrSelect());
		return "hdofc/frcs/insertFrcsCheck";
	}

	/**
	* @methodName  : selectFrcs
	* @author      : 송예진
	* @date        : 2024.09.19
	* @return      : 점검이 필요한 가맹점 조회+전체 조회
	*/
	@ResponseBody
	@GetMapping("/frcsList")
	public Map<String, Object> selectFrcs(@RequestParam Map<String, Object> map){
		int size = 5;
		map.put("size", size);
		List<FrcsCheckVO> frcsCheckList = this.checkService.selectFrcs(map);
		Map<String, Object> response = this.checkService.selectTotalFrcs(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<FrcsCheckVO>(total, currentPage, size, frcsCheckList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : insertFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 가맹점 점검 추가
	*/
	@ResponseBody
	@PostMapping("/registAjax")
	public String insertFrcsCheck(@RequestBody FrcsCheckVO frcsCheckVO) {
		// 점검 추가
		this.checkService.insertFrcsCheck(frcsCheckVO);
		
		// 경고 확인
		int totScr = frcsCheckVO.getClenScr() + frcsCheckVO.getSrvcScr();
		String totStr = CheckScore.evaluateGrade(totScr);
		if(totStr.equals("F")) {
			String frcsNo = frcsCheckVO.getFrcsNo();
			this.checkService.updateWarn(frcsNo);
			int warnCnt = this.checkService.selectWarn(frcsNo);
			
			// 경고 횟수가 3회 되었을 경우 폐업 처리
			if(warnCnt>=3) {
				this.checkService.updateFrcsCls(frcsNo);
				this.checkService.insertFrcsClsbiz(frcsNo);
				return "clsbiz";
			}
		}
		
		return "ok";
	}
	
	
	//////////// 점검 조회
	
	/**
	* @methodName  : selectCheck
	* @author      : 송예진
	* @date        : 2024.09.19
	* @return      : 점검 조회 리스트로 이동
	*/
	@GetMapping("/list")
	public String selectCheck(Model model) {
		// 검색 조건
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		model.addAttribute("mngr", this.mngrService.selectMngrSelect());
		return "hdofc/frcs/selectFrcsCheck";
	}
	
	/**
	* @methodName  : selectFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param map   : 검색 조건
	* @return      : 가맹점 조회
	*/
	@ResponseBody
	@GetMapping("/listAjax")
	public ArticlePage<FrcsCheckVO> selectFrcsCheck(@RequestParam Map<String, Object> map){
		int size = 10;
	    int total = this.checkService.selectTotalFrcsCheck(map);
	    map.put("size", size);
	    List<FrcsCheckVO> frcsCheckList = this.checkService.selectFrcsCheck(map);
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    return new ArticlePage<FrcsCheckVO>(total, currentPage, size, frcsCheckList, map); // 여러 데이터를 포함한 Map 반환
		
	};
	
	//////////////////// 점검 상세
	
	/**
	* @methodName  : selectFrcsCheckDtl
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param frcsCheckVO(frcsNo, chckSeq)
	* @return      : 점검 상세
	*/
	@ResponseBody
	@PostMapping("/dtlAjax")
	public FrcsCheckVO selectFrcsCheckDtl(@RequestBody FrcsCheckVO frcsCheckVO) {
		return this.checkService.selectFrcsCheckDtl(frcsCheckVO);
	}
	
	/**
	* @methodName  : deleteFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param frcsCheckVO
	* @return      : 점검 삭제
	*/
	@ResponseBody
	@PostMapping("/delete")
	public String deleteFrcsCheck(@RequestBody FrcsCheckVO frcsCheckVO) {
		
		this.checkService.deleteFrcsCheck(frcsCheckVO);
		String frcsNo = frcsCheckVO.getFrcsNo();
		String totStr = frcsCheckVO.getTotStr();
		log.info(frcsNo+"와"+totStr);
		if(totStr.equals("F")) {
			// 경고 횟수 확인
			int warnCnt = this.checkService.selectWarn(frcsNo);
			
			// 경고 차감
			this.checkService.deleteWarn(frcsNo);
			
			// 폐업 취소 처리
			if(warnCnt>=3) {
				// 이미 폐업이 된 상태인지 조회
				String frcsType = this.checkService.selectFrcsType(frcsNo);
				// 이미 폐업된 상태라면 폐업이 취소되지 않음
				if(frcsType.equals("FRS02")) {
					return "ok";
				}
				// 본사가 강제 폐업 조치를 한경우에만 삭제
				int cnt = this.checkService.cancelFrcsClsbiz(frcsNo);
				
				// 본사가 강제 폐업을 해서 폐업을 당한 경우에 frcs운영타입 변경
				if(cnt>0) {
					// 상태 운영과 변경
					this.checkService.cancelFrcs(frcsNo);
					return "clsbiz";
				}
			} 
		}
		return "ok";
	}

}