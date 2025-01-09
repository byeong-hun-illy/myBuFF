package com.buff.cust.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MemberVO;
import com.buff.vo.OrdrVO;
import com.buff.vo.QsVO;

public interface CustMyPageMapper {

	public List<QsVO> myQs(String mbrId);

	public List<FrcsDscsnVO> myDscsn(String mbrId);

	public List<OrdrVO> myOrdr(String mbrId);

	public List<EventVO> myCoupon(String mbrId);

	public EventVO insertEventCoupon(String eventNo);

	public MemberVO myStore(String mbrId);

	/**
     * @methodName  : insertEventCouponPost
     * @author      : 서윤정
     * @date        : 2024.10.02
     * @param mbrId
     * @return      : 고객 쿠폰 쿠폰 발급
     */
	public int insertEventCouponPost(Map<String, Object> map);
	
	/**
     * @methodName  : chageCustInfoAjax
     * @author      : 서윤정
     * @date        : 2024.10.02
     * @param mbrId
     * @return      : 마이페이지_ 나의 정보 변경
     */
	public int changeCustInfoAjax(MemberVO memberVO);

	
	/**
     * @methodName  : updateMbrAjax
     * @author      : 서윤정
     * @date        : 2024.10.02
     * @param mbrId
     * @return      : 마이페이지_ 회원 탈퇴
     */
	public int updateMbrAjax(String mbrId);

	/**
     * @methodName  : deleteLikeStoreAjax
     * @author      : 서윤정
     * @date        : 2024.10.09
     * @param mbrId
     * @return      : 마이페이지_ 관심 매장 삭제
     */
	public int deleteLikeStoreAjax(String mbrId, String frcsNo);
	
	
	  

}
