package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsClclnVO.java
* @author       : 송예진
* @date         : 2024.09.21
* @description  : 가맹점 정산 VO
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.21        송예진     	  			최초 생성
*/
@Data
public class FrcsClclnVO {
	private int rnum;
	
	private int clclnYm;
	private String frcsNo;
	private String clclnYmd;
	private String clclnYn;
	private int slsGramt;
	private int royalty;
	private int dscntAmt;
	private int npmntAmt;
	private String regYmd;
	
	private String actno;
	private String bankType;
	private String bankTypeNm;
	
	private BzentVO bzentVO;
}
