package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.QsVO;
import com.buff.vo.hdofc.HdofcAmtVO;
import com.buff.vo.hdofc.HdofcCntVO;

@Mapper
public interface HdofcMainMapper {
	
	/**
	* @methodName  : selectCnt
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : BUFF 현황, 물류관리, 최근 1년간 구매 발주, 갯수 등
	*/
	public HdofcCntVO selectCnt();
	
	/**
	* @methodName  : selectDscsnEvent
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param map
	* @return      : 상담 캘린더 이벤트
	*/
	public List<FrcsDscsnVO> selectDscsnEvent(Map<String, Object> map);
	
	/**
	* @methodName  : selectRgnAmt
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 지역별 매출
	*/
	public List<HdofcAmtVO> selectRgnAmt(String date);
	
	/**
	* @methodName  : selectOrdrAmt
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param date
	* @return      : 주문 매출
	*/
	public List<HdofcAmtVO> selectOrdrAmt(String date);

	/**
	* @methodName  : selectChkGrade
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 가맹점 점검 분포
	*/
	public List<HdofcAmtVO> selectChkGrade();
	
	/**
	* @methodName  : selectDscsn
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 상담 예정인 사람들
	*/
	public List<FrcsDscsnVO> selectDscsn();
	
	/**
	* @methodName  : selectQs
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 답변필요 문의사항
	*/
	public List<QsVO> selectQs();
	
	/**
	* @methodName  : selectEvent
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 진행중인 이벤트
	*/
	public List<EventVO> selectEvent();
}
