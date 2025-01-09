package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : StockPo.java
* @author       : 이병훈
* @date         : 2024.09.24
* @description  : 발주 상세 테이블
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.24        이병훈     	  			최초 생성
*/
@Data
public class StockPoVO {
	
	private int poSeq;
	private String poNo;
	private String bzentNo;
	private String gdsCode;
	private int qty;
	private int gdsAmt;
	private String spmtYmd;
	
	// 1:1 납품하는 사업체 정보 (보통 거래처에 사용)
	private BzentVO bzentVO;
	
	private GdsVO gdsVO;
}
