package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsStockAjmtMapper;
import com.buff.frcs.service.FrcsStockAjmtService;
import com.buff.vo.GdsVO;

/**
* @packageName  : com.buff.frcs.service.impl
* @fileName     : FrcsStockAjmtServiceImpl.java
* @author       : 정현종
* @date         : 2024.09.30
* @description  : 재고조정내역 serviceimpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30        정현종     	  			최초 생성
*/
@Service
public class FrcsStockAjmtServiceImpl implements FrcsStockAjmtService {
	
	@Autowired
	FrcsStockAjmtMapper frcsStockAjmtMapper;
	
	/**
	* @methodName  : selectFrcsStockAjmtList
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param       : map
	* @return	   : 재고조정내역조회
	*/
	@Override
	public List<GdsVO> selectFrcsStockAjmtList(Map<String, Object> map) {
		return this.frcsStockAjmtMapper.selectFrcsStockAjmtList(map);
	}
	
	/**
	* @methodName  : selectTotalFrcsStockAjmt
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 재고조정내역 총 갯수
	*/
	@Override
	public int selectTotalFrcsStockAjmt(Map<String, Object> map) {
		return this.frcsStockAjmtMapper.selectTotalFrcsStockAjmt(map);
	}
	
	/**
	* @methodName  : selectAllStockAjmtCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 재고조정내역 전체유형 갯수
	*/
	@Override
	public int selectAllStockAjmtCount(Map<String, Object> map) {
		return this.frcsStockAjmtMapper.selectAllStockAjmtCount(map);
	}
	
	/**
	* @methodName  : selectOrderStockAjmtCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 재고조정내역 주문유형 갯수
	*/
	@Override
	public int selectOrderStockAjmtCount(Map<String, Object> map) {
		return this.frcsStockAjmtMapper.selectOrderStockAjmtCount(map);
	}
	
	/**
	* @methodName  : selectDisposeStockAjmtCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 재고조정내역 폐기유형 갯수
	*/
	@Override
	public int selectDisposeStockAjmtCount(Map<String, Object> map) {
		return this.frcsStockAjmtMapper.selectDisposeStockAjmtCount(map);
	}

}
