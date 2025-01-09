package com.buff.cnpt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.cnpt.mapper.CnptMainMapper;
import com.buff.cnpt.service.CnptMainService;
import com.buff.vo.CnptCntVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.cnpt.service.impl
* @fileName     : CnptCntServiceImpl.java
* @author       : 이병훈
* @date         : 2024.10.11
* @description  : 거래처 메인화면 Service Impl 구현서비스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.11        이병훈     	  			최초 생성
*/
@Service
public class CnptCntServiceImpl implements CnptMainService {
	
	@Autowired
	CnptMainMapper cnptMainMapper;
	
	/**
	* @methodName  : selectCnt
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 거래처 메인화면 - 판매중인 상품, 미판매 상품, 배송완료 건수, 배송중 건수
	*/
	@Override
	public CnptCntVO selectCnt(Map<String, Object> map) {
		return this.cnptMainMapper.selectCnt(map);
	}
	
	/**
	* @methodName  : selectTotalSalesAmount
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 매출 총 금액
	*/
	@Override
	public long selectTotalSalesAmount(Map<String, Object> map) {
		Long result = cnptMainMapper.selectTotalSalesAmount(map);
	    return result != null ? result : 0L;
	}
	
	/**
	* @methodName  : selectSaleData
	* @author      : 이병훈
	* @date        : 2024.10.11
	* @param map
	* @return      : 매출 데이터 반환
	*/
	@Override
	public List<PoClclnVO> selectSaleData(Map<String, Object> map) {
		// 총 매출 금액 및 차트 데이터 반환
		return this.cnptMainMapper.selectChartData(map);
	}
	
	/**
	* @methodName  : selectProductSales
	* @author      : 이병훈
	* @date        : 2024.10.12
	* @param map
	* @return      : 검색 조건에 따른 상품 매출 데이터
	*/
	@Transactional
	@Override
	public List<PoClclnVO> selectProductSales(Map<String, Object> map) {
		String period = (String) map.get("period");
		
		switch(period) {
			case "year" :
				return this.cnptMainMapper.selectProductSalesByYear(map);
			case "month" :
				return this.cnptMainMapper.selectProductSalesByMonth(map);
			case "day" :
				return this.cnptMainMapper.selectProductSalesByDay(map);
			default :
				throw new IllegalArgumentException("기간 오류" + period);
		}
		
	}
	
	/**
	* @methodName  : selectTotalNotClclnAmount
	* @author      : 이병훈
	* @date        : 2024.10.14
	* @param map
	* @return      : 1년간 미정산 총금액
	*/
	@Override
	public long selectTotalNotClclnAmount(Map<String, Object> map) {
		return this.cnptMainMapper.selectTotalNotClclnAmount(map);
	}
	
	/**
	* @methodName  : selectUnApprove
	* @author      : 이병훈
	* @date        : 2024.10.14
	* @param map
	* @return      : 미승인 리스트
	*/
	@Override
	public List<PoVO> selectUnApprove(Map<String, Object> map) {
		return this.cnptMainMapper.selectUnApprove(map);
	}


}
