package com.buff.cust.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.mapper.cust
* @fileName     : MemberMapper.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 이 클래스는 데이터베이스에서 로그인 정보를 조회하기 위한 Mapper 인터페이스.
 				  Sql 쿼리를 실행하여 데이터베이스(DB)와 상호작용한다.
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/



@Mapper
public interface MemberMapper {
	
	/**
	* @methodName  : getLogin
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @param mbrId : 해당하는 사용자ID
	* @return : 로그인 성공 / 실패
	*/
	public MemberVO getLogin(String mbrId);
	
	

	/**
	* @methodName  : selectId
	* @author      : 이병훈
	* @date        : 2024.09.13
	* @param memberVO : 사용자 정보가 담긴 VO객체
	* @return 	   : 해당하는 사용자 ID
	*/
	public String selectId(MemberVO memberVO);
	
	
	/**
	* @methodName  : selectPswd
	* @author      : 이병훈
	* @date        : 2024.09.13
	* @param memberVO : 사용자 정보가 담긴 VO객체
	* @return	   : 해당하는 사용자 password
	*/
	public String selectPswd(MemberVO memberVO);
	
	
	/**
	* @methodName  : updatePswd
	* @author      : 이병훈
	* @date        : 2024.09.14
	* @param memberVO : 사용자 정보가 담긴 VO객체
	*/
	public void updatePswd(MemberVO memberVO);
	

	
	/**
	* @methodName  : selectStore
	* @author      : 서윤정
	 * @param map 
	* @date        : 2024.09.20
	* @param BzentVO : 매장조회 _ 페이징 처리
	* @return 	   : 해당 가맹점 정보
	*/
	public int getTotal(Map<String, Object> map);
	
	/**
	* @methodName	: insertMemberSign
	* @author		: 김현빈
	* @date			: 2024.09.26
	* @param		: memberVO
	* @return		: 회원 테이블 insert
	*/
	public int insertMemberSign(MemberVO memberVO);
	/**
	* @methodName	: insertAuthSign
	* @author		: 김현빈
	* @date			: 2024.09.26
	* @param		: memberVO
	* @return		: 권한 테이블 insert
	*/
	public int insertAuthSign(MemberVO memberVO);
	
    /**
     * @methodName   : checkIdDuplicate
     * @author       : 김현빈
     * @date         : 2024.09.27
     * @param mbrId  : 사용자 아이디
     * @return       : 중복된 아이디 개수 (0이면 중복 없음, 1 이상이면 중복)
     */
    public int checkIdDuplicate(String mbrId);
    
    /**
    * @methodName  : insertRoleCust
    * @author      : 송예진
    * @date        : 2024.10.02
    * @param mbrId
    * @return      : 거래처나 본사 회원권한 추가
    */
    public int insertRoleCust(String mbrId);
   
    
    /**
     * @methodName  : selectStore
     * @author      : 서윤정
     * @date        : 2024.10.06
     * @param mbrId
     * @return      : 고객 관심 매장 중복 확인
     */
	public int chkLikeStore(Map<String, Object> map);


	 /**
     * @methodName  : selectStore
     * @author      : 서윤정
     * @date        : 2024.10.06
     * @param mbrId
     * @return      : 고객 관심 매장 중복 확인
     */
	public int deleteLikeStore(Map<String, Object> map);


	 /**
     * @methodName  : selectStore
     * @author      : 서윤정
     * @date        : 2024.10.06
     * @param mbrId
     * @return      : 고객 관심 매장 중복 확인
     */
	public int insertLikeStore(Map<String, Object> map);
}
