package com.buff.cust.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.BzentVO;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MenuVO;

/**
* @packageName  : com.buff.service.cust
* @fileName     : CustHomeService.java
* @author       : 서윤정
* @date         : 2024.09.13
* @description  : 고객 메인화면_가맹점 카드 목록
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/
public interface CustHomeService {
	
	
	/**
	* @methodName  : home
	* @author      : 서윤정
	* @date        : 2024.09.13
	* @param  	   : 
	* @return      : 고객 메인화면_ 가맹점 카드 리스트 
	*/
	public List<BzentVO> selectBzentInfo();
	
	/**
	* @methodName  : selectStore
	* @author      : 서윤정
	* @date        : 2024.09.13
	* @param  	   : 
	* @return      : BzentVO
	*/
	public List<BzentVO> selectStore(Map<String, Object> map);
	
	/**
	* @methodName  : selectMenu
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 메인 페이지 _전체 메뉴 조회
	* @return : 
	*/
	public List<MenuVO> selectMenu(String menuGubun);
	
	/**
	* @methodName  : insertOrdr
	* @author      : 서윤정
	 * @param  
	* @param  : 페이징
	* @return : 
	*/
	public int getTotal(Map<String, Object> map);
	/**
	* @methodName  : selectEvent
	* @author      : 서윤정
	 * @param faqCategory 
	* @param FaqVO : 이벤트 목록 조회
	* @return : EventVO
	*/
	public List<EventVO> selectEvent();
	/**
	* @methodName  : insertDscsnPost
	* @author      : 서윤정
	 * @param frcsDscsnVO 
	* @param FaqVO : 가맹지점 상담 
	* @return : 
	*/
	public int insertDscsnPost(FrcsDscsnVO frcsDscsnVO);
	/**
	* @methodName  : checkId
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 가맹지점 상담 신청 시 아이디 중복 확인
	* @return : 
	*/
	public int checkId(String mbrId);
	/**
	* @methodName  : selectOrdrStore
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 주문 _ 가맹점 조회
	* @return : 
	*/
	public List<BzentVO> selectOrdrStore(Map<String, Object> map);
	/**
	* @methodName  : selectOrdrMenu
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 주문 _ 가맹점 메뉴 조회
	* @return : 
	*/
	public List<MenuVO> selectOrdrMenu(Map<String, Object> map);
	/**
	* @methodName  : insertEventCoupon
	* @author      : 서윤정
	 * @param eventNo
	* @param  : 이벤트 상세 조회
	* @return : 
	*/
	public EventVO insertEventCoupon(String eventNo);
	/**
	* @methodName  : insertEventCoupon
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 이벤트 쿠폰  발급
	* @return : 
	*/
	public int insertEventCouponPost(Map<String,Object> map);
	/**
	* @methodName  : chkCoupon
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 이벤트 쿠폰 중복 확인 
	* @return : 
	*/
	public int chkCoupon(Map<String, Object> map);
	/**
	* @methodName  : chkLikeStore
	* @author      : 서윤정
	* @date        : 2024.10.06
	* @param  	   : 
	* @return      : 관심 매장 중복 확인
	*/
	public int chkLikeStore(Map<String, Object> map);
	/**
	* @methodName  : deleteLikeStore
	* @author      : 서윤정
	* @date        : 2024.10.06
	* @param  	   : 
	* @return      : 관심 매장 삭제
	*/
	public int deleteLikeStore(Map<String, Object> map);
	/**
	* @methodName  : insertLikeStore
	* @author      : 서윤정
	* @date        : 2024.10.06
	* @param  	   : 
	* @return      : 관심 매장 등록
	*/
	public int insertLikeStore(Map<String, Object> map);

	/**
	* @methodName  : selectDscsn
	* @author      : 정기쁨
	* @date        : 2024.10.08
	* @param  	   : mbrId
	* @return      : 가맹점 문의 조회
	*/
	public Map<String, Object> selectFrcsDscsn(String mbrId);

	
	/**
	* @methodName  : selectEndEventAjax
	* @author      : 서윤정
	* @param       : EventVO이벤트종료 조회
	* @return : 이벤트종료 조회
	*/
	public List<EventVO> selectEndEventAjax();

	
	/**
	* @methodName  : selectMainMenu
	* @author      : 서윤정
	* @param  menuVO
	* @return : 메인 화면 - 캐러셀 -메뉴 조회
	*/
	public List<MenuVO> selectMainMenu();
	
	
	
	
	
}
