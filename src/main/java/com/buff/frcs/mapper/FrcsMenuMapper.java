package com.buff.frcs.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.FrcsMenuVO;
import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.mapper.frcs
* @fileName     : FrcsMenuMapper.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 가맹점 판매 메뉴 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12                정현종     	  		      최초 생성
*/

public interface FrcsMenuMapper {
	
	/**
	 * @methodName  : selectAllFrcsMenuList
	 * @author      : 정현종
	 * @date        : 2024.09.13
	 * @param  	   : 검색 조건(메뉴 유형(MENU_TYPE) {MENU02 : 단품, MENU03 : 사이드, MENU04 : 음료, MENU01 : 세트}, 메뉴 이름(MENU_NM))
	 * @return      : 판매 가능 메뉴 목록
	 */
	public List<MenuVO> selectAllFrcsMenuList(Map<String,Object> map);

	/**
	* @methodName  : selectFrcsMenuList
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 검색 조건(메뉴 유형(MENU_TYPE) {MENU02 : 단품, MENU03 : 사이드, MENU04 : 음료, MENU01 : 세트}, 메뉴 이름(MENU_NM))
	* @return      : 매장에서 판매하고 있는 메뉴 목록
	*/
	public List<MenuVO> selectFrcsMenuList(Map<String,Object> map);
	
	/**
	* @methodName  : stopFrcsMenu
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 판매 가능한 메뉴 테이블에 있는 메뉴 번호
	* @return      : 0 또는 1이상
	*/
	public int stopFrcsMenu(FrcsMenuVO frcsMenuVO);
	
	public int setMenuRemove(FrcsMenuVO frcsMenuVO);
	
	/**
	* @methodName  : selectFrcsMenuCount
	* @author      : 정현종
	* @date        : 2024.10.01
	* @param       : map
	* @return      : 메뉴번호가 있는지 확인
	*/
	public int selectFrcsMenuCount(Map<String, Object> map);

	public int insertFrcsMenu(Map<String, Object> map);
	
	/**
	* @methodName  : sellFrcsMenu
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 가맹점에서 판매하는 메뉴 테이블에 있는 메뉴 번호
	* @return      : 0 또는 1이상
	*/
	public int sellFrcsMenu(FrcsMenuVO frcsMenuVO);
	
	public int setMenuAdd(FrcsMenuVO frcsMenuVO);

	
	
}
