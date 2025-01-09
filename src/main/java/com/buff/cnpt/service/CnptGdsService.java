package com.buff.cnpt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.buff.vo.ComVO;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;

/**
* @packageName  : com.buff.cnpt.service
* @fileName     : CnptGbsService.java
* @author       : 이병훈
* @date         : 2024.09.22
* @description  : 거래처 상품 재고 관련 서비스 인터페이스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.22        이름     	  			최초 생성
*/
/**
* @packageName  : com.buff.cnpt.service
* @fileName     : CnptGdsService.java
* @author       : 
* @date         : 2024.10.01
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        이름     	  			최초 생성
*/
public interface CnptGdsService {
	
	/**
	* @methodName  : selectGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param map
	* @return : 상품 목록 조회
	*/
	public List<GdsVO> selectCnptGds(Map<String, Object> map);
	
	
	/**
	* @methodName  : downloadExcel
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param response : 서버 응답 
	 * @param bzentNo 
	*/
	public void downloadExcel(HttpServletResponse response, String bzentNo);


	/**
	* @methodName  : selectTotalGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param map
	* @return      : 검색조건에 맞는 리스트 총 갯수 
	*/
	public int selectTotalGds(Map<String, Object> map);


	/**
	* @methodName  : selectAllGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param map
	* @return      : 전체 상품 갯수
	*/
	public int selectAllGds(Map<String, Object> map);

	
	/**
	* @methodName  : hasStock
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentNO  : 거래처 번호
	* @return 	   : 거래처 재고 유무 확인
	*/
	public boolean hasStock(String bzentNo);
	
	
	/**
	* @methodName  : selectGdsType
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentType : 거래처 유형
	* @return      : 거래처 유형에 따른 취급 상품 유형
	*/
	public List<ComVO> selectGdsType(String bzentType);


	/**
	* @methodName  : selectBzentType
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentNo : 거래처 번호
	* @return		: 거래처 타입
	*/
	public String selectBzentType(String bzentNo);


	/**
	* @methodName  : selectGdsDtl
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO 
	* @return      : 상품 상세 정보
	*/
	public GdsVO selectGdsDtl(StockVO stockVO);


	/**
	* @methodName  : selectUpdateChk
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO
	* @return      : 상품 수정할 수 있는지 여부 확인
	*/
	public int selectUpdateChk(StockVO stockVO);


	/**
	* @methodName  : updateGds
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param gdsVO
	* @return      : 상품 수정
	*/
	public int updateGds(GdsVO gdsVO);

	/**
	* @methodName  : insertStock
	* @author      : 이병훈 
	* @date        : 2024.09.27
	* @param gdsAmtVO
	* @return	   : 단가 추가 시 선행작업, 재고 테이블에 추가
	*/
	public int insertStock(GdsAmtVO gdsAmtVO);


	/**
	* @methodName  : updateGdsAmt
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param gdsAmtVO : 단가 변경 정보가 담긴 gdsAmtVO 객체
	* @return      : 단가 변경 
	*/
//	public int updateGdsAmt(GdsAmtVO gdsAmtVO);


	/**
	* @methodName  : updateNtsl
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO : 판매 상태유형 변경 정보가 담긴 stockVO 객체
	* @return	   : 판매 상태 유형 변경
	*/
	public int updateNtsl(StockVO stockVO);


	/**
	* @methodName  : insertGds
	* @author      : 이병훈
	* @date        : 2024.09.28
	* @param gdsVO
	* @return      : 상품 테이블에 상품 추가
	*/
	public int insertGds(GdsVO gdsVO);


	/**
	* @methodName  : insertGdsAmt
	* @author      : 이병훈
	* @date        : 2024.09.28
	* @param gdsAmtVO
	* @return      : 상품단가 테이블에 단가 추가
	*/
	public int insertGdsAmt(GdsAmtVO gdsAmtVO);
	
	
	/**
	* @methodName  : insertAllGds
	* @author      : 이병훈
	* @date        : 2024.09.30
	* @param map
	* @return      : gds와 gdsAmt 동시 처리, 상세정보 이동을 위해 gdsCode를 보냄
	*/
	public String insertAllGds(Map<String, Object> map);
	
	/**
	* @methodName  : updateAllStock
	* @author      : 송예진
	* @date        : 2024.09.28
	* 단가 및 판매상태 변경
	*/
	public int updateAllStock(Map<String, Object> map);


	/**
	* @methodName  : deleteGds
	* @author      : 이병훈
	* @date        : 2024.09.30
	* @param gdsCode
	* @return      : 재고 없을 때 상품 삭제
	*/
//	public int deleteGds(String gdsCode);

	
	/**
	* @methodName  : deleteStock
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	* @return	   : 재고 테이블에서 재고 상품 삭제
	*/
//	public int deleteStock(String gdsCode);
	
	
	/**
	* @methodName  : deleteAll
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	*/
	public int deleteAll(Map<String, Object> map);


	/**
	* @methodName  : selectSellingCnt
	* @author      : 이병훈
	* @date        : 2024.10.04
	* @param map
	* @return      : 판매중인 상품 총 갯수
	*/
	public int selectSellingCnt(Map<String, Object> map);


	/**
	* @methodName  : selectNotSellingCnt
	* @author      : 이병훈
	* @date        : 2024.10.04
	* @param map
	* @return      : 미판매중인 상품 총 갯수
	*/
	public int selectNotSellingCnt(Map<String, Object> map);
	
	
}
