package com.buff.frcs.service;

import com.buff.vo.FrcsVO;

/**
* @packageName  : com.buff.service.frcs
* @fileName     : FrcsMyPageService.java
* @author       : 김현빈
* @date         : 2024.09.12
* @description  : 가맹점 마이페이지 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13               김현빈     	  		      최초 생성
*/
public interface FrcsMyPageService {
	
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
	* @return      : 가맹점, 가맹업주 정보 수정
	*/
	public int updateFrcsMyPage(FrcsVO frcsVO);
	
	/**
	 * @methodName  : insertFrcsClsbiz
	 * @author      : 김현빈
	 * @date        : 2024.09.20
	 * @param 	   : 
	 * @return      : 가맹점 폐업신청 테이블 insert, 가맹점 상태, 폐업일자 update
	 */
	public int insertFrcsClsbiz(FrcsVO frcsVO);
	
	/**
	* @methodName  : selectFrcsMngr
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 가맹점 담당 관리자의 정보 출력
	*/
	public FrcsVO selectFrcsMngr(String mbrId);
	
}
