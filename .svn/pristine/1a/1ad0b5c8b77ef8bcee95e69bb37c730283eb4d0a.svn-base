package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.OrdrVO;

/**
* @packageName  : com.buff.frcs.service
* @fileName     : FrcsSlsService.java
* @author       : 정현종
* @date         : 2024.10.03
* @description  : 가맹점 기간별 매출 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.03        정현종     	  			최초 생성
*/
public interface FrcsSlsService {

	/**
	* @methodName  : selectFrcsPeriodSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param 	   : map
	* @return	   : 검색조건에 맞는 기간별 매출 리스트
	*/
	public List<OrdrVO> selectFrcsPeriodSlsList(Map<String, Object> map);

	/**
	* @methodName  : selectTotalFrcsPeriodSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param       : map
	* @return      : 페이징을 위한 총 행의 수
	*/
	public int selectTotalFrcsPeriodSlsList(Map<String, Object> map);

	/**
	* @methodName  : selectFrcsPeriodSlsTotalAmt
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param 	   : map
	* @return	   : 검색조건에 맞는 총 매출액
	*/
	public long selectFrcsPeriodSlsTotalAmt(Map<String, Object> map);

	/**
	* @methodName  : selectdailySales
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param 	   : map
	* @return	   : 당일 매출 금액
	*/
	public long selectdailySales(Map<String, Object> map);

	/**
	* @methodName  : selectmaxDailySales
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 최고 일일 매출 금액
	*/
	public long selectmaxDailySales(Map<String, Object> map);

	public List<OrdrVO> selectfrcsSlsList(Map<String, Object> map);

}
