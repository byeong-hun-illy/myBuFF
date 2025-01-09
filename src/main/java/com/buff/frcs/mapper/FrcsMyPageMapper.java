package com.buff.frcs.mapper;

import com.buff.vo.FrcsVO;

/**
* @packageName  : com.buff.mapper.frcs
* @fileName     : FrcsMyPageMapper.java
* @author       : 김현빈
* @date         : 2024.09.12
* @description  : 가맹점 마이 페이지 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12                김현빈     	  		      최초 생성
*/
public interface FrcsMyPageMapper {
	
	/**
	* @methodName  : myPageAjax
	* @author      : 김현빈
	* @date        : 2024.09.12
	* @param 	   : 
	* @return      : 가맹점과 가맹점주의 정보 출력
	*/
	public FrcsVO selectFrcsMyPage(String mbrId);
	
	/**
	* @methodName  : updateFrcsMyPage
	* @author      : 김현빈
	* @date        : 2024.09.14
	* @param 	   : 
	* @return      : 가맹점의 운영 영업시작시간, 영업종료시간 수정
	*/
	public int updateFrcsMyPageTime(FrcsVO frcsVO);
	
	/**
	* @methodName  : updateFrcsMyPage
	* @author      : 김현빈
	* @date        : 2024.09.14
	* @param 	   : 
	* @return      : 가맹점의 전화번호 수정
	*/
	public int updateFrcsMyPageTel(FrcsVO frcsVO);
	
	/**
	* @methodName  : updateOwnerMyPage
	* @author      : 김현빈
	* @date        : 2024.09.17
	* @param 	   : 
	* @return      : 가맹점주의 이름, 전화번호, 이메일 수정
	*/
	public int updateFrcsMypageMember(FrcsVO frcsVO);
	
	/**
	* @methodName  : updateOwnerMyPage
	* @author      : 김현빈
	* @date        : 2024.09.17
	* @param 	   : 
	* @return      : 가맹점주의 계좌 번호, 은행 유형 수정
	*/
	public int updateFrcsMypageBzent(FrcsVO frcsVO);
	
	/**
	* @methodName  : insertFrcsClsbiz
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 가맹점 폐업신청 테이블 insert
	*/
	public int insertFrcsClsbiz(FrcsVO frcsVO);
	
	/**
	* @methodName  : insertFrcsClsbiz
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 가맹점 상태, 폐업일자 update
	*/
	public int updateFrcsClsbiz(FrcsVO frcsVO);
	
	/**
	* @methodName  : selectFrcsMngr
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 가맹점 담당 관리자의 정보 출력
	*/
	public FrcsVO selectFrcsMngr(String mbrId);
	
}
