package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;

public interface HdofcGdsService {
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
	
	
	/// 상품 추가
	/**
	* @methodName  : insertGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsVO(gdsNm, gdsType, unitNm, mbrId)
	* @return      : 상품 추가
	*/
	public int insertGds(GdsVO gdsVO);
	
	/**
	* @methodName  : insertGdsAmt
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsAmtVO(bzentNo, gdsCode, amt)
	* @return      : 상품단가 추가
	*/
	public int insertGdsAmt(GdsAmtVO gdsAmtVO);
	
	/**
	* @methodName  : insertAllGds
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param map
	* @return      : gds와 gdsAmt동시 처리, 상세정보 이동을 위해 gdsCode를 보냄
	*/
	public String insertAllGds(Map<String, Object> map);
	
	/**
	* @methodName  : insertStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsAmtVO
	* @return      : 단가 추가시 선행 작업, stock테이블에 추가
	*/
	public int insertStock(GdsAmtVO gdsAmtVO);
	
	/**
	* @methodName  : selectStockDtl
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsCode
	* @return      : 상품상세
	*/
	public GdsVO selectStockDtl(StockVO stockVO);
	
	
	/**
	* @methodName  : selectUpdateChk
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param stockVO
	* @return      : 상품을 수정 삭제할지 확인
	*/
	public int selectUpdateChk(StockVO stockVO);
	
	/**
	* @methodName  : deleteGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsCode
	* @return      : 상품 삭제
	*/
	public int deleteGds(String gdsCode);
	
	/**
	* @methodName  : updateGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsVO
	* @return      : 상품 수정
	*/
	public int updateGds(GdsVO gdsVO);
	
	/**
	* @methodName  : updateSfStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param stockVO
	* @return      : 안전 재고 변경
	*/
	public int updateSfStock(StockVO stockVO);
	
	/**
	* @methodName  : updateAllStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 안전재고와 선택적으로 단가 추가
	*/
	public int updateAllStock(Map<String, Object> map);
}
