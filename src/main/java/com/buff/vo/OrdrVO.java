package com.buff.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : OrdrVO.java
* @author       : 정현종
* @date         : 2024.10.03
* @description  : 주문 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.03        정현종     	  			최초 생성
*/
@Data
public class OrdrVO {
	private int rnum;
	private String ordrNo;
	private Date ordrDt;
	private String bestDay;
	private String bestTime;
	private String ordrType;
	private String spmtYn;
	private String mbrId;
	private String issuSn;
	
	private int month; // 월
	
	private long totalamt; // 검색조건에 해당하는 매출 금액
	private long dailysalesCnt; // 당일 판매 횟수
	private long dailysales; // 당일 매출 금액
	private long maxdailysales; // 최고 일일 매출 금액
	
	// 주문 : 주문상세 = 1 : N
	private List<OrdrDtlVO> ordrDtlVOList;
	
	// 주문 
	private CouponVO couponVO;
}
