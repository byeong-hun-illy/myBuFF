package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : NavVO.java
* @author       : 송예진
* @date         : 2024.10.11
* @description  : 메뉴 검색 조건을 위한 VO
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        송예진     	  			최초 생성
*/
@Data
public class NavVO {
	private String navCode;
	private String topNavCode;
	private String navType;
	private String navNm;
	private String navExpln;
	private String navUrl;
	private String useYn;
	private int navSeq;
	
	private String path;
}
