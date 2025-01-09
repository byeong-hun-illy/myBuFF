package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.com.mapper.ComMapper;
import com.buff.hdofc.mapper.HdofcAnalyzeMapper;
import com.buff.hdofc.service.HdofcAnalyzeService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.ComVO;
import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.hdofc.service.impl
* @fileName     : HdofcAnalyzeServiceImpl.java
* @author       : 김현빈
* @date         : 2024.10.05
* @description  : 본사 매출 영업분석
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.05               김현빈     	  			최초 생성
*/
@Service
public class HdofcAnalyzeServiceImpl implements HdofcAnalyzeService {
	
	@Inject
	HdofcAnalyzeMapper hdofcAnalyzeMapper;
	
	@Autowired
	ComMapper comMapper;
	
	/**
	* @methodName  : selectAnalyzeList
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 영업분석 메뉴별 모든 판매량 매출 리스트 출력
	*/
	@Override
	public List<MenuVO> selectAnalyzeList(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.selectAnalyzeList(map);
	}
	
	/**
	* @methodName  : menuTotalCnt
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 검색되어진 메뉴의 총 갯수
	*/
	@Override
	public int menuTotalCnt(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.menuTotalCnt(map);
	}
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 메뉴 유형별 갯수
	*/
	@Override
	public Map<String, Object> tapMaxTotal() {
		return this.hdofcAnalyzeMapper.tapMaxTotal();
	}
	
	/**
	* @methodName  : selectBestMenu
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 베스트 메뉴
	*/
	@Override
	public MenuVO selectBestMenu(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.selectBestMenu(map);
	}
	
	/**
	* @methodName  : selectBestDay
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 최고 판매량 피크데이
	*/
	@Override
	public MenuVO selectBestDay(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.selectBestDay(map);
	}
	
	/**
	* @methodName  : selectBestTime
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 최고 판매량 피크타임
	*/
	@Override
	public MenuVO selectBestTime(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.selectBestTime(map);
	}
	
	/**
	* @methodName  : selectTotalAmt
	* @author      : 김현빈
	* @date        : 2024.10.08
	* @param 	   : 
	* @return      : 기간별 판매량 총 액수
	*/
	@Override
	public MenuVO selectTotalAmt(Map<String, Object> map) {
		return this.hdofcAnalyzeMapper.selectTotalAmt(map);
	}

	/**
	* @methodName  : selectCom
	* @author      : 정기쁨
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 지역 셀렉트 박스 조회
	*/
	@Override
	public List<ComVO> selectCom(String string) {
		List<ComVO> rgn = this.comMapper.selectCom("RGN");
		return rgn;
	}

	/** 지역 셀렉트 박스에 따른 가맹점 조회
	 * 요청URI : /hdofc/analyze/selectBzentList
	 * 요청파라미터 : rgnNo
	 * 요청방식 : get
	 */
	@Override
	public List<BzentVO> selectBzentList(String rgnNo) {
		List<BzentVO> bzentVOList = this.hdofcAnalyzeMapper.selectBzentList(rgnNo);
		return bzentVOList;
	}

	/** 가맹점 별 매출 조회
	 * 요청URI : /hdofc/analyze/selectFrcsAnalyzeAjax
	 * 요청파라미터 : let data = {"currentPage":currentPage, "sortField":sortField, "orderby":orderby, 
	 * 						  "rgnNo":rgnNo, "bzentNo":bzentNo, "bgngYmd":bgngYmd, "expYmd":expYmd};
	 * 요청방식 : get
	 */
	@Override
	public Map<String, Object> selectFrcsAnalyzeAjax(Map<String, Object> map) {
		
		int currentPage = (Integer) map.get("currentPage");
		int size = 10;
		map.put("currentPage", currentPage);
		map.put("size", size);
		List<BzentVO> bzentVOList = this.hdofcAnalyzeMapper.selectFrcsAnalyzeAjax(map); // 가맹점 매출 조회
		
		Map<String, Object> response = new HashMap<>();
		
		if (bzentVOList.isEmpty()) {
			response.put("empty", "검색 결과가 없습니다!");
		} else {
			// 응답 데이터를 담을 Map 생성
			int total = bzentVOList.get(0).getTotal();
			response.put("articlePage", new ArticlePage<BzentVO>(total, currentPage, size, bzentVOList, map));
		}
		
		return response;
	}
	
}














