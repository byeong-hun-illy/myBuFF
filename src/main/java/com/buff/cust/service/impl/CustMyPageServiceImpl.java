package com.buff.cust.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.cust.mapper.CustMyPageMapper;
import com.buff.cust.service.CustMyPageService;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MemberVO;
import com.buff.vo.OrdrVO;
import com.buff.vo.QsVO;

@Service
public class CustMyPageServiceImpl implements CustMyPageService {

	@Inject
	CustMyPageMapper myPageMapper;
	
	
	/**
	* @methodName  : myPageMain
	* @author      : 서윤정
	* @date        : 2024.09.13
	* @param  	   : 
	* @return      : 마이페이지 화면 
	*/
		
	@Override
	public List<QsVO> myQs(String mbrId) {
		return this.myPageMapper.myQs(mbrId);
	}


	@Override
	public List<FrcsDscsnVO> myDscsn(String mbrId) {
		return this.myPageMapper.myDscsn(mbrId);
	}


	@Override
	public List<OrdrVO> myOrdr(String mbrId) {
		return this.myPageMapper.myOrdr(mbrId);
	}


	@Override
	public List<EventVO> myCoupon(String mbrId) {
		return this.myPageMapper.myCoupon(mbrId);
	}


	@Override
	public MemberVO myStore(String mbrId) {
		return this.myPageMapper.myStore(mbrId);
	}


	@Override
	public int changeCustInfoAjax(MemberVO memberVO) {
		return this.myPageMapper.changeCustInfoAjax(memberVO);
	}


	@Override
	public int updateMbrAjax(String mbrId) {
		return this.myPageMapper.updateMbrAjax(mbrId);
	}


	@Override
	public int deleteLikeStoreAjax(String mbrId, String frcsNo) {
		return this.myPageMapper.deleteLikeStoreAjax(mbrId, frcsNo);
	}


	
	
	
}
