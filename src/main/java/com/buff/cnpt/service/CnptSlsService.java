package com.buff.cnpt.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.PoClclnVO;

/**
* @packageName  : com.buff.cnpt.service
* @fileName     : CnptSlsService.java
* @author       : 이병훈
* @date         : 2024.10.08
* @description  : 거래처 매출 관련 service interface
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.08        이병훈     	  			최초 생성
*/
public interface CnptSlsService {

	/**
	* @methodName  : selectYearData
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param bzentNo
	* @return      : 매출데이터 조회
	*/
	public List<PoClclnVO> selectSales(Map<String, Object> map);

	
	/**
	* @methodName  : selectTotalSls
	* @author      : 이병훈 
	* @date        : 2024.10.08
	* @param bzentNo
	* @param startMonth
	* @param endMonth
	* @param selectedYear
	* @return      :  (특정검색 조건으로 인한) 매출 갯수 조회 
	*/
	public int selectTotalSls(Map<String, Object> map);

	
	/**
	* @methodName  : selectAllSales
	* @author      : 이병훈
	* @date        : 2024.10.09
	* @param map
	* @return  	   : 전체 매출 데이터 수 조회
	*/
	public int selectAllSales(String bzentNo);


	/**
	* @methodName  : selectDailySales
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param bzentNo
	* @param today
	* @return      : 거래처 일간 데이터
	*/
	public List<PoClclnVO> selectDailySales(Map<String, Object> map);


	/**
	* @methodName  : selectTotalDailySales
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param map
	* @return      : 일간 매출 데이터 총 갯수
	*/
	public int selectTotalDailySales(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectTotalSalesAmount
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param map
	* @return	   : 동적으로 계산되는 매출 총 금액
	*/
	public long selectTotalSalesAmount(Map<String, Object> map);


	/**
	* @methodName  : selectAllSalesData
	* @author      : 이병훈
	* @date        : 2024.10.19
	* @param map
	* @return      : 전체 차트 데이터
	*/
	public List<PoClclnVO> selectAllSalesData(Map<String, Object> map);
	
	
}
