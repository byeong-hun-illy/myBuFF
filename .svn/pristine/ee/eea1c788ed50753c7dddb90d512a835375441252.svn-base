package com.buff.cnpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.CnptCntVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.cnpt.mapper
* @fileName     : CnptMainMapper.java
* @author       : 이병훈 
* @date         : 2024.10.11
* @description  : 거래처 메인화면 관련 Mapper interface
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        이병훈     	  			최초 생성
*/
@Mapper
public interface CnptMainMapper {

	/**
	* @methodName  : selectCnt
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @return      : 거래처 메인화면 - 판매중인 상품, 미판매 상품, 배송완료 건수, 배송중 건수
	*/
	public CnptCntVO selectCnt(Map<String, Object> map);

	/**
	* @methodName  : selectTotalSalesAmount
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 매출 총 금액 계산
	*/
	public long selectTotalSalesAmount(Map<String, Object> map);

	/**
	* @methodName  : selectChartData
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 매출 차트 데이터 반환
	*/
	public List<PoClclnVO> selectChartData(Map<String, Object> map);

	/**
	* @methodName  : selectProductSales
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return      : 년도에 따른 상품 매출 데이터 반환
	*/
	public List<PoClclnVO> selectProductSalesByYear(Map<String, Object> map);

	/**
	* @methodName  : selectProductSalesByMonth
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return      : 월별에 따른 상품 매출 데이터 반환
	*/
	public List<PoClclnVO> selectProductSalesByMonth(Map<String, Object> map);
	
	/**
	* @methodName  : selectProductSalesByDay
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return      : 일별에 따른 상품 매출 데이터 반환
	*/
	public List<PoClclnVO> selectProductSalesByDay(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectTotalNotClclnAmount
	* @author      : 이병훈
	* @date        : 2024.10.14
	* @param map
	* @return      : 1년간 미정산 총 금액
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
