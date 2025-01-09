package com.buff.frcs.controller;

import java.security.Principal;
import java.util.HashMap;
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

import com.buff.frcs.service.FrcsMenuService;
import com.buff.vo.MenuVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.frcs.controller
* @fileName     : FrcsMenuController.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 가맹점 판매 메뉴 컨트롤러
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정현종     	  			최초 생성
*/

@PreAuthorize("hasRole('ROLE_FRCS')")
@RequestMapping("/frcs")
@Slf4j
@Controller
public class FrcsMenuController {

	@Autowired
	FrcsMenuService frcsMenuService;

	/**
	 * @methodName : selectFrcsMenuList
	 * @author : 정현종
	 * @date : 2024.09.12
	 * @param : 회원아이디, 메뉴 유형, 메뉴 이름
	 * @return : 메뉴 관리 화면 URL
	 */
	@GetMapping("/menuList")
	public String selectFrcsMenuList(Model model, Principal principal,
			@RequestParam(name = "menuType", required = false, defaultValue = "") String menuType,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword) {

		// principal == CustomUser
		// principal.getName() : 로그인 한 아이디
		String mbrId = principal.getName();

		// [왼쪽 목록]판매 가능 메뉴 목록
		// WHERE FM.FRCS_NO = (SELECT D.BZENT_NO FROM BZENT D WHERE D.MBR_ID = 샵{mbrId})
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);
		map.put("menuType", menuType);
		map.put("keyword", keyword);

		// map{"mbrId":"aw2l8b0g"}
		List<MenuVO> menuVOList = this.frcsMenuService.selectAllFrcsMenuList(map);
		log.info("selectFrcsMenuList->menuVOList : " + menuVOList);

		// [오른쪽 목록]매장에서 판매하고 있는 메뉴 목록
		List<MenuVO> frcsMenuVOList = this.frcsMenuService.selectFrcsMenuList(map);
		log.info("selectFrcsMenuList->frcsMenuVOList : " + frcsMenuVOList);

		model.addAttribute("menuVOList", menuVOList);
		model.addAttribute("frcsMenuVOList", frcsMenuVOList);

		return "frcs/selectFrcsMenuList";
	}

	/**
	 * @methodName : updateFrcsMenuAjax
	 * @author : 정현종
	 * @date : 2024.09.13
	 * @param : Map(왼쪽 테이블 메뉴 번호 리스트, 오른쪽 테이블 메뉴 번호 리스트)
	 * @description : 메뉴관리에서 변경사항을 저장하는 메소드
	 * @return : 0 또는 1이상
	 * 
	 */
	@ResponseBody
	@PostMapping("/updateFrcsMenuAjax")
	public int updateFrcsMenuAjax(@RequestBody Map<String, Object> menuNos) {
		// updateFrcsMenuAjax->bzentNo : FR0303
		String bzentNo = (String) menuNos.get("bzentNo");
		// updateFrcsMenuAjax->leftMenuNos : []
		List<String> leftMenuNos = (List<String>) menuNos.get("leftMenuNos");
		// updateFrcsMenuAjax->rightMenuNos : [BG0001, BG0002, BG0003, BG0004, BG0005,
		// BG0006, BG0007, BG0008, BG0009, BG0010, BG0011, BG0012, BG0013, DK0002,
		// SD0001, SD0002, SD0003, SD0004, SD0005, SD0006, SD0007, SD0008, SD0009,
		// SD0010, SD0011, SD0012, ST0001, ST0002, ST0003, ST0004, ST0005, ST0006,
		// ST0007, ST0008, ST0009, ST0010, ST0011, ST0012, ST0013, DK0001, DK0003]
		List<String> rightMenuNos = (List<String>) menuNos.get("rightMenuNos");

		log.info("updateFrcsMenuAjax->bzentNo : " + bzentNo);
		log.info("updateFrcsMenuAjax->leftMenuNos : " + leftMenuNos);
		log.info("updateFrcsMenuAjax->rightMenuNos : " + rightMenuNos);

		int result = 0;

		// 왼쪽(판매 가능한 메뉴 : N) 업데이트
		if (leftMenuNos != null && !leftMenuNos.isEmpty()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bzentNo", bzentNo);
			map.put("leftMenuNos", leftMenuNos);
			log.info("updateFrcsMenuAjax->map : " + map);
			result += this.frcsMenuService.stopFrcsMenu(map);
		}

		int menuCnt = 0;

		// 메뉴를 추가하기 전 메뉴 번호 확인
		if (rightMenuNos != null && !rightMenuNos.isEmpty()) {
		    Map<String, Object> map = new HashMap<String, Object>();
		    map.put("bzentNo", bzentNo);
		    map.put("rightMenuNos", rightMenuNos);
		    menuCnt = this.frcsMenuService.selectFrcsMenuCount(map);
		    log.info("updateFrcsMenuAjax->menuCnt : " + menuCnt);

		    // 메뉴가 존재하지 않거나, count가 다른 경우 새로운 메뉴 추가
		    if (menuCnt == 0 || menuCnt != rightMenuNos.size()) {
//		        log.info("updateFrcsMenuAjax->menuCnt : " + menuCnt);
		        // 새로운 메뉴를 삽입하는 코드
//		        int cnt = this.frcsMenuService.insertFrcsMenu(map);
//		        log.info("updateFrcsMenuAjax->cnt : " + cnt);
		    }
		}
		
		// 오른쪽(가맹점에서 판매할 메뉴 : Y) 업데이트
		if (rightMenuNos != null && !rightMenuNos.isEmpty() && menuCnt != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bzentNo", bzentNo);
			map.put("rightMenuNos", rightMenuNos);
			log.info("updateFrcsMenuAjax->map : " + map);
			result += this.frcsMenuService.sellFrcsMenu(map);

		}
		
		return result;
	}
}