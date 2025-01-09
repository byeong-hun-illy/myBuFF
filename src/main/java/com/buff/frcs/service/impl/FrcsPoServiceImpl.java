package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsPoMapper;
import com.buff.frcs.service.FrcsPoService;
import com.buff.vo.GdsVO;
import com.buff.vo.PoVO;

/**
* @packageName  : com.buff.service.frcs.impl
* @fileName     : FrcsPoService.java
* @author       : 김현빈
* @date         : 2024.09.13
* @description  : 가맹점 마이 페이지 serviceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13                김현빈     	  		      최초 생성
*/
@Service
public class FrcsPoServiceImpl implements FrcsPoService {
	
	@Inject
	FrcsPoMapper frcsPoMapper;
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.20
	* @param 	   : 
	* @return      : 접속한 가맹점주의 발주 내역 출력
	*/
	@Override
	public List<PoVO> selectFrcsPoList(Map<String, Object> map) {
		return this.frcsPoMapper.selectFrcsPoList(map);
	}
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.23
	* @param 	   : 
	* @return      : 페이징처리된 내역의 총 갯수 출력
	*/
	@Override
	public int poTotalCnt(Map<String, Object> map) {
		return this.frcsPoMapper.poTotalCnt(map);
	}
	
	/**
	* @methodName  : frcsPoList
	* @author      : 김현빈
	* @date        : 2024.09.25
	* @param 	   : 
	* @return      : 발주 유형의 총 갯수 출력
	*/
	@Override
	public Map<String, Object> tapMaxTotal(String mbrId) {
		return this.frcsPoMapper.tapMaxTotal(mbrId);
	}
	
	/**
	* @methodName  : 
	* @author      : 김현빈
	* @date        : 2024.09.25
	* @param 	   : 
	* @return      : 발주 내역 상세 보기
	*/
	@Override
	public List<GdsVO> selectFrcsPoDetail(String poNo) {
		return this.frcsPoMapper.selectFrcsPoDetail(poNo);
	}
	
}
