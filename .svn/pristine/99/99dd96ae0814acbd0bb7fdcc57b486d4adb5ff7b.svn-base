package com.buff.frcs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.buff.vo.GdsVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.mapper.frcs
* @fileName     : FrcsPoMapper.java
* @author       : 김현빈
* @date         : 2024.09.13
* @description  : 가맹점 마이 페이지 Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13                김현빈     	  		      최초 생성
*/
public interface FrcsPoMapper {
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 접속한 가맹점주의 발주 내역 출력
	*/
	public List<PoVO> selectFrcsPoList(Map<String, Object> map);
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.23
	* @param 	   : 
	* @return      : 페이징처리된 내역의 총 갯수 출력
	*/
	public int poTotalCnt(Map<String, Object> map);
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.25
	* @param 	   : 
	* @return      : 발주 유형의 총 갯수 출력
	*/
	public Map<String, Object> tapMaxTotal(String mbrId);
	
	/**
	* @methodName  : 
	* @author      : 김현빈
	* @date        : 2024.09.25
	* @param 	   : 
	* @return      : 발주 내역 상세 보기
	*/
	public List<GdsVO> selectFrcsPoDetail(@Param("poNo") String poNo);
	
}
