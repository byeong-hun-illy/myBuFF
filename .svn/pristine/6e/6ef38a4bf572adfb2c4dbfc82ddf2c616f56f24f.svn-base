package com.buff.hdofc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.buff.com.service.ComService;
import com.buff.hdofc.service.HdofcMenuService;
import com.buff.hdofc.service.MngrService;
import com.buff.util.ArticlePage;
import com.buff.vo.GdsVO;
import com.buff.vo.MenuSetVO;
import com.buff.vo.MenuVO;
import com.buff.vo.RecipeVO;

@Controller
@PreAuthorize("hasRole('ROLE_HDOFC')")
@RequestMapping("/hdofc/menu")
public class HdofcMenuController {
	
	@Autowired
	ComService comService;
	
	@Autowired
	HdofcMenuService menuService;
	
	@Autowired
	MngrService mngrService;
	
	/**
	* @methodName  : selectMenu
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param model
	* @return     : 페이지 이동
	*/
	@GetMapping("/list")
	public String selectMenu(Model model) {
		// 검색 조건 추가
		model.addAttribute("menu", this.comService.selectCom("MENU"));
		model.addAttribute("ntsl", this.comService.selectCom("NTSL"));
		model.addAttribute("mngr", this.mngrService.selectMngrSelect()); // 관리자
		return "hdofc/menu/selectMenu";
	}
	
	/**
	* @methodName  : selectMenuAjax
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 메뉴 조회
	*/
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectMenuAjax(@RequestParam Map<String, Object> map){
		int size = 5;
	    map.put("size", size);
	    List<MenuVO> menuList = this.menuService.selectMenu(map);
	    Map<String, Object> response = this.menuService.selectTotalMenu(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<MenuVO>(total, currentPage, size, menuList, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : selectMenuDtl
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param model
	* @return      : 메뉴 상세 이동
	*/ 
	@GetMapping("/dtl")
	public String selectMenuDtl(Model model) {
		// 검색 조건 추가
		model.addAttribute("menu", this.comService.selectCom("MENU"));
		model.addAttribute("ntsl", this.comService.selectCom("NTSL"));
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/menu/selectMenuDtl";
	}
	
	/**
	 * @methodName  : insertMenu
	 * @author      : 송예진
	 * @date        : 2024.10.01
	 * @param model
	 * @return      : 메뉴 상세 이동
	 */ 
	@GetMapping("/regist")
	public String insertMenu(Model model) {
		// 검색 조건 추가
		model.addAttribute("menu", this.comService.selectCom("MENU"));
		model.addAttribute("ntsl", this.comService.selectCom("NTSL"));
		model.addAttribute("rgn", this.comService.selectCom("RGN"));
		return "hdofc/menu/selectMenuDtl";
	}
	
	/**
	* @methodName  : selectMenuDtlAjax
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param menuNo
	* @return      : 메뉴 상세 정보 가져오기
	*/
	@PostMapping("/dtlAjax")
	@ResponseBody
	public Map<String, Object> selectMenuDtlAjax(@RequestParam String menuNo){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", this.menuService.selectMenuDtl(menuNo));
		return map;
	}
	
	/**
	* @methodName  : selectGdsList
	* @author      : 송예진
	* @date        : 2024.10.01
	* @param map
	* @return      : 상품 추가를 위한 리스트
	*/
	@GetMapping("/gdsList")
	@ResponseBody
	public ArticlePage<GdsVO> selectGdsList(@RequestParam Map<String, Object> map){
		int size = 5;
	    map.put("size", size);
	    List<GdsVO> gdsList = this.menuService.selectGdsFood(map);
	    int total = this.menuService.selectTotalGdsFood(map);
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    return new ArticlePage<GdsVO>(total, currentPage, size, gdsList, map);
	}
	
	
	/**
	* @methodName  : editSetMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map
	* @return      : 세트 메뉴 수정
	*/
	@PostMapping(value = "/editSetAjax", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	@ResponseBody
	public int editSetMenu(@RequestPart("menuVO") MenuVO menuVO,
		    @RequestPart("menuSetVOList") List<MenuSetVO> menuSetVOList,
		    @RequestPart(value = "file", required = false) MultipartFile file) {
		return this.menuService.editSetMenu(menuVO, menuSetVOList, file);
	}
	
	/**
	* @methodName  : editMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param map   
	* @return      : 일반 메뉴 수정
	*/
	@PostMapping(value = "/editAjax", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	@ResponseBody
	public int editMenu(@RequestPart("menuVO") MenuVO menuVO,
			    @RequestPart("recipeVOList") List<RecipeVO> recipeVOList,
			    @RequestPart(value = "file", required = false) MultipartFile file) {
		return this.menuService.editMenu(menuVO, recipeVOList, file);
	}
	
	@PostMapping(value = "/registAjax", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	@ResponseBody
	public String registMenu(@RequestPart("menuVO") MenuVO menuVO,
		    @RequestPart("recipeVOList") List<RecipeVO> recipeVOList,
		    @RequestPart(value = "file", required = false) MultipartFile file) {
		return this.menuService.registMenu(menuVO, recipeVOList, file);
	}
	
	@PostMapping(value = "/registSetAjax", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	@ResponseBody
	public String registSetMenu(@RequestPart("menuVO") MenuVO menuVO,
		    @RequestPart("menuSetVOList") List<MenuSetVO> menuSetVOList,
		    @RequestPart(value = "file", required = false) MultipartFile file) {
		return this.menuService.registSetMenu(menuVO, menuSetVOList, file);
	}
	
	/**
	* @methodName  : deleteSetMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 세트 삭제
	*/
	@PostMapping("/deleteSetAjax")
	@ResponseBody
	public int deleteSetMenu(@RequestParam String menuNo) {
		return this.menuService.removeSetMenu(menuNo);
	}
	
	/**
	* @methodName  : deleteMenu
	* @author      : 송예진
	* @date        : 2024.10.02
	* @param menuNo
	* @return      : 일반 삭제
	*/
	@PostMapping("/deleteAjax")
	@ResponseBody
	public int deleteMenu(@RequestParam String menuNo) {
		return this.menuService.removeMenu(menuNo);
	}
	
}
