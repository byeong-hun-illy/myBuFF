package com.buff.com.service;

import org.apache.commons.mail.EmailException;

import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.service
* @fileName     : MemberService.java
* @author       : 이병훈
* @date         : 2024.09.13
* @description  : 공통 비회원 관련 서비스 인터페이스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/
public interface MemberService {
	
	
	/**
	* @methodName  : selectId
	* @author      : 이병훈 
	* @date        : 2024.09.13
	* @param memberVO : 아이디 찾기를 위한 정보가 담긴 사용자VO 객체
	* @return 	   : 검색에 따른 해당 회원ID
	*/
	public String selectId(MemberVO memberVO);
	
	/**
	* @methodName  : selectPswd
	* @author      : 이병훈
	* @date        : 2024.09.13
	* @param memberVO : 사용자 정보가 담긴 VO 객체 
	* @return	   : 검색에 따른 해당 회원 Password
	*/
//	public String selectPswd(MemberVO memberVO);

	/**
	* @methodName  : sendTempPswd
	* @author      : 이병훈 
	* @date        : 2024.09.14
	* @param memberVO : 사용자 정보가 담긴 VO객체
	* @return 	   : 성공 여부 
	*/
	public String sendTempPswd(MemberVO memberVO);
	
    
    /**
    * @methodName  : insertRoleCust
    * @author      : 송예진
    * @date        : 2024.10.02
    * @param mbrId
    * @return      : 거래처나 본사 회원권한 추가
    */
    public int insertRoleCust(String mbrId);
	
	
	/**
	* @methodName	: insertMember
	* @author		: 김현빈
	* @date			: 2024.09.27
	* @param		: memberVO
	* @return		: 회원 테이블, 권한 테이블 insert
	*/
	public int insertMember(MemberVO memberVO);
	
	/**
     * @methodName   : checkIdDuplicate
     * @author       : 김현빈
     * @date         : 2024.09.27
     * @param mbrId  : 사용자 아이디
     * @return       : 중복된 아이디 개수 (0이면 중복 없음, 1 이상이면 중복)
     */
    public int checkIdDuplicate(String mbrId);
	
    
    /**
    * @methodName  : generateTempPassword
    * @author      : 이병훈
    * @date        : 2024.10.04
    * @return	   : 임시비밀번호 랜덤 생성
    */
    public String generateTempPassword();
    
    
    /**
    * @methodName  : sendEmailWithTempPswd
    * @author      : 이병훈
    * @date        : 2024.10.04
    * @param email
    * @param tempPswd
    */
    public void sendEmailWithTempPswd(String email, String tempPswd)  throws EmailException;
    
    /**
    * @methodName  : updatePswd
    * @author      : 이병훈
    * @date        : 2024.10.04
    * @param memberVO
    * 사용자 비밀번호 업데이트
    */
    public void updatePswd(MemberVO memberVO);
    
}
