package com.buff.com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.StockAjmtMapper;
import com.buff.com.service.StockAjmtService;
import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;

@Service
public class StockAjmtServiceImpl implements StockAjmtService {
	
	@Autowired
	StockAjmtMapper ajmtMapper;
	
	/**
	* @methodName  : selectStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param map
	* @return      : 재고 조정 조회
	*/
	public List<StockAjmtVO> selectStockAjmt(Map<String, Object> map){
		return this.ajmtMapper.selectStockAjmt(map);
	};
	
	/**
	* @methodName  : selectTotalStockAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param map
	* @return      : 재고 조정 갯수
	*/
	public Map<String, Object> selectTotalStockAjmt(Map<String, Object> map) {
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.ajmtMapper.selectTotalStockAjmt(map));
		
		map.put("ajmtType", "AJMT01");
		cnt.put("a01", this.ajmtMapper.selectTotalStockAjmt(map));
		
		map.put("ajmtType", "AJMT02");
		cnt.put("a02", this.ajmtMapper.selectTotalStockAjmt(map));
		
		map.put("ajmtType", "AJMT03");
		cnt.put("a03", this.ajmtMapper.selectTotalStockAjmt(map));
		
		map.put("ajmtType", "AJMT04");
		cnt.put("a04", this.ajmtMapper.selectTotalStockAjmt(map));
		
		map.remove("ajmtType");
		cnt.put("all", this.ajmtMapper.selectTotalStockAjmt(map));
		
		return cnt;
	};
	
	/**
	* @methodName  : deleteAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param ajmtNo
	* @return      : 재고 조정 기록 삭제 updateStock > deleteAjmt
	*/
	@Transactional
	public int deleteAjmt(String ajmtNo) {
		int cnt = this.ajmtMapper.updateStock(ajmtNo);
		cnt += this.ajmtMapper.deleteAjmt(ajmtNo);
		return cnt;
	};
	
	/**
	* @methodName  : insertAjmt
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param stockAjmtVO
	* @return      : 재고 조정 폐기 추가 
	*/
	@Transactional
	public int insertAjmt(StockAjmtVO stockAjmtVO) {
		int cnt = this.ajmtMapper.insertAjmt(stockAjmtVO);
		cnt += this.ajmtMapper.updateDisStock(stockAjmtVO);
		return cnt;
	};
	
	//// 상품 추가
	
	/**
	* @methodName  : selectStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 재고 조회
	*/
	public List<GdsVO> selectStock(Map<String, Object> map){
		return this.ajmtMapper.selectStock(map);
	};
	
	/**
	* @methodName  : selectTotalStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 재고 분류별 갯수 조회
	*/
	public Map<String, Object> selectTotalStock(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.ajmtMapper.selectTotalStock(map));
		
		map.put("gdsClass", "FD");
		cnt.put("fd", this.ajmtMapper.selectTotalStock(map));
		map.put("gdsClass", "SM");
		cnt.put("sm", this.ajmtMapper.selectTotalStock(map));
		map.put("gdsClass", "PM");
		cnt.put("pm", this.ajmtMapper.selectTotalStock(map));
		map.remove("gdsClass");
		cnt.put("all", this.ajmtMapper.selectTotalStock(map));
		return cnt;
	};
	
}
