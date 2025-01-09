package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcGdsMapper.java
* @author       : 송예진
* @date         : 2024.09.25
* @description  : 상품관리, 재고관리, 안전재고관리, 상품소모량 조회
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.25        송예진     	  			최초 생성
*/
@Mapper
public interface HdofcGdsMapper {
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
}
