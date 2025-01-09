package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : CouponVO.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 쿠폰 사용 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정현종     	  			최초 생성
*/

@Data
public class CouponVO {
	private String issuSn;     // 쿠폰 일련 번호
	private String couponCode; // 쿠폰  코드
	private String mbrId;      // 회원 아이디
	private String useYn;      // 쿠폰 사용 여부
	private String useYmd;     // 사용 일자
	//임시 프로퍼티
	private String eventNo;

	// 사용가능한 쿠폰 리스트 조회 시 조인조건없이 사용
	private String menuNo;
	private String couponNm;
	private int dscntAmt;
	private String expYmd;
	private String menuNm;
	
	// 쿠폰 : 주문 = 1 : 1
	private OrdrVO ordrVO;
}
