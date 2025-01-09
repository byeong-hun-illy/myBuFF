package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

@Mapper
public interface HdofcCnptMapper {
	/**
	* @methodName  : selectCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @return      : 거래처 리스트
	*/
	public List<BzentVO> selectCnpt(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @return      : 거래처 갯수
	*/
	public int selectTotalCnpt(Map<String, Object> map);
	
	/////////////////////////////// 추가
	
	/**
	* @methodName  : selectCnptMbr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param map
	* @return      : 아직 거래처를 담당하지 않은 허락되지않은 회원 조회
	*/
	public List<MemberVO> selectCnptMbr(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalCnptMbr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param map
	* @return      : 아직 거래처를 담당하지 않은 허락되지않은 회원 조회 갯수
	*/
	public int selectTotalCnptMbr(Map<String, Object> map);
	
	/**
	* @methodName  : insertCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 추가
	*/
	public int insertCnpt(BzentVO bzentVO);
	
	/**
	* @methodName  : insertRoleCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 권한 추가
	*/
	public int insertRoleCnpt(BzentVO bzentVO);
	
	///////////////////////////////// 수정
	
	/**
	* @methodName  : deleteRoleCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 권한 삭제
	*/
	public int deleteRoleCnpt(BzentVO bzentVO);
	
	/**
	* @methodName  : updateBzent
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 수정
	*/
	public int updateBzent(BzentVO bzentVO);
	
	/**
	* @methodName  : selectCnptDtl
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 거래처 상세
	*/
	public BzentVO selectCnptDtl(String bzentNo);
	
	/**
	* @methodName  : deleteCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 재고 정보가없는 거래처 삭제
	*/
	public int deleteCnpt(String bzentNo);
}
