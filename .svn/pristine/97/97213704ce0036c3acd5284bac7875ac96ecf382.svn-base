package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.buff.com.mapper.ComMapper;
import com.buff.hdofc.mapper.HdofcMenuMapper;
import com.buff.hdofc.service.HdofcMenuService;
import com.buff.util.UploadController;
import com.buff.vo.ComVO;
import com.buff.vo.GdsVO;
import com.buff.vo.MenuSetVO;
import com.buff.vo.MenuVO;
import com.buff.vo.RecipeVO;
import com.buff.vo.StockPoVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class HdofcMenuServiceImpl implements HdofcMenuService{
	
	@Autowired
	HdofcMenuMapper menuMapper;
	
	@Autowired
	ComMapper comMapper;
	
	@Autowired
	UploadController uploadController;
	
	/**
	* @methodName  : selectMenu
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map   
	* @return      : 메뉴 전체 조회
	*/
	public List<MenuVO> selectMenu(Map<String, Object> map){
		return this.menuMapper.selectMenu(map);
	};
	
	/**
	* @methodName  : selectTotalMenu
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 메뉴 갯수
	*/
	public Map<String, Object> selectTotalMenu(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.menuMapper.selectTotalMenu(map));
		
		List<ComVO> menu = this.comMapper.selectCom("MENU");
		
		for(ComVO comVO : menu) {
			map.put("menuType", comVO.getComNo());
			cnt.put(comVO.getComNo(), this.menuMapper.selectTotalMenu(map));
		}

		map.remove("menuType");
		cnt.put("all", this.menuMapper.selectTotalMenu(map));
		return cnt;
	};
	
	/**
	* @methodName  : selectMenuDtl
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param menuNo
	* @return      : 메뉴상세
	*/
	public MenuVO selectMenuDtl(String menuNo) {
		return this.menuMapper.selectMenuDtl(menuNo);
	};
	
	
	/**
	* @methodName  : selectGdsFood
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 음식 상품 조회
	*/
	public List<GdsVO> selectGdsFood(Map<String, Object> map){
		return this.menuMapper.selectGdsFood(map);
	};
	
	/**
	* @methodName  : selectTotalGdsFood
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 음식 상품 조회 갯수
	*/ 
	public int selectTotalGdsFood(Map<String, Object> map) {
		return this.menuMapper.selectTotalGdsFood(map);
	};
	
	/////////////////// 수정 과정
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
	* @methodName  : editSetMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map
	* @return      : 세트 메뉴 수정
	*/
	@Transactional
	public int editSetMenu(MenuVO menuVO, List<MenuSetVO> menuSetVOList, MultipartFile file) {
		
		if(file!=null && file.getOriginalFilename().length() > 0) {
			String menuImgPath = this.uploadController.imageUpload(file);
			menuVO.setMenuImgPath(menuImgPath);
		}
		
		String menuNo = menuVO.getMenuNo();
		int cnt = this.menuMapper.updateMenu(menuVO);
		cnt += this.menuMapper.deleteRecipe(menuNo);
		cnt += this.menuMapper.deleteSetRecipe(menuNo);
		
		for(MenuSetVO menuSetVO : menuSetVOList) {
			cnt += this.menuMapper.insertMenuSet(menuSetVO);
		}
		cnt += this.menuMapper.insertSetRecipe(menuNo);
		return cnt;
	};
	
	/**
	* @methodName  : editMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map
	* @return      : 일반 메뉴 수정
	*/
	@Transactional
	public int editMenu(MenuVO menuVO, List<RecipeVO> recipeVOList, MultipartFile file) {
		
		if(file!=null && file.getOriginalFilename().length() > 0) {
			String menuImgPath = this.uploadController.imageUpload(file);
			menuVO.setMenuImgPath(menuImgPath);
		}
		String menuNo = menuVO.getMenuNo();
		int cnt = this.menuMapper.updateMenu(menuVO);
		cnt+= this.menuMapper.deleteRecipe(menuNo);
		
		for(RecipeVO recipeVO : recipeVOList) {
			cnt += this.menuMapper.insertRecipe(recipeVO);
		}
		return cnt;
	};
	
	
	/**
	* @methodName  : registSetMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map
	* @return      : 세트메뉴 등록
	*/
	@Transactional
	public String registSetMenu(MenuVO menuVO, List<MenuSetVO> menuSetVOList, MultipartFile file) {
		if(file!=null && file.getOriginalFilename().length() > 0) {
			String menuImgPath = this.uploadController.imageUpload(file);
			menuVO.setMenuImgPath(menuImgPath);
		}
		int cnt = this.menuMapper.insertMenu(menuVO);
		String menuNo = menuVO.getMenuNo();
		for(MenuSetVO menuSetVO : menuSetVOList) {
			menuSetVO.setSetNo(menuNo);
			cnt += this.menuMapper.insertMenuSet(menuSetVO);
		}
		cnt += this.menuMapper.insertSetRecipe(menuNo);
		return menuNo;
		
	};
	
	/**
	* @methodName  : registMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map
	* @return      : 일반 메뉴 등록
	*/
	@Transactional
	public String registMenu(MenuVO menuVO, List<RecipeVO> recipeVOList, MultipartFile file){
		if(file!=null && file.getOriginalFilename().length() > 0) {
			String menuImgPath = this.uploadController.imageUpload(file);
			menuVO.setMenuImgPath(menuImgPath);
		}
		int cnt = this.menuMapper.insertMenu(menuVO);
		String menuNo = menuVO.getMenuNo();
//		String menuNo = null;
		
		for(RecipeVO recipeVO : recipeVOList) {
			recipeVO.setMenuNo(menuNo);
			cnt += this.menuMapper.insertRecipe(recipeVO);
		}
		return menuNo;
	};
	
	/**
	* @methodName  : removeSetMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 세트메뉴 삭제
	*/
	@Transactional
	public int removeSetMenu(String menuNo) {
		int cnt = this.menuMapper.deleteRecipe(menuNo);
		cnt+= this.menuMapper.deleteSetRecipe(menuNo);
		cnt+= this.menuMapper.deleteMenu(menuNo);
		return cnt;
	};
	/**
	* @methodName  : removeMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 일반 메뉴 삭제
	*/
	@Transactional
	public int removeMenu(String menuNo) {
		int cnt = this.menuMapper.deleteRecipe(menuNo);
		cnt += this.menuMapper.deleteMenu(menuNo);
		return cnt;
	};
}
