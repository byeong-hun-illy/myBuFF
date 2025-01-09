package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.EventVO;

/**
* @packageName  : com.buff.frcs.service
* @fileName     : FrcsCouponService.java
* @author       : 정현종
* @date         : 2024.09.27
* @description  : 가맹점 쿠폰 서비스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.27        정현종     	  			최초 생성
*/
public interface FrcsCouponService {

	/**
	* @methodName  : selectFrcsCouponUseList
	* @author      : 정현종
	* @date        : 2024.09.27
	* @param 	   : map
	* @return	   : 가맹점 쿠폰 사용 내역 조회
	*/
	public List<EventVO> selectFrcsCouponUseList(Map<String, Object> map);

	/**
	* @methodName  : selectTotalFrcsCoupon
	* @author      : 정현종
	* @date        : 2024.09.27
	* @param       : map
	* @return      : 검색조건에 따른 가맹점 쿠폰 사용 내역 조회 갯수
	*/
	public int selectTotalFrcsCoupon(Map<String, Object> map);

	/**
	* @methodName  : selectAllEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return      : 전체 이벤트 수	
	*/
	public int selectAllEventCount(Map<String, Object> map);

	/**
	* @methodName  : selectProgressEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 진행중인 이벤트 수
	*/
	public int selectProgressEventCount(Map<String, Object> map);

	/**
	* @methodName  : selectCompletedEventCount
	* @author      : 정현종
	* @date        : 2024.09.30
	* @param 	   : map
	* @return	   : 완료된 이벤트 수
	*/
	public int selectCompletedEventCount(Map<String, Object> map);

}
