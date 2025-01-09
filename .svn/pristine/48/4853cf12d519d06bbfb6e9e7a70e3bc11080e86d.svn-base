package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;
import com.buff.vo.MngrVO;

/**
* @packageName  : com.buff.mapper.hdofc
* @fileName     : MngrMapper.java
* @author       : 송예진
* @date         : 2024.09.13
* @description  : 본사 관리자 관련 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        송예진     	  			최초 생성
*/
@Mapper
public interface MngrMapper {
	
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
	* @methodName  : selectBzentMngr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentType
	* @return      : 가맹점이나 관리자 거래처담당자 하나 지정해 조회
	*/
	public List<MemberVO> selectMngrSelect();
	
	/**
	* @methodName  : selectBzentMngr
	* @author      : 정기쁨
	* @date        : 2024.09.29
	* @param bzentType
	* @return      : 사원 관리 페이지에서 사용할 정보
	*/
	public Map<String, Object> selectTapNum();
	public List<MngrVO> selectBoxMngr(); // 검색: 담당자 조회
	public List<BzentVO> selectBoxFrcs(); // 검색: 가맹점 조회
	public List<BzentVO> selectBoxCntp(); // 검색: 거래처 조회
	public int selectTotalMngrList(Map<String, Object> map); // 검색 결과 갯수
	public List<MngrVO> selectMngrList(Map<String, Object> map); // 페이징
	public int updateAuth(String mbrId); // 권한 테이블 insert
	public int updateMngr(String mbrId); // 사원 테이블 insert

	/**
	* @methodName  : selectMngrDtl
	* @author      : 정기쁨
	* @date        : 2024.09.29
	* @param bzentType
	* @return      : 사원 상세 페이지에서 사용할 정보
	*/
	public MngrVO selectMngrDtl(String mngrId); // 사원 정보 조회
	public List<BzentVO> selectMngrBzent(String mngrId); // 사원 담당업체 조회
	public int updateMngrInfo(MemberVO memberVO); // 사원 정보 변경
	public int updateMngrBzent(BzentVO bzentVO); // 사원 담당 업체 변경 (추가/삭제)
	public Map<String, Object> selectBzentNum(); // // 전체업체수, 가맹점 수, 거래처 수
	public List<BzentVO> selectBzentList(Map<String, Object> map); // 업체 테이블 조회
	public int deleteMngrBzent(Map<String,Object> map); // 업체 삭제


	/**
	* @methodName  : selectMngrInfo
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param mbrId
	* @return      : 사람의 사원정보와 회원정보 조회
	*/
	public MngrVO selectMngrInfo(String mbrId);
	
}














