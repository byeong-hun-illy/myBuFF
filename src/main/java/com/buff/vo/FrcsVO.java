package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FrcsVO.java
* @author       : 송예진
* @date         : 2024.09.12
* @description  : 가맹점 관련 정보, 담당 관리자 정보 등을 포함
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        송예진     	  			최초 생성
*/
@Data
public class FrcsVO {
	// 게시판 순서를 매기기위한 정보
	private int rnum;
	
	private String frcsNo;
	private String frcsType;
	
	// 공통코드 조인 
	private String frcsTypeNm;
	
	private int warnCnt;
	private String opbizYmd;
	private String clsbizYmd;
	private String openTm;
	private String ddlnTm;
	
	//1:1 사업체
	private BzentVO bzentVO;
	
	// 1:1 가맹점 폐업 테이블
	private FrcsClsbizVO frcsClsbizVO;
	
	// 1:N 가맹점 정산
	private List<FrcsClclnVO> frcsClclnVOList;
	
	// 1:N 가맹점 매출
	private List<FrcsSlsVO> frcsSlsVOList;
}
