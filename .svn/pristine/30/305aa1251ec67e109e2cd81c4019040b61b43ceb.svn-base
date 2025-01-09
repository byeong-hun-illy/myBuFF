package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.BzentVO;
import com.buff.vo.ComVO;
import com.buff.vo.MemberVO;


/**
* @packageName  : com.buff.service.hdofc
* @fileName     : HdofcMngrService.java
* @author       : 정기쁨
* @date         : 2024.09.29
* @description  : 본사 사원 관련 서비스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.28
*         정기쁨     	  			최초 생성
*/
public interface HdofcMngrService {

	/**
	* @methodName  : selectNoticeAjax
	* @author      : 정기쁨
	* @date        : 2024.09.29
	* @param bzentType
	* @return      : 사원관리 페이지 정보
	*/
	public Map<String, Object> selectNoticeAjax(Map<String, Object> map); // 테이블 목록 정보
	public int updateAuthAjax(List<MemberVO> memberVOList); // 권한 승인

	/**
	* @methodName  : selectMngrDetail
	* @author      : 정기쁨
	* @date        : 2024.09.29
	* @param bzentType
	* @return      : 사원관리 페이지 정보
	*/
	public Map<String, Object> MngrDtl(String mngrId);
	public int updateMngrInfo(MemberVO memberVO); // 사원 정보 변경
	public int updateMngrBzent(BzentVO bzentVO); // 사원 담당 업체 변경 (추가/삭제)
	public List<ComVO> selectCom(String groupNo); // 그룹번호를 통해 select할 값 전체 가져오기
	public Map<String, Object> selectBzentAjax(Map<String, Object> map); // 업체 선택 모달창
	public int deleteMngrBzent(Map<String,Object> map); // 업체 삭제


	

}


