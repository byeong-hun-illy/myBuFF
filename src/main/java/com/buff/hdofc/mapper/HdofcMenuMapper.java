package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.GdsVO;
import com.buff.vo.MenuSetVO;
import com.buff.vo.MenuVO;
import com.buff.vo.RecipeVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcMenuMapper.java
* @author       : 송예진
* @date         : 2024.10.01
* @description  : 본사 메뉴 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        송예진     	  			최초 생성
*/
@Mapper
public interface HdofcMenuMapper {
	
	/**
	* @methodName  : selectMenu
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map   
	* @return      : 메뉴 전체 조회
	*/
	public List<MenuVO> selectMenu(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalMenu
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 메뉴 갯수
	*/
	public int selectTotalMenu(Map<String, Object> map);
	
	/**
	* @methodName  : selectMenuDtl
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param menuNo
	* @return      : 메뉴상세
	*/
	public MenuVO selectMenuDtl(String menuNo);
	
	/**
	* @methodName  : selectGdsFood
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 음식 상품 조회
	*/
	public List<GdsVO> selectGdsFood(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalGdsFood
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 음식 상품 조회 갯수
	*/ 
	public int selectTotalGdsFood(Map<String, Object> map);
	
	////////// 수정 삭제
	// 메뉴 등록시
	// 세트 insertMenu > insertMenuSet > insertSetRecipe
	// 일반 insertMenu > insertRecipe
	
	// 수정 시
	// 세트 updateMenu > deleteRecipe > deleteSetRecipe > insertMenuSet > insertSetRecipe
	// 일반 updateMenu > deleteRecipe > insertRecipe
	
	// 삭제 시 (출시일 이전의 것만 삭제가능)
	// 세트 deleteRecipe > deleteSetRecipe > deleteMenu
	// 일반 deleteRecipe > deleteMenu
	 
	/**
	* @methodName  : updateMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuVO
	* @return      : 메뉴 수정(일반, 세트)
	*/
	public int updateMenu(MenuVO menuVO);
	
	/**
	* @methodName  : deleteSetRecipe
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param setNo
	* @return      : 세트 레시피 삭제(MENU_SET)
	*/
	public int deleteSetRecipe(String setNo);
	
	/**
	* @methodName  : insertMenuSet
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuSetVO
	* @return      : 세트 메뉴 insert(MENU_SET)
	*/
	public int insertMenuSet(MenuSetVO menuSetVO);
	
	/**
	* @methodName  : insertSetRecipe
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param setNo
	* @return      : 세트 메뉴 토대로 레시피 등록
	*/
	public int insertSetRecipe(String setNo);
	
	/**
	* @methodName  : deleteRecipe
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 레시피 삭제
	*/
	public int deleteRecipe(String menuNo);
	
	/**
	* @methodName  : insertRecipe
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param recipeVO
	* @return      : 레시피 추가
	*/
	public int insertRecipe(RecipeVO recipeVO);
	
	/**
	* @methodName  : insertMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuVO
	* @return      : 메뉴 등록
	*/
	public int insertMenu(MenuVO menuVO);
	
	/**
	* @methodName  : deleteMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 메뉴 삭제
	*/
	public int deleteMenu(String menuNo);
}
