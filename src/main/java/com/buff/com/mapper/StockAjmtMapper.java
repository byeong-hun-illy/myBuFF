package com.buff.com.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;

@Mapper
public interface StockAjmtMapper{

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
	public int selectTotalStockAjmt(Map<String, Object> map);
	
	/**
	* @methodName  : deleteAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param ajmtNo
	* @return      : 재고 조정 기록 삭제 updateStock > deleteAjmt
	*/
	public int deleteAjmt(String ajmtNo);
	
	/**
	* @methodName  : updateStock
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param ajmtNo
	* @return      : 재고 조정 삭제시 재고 변경
	*/
	public int updateStock(String ajmtNo);
	
	/**
	* @methodName  : insertAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param stockAjmtVO
	* @return      : 재고 조정 폐기 추가 
	*/
	public int insertAjmt(StockAjmtVO stockAjmtVO);
	
	/**
	* @methodName  : updateDisStock
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param stockAjmtVO
	* @return 재고 조정 폐기 추가 후 재고 변경
	*/
	public int updateDisStock(StockAjmtVO stockAjmtVO);
	
	
	/// 상품 조회
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
	public int selectTotalStock(Map<String, Object> map);
	
}
