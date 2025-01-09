package com.buff.cnpt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;
import com.buff.vo.StockVO;

/**
* @packageName  : com.buff.cnpt.service
* @fileName     : CnptStockService.java
* @author       : 이병훈
* @date         : 2024.10.01
* @description  : 거래처 재고 관련 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        이병훈     	  			최초 생성
*/
public interface CnptStockService {

	/**
	* @methodName  : insertStockQty
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param map
	* @return      : 재고 조정 추가
	*/
	public int insertStockQty(Map<String, Object> map);
	

	/**
	* @methodName  : insertStockAjmt
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param stockAjmtVO
	* @return	   : 재고조정 테이블에 추가
	*/
	public int insertStockAjmt(StockAjmtVO stockAjmtVO);


	/**
	* @methodName  : selectGdsList
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param bzentNo
	* @return      : 해당 거래처 보유 상품 리스트
	*/
	public List<GdsVO> selectGdsList(String bzentNo);


	/**
	* @methodName  : downloadTemp
	* @author      : 이병훈
	* @date        : 2024.10.02
	* @param response
	* @param bzentNo
	* 엑셀 양식파일 다운로드
	*/
	public void downloadTemp(HttpServletResponse response, String bzentNo);


	/**
	 * @methodName  : uploadNewStock
	 * @author      : 이병훈
	 * @date        : 2024.10.02
	 * @param file
	 * @return      : 재고 엑셀 파일 업로드 및 재고 등록(임포트)
	 */
//	public boolean uploadNewStock(String bzentNo, MultipartFile file);


	/**
	* @methodName  : insertNewAll
	* @author      : 이병훈
	* @date        : 2024.10.05
	* @param gdsVO
	* @param stockVO
	* @param gdsAmtVO
	*/
	public void insertNewAll(List<Map<String, Object>> gdsList);


	/**
	* @methodName  : selectGdsAll
	* @author      : 이병훈
	* @date        : 2024.10.05
	* @return      : 전체 상품 리스트
	*/
	public List<GdsVO> selectGdsAll(String bzentType);


	/**
	* @methodName  : selectGdsNm
	* @author      : 이병훈
	* @date        : 2024.10.07
	* @param gdsCode
	* @return      : 상품명 가져오기
	*/
	public String selectGdsNm(String gdsCode);
	
}
