package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsCheckVO.java
* @author       : 송예진
* @date         : 2024.09.16
* @description  : 가맹점 점검관련 테이블
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.16        송예진     	  			최초 생성
*/
@Data
public class FrcsCheckVO {
	private int rnum;
	
	private int chckSeq; // 순번
	private String frcsNo; // 가맹점 번호
	private String mngrId; // 관리자 아이디
	private String chckYmd; // 점검 일자
	private int clenScr; // 청결 점수
	private int srvcScr; // 서비스 점수
	
	private int totScr; // 전체 점수
	private String totStr; // 전체 점수 문자화 
	
	private String chckCn; // 점검 내용
	
	// 1:1
	private FrcsVO frcsVO; // 가맹점 정보
	
	// 1:1
	private MemberVO insctrVO; // 관리자 정보
}
