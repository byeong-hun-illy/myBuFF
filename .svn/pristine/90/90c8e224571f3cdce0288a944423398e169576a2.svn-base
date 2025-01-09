package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.BzentVO;
import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcAnalyzeMapper.java
* @author       : 김현빈
* @date         : 2024.10.05
* @description  : 본사 매출 영업분석
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.05               김현빈     	  			최초 생성
*/
public interface HdofcAnalyzeMapper {
	
	/**
	* @methodName  : selectAnalyzeList
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 영업분석 메뉴별 모든 판매량 매출 리스트 출력
	*/
	public List<MenuVO> selectAnalyzeList(Map<String, Object> map);
	
	/**
	* @methodName  : menuTotalCnt
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 검색되어진 메뉴의 총 갯수
	*/
	public int menuTotalCnt(Map<String, Object> map);
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.10.05
	* @param 	   : 
	* @return      : 메뉴 유형별 갯수
	*/
	public Map<String, Object> tapMaxTotal();
	
	/**
	* @methodName  : selectBestMenu
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 베스트 메뉴
	*/
	public MenuVO selectBestMenu(Map<String, Object> map);
	
	/**
	* @methodName  : selectBestDay
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 최고 판매량 피크데이
	*/
	public MenuVO selectBestDay(Map<String, Object> map);
	
	/**
	* @methodName  : selectBestTime
	* @author      : 김현빈
	* @date        : 2024.10.07
	* @param 	   : 
	* @return      : 최고 판매량 피크타임
	*/
	public MenuVO selectBestTime(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalAmt
	* @author      : 김현빈
	* @date        : 2024.10.08
	* @param 	   : 
	* @return      : 기간별 판매량 총 액수
	*/
	public MenuVO selectTotalAmt(Map<String, Object> map);

	/** 지역 셀렉트 박스에 따른 가맹점 조회
	 * 요청URI : /hdofc/analyze/selectBzentList
	 * 요청파라미터 : rgnNo
	 * 요청방식 : get
	 */
	public List<BzentVO> selectBzentList(String rgnNo);

	/** 가맹점 별 매출 조회
	 * 요청URI : /hdofc/analyze/selectFrcsAnalyzeAjax
	 * 요청파라미터 : let data = {"currentPage":currentPage, "sortField":sortField, "orderby":orderby, 
	 * 						  "rgnNo":rgnNo, "bzentNo":bzentNo, "bgngYmd":bgngYmd, "expYmd":expYmd};
	 * 요청방식 : get
	 */
	public List<BzentVO> selectFrcsAnalyzeAjax(Map<String, Object> map);
	
}
