package com.buff.cust.service;

import java.util.List;

import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MemberVO;
import com.buff.vo.OrdrVO;
import com.buff.vo.QsVO;

public interface CustMyPageService {

	/**
	 * 
	 * 문의 사항 내역, 가맹점 상담 내역, 쿠폰 내역, 나의 정보 변경 
	* @methodName  : selectMyPage
	* @author      : 서윤정
	 *@param QsVO, FrcsDscsnVO, EventVO,myStore, myInfo, updateMbrAjax 회원 탈퇴, deleteLikeStoreAjax 관심 삭제
	*  마이페이지 페이지 조회
	* @return : 
	*/
	public List<QsVO> myQs(String mbrId);

	public List<FrcsDscsnVO> myDscsn(String mbrId);

	public List<OrdrVO> myOrdr(String mbrId);

	public List<EventVO> myCoupon(String mbrId);

	public MemberVO myStore(String mbrId);

	public int changeCustInfoAjax(MemberVO memberVO);

	public int updateMbrAjax(String mbrId);

	public int deleteLikeStoreAjax(String mbrId, String frcsNo);

	


	
}
