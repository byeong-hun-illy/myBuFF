package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : PoVO.java
* @author       : 김현빈
* @date         : 2024.09.13
* @description  : 발주, 배송상태, 발주 승인여부 등을 포함
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        송예진     	  			최초 생성
*/

@Data
public class PoVO {
	// 페이징처리 행번호
	private int rnum;
	
	private String poNo;
	private String bzentNo;
	private String deliYmd;
	private String deliType;
	
	// 공통코드 조인
	private String deliTypeNm;
	
	// 반려 사유 추가
	private String rjctRsn;
	// 예진
	// 1:N 발주에 대한 여러 상세 내용 
	private List<StockPoVO> stockPoVOList;
	
	// 1:1 발주를 신청한 사업체의 정보 (보통 가맹점을 위해 사용)
	private BzentVO bzentVO;
	
	// 1:1 발주 하나당 해당하는 정산정보
	private PoClclnVO poClclnVO;
	
	private long clclnAmt; // 정산금액
	
}
