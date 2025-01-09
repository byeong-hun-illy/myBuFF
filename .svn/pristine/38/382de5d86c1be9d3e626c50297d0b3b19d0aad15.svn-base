package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.hdofc.service
* @fileName     : HdofcMemberService.java
* @author       : 김현빈
* @date         : 2024.10.10
* @description  : 회원 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.10               김현빈     	  			최초 생성
*/
public interface HdofcMemberService {
	
	/**
	* @methodName  : selectMemberList
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 전체 회원 리스트 출력
	*/
	public List<MemberVO> selectMemberList(Map<String, Object> map);
	
	/**
	* @methodName  : selectMbrNmList
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 회원명 필터링 select
	*/
	public List<MemberVO> selectMbrNmList();
	
	/**
	* @methodName  : totalMember
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 전체 회원 인원수
	*/
	public int totalMember(Map<String, Object> map);
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 탈퇴 유형 별 인원수
	*/
	public Map<String, Object> tapMaxTotal();
	
	/**
	* @methodName  : selectMemberDetail
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 회원 관리 상세보기
	*/
	public MemberVO selectMemberDetail(String mbrId);
	
}
