package com.buff.cust.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.cust.mapper.CustOrdrMapper;
import com.buff.cust.service.CustOrdrService;
import com.buff.vo.CouponVO;
import com.buff.vo.MenuVO;
import com.buff.vo.OrdrDtlVO;
import com.buff.vo.OrdrVO;

@Service
public class CustOrdrServiceImpl implements CustOrdrService{
	
	@Autowired
	CustOrdrMapper ordrMapper;
	
	/**
	* @methodName  : selectOrdrMenu
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param map
	* @return      : 주문할 매장의 메뉴 조회
	*/
	public List<MenuVO> selectOrdrMenu(Map<String, Object> map){
		return this.ordrMapper.selectOrdrMenu(map);
	};
	
	
	/**
	* @methodName  : selectCoupon
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param mbrId
	* @return      : 회원이 사용가능한 쿠폰 조회
	*/
	public List<CouponVO> selectCoupon(String mbrId){
		return this.ordrMapper.selectCoupon(mbrId);
	};
	
	
	/**
	* @methodName  : insertOrdr
	* @author      : 송예진
	* @date        : 2024.10.08
	* @param ordrVO
	* @return      : 주문 등록
	*/
	@Transactional
	public int insertOrdr(OrdrVO ordrVO) {
		// 주문 추가
		int cnt = this.ordrMapper.insertOrdr(ordrVO);
		List<OrdrDtlVO> ordrDtlList = ordrVO.getOrdrDtlVOList();
		String ordrNo = ordrVO.getOrdrNo();
		
		String issuSn = ordrVO.getIssuSn();
		
		// 쿠폰 사용했을 경우
		if(issuSn != null) {
			cnt += this.ordrMapper.updateCouponUse(issuSn);
		}
		
		// 주문 상세
		for(OrdrDtlVO ordrDtl : ordrDtlList) {
			ordrDtl.setOrdrNo(ordrNo);
			cnt+= this.ordrMapper.insertOrdrDtl(ordrDtl);
		}
		return cnt;
	};
}
