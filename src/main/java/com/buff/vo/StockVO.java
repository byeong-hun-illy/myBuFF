package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : StockVO.java
* @author       : 정현종
* @date         : 2024.09.20
* @description  : 재고 현황 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.20        정현종     	  			최초 생성
*/
@Data
public class StockVO {
	
	private String gdsCode;  // 상품 코드
	private String bzentNo;  // 사업체 번호
	private double qty;         // 수량
	private double sfStockQty;  // 안전 재고 수량
	private String ntslType; // 판매 여부
	private String ntslTypeNm; // 판매 여부
	
	private int ntslQty; // 판매 대기 중인 수량
	private int aprvQty; // 승인 대기중인 수량
	
	// 상품단가 테이블 : 재고 테이블 = 1:1 관계
	private List<GdsAmtVO> gdsAmtVOList;
	
	// 재고와 상품 연결 1:1
	private GdsVO gdsVO;
	
	// 재고 테이블 : 발주 상세 테이블 = 1 : N 관계
	private List<StockPoVO> stockPoVOList;
	
	// 재고 현황(STOCK) : 재고 조정(STOCK_AJMT) = 1 : N
	private List<StockAjmtVO> stockAjmtVOList;
	
	// 1:1
	private BzentVO bzentVO;
	
	
}
