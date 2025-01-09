package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsCouponMapper;
import com.buff.frcs.service.FrcsCouponService;
import com.buff.vo.EventVO;

/**
* @packageName  : com.buff.frcs.service.impl
* @fileName     : FrcsCouponServiceImpl.java
* @author       : 정현종
* @date         : 2024.09.27
* @description  : 가맹점 쿠폰 서비스 impl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.27        정현종     	  			최초 생성
*/
@Service
public class FrcsCouponServiceImpl implements FrcsCouponService {
	
	@Autowired
	FrcsCouponMapper frcsCouponMapper;
	
	/**
	* @methodName  : selectFrcsCouponUseList
	* @author      : 정현종
	* @date        : 2024.09.27
	* @param 	   : map
	* @return	   : 가맹점 쿠폰 사용 내역 조회
	*/
	@Override
	public List<EventVO> selectFrcsCouponUseList(Map<String, Object> map) {
		return this.frcsCouponMapper.selectFrcsCouponUseList(map);
	}
	
	/**
	* @methodName  : selectTotalFrcsCoupon
	* @author      : 정현종
	* @date        : 2024.09.27
	* @param       : map
	* @return      : 검색조건에 따른 가맹점 쿠폰 사용 내역 조회 갯수
	*/
	@Override
	public int selectTotalFrcsCoupon(Map<String, Object> map) {
		return this.frcsCouponMapper.selectTotalFrcsCoupon(map);
	}
	
	/**
	* @methodName  : selectAllEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return      : 전체 이벤트 수	
	*/
	@Override
	public int selectAllEventCount(Map<String, Object> map) {
		return this.frcsCouponMapper.selectAllEventCount(map);
	}
	
	/**
	* @methodName  : selectProgressEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 진행중인 이벤트 수
	*/
	@Override
	public int selectProgressEventCount(Map<String, Object> map) {
		return this.frcsCouponMapper.selectProgressEventCount(map);
	}
	
	/**
	* @methodName  : selectCompletedEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 완료된 이벤트 수
	*/
	@Override
	public int selectCompletedEventCount(Map<String, Object> map) {
		return this.frcsCouponMapper.selectCompletedEventCount(map);
	}

}
