package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : MenuSetVO.java
* @author       : 송예진
* @date         : 2024.10.01
* @description  : 세트메뉴 VO
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        송예진     	  			최초 생성
*/
@Data
public class MenuSetVO {
	private String setNo;
	private String menuNo;
	
	// 조인 조건
	private String menuNm;
	private String menuType;
	private String menuTypeNm;
	private int menuAmt;
	
	private int qty;
	
	// 1:1
	private MenuVO setVO;
	
	// 1:1
	private MenuVO menuVO;
}
