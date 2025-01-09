package com.buff.hdofc.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.HdofcStockAjmtMapper;
import com.buff.hdofc.service.HdofcStockAjmtService;
import com.buff.vo.GdsVO;

/**
* @packageName  : com.buff.service.hdofc.impl
* @fileName     : HdofcStockAjmtServiceImpl.java
* @author       : 김현빈
* @date         : 2024.10.04
* @description  : 판매 상품 소모량 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.04        김현빈     	  			최초 생성
*/
@Service
public class HdofcStockAjmtServiceImpl implements HdofcStockAjmtService {
	
	@Inject
	HdofcStockAjmtMapper hdofcStockAjmtMapper;
	
	@Override
	public List<GdsVO> selectStockAjmtList(Map<String, Object> map) {
		return this.hdofcStockAjmtMapper.selectStockAjmtList(map);
	}
	
	@Override
	public int stockAjmtTotalCnt(Map<String, Object> map) {
		return this.hdofcStockAjmtMapper.stockAjmtTotalCnt(map);
	}
	
}
