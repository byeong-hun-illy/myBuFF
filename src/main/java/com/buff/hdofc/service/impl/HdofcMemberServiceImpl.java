package com.buff.hdofc.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.HdofcMemberMapper;
import com.buff.hdofc.service.HdofcMemberService;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.service.hdofc.impl
* @fileName     : HdofcMemberServiceImpl.java
* @author       : 김현빈
* @date         : 2024.10.10
* @description  : 회원 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.10        김현빈     	  			최초 생성
*/
@Service
public class HdofcMemberServiceImpl implements HdofcMemberService {
	
	@Inject
	HdofcMemberMapper hdofcMemberMapper;
	
	/**
	* @methodName  : selectMemberList
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 전체 회원 리스트 출력
	*/
	@Override
	public List<MemberVO> selectMemberList(Map<String, Object> map) {
		return this.hdofcMemberMapper.selectMemberList(map);
	}
	
	/**
	* @methodName  : selectMbrNmList
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 회원명 필터링 select
	*/
	@Override
	public List<MemberVO> selectMbrNmList() {
		return this.hdofcMemberMapper.selectMbrNmList();
	}
	
	/**
	* @methodName  : totalMember
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : map
	* @return      : 전체 회원 인원수
	*/
	@Override
	public int totalMember(Map<String, Object> map) {
		return this.hdofcMemberMapper.totalMember(map);
	}
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 탈퇴 유형 별 인원수
	*/
	@Override
	public Map<String, Object> tapMaxTotal() {
		return this.hdofcMemberMapper.tapMaxTotal();
	}
	
	/**
	* @methodName  : selectMemberDetail
	* @author      : 김현빈
	* @date        : 2024.10.10
	* @param 	   : 
	* @return      : 회원 관리 상세보기
	*/
	@Override
	public MemberVO selectMemberDetail(String mbrId) {
		return this.hdofcMemberMapper.selectMemberDetail(mbrId);
	}
	
}