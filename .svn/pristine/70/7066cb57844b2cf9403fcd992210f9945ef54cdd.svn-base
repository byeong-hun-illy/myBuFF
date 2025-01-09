package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.EventVO;
import com.buff.vo.FrcsCheckVO;
import com.buff.vo.MenuVO;
import com.buff.vo.NoticeVO;

public interface FrcsMainService {
	
	/**
	* @methodName  : selectMenuQtyDesc
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param 	   : 
	* @return      : 이번달 판매량 best메뉴 top3 출력
	*/
	public List<MenuVO> selectMenuQtyDesc(String bzentNo);
	
	/**
	* @methodName  : selectMenuQtyAsc
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param 	   : 
	* @return      : 이번달 판매량 worst메뉴 top3 출력
	*/
	public List<MenuVO> selectMenuQtyAsc(String bzentNo);
	
	/**
	* @methodName  : selectDailysales
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 매출 금액
	*/
	public long selectDailysales(String bzentNo);
	
	/**
	* @methodName  : selectDailysalesCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 판매 횟수
	*/
	public long selectDailysalesCnt(String bzentNo);
	
	/**
	* @methodName  : selectIngEvent
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @return	   : 현재 진행중인 이벤트 리스트
	*/
	public List<EventVO> selectIngEvent();
	
	/**
	* @methodName  : selectIngNotice
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @return	   : 문의사항 리스트
	*/
	public List<NoticeVO> selectIngNotice();

	/**
	* @methodName  : selectStoreGrade
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 최근 매장점검 점수
	*/
	public int selectStoreGrade(String bzentNo);
	
	/**
	* @methodName  : selectStoreWarningCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 매장점검 경고 횟수
	*/
	public int selectStoreWarningCnt(String bzentNo);
	
	/**
	* @methodName  : selectOrderStatusCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.12
	* @param mbrId
	* @return	   : 발주관리 유형별 갯수
	*/
	public Map<String, Object> selectOrderStatusCnt(String mbrId);
	
	/**
	* @methodName  : selectStoreCheckList
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.12
	* @param bzentNo
	* @return	   : 매장 점검 내역
	*/
	public List<FrcsCheckVO> selectStoreCheckList(String bzentNo);
	
	/**
	* @methodName  : selectDayAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 일간 매출 금액
	*/
	public long selectDayAmt(String bzentNo);
	
	/**
	* @methodName  : selectMonthAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 월간 매출 금액
	*/
	public long selectMonthAmt(String bzentNo);
	
	/**
	* @methodName  : selectYearAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 연간 매출 금액
	*/
	public long selectYearAmt(String bzentNo);
	
	/**
	* @methodName  : selectHourOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 당일 시간당 매출 금액
	*/
	public List<MenuVO> selectHourOrderAmt(String bzentNo);
	
	/**
	* @methodName  : selectDayOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 이번달 일간 매출 금액
	*/
	public List<MenuVO> selectDayOrderAmt(String bzentNo);
	
	/**
	* @methodName  : selectMonthOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 이년년도 월간 매출 금액
	*/
	public List<MenuVO> selectMonthOrderAmt(String bzentNo);

	/**
	* @methodName  : selectSfStockDown
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param mbrId
	* @return	   : 안전재고 미만인 재고의 수
	*/
	public int selectSfStockDown(String mbrId);
	
	/**
	* @methodName  : selectFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 가맹점 정산 필요 건수
	*/
	public int selectFrcsClcln(String mbrId);
	
	/**
	* @methodName  : selectPoClcln
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 발주 정산필요건수
	*/
	public int selectPoClcln(String mbrId);
	
	/**
	* @methodName  : selectFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 폐업일
	*/
	public String selectFrcsClsbiz(String mbrId);
}
