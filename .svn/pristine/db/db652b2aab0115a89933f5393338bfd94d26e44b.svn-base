package com.buff.com.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.DealMapper;
import com.buff.com.service.DealService;
import com.buff.vo.GdsVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;
import com.buff.vo.StockPoVO;
import com.buff.vo.StockVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DealServiceImpl implements DealService{
	
	@Autowired
	DealMapper dealMapper;
	
	/**
	* @methodName  : selectDeal
	* @author      : 송예진
	* @date        : 2024.09.26 
	* @param map   : 필수 입력 정보 type(po || so), bzentNo, 검색 조건(sort,orderby, bzentNm, deliType, deliYmd(sdeYmd,edeYmd), spmtYmd(sregYmd,eregYmd)), 페이징
	* @return      : 발주/납품 조회
	*/
	public List<PoVO> selectDeal(Map<String, Object> map){
		return this.dealMapper.selectDeal(map);
	};
	
	/**
	* @methodName  : selectTotalDeal
	* @author      : 송예진
	* @date        : 2024.09.26
	* @param map   : 필수 입력 정보 type(po || so), bzentNo, 검색 조건(sort,orderby, bzentNm, deliType, deliYmd(sdeYmd,edeYmd), spmtYmd(sregYmd,eregYmd))
	* @return      : 발주/납품 조회 갯수
	*/
	public Map<String, Object> selectTotalDeal(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.dealMapper.selectTotalDeal(map));
		
		map.put("deliType", "DELI01");
		cnt.put("deli01", this.dealMapper.selectTotalDeal(map));
		map.put("deliType", "DELI02");
		cnt.put("deli02", this.dealMapper.selectTotalDeal(map));
		map.put("deliType", "DELI03");
		cnt.put("deli03", this.dealMapper.selectTotalDeal(map));
		map.put("deliType", "DELI04");
		cnt.put("deli04", this.dealMapper.selectTotalDeal(map));
		
		map.remove("deliType");
		cnt.put("all", this.dealMapper.selectTotalDeal(map));
		
		return cnt;
	};
	
	/**
	* @methodName  : selectDealDtl
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : 발주에 대한 상세 정보
	*/
	public PoVO selectDealDtl(String poNo) {
		return this.dealMapper.selectDealDtl(poNo);
	};
	
	
	/**
	* @methodName  : selectCnptGds
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param gdsCode
	* @return      : 해당 상품을 판매중인 거래처 조회
	*/
	public List<StockVO> selectCnptGds(String gdsCode){
		return this.dealMapper.selectCnptGds(gdsCode);
	};
	

	/**
	* @methodName  : insertDealAjax
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param bzentNoGroups
	* @return     : 거래처별 리스트를 받아서 stockPOVO 를 반환
	*/
	@Transactional
	public int insertDealAjax(Map<String, List<StockPoVO>> bzentNoGroups) {
		List<StockPoVO> list = new ArrayList<StockPoVO>();
		int cnt = 0;
		// bzentNo 별로 발주 처리
        for (String bzentNo : bzentNoGroups.keySet()) {
        	PoVO poVo = new PoVO();
        	poVo.setBzentNo("HO0001"); // 본사
            // 발주번호(P240927001) 생성 (날짜 + 순번 형식)
        	cnt += this.dealMapper.insertPo(poVo);
            String poNo = poVo.getPoNo();

            // 각 bzentNo 별로 StockPO 데이터 처리
            for (StockPoVO stockPoVo : bzentNoGroups.get(bzentNo)) {
            	stockPoVo.setPoNo(poNo); // 발주 번호 설정
                cnt+=this.dealMapper.insertStockPo(stockPoVo); // 데이터베이스에 삽입
            }
        }
        return cnt;
	};
	
	/**
	* @methodName  : updateStockPo
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param stockPoVOList
	* @return      : 업데이트
	*/
	@Transactional
	public int updateStockPo(List<StockPoVO> stockPoVOList) {
		// 기존에 있던 발주 데이터 삭제
		String poNo = stockPoVOList.get(0).getPoNo();
		// stock_po에있는 데이터 삭제
		int cnt = this.deleteStockPo(poNo);
		for(StockPoVO stockPoVO : stockPoVOList) {
			// 삭제 후 새로 다시 추가
			cnt += this.dealMapper.insertStockPo(stockPoVO);
		}
		return cnt;
	};
	
	/**
	* @methodName  : insertPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poVo(bzentNo) : 발주 받는 사람의 사업체 번호(본사나 가맹점)
	* @return
	*/
	public int insertPo(PoVO poVo) {
		return this.dealMapper.insertPo(poVo);
	};
	
	/**
	* @methodName  : insertStockPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param stockPoVO : 발주 정보
	* @return
	*/
	public int insertStockPo(StockPoVO stockPoVO) {
		return this.dealMapper.insertStockPo(stockPoVO);
	};
	
	
	/**
	* @methodName  : deleteStockPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : STOCK_PO삭제 
	*/
	public int deleteStockPo(String poNo) {
		return this.dealMapper.deleteStockPo(poNo);
	};
	
	/**
	* @methodName  : deletePo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : PO삭제 (선행 STOCK_PO삭제필요) -deleteStockPo
	*/
	@Transactional
	public int deletePo(String poNo) {
		int cnt = this.deleteStockPo(poNo);
		cnt+= this.dealMapper.deletePo(poNo);
		return cnt;
	};
	
	
	/**
	* @methodName  : updateMinStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 거래처나 가맹점이 승인한 경우 (본사나 거래처) - 수량 감소
	*/
	public int updateMinStock(String poNo) {
		return this.dealMapper.updateMinStock(poNo);
	};
	
	
	/**
	* @methodName  : updateAddStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 배송 완료한 경우 (본사나 가맹점) - 수량 추가
	* MERGE을 써서 조건문에 따라 INSERT나 UPDATE가 이루어진다
	*/
	public int updateAddStock(String poNo) {
		return this.dealMapper.updateAddStock(poNo);
	};
	
	/**
	* @methodName  : updatePo
	* @author      : 송예진
	* @date        : 2024.09.28
	 	배송 승인한 경우 (deliType = DELI02 , deliYmd) > updateMinStock (발주 받은사람이 누름 -> 본사 거래처)
		배송 완료 (deliType = DELI03) > updateAddStock (발주시킨사람이 누름 -> 가맹점 본사)
		미승인 (deliType = DELI04, rjctRsn)
	*/
	public int updatePo(PoVO poVO) {
		return this.dealMapper.updatePo(poVO);
	};
	
	/**
	* @methodName  : insertPoClcln
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poNo
	* @return      : 배송 완료하는 경우 승인
	*/
	public int insertPoClcln(String poNo) {
		return this.dealMapper.insertPoClcln(poNo);
	};
	
	
	/**
	* @methodName  : deli02Update
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 배송 시작, 승인
	*/
	@Transactional
	public int updateDeli02(PoVO poVO) {
		// 재고 감소
		int cnt = this.updateMinStock(poVO.getPoNo());
		// PO 변경
		cnt += this.updatePo(poVO);
		return cnt;
	};
	
	/**
	* @methodName  : deli03Update
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 배송 완료
	*/
	@Transactional
	public int updateDeli03(PoVO poVO) {
		int cnt = this.updateAddStock(poVO.getPoNo());
		cnt += this.updatePo(poVO);
		cnt += this.insertPoClcln(poVO.getPoNo());
		return cnt;
	};

	////////////// 가맹점 발주 시작 리스트
	/**
	* @methodName  : selectFrcsGds
	* @author      : 송예진
	* @date        : 2024.09.29
	* @param bzentNo는 필수 정보!
	* @return      : 가맹점정보를 넣어 수량과 안전재고를 파악하고 본사의 재고와 단가에 따라 거래
	*/
	public List<GdsVO> selectFrcsGds(Map<String, Object> map){
		return this.dealMapper.selectFrcsGds(map);
	};
	
	/**
	* @methodName  : selectTotalFrcsGds
	* @author      : 송예진
	* @date        : 2024.09.29
	* @param map   : 검색조건과 가맹점 정보
	* @return      : 갯수 분류별
	*/
	public Map<String, Object> selectTotalFrcsGds(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.dealMapper.selectTotalFrcsGds(map));
		
		map.put("gdsClass", "FD");
		cnt.put("fd", this.dealMapper.selectTotalFrcsGds(map));
		map.put("gdsClass", "SM");
		cnt.put("sm", this.dealMapper.selectTotalFrcsGds(map));
		map.put("gdsClass", "PM");
		cnt.put("pm", this.dealMapper.selectTotalFrcsGds(map));
		map.remove("gdsClass");
		cnt.put("all", this.dealMapper.selectTotalFrcsGds(map));
		return cnt;
	};
	
	/**
	* @methodName  : selectFrcsSfGds
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param bzentNo
	* @return      : 자동으로 담기 버튼을 눌렀을 때 안전 재고 이하만큼 담기게함
	*/
	public List<GdsVO> selectFrcsSfGds(String bzentNo){
		return this.dealMapper.selectFrcsSfGds(bzentNo);
	};
	
	/**
	* @methodName  : insertFrcsPo
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param stockPOList
	* @return     : 가맹점 발주 추가
	*/
	@Transactional
	public int insertFrcsPo(Map<String, Object> map) {
		ObjectMapper objMapper = new ObjectMapper();
		
		PoVO poVO = objMapper.convertValue(map.get("poVO"), PoVO.class);
		// List<StockPoVO> 변환 (TypeReference 사용)
		
		List<StockPoVO> stockPOList = objMapper.convertValue(map.get("stockPOList"), new TypeReference<List<StockPoVO>>() {});
		// PO 테이블
		int cnt=this.dealMapper.insertPo(poVO);
		
		// STOCK_PO
		for(StockPoVO stockPoVO : stockPOList) {
			stockPoVO.setBzentNo("HO0001");
			stockPoVO.setPoNo(poVO.getPoNo());
			cnt+=this.dealMapper.insertStockPo(stockPoVO);
		}
		return cnt;
	};
	
	
	/**
	* @methodName  : updateClcln
	* @author      : 송예진
	* @date        : 2024.10.04
	* @param poClclnVO
	* @return      : 정산하기
	*/
	public int updateClcln(PoClclnVO poClclnVO) {
		return this.dealMapper.updateClcln(poClclnVO);
	};
}
