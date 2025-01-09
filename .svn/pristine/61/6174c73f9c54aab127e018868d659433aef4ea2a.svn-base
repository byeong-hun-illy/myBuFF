package com.buff.hdofc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.MngrMapper;
import com.buff.hdofc.service.MngrService;
import com.buff.vo.MemberVO;
import com.buff.vo.MngrVO;

/**
* @packageName  : com.buff.service.hdofc.impl
* @fileName     : MngrServiceImpl.java
* @author       : 송예진
* @date         : 2024.09.13
* @description  : 본사 관련 서비스 impl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        송예진     	  			최초 생성
*/
@Service
public class MngrServiceImpl implements MngrService{
	
	@Autowired
	MngrMapper mngrMapper;
	
	/**
	* @methodName  : selectMngr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 검색 조건 + 페이징
	* @return      : 검색 조건에 따른 관리자 정보
	*/
	public List<MngrVO> selectMngr(Map<String, Object> map) {
		return this.mngrMapper.selectMngr(map);
	};
	
	
	/**
	* @methodName  : selectTotalMngr
	* @author      : 송예진
	* @date        : 2024.09.13
	* @param       : 검색 조건 + 페이징
	* @return      : 검색 조건에 따른 관리자 정보 총 갯수
	*/
	public int selectTotalMngr(Map<String, Object> map) {
		return this.mngrMapper.selectTotalMngr(map);
	};
	
	/**
	* @methodName  : selectBzentMngr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentType
	* @return      : 가맹점이나 관리자 거래처담당자 하나 지정해 조회
	*/
	public List<MemberVO> selectMngrSelect(){
		return this.mngrMapper.selectMngrSelect();
	};
	

	/**
	* @methodName  : selectMngrInfo
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param mbrId
	* @return      : 사람의 사원정보와 회원정보 조회
	*/
	public MngrVO selectMngrInfo(String mbrId) {
		return this.mngrMapper.selectMngrInfo(mbrId);
	};
}
