package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.frcs.service
* @fileName     : FrcsMenuSlsService.java
* @author       : 정현종
* @date         : 2024.10.07
* @description  : 가맹점 메뉴 매출 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.07        정현종     	  			최초 생성
*/
public interface FrcsMenuSlsService {
	
	/**
	* @methodName  : selectFrcsMenuSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param 	   : map
	* @return      : 메뉴 매출 리스트
	*/
	public List<MenuVO> selectFrcsMenuSlsList(Map<String, Object> map);

	/**
	 * @methodName  : selectTotalFrcsMenuSlsList
	 * @author      : 정현종
	 * @date        : 2024.10.04
	 * @param       : map
	 * @return	    : 전체 메뉴의 수
	 */
	public int selectTotalFrcsMenuSlsList(Map<String, Object> map);

	/**
	* @methodName  : selectTotalSingle
	* @author      : 정현종
	* @date        : 2024.10.05
	* @param 	   : map
	* @return      : 단품 메뉴의 수
	*/
	public int selectTotalSingle(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalSet
	* @author      : 정현종
	* @date        : 2024.10.05
	* @param       : map
	* @return      : 세트 메뉴의 수
	*/
	public int selectTotalSet(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalSide
	* @author      : 정현종
	* @date        : 2024.10.05
	* @param       : map
	* @return      : 사이드 메뉴의 수
	*/
	public int selectTotalSide(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalDrink
	* @author      : 정현종
	* @date        : 2024.10.05
	* @param       : map
	* @return      : 음료 메뉴의 수
	*/
	public int selectTotalDrink(Map<String, Object> map);
	
	/**
	* @methodName  : selectFrcsMenuSlsListAjax
	* @author      : 정현종
	* @date        : 2024.10.07
	* @param params
	* @return	   : 메뉴별 매출 비율 차트(전체)
	*/
	public List<MenuVO> selectFrcsMenuSlsListAjax(Map<String, Object> map);

	/**
	* @methodName  : selectFrcsMenuTypeSlsListAjax
	* @author      : 정현종
	* @date        : 2024.10.15
	* @param params
	* @return	   : 메뉴별 매출 비율 차트(세트,단품,사이드,음료 선택시)
	*/
	public List<MenuVO> selectFrcsMenuTypeSlsListAjax(Map<String, Object> map);
}
