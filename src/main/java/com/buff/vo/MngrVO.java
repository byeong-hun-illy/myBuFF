package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : MngrVO.java
* @author       : 송예진
* @date         : 2024.09.13
* @description  : 관리자 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        송예진     	  			최초 생성
*/
@Data
public class MngrVO {
	// 순번
	private int rnum;
	
	private String mngrId;
	private String mngrType; // 관리자 유형
	private String mngrTypeNm; // 관리자 유형
	private String jncmpYmd; // 입사 일자
	private String hdofYn; // 재직 여부
	private String rtrmYmd; // 퇴직 일자
	
	// 1:1 회원 정보
	private MemberVO mbrVO;
	private MemberVO memberVO;
	
	// 관리자 : 사업체 = 1 : N
	private List<BzentVO> bzentVOList;
	private String frcsNames;   // 담당 가맹점 (LISTAGG로 생성된 문자열)
    private String cnptNames;  // 담당 거래처 (LISTAGG로 생성된 문자열)
    
    // 관리자 : 권한 = 1 : 1
    private AuthVO authVO;
    
}
