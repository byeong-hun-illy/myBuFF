package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : CouponGroupVO.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 쿠폰 그룹 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정현종     	  			최초 생성
*/

@Data
public class CouponGroupVO {
	private String couponCode; // 쿠폰 코드 
	private String menuNo;     // 메뉴 번호
	private String eventNo;    // 이벤트 번호
	private String couponNm;   // 쿠0폰 이름
	private int dscntAmt;      // 할인 가격
	private int issuQty;       // 발급 수량 
	
	// 이벤트 : 메뉴 = 1 : 1
	private MenuVO menuVO;
	
	// 쿠폰그룹(COUPON_GROUP) : 쿠폰(COUPON) = 1 : N
	private List<CouponVO> couponVOList;
	
	private EventVO eventVO;

	
}
