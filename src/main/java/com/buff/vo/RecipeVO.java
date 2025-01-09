package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : RecipeVO.java
* @author       : 송예진
* @date         : 2024.10.01
* @description  : 메뉴 레시피
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        송예진     	  			최초 생성
*/
@Data
public class RecipeVO {
	private String gdsCode;
	private String menuNo;
	private double qty;
	
	private GdsVO gdsVO;
}
