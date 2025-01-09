package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsSlsMapper;
import com.buff.frcs.service.FrcsSlsService;
import com.buff.vo.OrdrVO;

/**
* @packageName  : com.buff.frcs.service.impl
* @fileName     : FrcsSlsServiceImpl.java
* @author       : 정현종
* @date         : 2024.10.03
* @description  : 가맹점 매출 ServiceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.03        정현종     	  			최초 생성
*/
@Service
public class FrcsSlsServiceImpl implements FrcsSlsService {
	
	@Autowired
	FrcsSlsMapper frcsSlsMapper;
	
	/**
	* @methodName  : selectFrcsPeriodSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param 	   : map
	* @return	   : 검색조건에 맞는 기간별 매출 리스트
	*/
	@Override
	public List<OrdrVO> selectFrcsPeriodSlsList(Map<String, Object> map) {
		return this.frcsSlsMapper.selectFrcsPeriodSlsList(map);
	}
	
	/**
	* @methodName  : selectTotalFrcsPeriodSlsList
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param       : map
	* @return      : 페이징을 위한 총 행의 수
	*/
	@Override
	public int selectTotalFrcsPeriodSlsList(Map<String, Object> map) {
		return this.frcsSlsMapper.selectTotalFrcsPeriodSlsList(map);
	}
	
	/**
	* @methodName  : selectFrcsPeriodSlsTotalAmt
	* @author      : 정현종
	* @date        : 2024.10.04
	* @param 	   : map
	* @return	   : 검색조건에 맞는 총 매출액
	*/
	@Override
	public long selectFrcsPeriodSlsTotalAmt(Map<String, Object> map) {
		return this.frcsSlsMapper.selectFrcsPeriodSlsTotalAmt(map);
	}
	
	/**
	* @methodName  : selectdailySales
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param 	   : map
	* @return	   : 당일 매출 금액
	*/
	@Override
	public long selectdailySales(Map<String, Object> map) {
		return this.frcsSlsMapper.selectdailySales(map);
	}
	
	/**
	* @methodName  : selectmaxDailySales
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 최고 일일 매출 금액
	*/
	@Override
	public long selectmaxDailySales(Map<String, Object> map) {
		return this.frcsSlsMapper.selectmaxDailySales(map);
	}

	@Override
	public List<OrdrVO> selectfrcsSlsList(Map<String, Object> map) {
		return this.frcsSlsMapper.selectfrcsSlsList(map);
	}

}
