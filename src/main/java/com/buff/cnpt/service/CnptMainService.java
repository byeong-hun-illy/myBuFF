package com.buff.cnpt.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.CnptCntVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.cnpt.service
* @fileName     : CnptMainService.java
* @author       : 이병훈 
* @date         : 2024.10.11
* @description  : 거래처 메인화면 service interface
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        이병훈     	  			최초 생성
*/
public interface CnptMainService {
	
	/**
	* @methodName  : selectCnt
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @return	   : 거래처 메인화면 - 판매중인 상품, 미판매 상품, 배송완료 건수, 배송중 건수
	*/
	public CnptCntVO selectCnt(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectTotalSalesAmount
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return	   : 매출 총 금액
	*/
	public long selectTotalSalesAmount(Map<String, Object> map);
	
	/**
	* @methodName  : selectSaleData
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 매출 데이터 반환
	*/
	public List<PoClclnVO> selectSaleData(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectProductSales
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return	   : 검색조건에 따른 상품 매출 데이터
	*/
	public List<PoClclnVO> selectProductSales(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectTotalNotClclnAmount
	* @author      : 이병훈
	* @date        : 2024.10.14
	* @param map
	* @return      : 1년간 미정산 총금액
	*/
	public long selectTotalNotClclnAmount(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectUnApprove
	* @author      : 이병훈
	* @date        : 2024.10.14
	* @param map
	* @return      : 미승인 리스트
	*/
	public List<PoVO> selectUnApprove(Map<String, Object> map);
	
}
