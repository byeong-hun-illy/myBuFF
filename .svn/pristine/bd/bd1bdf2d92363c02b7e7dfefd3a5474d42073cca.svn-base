package com.buff.frcs.mapper;

import java.util.Map;

import com.buff.vo.GdsVO;
import java.util.List;

/**
 * @packageName  : com.buff.frcs.mapper
 * @fileName     : FrcsStockMapper.java
 * @author       : 정현종
 * @date         : 2024.09.20
 * @description  : 가맹점 재고 현황 Mapper
 * ===========================================================
 * DATE              AUTHOR             NOTE
 * -----------------------------------------------------------
 * 2024.09.20                정현종     	  		      최초 생성
 */
public interface FrcsStockMapper {
	
	/**
	* @methodName  : selectFrcsStockList
	* @author      : 정현종
	* @date        : 2024.09.20
	* @param  	   : 
	* @return      : 가맹점 재고 현황 목록
	*/
	public List<GdsVO> selectFrcsStockList (Map<String, Object> map);

	/**
	* @methodName  : selectFrcsStockList
	* @author      : 정현종
	* @param       : map 
	* @date        : 2024.09.20
	* @param  	   : 
	* @return      : 가맹점 재고 총 갯수 
	*/
	public int selectTotalFrcsStock(Map<String, Object> map);
	
	/**
	* @methodName  : selectFrcsStockDetail
	* @author      : 정현종
	* @date        : 2024.09.24
	* @param  	   : 회원아이디, 상품 번호
	* @return      : 가맹점 재고 상세
	*/
	public GdsVO selectFrcsStockDetail(Map<String, Object> map);

	/**
	* @methodName  : safeStockFrcsUpdateAjax
	* @author      : 정현종
	* @date        : 2024.09.24
	* @param  	   : 회원아이디, 상품 번호
	* @return      : 가맹점 안전 재고 설정
	*/
	public int safeStockFrcsUpdateAjax(Map<String, Object> map);	
	
	/**
	* @methodName  : stockAjmtFrcsInsertAjax
	* @author      : 정현종
	* @date        : 2024.09.25
	* @param       : 조정 수량
	* @return      : 재고 조정 (입력 성공 : 1, 입력 실패 : 0)
	*/
	public int stockAjmtFrcsInsertAjax(Map<String, Object> map);

	/**
	* @methodName  : stockFrcsUpdateAjax
	* @author      : 정현종
	* @date        : 2024.09.25
	* @param 	   : 조정 번호
	* @return	   : 재고 조정 (수정 성공 : 1, 수정 실패 : 0)
	*/
	public int stockFrcsUpdateAjax(Map<String, Object> map);
	
	/**
	* @methodName  : selectFdStock
	* @author      : 정현종
	* @date        : 2024.09.26
	* @return	   : 전체 재고 갯수
	*/
	public int selectAllstock(Map<String, Object> map);

	/**
	* @methodName  : selectFdStock
	* @author      : 정현종
	* @date        : 2024.09.26
	* @return	   : 식품 재고 갯수
	*/
	public int selectFdStock(Map<String, Object> map);
	
	/**
	* @methodName  : selectSmStock
	* @author      : 정현종
	* @date        : 2024.09.26
	* @return 	   : 부자재 재고 갯수
	*/
	public int selectSmStock(Map<String, Object> map);
	
	/**
	* @methodName  : selectPmStock
	* @author      : 정현종
	* @date        : 2024.09.26
	* @return	   : 포장재 재고 갯수
	*/
	public int selectPmStock(Map<String, Object> map);
}
