package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsMainMapper;
import com.buff.frcs.service.FrcsMainService;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsCheckVO;
import com.buff.vo.MenuVO;
import com.buff.vo.NoticeVO;

@Service
public class FrcsMainServiceImpl implements FrcsMainService {
	
	@Inject
	FrcsMainMapper frcsMainMapper;
	
	/**
	* @methodName  : selectMenuQtyDesc
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param 	   : 
	* @return      : 이번달 판매량 best메뉴 top3 출력
	*/
	@Override
	public List<MenuVO> selectMenuQtyDesc(String bzentNo) {
		return this.frcsMainMapper.selectMenuQtyDesc(bzentNo);
	}
	
	/**
	* @methodName  : selectMenuQtyAsc
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param 	   : 
	* @return      : 이번달 판매량 worst메뉴 top3 출력
	*/
	@Override
	public List<MenuVO> selectMenuQtyAsc(String bzentNo) {
		return this.frcsMainMapper.selectMenuQtyAsc(bzentNo);
	}
	
	/**
	* @methodName  : selectDailysales
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 매출 금액
	*/
	@Override
	public long selectDailysales(String bzentNo) {
		return this.frcsMainMapper.selectDailysales(bzentNo);
	}
	
	/**
	* @methodName  : selectDailysalesCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 당일 판매 횟수
	*/
	@Override
	public long selectDailysalesCnt(String bzentNo) {
		return this.frcsMainMapper.selectDailysalesCnt(bzentNo);
	}
	
	/**
	* @methodName  : selectIngEvent
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @return	   : 현재 진행중인 이벤트 리스트
	*/
	@Override
	public List<EventVO> selectIngEvent() {
		return this.frcsMainMapper.selectIngEvent();
	}
	
	/**
	* @methodName  : selectIngNotice
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @return	   : 문의사항 리스트
	*/
	@Override
	public List<NoticeVO> selectIngNotice() {
		return this.frcsMainMapper.selectIngNotice();
	}
	
	/**
	* @methodName  : selectStoreGrade
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 최근 매장점검 점수
	*/
	@Override
	public int selectStoreGrade(String bzentNo) {
		return this.frcsMainMapper.selectStoreGrade(bzentNo);
	}
	
	/**
	* @methodName  : selectStoreWarningCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.11
	* @param bzentNo
	* @return	   : 매장점검 경고 횟수
	*/
	@Override
	public int selectStoreWarningCnt(String bzentNo) {
		return this.frcsMainMapper.selectStoreWarningCnt(bzentNo);
	}
	
	/**
	* @methodName  : selectOrderStatusCnt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.12
	* @param mbrId
	* @return	   : 발주관리 유형별 갯수
	*/
	@Override
	public Map<String, Object> selectOrderStatusCnt(String mbrId) {
		return this.frcsMainMapper.selectOrderStatusCnt(mbrId);
	}
	
	/**
	* @methodName  : selectStoreCheckList
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.12
	* @param bzentNo
	* @return	   : 매장 점검 내역
	*/
	@Override
	public List<FrcsCheckVO> selectStoreCheckList(String bzentNo) {
		return this.frcsMainMapper.selectStoreCheckList(bzentNo);
	}
	
	/**
	* @methodName  : selectDayAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 일간 매출 금액
	*/
	@Override
	public long selectDayAmt(String bzentNo) {
		return this.frcsMainMapper.selectDayAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectMonthAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 월간 매출 금액
	*/
	@Override
	public long selectMonthAmt(String bzentNo) {
		return this.frcsMainMapper.selectMonthAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectYearAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.14
	* @param map
	* @return	   : 연간 매출 금액
	*/
	@Override
	public long selectYearAmt(String bzentNo) {
		return this.frcsMainMapper.selectYearAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectHourOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 당일 시간당 매출 금액
	*/
	@Override
	public List<MenuVO> selectHourOrderAmt(String bzentNo) {
		return this.frcsMainMapper.selectHourOrderAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectDayOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 이번달 일간 매출 금액
	*/
	@Override
	public List<MenuVO> selectDayOrderAmt(String bzentNo) {
		return this.frcsMainMapper.selectDayOrderAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectMonthOrderAmt
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param map
	* @return	   : 이년년도 월간 매출 금액
	*/
	@Override
	public List<MenuVO> selectMonthOrderAmt(String bzentNo) {
		return this.frcsMainMapper.selectMonthOrderAmt(bzentNo);
	}
	
	/**
	* @methodName  : selectSfStockDown
	* @author      : 김현빈, 정현종
	* @date        : 2024.10.15
	* @param mbrId
	* @return	   : 안전재고 미만인 재고의 수
	*/
	@Override
	public int selectSfStockDown(String mbrId) {
		return this.frcsMainMapper.selectSfStockDown(mbrId);
	}
	
	/**
	* @methodName  : selectFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 가맹점 정산 필요 건수
	*/
	public int selectFrcsClcln(String mbrId) {
		return this.frcsMainMapper.selectFrcsClcln(mbrId);
	};
	
	/**
	* @methodName  : selectPoClcln
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 발주 정산필요건수
	*/
	public int selectPoClcln(String mbrId) {
		return this.frcsMainMapper.selectPoClcln(mbrId);
	};
	
	/**
	* @methodName  : selectFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.10.15
	* @param mbrId
	* @return      : 폐업일
	*/
	public String selectFrcsClsbiz(String mbrId) {
		return this.frcsMainMapper.selectFrcsClsbiz(mbrId);
	};
}
