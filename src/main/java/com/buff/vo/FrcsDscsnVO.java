package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsDscsnVO.java
* @author       : 송예진
* @date         : 2024.09.13
* @description  : 가맹점 상담 관련 VO
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        송예진     	  			최초 생성
*/
@Data
public class FrcsDscsnVO {
	private String rnum;
	
	private String dscsnCode;
	private String mbrId;
	private String mbrNm;
	private String mbrTelno;
	
	private String mngrId;
	private String dscsnPlanYmd;
	private String rgnNo;
	private String dscsnCn;
	private String dscsnType;
	private String dscsnTypeNm;
	private String frcsNo;
	
	private String rgnNm; // 지역이름
	
	// 1:1 관리자에 대한 정보
	private MemberVO mngrVO;
	
	// 1:1 담당자에 대한 정보
	private MemberVO mbrVO;
	
	// 1:1 개업한 가맹점 정보
	private FrcsVO frcsVO;
}
