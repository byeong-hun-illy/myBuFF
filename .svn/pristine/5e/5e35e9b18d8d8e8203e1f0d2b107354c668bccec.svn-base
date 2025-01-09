package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.MemberVO;
import com.buff.vo.MngrVO;

/**
* @packageName  : com.buff.service.hdofc
* @fileName     : MngrService.java
* @author       : 송예진
* @date         : 2024.09.13
* @description  : 본사 관리자 관련 서비스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        송예진     	  			최초 생성
*/
public interface MngrService {
	/**
	* @methodName  : selectMngr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 검색 조건 + 페이징
	* @return      : 검색 조건에 따른 관리자 정보
	*/
	public List<MngrVO> selectMngr(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalMngr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 검색 조건 + 페이징
	* @return      : 검색 조건에 따른 관리자 정보 총 갯수
	*/
	public int selectTotalMngr(Map<String, Object> map);
	
	/**
	* @methodName  : selectMngrSelect
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentType
	* @return      : 가맹점이나 관리자 거래처담당자 하나 지정해 조회
	*/
	public List<MemberVO> selectMngrSelect();


	/**
	* @methodName  : selectMngrInfo
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param mbrId
	* @return      : 사람의 사원정보와 회원정보 조회
	*/
	public MngrVO selectMngrInfo(String mbrId);
}


