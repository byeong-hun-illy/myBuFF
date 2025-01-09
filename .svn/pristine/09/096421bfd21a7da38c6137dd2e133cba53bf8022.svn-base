package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.BzentVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.FrcsVO;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.mapper.hdofc
* @fileName     : FrcsMapper.java
* @author       : 송예진
* @date         : 2024.09.12
* @description  : 가맹점 관련 mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        송예진     	  			최초 생성
*/
@Mapper
public interface HdofcFrcsMapper {
// <----------------------------- 가맹점 조회 시작 ------------------------------>
	/**
	* @methodName  : selectFrcs
	* @author      : 송예진
	* @date        : 2024.09.12
	* @param 	   : 검색 조건
	* @return      : 검색조건에 맞는 페이징 된 가맹점 리스트
	*/
	public List<FrcsVO> selectFrcs(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcs
	* @author      : 송예진
	* @date        : 2024.09.12
	* @param 	   : 검색 조건
	* @return      : 검색조건에 맞는 가맹점 리스트 총 갯수
	*/
	public int selectTotalFrcs(Map<String, Object> map);

// <----------------------------- 가맹점 조회 끝 ------------------------------>

// <----------------------------- 가맹점 상세 조회 시작 ------------------------------>
	
	/**
	* @methodName  : selectDtlFrcs
	* @author      : 송예진
	* @date        : 2024.09.13
	* @return      : 하나의 가맹점 정보
	*/
	public FrcsVO selectDtlFrcs(String frcsNo);
	
	/**
	* @methodName  : updateBzentMbr
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param       : bzentVO (bzentNo, bzentNm, bzentZip, bzentAddr, bzentDaddr, bzentTelno, mbrId, mngrId)
, mbrId)
	*/
	public int updateBzent(BzentVO bzentVO);
	
	/**
	 * @methodName  : updateFrcs
	 * @author      : 송예진
	 * @date        : 2024.09.14
	 * @param       : frcsVO (bzentNo, opbizYmd)
	 */
	public int updateFrcs(FrcsVO frcsVO);
	
	/**
	* @methodName  : deleteRoleFrcs
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param       : bzentVO(bzentNo) 이전에 가지고있는 사람 권한 삭제, 필수로 가맹점주 수정 이전에 수행할 것
	*/
	public int deleteRoleFrcs(BzentVO bzentVO);
	
	/**
	 * @methodName  : updateMbrType
	 * @author      : 송예진
	 * @date        : 2024.09.22
	 * @param       : bzentVO(bzentNo) 회원 구분 고객으로 바꿈(폐업시)
	 */
	public int updateMbrType(BzentVO bzentVO);
	
	/**
	* @methodName  : insertRoleFrcs
	* @author      : 송예진
	* @date        : 2024.09.14
	* @param       : bzentVO(mbrId) 가맹점주 권한 추가
	*/
	public int insertRoleFrcs(BzentVO bzentVO);
	
	/**
	* @methodName  : deleteDscsnFrcs
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param bzentVO
	* @return      : 변경시 기존 상담정보 삭제
	*/
	public int deleteDscsnFrcs(BzentVO bzentVO);
	
	/**
	* @methodName  : updateDscsnFrcs
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO
	* @return      : 상담에 대한 정보 매칭
	*/
	public int updateDscsnFrcs(FrcsDscsnVO frcsDscsnVO);
// <----------------------------- 가맹점 상세 조회 끝 ------------------------------>
	
// <----------------------------- 가맹점 추가 시작 ------------------------------>
	
	/**
	* @methodName  : selectPreFrcsMbr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param map   : 검색조건 + 페이징 
	* @return      : 상담을 마친 가맹점을 배정받지 않은 회원 리스트
	*/
	public List<FrcsDscsnVO> selectPreFrcsMbr(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalPreFrcsMbr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param map   : 검색조건 + 페이징 
	* @return      : 상담을 마친 가맹점을 배정받지 않은 회원 총 갯수
	*/
	public int selectTotalPreFrcsMbr(Map<String, Object> map);
	
	/**
	* @methodName  : insertBzent
	* @author      : 송예진
	* @date        : 2024.09.16
	* @param       : bzentVO
	* @return      : 가맹점 사업체 정보 추가
	*/
	public int insertBzent(BzentVO bzentVO);
	
	/**
	* @methodName  : insertFrcs
	* @author      : 송예진
	* @date        : 2024.09.16
	* @param       : frcsVO
	* @return      : 가맹점 테이블 추가 (bzent>frcs순서)
	*/
	public int insertFrcs(FrcsVO frcsVO);
	
	/**
	* @methodName  : selectMaxFrcsNo
	* @author      : 송예진
	* @date        : 2024.09.23
	* @return      : 추가시 가맹점 번호가져오기
	*/
	public String selectMaxFrcsNo();
// <----------------------------- 가맹점 추가 끝 ------------------------------>
}
