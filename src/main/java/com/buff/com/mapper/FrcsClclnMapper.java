package com.buff.com.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.FrcsClclnMaxVO;
import com.buff.vo.FrcsClclnVO;
import com.buff.vo.FrcsVO;

@Mapper
public interface FrcsClclnMapper {

	/**
	* @methodName  : selectFrceClclnMonth
	* @author      : 송예진
	* @date        : 2024.10.05
	* @return      : 이번달 정산 예정 금액/ 완료 금액
	*/
	public FrcsClclnMaxVO selectFrceClclnMonth();
	
	/**
	* @methodName  : selectFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param map
	* @return      : 조회 현황
	*/
	public List<FrcsClclnVO> selectFrcsClcln(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param map
	* @return       : 조회 갯수
	*/
	public int selectTotalFrcsClcln(Map<String, Object> map);
	
	/**
	* @methodName  : insertFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param clclnYm (년, 월)
	* @return      :  년 월을 입력받아 해당 월에 판매되었던 매출의 내역따라 정산 내역 출력
	*/
	public int insertFrcsClcln(String clclnYm);
	
	/**
	* @methodName  : selectFrcsClclnDtl
	* @author      : 송예진
	* @date        : 2024.10.06
	* @param frcsClclnVO (frcsNo, clclnYm)
	* @return      : 상세 조회
	*/
	public FrcsClclnVO selectFrcsClclnDtl(FrcsClclnVO frcsClclnVO);
	
	/**
	* @methodName  : updateFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.06
	* @param frcsClclnVO (npmntAmt, frcsNo, clclnYm)
	* @return      : 가맹점이 정산 처리
	*/
	public int updateFrcsClcln(FrcsClclnVO frcsClclnVO);
	
	/**
	* @methodName  : updateClsbizType
	* @author      : 송예진
	* @date        : 2024.10.07
	* @return      : 본사가 등록시 cls01 > cls02로 변경
	*/
	public int updateClsbizType();
}
