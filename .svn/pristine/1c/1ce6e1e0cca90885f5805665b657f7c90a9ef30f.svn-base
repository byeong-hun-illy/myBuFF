package com.buff.frcs.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.frcs.mapper.FrcsMyPageMapper;
import com.buff.frcs.service.FrcsMyPageService;
import com.buff.vo.FrcsVO;

/**
* @packageName  : com.buff.service.frcs.impl
* @fileName     : FrcsMyPageServiceImpl.java
* @author       : 김현빈
* @date         : 2024.09.12
* @description  : 가맹점 마이 페이지 serviceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12                김현빈     	  		      최초 생성
*/


@Service
public class FrcsMyPageServiceImpl implements FrcsMyPageService {
	
	@Inject
	FrcsMyPageMapper frcsMyPageMapper;
	
	/**
	* @methodName  : myPageAjax
	* @author      : 김현빈
	* @date        : 2024.09.12
	* @param 	   : 
	* @return      : 가맹점과 가맹점주의 정보 출력
	*/
	@Override
	public FrcsVO selectFrcsMyPage(String mbrId) {
		return this.frcsMyPageMapper.selectFrcsMyPage(mbrId);
	}
	
	/**
	* @methodName  : updateFrcsMyPage
	* @author      : 김현빈
	* @date        : 2024.09.14
	* @param 	   : 
	* @return      : 가맹점, 가맹업주 정보 수정
	*/
	@Transactional
	@Override
	public int updateFrcsMyPage(FrcsVO frcsVO) {
		int result = 0;
		result = this.frcsMyPageMapper.updateFrcsMyPageTime(frcsVO);
		result = this.frcsMyPageMapper.updateFrcsMyPageTel(frcsVO);
		result = this.frcsMyPageMapper.updateFrcsMypageMember(frcsVO);
		result = this.frcsMyPageMapper.updateFrcsMypageBzent(frcsVO);
		return result;
	}

	/**
	 * @methodName  : insertFrcsClsbiz
	 * @author      : 김현빈
	 * @date        : 2024.09.20
	 * @param 	   : 
	 * @return      : 가맹점 폐업신청 테이블 insert, 가맹점 상태, 폐업일자 update
	 */
	@Transactional
	@Override
	public int insertFrcsClsbiz(FrcsVO frcsVO) {
		int result = 0;
		result = this.frcsMyPageMapper.insertFrcsClsbiz(frcsVO);
		result = this.frcsMyPageMapper.updateFrcsClsbiz(frcsVO);
		return result;
	}
	
	/**
	* @methodName  : selectFrcsMngr
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 가맹점 담당 관리자의 정보 출력
	*/
	@Override
	public FrcsVO selectFrcsMngr(String mbrId) {
		return this.frcsMyPageMapper.selectFrcsMngr(mbrId);
	}
	
}
