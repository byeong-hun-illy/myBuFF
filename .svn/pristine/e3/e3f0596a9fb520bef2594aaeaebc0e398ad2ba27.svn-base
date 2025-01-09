package com.buff.cnpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.ComVO;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;

/**
* @packageName  : com.buff.cnpt.mapper
* @fileName     : CnptGdsMapper.java
* @author       : 이병훈
* @date         : 2024.09.23
* @description  : 거래처 상품 재고 관련 mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.23        이병훈     	  			최초 생성
*/
@Mapper
public interface CnptGdsMapper {
	
	
	/**
	* @methodName  : selectGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @return 	   : 상품 목록 조회
	*/
	public List<GdsVO> selectCnptGds(Map<String, Object> map);

	/**
	* @methodName  : selectTotalGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param map
	* @return	   : 검색조건에 따른 페이지 총 갯수 조회
	*/
	public int selectTotalGds(Map<String, Object> map);

	/**
	* @methodName  : selectAllGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param map
	* @return      : 전체 상품 수
	*/
	public int selectAllGds(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectExcel
	* @author      : 이병훈
	 * @param map 
	 * @param bzentNo 
	* @date        : 2024.09.24
	* @return	   : 거래처 보유 상품 총 리스트
	*/
	public List<GdsVO> selectExcel(Map<String, Object> map);


	/**
	* @methodName  : selectHasStock
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentNo : 거래처 번호
	* @return      : 해당 거래처 재고 유무 숫자
	*/
	public int selectHasStock(String bzentNo);
	
	
	/**
	* @methodName  : selectGdsType
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentType : 거래처 유형
	* @return	   : 거래처 유형에 따른 취급하는 상품 유형
	*/
	public List<ComVO> selectGdsType(String bzentType);

	/**
	* @methodName  : selectBzentType
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param bzentNo : 거래처 번호
	* @return      : 거래처 유형
	*/
	public String selectBzentType(String bzentNo);

	/**
	* @methodName  : selectGdsDtl
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO 
	* @return      : 상품 상세 페이지
	*/
	public GdsVO selectGdsDtl(StockVO stockVO);

	/**
	* @methodName  : selectUpdateChk
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO
	* @return      : 상품을 수정할 수 있는지 여부 확인
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
	* @param gdsAmtVO : 단가 정보가 담긴 gdsAmtVO 객체
	* @return      : 단가 추가 시 선행 작업, stock테이블에 추가
	*/
	public int insertStock(GdsAmtVO gdsAmtVO);

	/**
	* @methodName  : updateGdsAmt
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param gdsAmtVO : 단가 변경 정보
	* @return      : 단가 추가
	*/
	public int insertGdsAmt(GdsAmtVO gdsAmtVO);

	/**
	* @methodName  : updateNtsl
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param stockVO : 판매 상태 유형변경 정보가 담긴 stockVO객체
	* @return      : 판매 상태변경
	*/
	public int updateNtsl(StockVO stockVO);

	/**
	* @methodName  : deleteGds
	* @author      : 이병훈
	* @date        : 2024.09.30
	* @param gdsCode
	* @return      : 상품 재고가 없을 때 상품 삭제
	*/
	public int deleteGds(Map<String, Object> map);

	/**
	* @methodName  : deleteStock
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	* @return      : 재고 테이블에서 상품 삭제
	*/ 
	public int deleteStock(Map<String, Object> map);
	
	
	/**
	* @methodName  : deleteGdsAmt
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	* @return      : 상품 단가 테이블에서 상품 삭제
	*/
	public int deleteGdsAmt(Map<String, Object> map);

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
	
	
	/**
	* @methodName  : deleteStockAjmt
	* @author      : 이병훈
	* @date        : 2024.10.04
	* @param map
	* @return      : 재고조정 테이블에서 관련 상품 재고 삭제
	*/
	public int deleteStockAjmt(Map<String, Object> map);
	
	
}
