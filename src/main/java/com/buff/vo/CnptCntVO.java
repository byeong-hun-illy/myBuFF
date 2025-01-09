package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : CnptCntVO.java
* @author       : 이병훈
* @date         : 2024.10.11
* @description  : 메인에 노출될 숫자
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        이병훈     	  			최초 생성
*/
@Data
public class CnptCntVO {
	private int sellingCnt;			// 판매중인 상품 수
	private int notSellingCnt;		// 미판매중인 상품 수
	private int deliIngCnt;			// 배송중 건 수
	private int deliCompleteCnt;    // 배송완료 건 수
	private int waitApproveCnt;	// 승인대기(= 배송 전) 건 수
	private int NotApproveCnt;	    // 미승인 건 수
}
