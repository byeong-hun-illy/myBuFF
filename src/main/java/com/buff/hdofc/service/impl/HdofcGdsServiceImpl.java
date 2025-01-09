package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.ComMapper;
import com.buff.hdofc.mapper.HdofcGdsMapper;
import com.buff.hdofc.service.HdofcGdsService;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class HdofcGdsServiceImpl implements HdofcGdsService{
	
	@Autowired
	HdofcGdsMapper gdsMapper;
	
	@Autowired
	ComMapper comMapper;
	
	/**
	* @methodName  : selectStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param map
	* @return      : 재고 조회
	*/
	public List<GdsVO> selectStock(Map<String, Object> map){
		return this.gdsMapper.selectStock(map);
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
		cnt.put("total", this.gdsMapper.selectTotalStock(map));
		
		map.put("gdsClass", "FD");
		cnt.put("fd", this.gdsMapper.selectTotalStock(map));
		map.put("gdsClass", "SM");
		cnt.put("sm", this.gdsMapper.selectTotalStock(map));
		map.put("gdsClass", "PM");
		cnt.put("pm", this.gdsMapper.selectTotalStock(map));
		map.remove("gdsClass");
		cnt.put("all", this.gdsMapper.selectTotalStock(map));
		return cnt;
	};
	
	/// 상품 추가
	/**
	* @methodName  : insertGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsVO(gdsNm, gdsType, unitNm, mbrId)
	* @return      : 상품 추가
	*/
	public int insertGds(GdsVO gdsVO) {
		return this.comMapper.insertGds(gdsVO);
	};
	
	/**
	* @methodName  : insertGdsAmt
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsAmtVO(bzentNo, gdsCode, amt)
	* @return      : 상품단가 추가
	*/
	public int insertGdsAmt(GdsAmtVO gdsAmtVO) {
		return this.comMapper.insertGdsAmt(gdsAmtVO);
	};
	
	
	/**
	* @methodName  : insertAllGds
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param map
	* @return      : gds와 gdsAmt동시 처리
	*/
	@Transactional
	public String insertAllGds(Map<String, Object> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		
		// Map 데이터를 VO로 변환
	    GdsVO gdsVO = objectMapper.convertValue(map.get("gdsVO"), GdsVO.class);
	    GdsAmtVO gdsAmtVO = objectMapper.convertValue(map.get("gdsAmtVO"), GdsAmtVO.class);
	    
		int cnt = this.insertGds(gdsVO);
		
		String gdsCode = gdsVO.getGdsCode();
		if(gdsAmtVO.getAmt()!=0) {
			gdsAmtVO.setGdsCode(gdsCode);
			this.insertStock(gdsAmtVO);
			this.insertGdsAmt(gdsAmtVO);
		}
		return gdsCode;
	};
	
	/**
	* @methodName  : insertStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsAmtVO
	* @return      : 단가 추가시 선행 작업, stock테이블에 추가
	*/
	public int insertStock(GdsAmtVO gdsAmtVO) {
		return this.gdsMapper.insertStock(gdsAmtVO);
	};
	
	/**
	* @methodName  : selectStockDtl
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsCode
	* @return      : 상품상세
	*/
	public GdsVO selectStockDtl(StockVO stockVO) {
		return this.gdsMapper.selectStockDtl(stockVO);
	};
	
	
	/**
	* @methodName  : selectUpdateChk
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param stockVO
	* @return      : 상품을 수정 삭제할지 확인
	*/
	public int selectUpdateChk(StockVO stockVO) {
		return this.gdsMapper.selectUpdateChk(stockVO);
	};
	
	/**
	* @methodName  : deleteGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsCode
	* @return      : 상품 삭제
	*/
	public int deleteGds(String gdsCode) {
		return this.gdsMapper.deleteGds(gdsCode);
	};
	
	/**
	* @methodName  : updateGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param gdsVO
	* @return      : 상품 수정
	*/
	public int updateGds(GdsVO gdsVO) {
		return this.gdsMapper.updateGds(gdsVO);
	};
	
	/**
	* @methodName  : updateSfStock
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param stockVO
	* @return      : 안전 재고 변경
	*/
	public int updateSfStock(StockVO stockVO) {
		return this.gdsMapper.updateSfStock(stockVO);
	};
	
	/**
	* @methodName  : updateAllStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 안전재고와 선택적으로 단가 추가
	*/
	@Transactional
	public int updateAllStock(Map<String, Object> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		// Map 데이터를 VO로 변환
	    StockVO stockVO = objectMapper.convertValue(map.get("stockVO"), StockVO.class);
	    GdsAmtVO gdsAmtVO = objectMapper.convertValue(map.get("gdsAmtVO"), GdsAmtVO.class);
	    
	    int cnt = this.selectUpdateChk(stockVO);
	    if(cnt==0) {
	    	cnt = this.insertStock(gdsAmtVO);
	    }
	    if(gdsAmtVO.getAmt()!=0) {
	    	// gdsAmtVO(bzentNo, gdsCode, amt)
			cnt = this.insertGdsAmt(gdsAmtVO);
		}
	 // bzentNo, gdsCode, sfStockQty
	 	cnt+= this.updateSfStock(stockVO);
	 		
	    return cnt;
	    
	};
}
