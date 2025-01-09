package com.buff.cust.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.CouponVO;
import com.buff.vo.MenuVO;
import com.buff.vo.OrdrDtlVO;
import com.buff.vo.OrdrVO;

public interface CustOrdrService {
	
	/**
	* @methodName  : selectOrdrMenu
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param map
	* @return      : 주문할 매장의 메뉴 조회
	*/
	public List<MenuVO> selectOrdrMenu(Map<String, Object> map);
	
	
	/**
	* @methodName  : selectCoupon
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param mbrId
	* @return      : 회원이 사용가능한 쿠폰 조회
	*/
	public List<CouponVO> selectCoupon(String mbrId);
	
	
	/**
	* @methodName  : insertOrdr
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param ordrVO
	* @return      : 주문 등록
	*/
	public int insertOrdr(OrdrVO ordrVO);
	
}
