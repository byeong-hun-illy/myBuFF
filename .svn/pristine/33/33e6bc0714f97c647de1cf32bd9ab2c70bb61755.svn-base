package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.GdsVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.service.frcs
* @fileName     : FrcsPoServiceImpl.java
* @author       : 김현빈
* @date         : 2024.09.12
* @description  : 가맹점 발주 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13               김현빈     	  		      최초 생성
*/
public interface FrcsPoService {
	
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
	public List<GdsVO> selectFrcsPoDetail(String poNo);
	
}
