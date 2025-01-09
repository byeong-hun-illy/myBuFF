package com.buff.vo;

import lombok.Data;

@Data
public class OrdrDtlVO {
	private String ordrNo;
	private String frcsNo;
	private String menuNo;
	private int ordrQty;
	private int ordrAmt;
	private int ordrQtySum;
	private long ordrAmtSum;
	
	private String period;
	
	private OrdrVO ordrVO;
	
	// 주문 상세 : 가맹점 = 1 : 1
	private BzentVO bzentVO;
	
	private int totalOrdrAtm; // 총 주문 금액 
}

