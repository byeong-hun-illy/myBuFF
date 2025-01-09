package com.buff.cnpt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.cnpt.mapper.CnptSlsMapper;
import com.buff.cnpt.service.CnptSlsService;
import com.buff.vo.PoClclnVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cnpt.service.impl
* @fileName     : CnptSlsServiceImpl.java
* @author       : 이병훈
* @date         : 2024.10.08
* @description  : 거래처 매출관련 serviceImpl(서비스 구현체)
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.08        이병훈     	  			최초 생성
*/
@Slf4j
@Service
public class CnptSlsServiceImpl implements CnptSlsService {
	
	@Autowired
	private CnptSlsMapper cnptSlsMapper;
	
	
	/**
	* @methodName  : selectYearData
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param map
	* @return      : 매출 데이터 조회
	*/
	@Override
	public List<PoClclnVO> selectSales(Map<String, Object> map) {
		return this.cnptSlsMapper.selectSales(map);
	}

	/**
	* @methodName  : selectTotalSls
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param map
	* @return      : (특정 검색 조건)매출 데이터 총 갯수
	*/
	@Override
	public int selectTotalSls(Map<String, Object> map) {
		return this.cnptSlsMapper.selectTotalSls(map);
	}


	/**
	* @methodName  : selectAllSales
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param map
	* @return      : 매출 데이터 총 갯수
	*/
	@Override
	public int selectAllSales(String bzentNo) {
		return this.cnptSlsMapper.selectAllSales(bzentNo);
	}
	
	/**
	* @methodName  : selectDailySales
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param map
	* @return      : 일간 매출 데이터 
	*/
	@Override
	public List<PoClclnVO> selectDailySales(Map<String, Object> map) {
		return this.cnptSlsMapper.selectDailySales(map);
	}
	
	/**
	* @methodName  : selectTotalDailySales
	* @author      : 이병훈
	* @date        : 2024.10.08
	* @param map
	* @return      : 일간 매출 데이터 총 갯수 
	*/
	@Override
	public int selectTotalDailySales(Map<String, Object> map) {
		return this.cnptSlsMapper.selectTotalDailySales(map);
	}
	
	/**
	* @methodName  : selectTotalSalesAmount
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param map
	* @return      : 동적으로 계산되는 총 매출 금액 
	*/
	@Override
	public long selectTotalSalesAmount(Map<String, Object> map) {
		return this.cnptSlsMapper.selectTotalSalesAmount(map);
	}
	
	/**
	* @methodName  : selectAllSalesData
	* @author      : 이병훈
	* @date        : 2024.10.10
	* @param map
	* @return      : 전체 매출 데이터
	*/
	@Override
	public List<PoClclnVO> selectAllSalesData(Map<String, Object> map) {
		return this.cnptSlsMapper.selectAllSalesData(map);
	}}
