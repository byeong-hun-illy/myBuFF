package com.buff.cust.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.BzentVO;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MenuVO;

@Mapper
public interface CustHomeMapper {

	/**
	* @methodName  : selectEvent
	* @author      : 서윤정
	 * @param  
	* @param  이벤트 조회 목록
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
	* @methodName  : selectMenu
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 메인 페이지 _전체 메뉴 조회
	* @return : 
	*/
	public List<MenuVO> selectMenu(String menuGubun);
	
	/**
	* @methodName  : selectOrdrMenu
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 주문 _ 가맹점 메뉴 조회
	* @return : 
	*/
	public List<MenuVO> selectOrdrMenu(Map<String, Object> map);
	
	/**
	* @methodName  : chkCoupon
	* @author      : 서윤정
	 * @param mbrId 
	* @param  : 이벤트 쿠폰 중복 확인 
	* @return : 
	*/
	public int chkCoupon(Map<String, Object> map);

	/**
	* @methodName  : chkCoupon
	* @author      : 정기쁨
	 * @param mbrId 
	* @param  : 가맹점 문의 여부 조회
	* @return : 
	*/
	public Map<String, Object> selectFrcsDscsn(String mbrId);

	
	/**
	* @methodName  : selectEvent
	* @author      : 서윤정
	 * @param faqCategory 
	* @param FaqVO : 이벤트 종료 조회
	* @return : EventVO
	*/
	public List<EventVO> selectEndEventAjax();


	/**
	* @methodName  : home
	* @author      : 서윤정
	* @date        : 2024.09.13
	* @param BzentVO : 고객메인화면 _ 가맹점 카드에 담길 VO객체
	* @return 	   : 해당 가맹점 정보
	*/
	public List<BzentVO> selectBzentInfo();

	/**
	* @methodName  : selectMainMenu
	* @author      : 서윤정
	* @param  menuVO
	* @return : 메인 메뉴 메뉴 조회
	*/
	public List<MenuVO> selectMainMenu();

	
	/**
	* @methodName  : selectStore
	* @author      : 서윤정
	* @param  menuVO
	* @return : 매장 조회
	*/
	public List<BzentVO> selectStore(Map<String, Object> map);

	
	
}
