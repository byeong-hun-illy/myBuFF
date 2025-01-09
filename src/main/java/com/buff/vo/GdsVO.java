package com.buff.vo;

import java.util.List;
import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : GdsVO.java
* @author       : 정현종
* @date         : 2024.09.20
* @description  : 상품 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.20        정현종     	  			최초 생성
*/

@Data
public class GdsVO {
	
	private int rnum; // 행번호
	
	private String gdsCode; // 상품코드
	private String gdsNm;   // 상품이름
	private String gdsType; // 상품유형
	private String gdsTypeNm; // 상품유형이름
	private String unitNm;  // 단위명
	private String regYmd;  // 등록일자
	private String mbrId; // 상품 등록한 사람
	
	// 상품(Gds) : 재고 현황(Stock) => 1 : N
	private List<StockVO> stockVOList;
	
	private MemberVO mbrVO;
}                          
