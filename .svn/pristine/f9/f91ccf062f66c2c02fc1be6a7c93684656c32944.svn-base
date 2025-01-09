package com.buff.cnpt.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.cnpt.mapper
* @fileName     : CnptMapper.java
* @author       : 이병훈
* @date         : 2024.09.17
* @description  : 거래처 관련 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.17        이병훈     	  			최초 생성
*/
@Mapper
public interface CnptMapper {

	/**
	* @methodName  : selectCnpt
	* @author      : 이병훈
	* @date        : 2024.09.17
	* @param bzentNo : 거래처 번호
	* @return 	   : 거래처 정보 및 거래처 담당자 정보
	*/
	public BzentVO selectCnpt(String bzentNo);

	/**
	* @methodName  : updateCnpt
	* @author      : 이병훈 
	* @date        : 2024.09.18
	* @param bzentVO : 수정된 거래처 정보
	* @return : 거래처 정보 수정
	*/
	public void updateCnpt(BzentVO bzentVO);

	/**
	* @methodName  : updateMngr
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param memberVO : 수정된 담당자 정보
	*/
	public void updateMngr(MemberVO memberVO);
	
	
}
