package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsMenuVO.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 가맹점 판매 메뉴 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정현종     	  			최초 생성
*/
@Data
public class FrcsMenuVO {
	private String frcsNo; 		//가맹점 번호
	private String menuNo; 		//메뉴 번호
	private String ntslYn; 		//판매 여부
	private String menuRegYmd;  //가맹점 메뉴 등록 일자
	
	
	// 가맹점 메뉴(FRCS_MENU) : 주문 상세(ORDR_DTL) => 1 : N
	private List<OrdrDtlVO> ordrDtlVOList;
	
}
