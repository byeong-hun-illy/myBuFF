package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.frcs.mapper.FrcsMenuMapper;
import com.buff.frcs.service.FrcsMenuService;
import com.buff.vo.FrcsMenuVO;
import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.service.frcs.impl
* @fileName     : FrcsMenuServiceImpl
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 가맹점 판매 메뉴 ServiceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12                정현종     	  		      최초 생성
*/
@Service
public class FrcsMenuServiceImpl implements FrcsMenuService {
	
	@Autowired
	FrcsMenuMapper frcsMenuMapper;
	
	/**
	 * @methodName  : selectAllFrcsMenuList
	 * @author      : 정현종
	 * @date        : 2024.09.13
	 * @param  	    : 검색 조건(메뉴 유형(MENU_TYPE) {MENU02 : 단품, MENU03 : 사이드, MENU04 : 음료, MENU01 : 세트}, 메뉴 이름(MENU_NM))
	 * @return      : 판매 가능 메뉴 목록
	 */
	@Override
	public List<MenuVO> selectAllFrcsMenuList(Map<String,Object> map) {
		return this.frcsMenuMapper.selectAllFrcsMenuList(map);
	}

	/**
	* @methodName  : selectFrcsMenuList
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 검색 조건(메뉴 유형(MENU_TYPE) {MENU02 : 단품, MENU03 : 사이드, MENU04 : 음료, MENU01 : 세트}, 메뉴 이름(MENU_NM))
	* @return      : 매장에서 판매하고 있는 메뉴 목록
	*/
	@Override
	public List<MenuVO> selectFrcsMenuList(Map<String,Object> map) {
		return this.frcsMenuMapper.selectFrcsMenuList(map);
	}
	
	/**
	* @methodName  : stopFrcsMenu
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 판매 가능한 메뉴 테이블에 있는 메뉴 번호
	* @return      : 0 또는 1이상
	*/
	@Override
	@Transactional
	public int stopFrcsMenu(Map<String, Object> map) {
		List<String> leftMenuNos = (List<String>) map.get("leftMenuNos");
		String frcsNo = (String) map.get("bzentNo");
		int cnt = 0;
		for (String menuNo : leftMenuNos) {
			FrcsMenuVO frcsMenuVO = new FrcsMenuVO();
			frcsMenuVO.setFrcsNo(frcsNo);
			frcsMenuVO.setMenuNo(menuNo);
			cnt += this.frcsMenuMapper.stopFrcsMenu(frcsMenuVO);
			cnt += this.frcsMenuMapper.setMenuRemove(frcsMenuVO);
		}
		return cnt;
	}
	
	/**
	* @methodName  : sellFrcsMenu
	* @author      : 정현종
	* @date        : 2024.09.12
	* @param  	   : 가맹점에서 판매하는 메뉴 테이블에 있는 메뉴 번호
	* @return      : 0 또는 1이상
	*/
	@Override
	@Transactional
	public int sellFrcsMenu(Map<String,Object> map) {
		List<String> rightMenuNos = (List<String>) map.get("rightMenuNos");
		String frcsNo = (String) map.get("bzentNo");
		int cnt = 0;
		for(String menuNo : rightMenuNos) {
			FrcsMenuVO frcsMenuVO = new FrcsMenuVO();
			frcsMenuVO.setFrcsNo(frcsNo);
			frcsMenuVO.setMenuNo(menuNo);
			cnt += this.frcsMenuMapper.sellFrcsMenu(frcsMenuVO);
			cnt += this.frcsMenuMapper.setMenuAdd(frcsMenuVO);
		}
		return cnt;
	}
	
	/**
	* @methodName  : selectFrcsMenuCount
	* @author      : 정현종
	* @date        : 2024.10.01
	* @param       : map
	* @return      : 메뉴번호가 있는지 확인
	*/
	@Override
	public int selectFrcsMenuCount(Map<String, Object> map) {
		return this.frcsMenuMapper.selectFrcsMenuCount(map);
	}

	@Override
	public int insertFrcsMenu(Map<String, Object> map) {
		return this.frcsMenuMapper.insertFrcsMenu(map);
	}
}
