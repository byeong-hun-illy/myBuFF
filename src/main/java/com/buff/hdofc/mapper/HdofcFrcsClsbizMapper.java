package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.FrcsVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcFrcsClsbizMapper.java
* @author       : 송예진
* @date         : 2024.09.21
* @description  : 본사가 다루는 가맹점 폐업 관리 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.21        송예진     	  			최초 생성
*/
@Mapper
public interface HdofcFrcsClsbizMapper {
	
	/**
	* @methodName  : selectFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param map   : 검색 조건 페이징
	* @return      : 폐업 예정/완료된 가맹점 조회
	*/
	public List<FrcsVO> selectFrcsClsbiz(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param map   : 검색 조건
	* @return      : 폐업 예정/완료된 가맹점 총 갯수
	*/
	public int selectTotalFrcsClsbiz(Map<String, Object> map);
	
	/**
	* @methodName  : selectFrcsClsbizDtl
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param frcsNo
	* @return      : 폐업 상세
	*/
	public FrcsVO selectFrcsClsbizDtl(String frcsNo);
	
	/**
	* @methodName  : updateOneFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @return      : 단일 폐업
	*/
	public int updateOneFrcsClsbiz(String frcsNo);
	
	/**
	* @methodName  : updateFrcsType
	* @author      : 송예진
	* @date        : 2024.09.22
	* @return      : 가맹점 상태 폐업 변경
	*/
	public int updateFrcsType(String frcsNo);
	
	/**
	* @methodName  : updateClclnChk
	* @author      : 송예진
	* @date        : 2024.10.07
	* @return      : cls02 > cls03으로 정산이 완료된 가맹점들 변경
	*/
	public int updateClclnChk();
}
