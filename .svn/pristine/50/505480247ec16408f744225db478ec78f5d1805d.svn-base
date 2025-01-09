package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsSlsVO.java
* @author       : 정현종
* @date         : 2024.10.03
* @description  : 가맹점 매출 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.03        정현종     	  			최초 생성
*/
@Data
public class FrcsSlsVO {
	private int rnum;
	
	private int slsYm;       // 매출 년월
	private String frcsNo;   // 가맹점 번호
	private long pureAmt;     // 순이익
	private long mngAmt;      // 관리 금액(가맹업주가 직접 입력)
	private long hireAmt;     // 고용 금액(가맹업주가 직접 입력)
	private long sumPoAmt;    // 발주 합계(매출 년월에 해당하는 발주 상품 합계)
	
	private long poAmt;
	private long poNpmntAmt;
	
	// 1:1 (예진 수정)
	private FrcsClclnVO frcsClclnVO;
}
