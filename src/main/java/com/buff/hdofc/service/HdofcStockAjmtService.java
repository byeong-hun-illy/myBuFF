package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.GdsVO;

/**
* @packageName  : com.buff.hdofc.service
* @fileName     : HdofcStockAjmtService.java
* @author       : 김현빈
* @date         : 2024.10.01
* @description  : 판매 상품 소모량 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.04               김현빈     	  			최초 생성
*/
public interface HdofcStockAjmtService {
	
	/**
	* @methodName  : selectStockAjmtList
	* @author      : 김현빈
	* @date        : 2024.10.04
	* @param 	   : map
	* @return      : 판매 상품 소모량의 모든 리스트 출력
	*/
	public List<GdsVO> selectStockAjmtList(Map<String, Object> map);
	
	/**
	* @methodName  : selectStockAjmtList
	* @author      : 김현빈
	* @date        : 2024.10.04
	* @param 	   : map
	* @return      : 판매 상품 소모량의 모든 리스트 출력
	*/
	public int stockAjmtTotalCnt(Map<String, Object> map);
	
}
