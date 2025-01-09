package com.buff.com.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.GdsVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;
import com.buff.vo.StockPoVO;
import com.buff.vo.StockVO;

public interface DealService {

	/**
	* @methodName  : selectDeal
	* @author      : 송예진
	* @date        : 2024.09.26 
	* @param map   : 필수 입력 정보 type(po || so), bzentNo, 검색 조건(sort,orderby, bzentNm, deliType, deliYmd(sdeYmd,edeYmd), spmtYmd(sregYmd,eregYmd)), 페이징
	* @return      : 발주/납품 조회
	*/
	public List<PoVO> selectDeal(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalDeal
	* @author      : 송예진
	* @date        : 2024.09.26
	* @param map   : 필수 입력 정보 type(po || so), bzentNo, 검색 조건(sort,orderby, bzentNm, deliType, deliYmd(sdeYmd,edeYmd), spmtYmd(sregYmd,eregYmd))
	* @return      : 발주/납품 조회 갯수
	*/
	public Map<String, Object> selectTotalDeal(Map<String, Object> map);
	
	/**
	* @methodName  : selectDealDtl
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : 발주에 대한 상세 정보
	*/
	public PoVO selectDealDtl(String poNo);
	
	
	/**
	* @methodName  : selectCnptGds
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param gdsCode
	* @return      : 해당 상품을 판매중인 거래처 조회
	*/
	public List<StockVO> selectCnptGds(String gdsCode);

	/**
	* @methodName  : insertDealAjax
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param bzentNoGroups
	* @return     : 거래처별 리스트를 받아서 stockPOVO 를 반환
	*/
	public int insertDealAjax(Map<String, List<StockPoVO>> bzentNoGroups);
	
	/**
	* @methodName  : insertPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poVo(bzentNo) : 발주 받는 사람의 사업체 번호(본사나 가맹점)
	* @return
	*/
	public int insertPo(PoVO poVo);
	
	/**
	* @methodName  : insertStockPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param stockPoVO : 발주 정보
	* @return
	*/
	public int insertStockPo(StockPoVO stockPoVO);
	
	
	/**
	* @methodName  : deleteStockPo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : STOCK_PO삭제 
	*/
	public int deleteStockPo(String poNo);
	
	/**
	* @methodName  : deletePo
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : PO삭제 (선행 STOCK_PO삭제필요) -deleteStockPo
	*/
	public int deletePo(String poNo);
	
	
	/**
	* @methodName  : updateMinStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 거래처나 가맹점이 승인한 경우 (본사나 거래처) - 수량 감소
	*/
	public int updateMinStock(String poNo);
	
	
	/**
	* @methodName  : updateAddStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 배송 완료한 경우 (본사나 가맹점) - 수량 추가
	* MERGE을 써서 조건문에 따라 INSERT나 UPDATE가 이루어진다
	*/
	public int updateAddStock(String poNo);
	
	/**
	* @methodName  : updatePo
	* @author      : 송예진
	* @date        : 2024.09.28
	 	배송 승인한 경우 (deliType = DELI02 , deliYmd) > updateMinStock (발주 받은사람이 누름 -> 본사 거래처)
		배송 완료 (deliType = DELI03) > updateAddStock (발주시킨사람이 누름 -> 가맹점 본사)
		미승인 (deliType = DELI04, rjctRsn)
	*/
	public int updatePo(PoVO poVO);
	
	/**
	* @methodName  : insertPoClcln
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poNo
	* @return      : 배송 완료하는 경우 승인
	*/
	public int insertPoClcln(String poNo);
	
	/**
	* @methodName  : deli02Update
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 배송 시작, 승인
	*/
	public int updateDeli02(PoVO poVO);
	
	/**
	* @methodName  : deli03Update
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 배송 완료
	*/
	public int updateDeli03(PoVO poVO);

	/**
	* @methodName  : updateStockPo
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param stockPoVOList
	* @return      : 업데이트
	*/
	public int updateStockPo(List<StockPoVO> stockPoVOList);
	
	////////////// 가맹점 발주 시작 리스트
	/**
	* @methodName  : selectFrcsGds
	* @author      : 송예진
	* @date        : 2024.09.29
	* @param bzentNo는 필수 정보!
	* @return      : 가맹점정보를 넣어 수량과 안전재고를 파악하고 본사의 재고와 단가에 따라 거래
	*/
	public List<GdsVO> selectFrcsGds(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsGds
	* @author      : 송예진
	* @date        : 2024.09.29
	* @param map   : 검색조건과 가맹점 정보
	* @return      : 갯수
	*/
	public Map<String, Object> selectTotalFrcsGds(Map<String, Object> map);
	
	/**
	* @methodName  : selectFrcsSfGds
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param bzentNo
	* @return      : 자동으로 담기 버튼을 눌렀을 때 안전 재고 이하만큼 담기게함
	*/
	public List<GdsVO> selectFrcsSfGds(String bzentNo);

	/**
	* @methodName  : insertFrcsPo
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param map
	* @return     : 가맹점 발주 추가
	*/
	public int insertFrcsPo(Map<String, Object> map);
	
	
	/**
	* @methodName  : updateClcln
	* @author      : 송예진
	* @date        : 2024.10.04
	* @param poClclnVO
	* @return      : 정산하기
	*/
	public int updateClcln(PoClclnVO poClclnVO);
}
