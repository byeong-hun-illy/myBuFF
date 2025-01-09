package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : BzentVO.java
* @author       : 송예진
* @date         : 2024.09.12
* @description  : 사업체의 전반적인 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        송예진     	  			최초 생성
*/
@Data
public class BzentVO {
	private int rnum;
	private int total;
	
	private String bzentNo;
	private String mbrId;
	private String mngrId;
	private String bzentTelno;
	private String bzentNm;
	private String regYmd;
	
	private String rgnNo;
	private String rgnNm; // 이름
	
	private String bzentZip;
	private String bzentAddr;
	private String bzentDaddr;
	private String bzentType; // 거래처 유형 (본사,가맹점,식품,부자재,포장재)
	private String bzentTypeNm; // 거래처 물품 유형 (식품,부자재,포장재)
	private String actno;
	private String bankType;
	
	// 공통코드 조인 (은행명 타입)
	private String bankTypeNm;
	
	// 1:1 관리자에 대한 정보
	private MemberVO mngrVO;
	
	// 1:1 담당자에 대한 정보
	private MemberVO mbrVO;
	private MemberVO memberVO;
	
	// 1:N 발주에 대한 정보
	private List<PoVO> poVOList;
	
	
	// 즐겨찾기
	private int favChk;
	private String openTm;
	private String ddlnTm;
	
	//가맹점 : 메뉴 = 1 : N
	private List<MenuVO> menuVOList;
	
	// 매출 합계
	private long salesSum;
	
}
