package com.buff.com.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;

public interface StockAjmtService {

	/**
	* @methodName  : selectStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param map
	* @return      : 재고 조정 조회
	*/
	public List<StockAjmtVO> selectStockAjmt(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param map
	* @return      : 재고 조정 갯수
	*/
	public Map<String, Object> selectTotalStockAjmt(Map<String, Object> map);
	
	/**
	* @methodName  : deleteAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param ajmtNo
	* @return      : 재고 조정 기록 삭제 updateStock > deleteAjmt
	*/
	public int deleteAjmt(String ajmtNo);
	
	/**
	* @methodName  : insertAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param stockAjmtVO
	* @return      : 재고 조정 폐기 추가 
	*/
	public int insertAjmt(StockAjmtVO stockAjmtVO);

	/**
	* @methodName  : selectStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 재고 조회
	*/
	public List<GdsVO> selectStock(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 재고 갯수 조회
	*/
	public Map<String, Object> selectTotalStock(Map<String, Object> map);
}
