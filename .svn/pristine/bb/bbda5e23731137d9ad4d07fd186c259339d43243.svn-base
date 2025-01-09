package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.FrcsCheckVO;

/**
* @packageName  : com.buff.hdofc.service
* @fileName     : HdofcFrcsCheckService.java
* @author       : 송예진
* @date         : 2024.09.16
* @description  : 가맹점 점검 service interface
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.16        송예진     	  			최초 생성
*/
public interface HdofcFrcsCheckService {
	/**
	* @methodName  : selectFrcs
	* @author      : 송예진
	* @date        : 2024.09.19
	* @param map   : 페이징 + 검색조건
	* @return      : 점검이 필요한 가맹점 조회
	*/
	public List<FrcsCheckVO> selectFrcs(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcs
	* @author      : 송예진
	* @date        : 2024.09.19
	* @param map   : 검색 조건
	* @return      : 페이징에 필요한 전체 페이지 갯수
	*/
	public Map<String, Object> selectTotalFrcs(Map<String, Object> map);
	
	/**
	* @methodName  : insertFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 점검 항목 추가
	*/
	public int insertFrcsCheck(FrcsCheckVO frcsCheckVO);
	
	/**
	* @methodName  : updateWarn
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 60점 미만 시 경고 추가
	*/
	public int updateWarn(String frcsNo);
	
	/**
	* @methodName  : selectWarn
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 경고 추가 시 경고 확인
	*/
	public int selectWarn(String frcsNo);
	
	/**
	* @methodName  : updateFrcsCls
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 폐업 예정 상태와 폐업일 추가
	*/
	public int updateFrcsCls(String frcsNo);
	
	/**
	* @methodName  : insertFrcsClbiz
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 폐업 테이블 추가
	*/
	public int insertFrcsClsbiz(String frcsNo);
	
	/////////////// 가맹점 점검 조회
	
	/**
	* @methodName  : selectFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param map   : 검색조건 + 페이징
	* @return      : 점검 조회
	*/
	public List<FrcsCheckVO> selectFrcsCheck(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param map   : 검색 조건	
	* @return      : 조건에 대한 총 갯수
	*/
	public int selectTotalFrcsCheck(Map<String, Object> map);
	
	//////////////// 가맹점 상세
	
	/**
	* @methodName  : selectFrcsCheckDtl
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param       : frcsCheckVO(frcsNo, chckSeq)
	* @return      : 점검 상세
	*/
	public FrcsCheckVO selectFrcsCheckDtl(FrcsCheckVO frcsCheckVO);
	
	/**
	* @methodName  : deleteFrcsCheck
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param       : frcsCheckVO(frcsNo, chckSeq)
	* @return      : 점검 삭제
	*/
	public int deleteFrcsCheck(FrcsCheckVO frcsCheckVO);
	
	/**
	* @methodName  : cancelFrcs
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 폐업 취소 frcs
	*/
	public int cancelFrcs(String frcsNo);
	
	/**
	* @methodName  : cancelFrcsClbiz
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 폐업 취소 frcs_clb
	*/
	public int cancelFrcsClsbiz(String frcsNo);
	
	/**
	* @methodName  : deleteWarn
	* @author      : 송예진
	* @date        : 2024.09.20
	* @return      : 경고 삭제
	*/
	public int deleteWarn(String frcsNo);
	
	/**
	* @methodName  : selectFrcsType
	* @author      : 송예진
	* @date        : 2024.09.20
	* @param frcsNo
	* @return     : 가맹점의 타입을 확인
	*/
	public String selectFrcsType(String frcsNo);
	
	/////////////////// 가맹점 상세
	
	/**
	* @methodName  : selectFrcsDtlCheckList
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param frcsNo
	* @return      : 가맹점 하나의 점검리스트 전체
	*/
	public List<FrcsCheckVO> selectFrcsDtlCheckList(String frcsNo);
	
	
	/**
	* @methodName  : selectAvgScr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param frcsNo
	* @return      : 한 가맹점의 평균 점수
	*/
	public String selectAvgScr(String frcsNo);
	
}
