package com.buff.cnpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.PoClclnVO;

/**
* @packageName  : com.buff.cnpt.mapper
* @fileName     : CnptSlsMapper.java
* @author       : 이병훈 
* @date         : 2024.10.08
* @description  : 거래처 매출 관련 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.08        이병훈     	  			최초 생성
*/
@Mapper
public interface CnptSlsMapper {

	/**
	* @methodName  : selectYearData
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param bzentNo
	* @return      : 매출 데이터
	*/
	public List<PoClclnVO> selectSales(Map<String, Object> map);

	
	/**
	* @methodName  : selectTotalSls
	* @author      : 매출 데이터 총 갯수
	* @date        : 2024.10.08
	* @param map
	* @return      : (특정 검색 조건) 매출 데이터 총 갯수
	*/
	public int selectTotalSls(Map<String, Object> map);


	/**
	* @methodName  : selectAllSales
	* @author      : 이병훈
	* @date        : 2024.10.09
	* @param map
	* @return      : 총 매출 데이터 갯수
	*/
	public int selectAllSales(String bzentNo);


	/**
	* @methodName  : selectDailySales
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param map
	* @return      : 일간 매출 데이터
	*/
	public List<PoClclnVO> selectDailySales(Map<String, Object> map);


	/**
	* @methodName  : selectToTalDailySales
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
	* @return      : 동적으로 계산되는 매출 총 금액
	*/
	public long selectTotalSalesAmount(Map<String, Object> map);


	/**
	* @methodName  : selectAllSalesData
	* @author      : 이병훈
	* @date        : 2024.10.19
	* @param map
	* @return      : 전체 차트데이터
	*/
	public List<PoClclnVO> selectAllSalesData(Map<String, Object> map);

	
	

}
