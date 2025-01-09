package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.FrcsDscsnVO;

@Mapper
public interface HdofcFrcsDscsnMapper {
	
	/**
	* @methodName  : selectFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param map   : 검색조건
	* @return      : 상담 내역 조회
	*/
	public List<FrcsDscsnVO> selectFrcsDscsn(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param map   : 검색조건
	* @return      : 상담내역 갯수
	*/
	public int selectTotalFrcsDscsn(Map<String, Object> map);
	
	/**
	* @methodName  : selectFrcsDscsnDtl
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param dscsnCode
	* @return      : 상담 상세
	*/
	public FrcsDscsnVO selectFrcsDscsnDtl(String dscsnCode);
	
	/**
	* @methodName  : updateFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO(dscsnCode, mngrId, dscsnType, rgnNo, dscsnPlanYmd) 선택 사항  dscsnCn
	* @return
	*/
	public int updateFrcsDscsn(FrcsDscsnVO frcsDscsnVO);
	
	/**
	* @methodName  : updateMbrType02
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO
	* @return : 회원구분 변경 DSC04로 바뀔때 함께 변경
	*/
	public int updateMbrType02(FrcsDscsnVO frcsDscsnVO);
	
	/**
	 * @methodName  : updateMbrType02
	 * @author      : 송예진
	 * @date        : 2024.09.23
	 * @param frcsDscsnVO
	 * @return : 회원구분 변경  개업포기
	 */
	public int updateMbrType01(FrcsDscsnVO frcsDscsnVO);
}
