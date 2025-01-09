package com.buff.vo.hdofc;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : HdofcMainCntVO.java
* @author       : 송예진
* @date         : 2024.10.10
* @description  : 메인에 노출한 숫자 
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.10        송예진     	  			최초 생성
*/
@Data
public class HdofcCntVO {
	private int frcsCnt;
	private int custCnt;
	private int cnptCnt;
	private int mngrCnt;
	private int purCnt;
	private int aprvCnt;
	private int deliCnt;
	private int clclnCnt;
	private int dscCnt;
	private int qsCnt;
	private int checkCnt;
	private int clsCnt;
	
	private long purAmt;
	private long sellAmt;
	private long clclnAmt;
}
