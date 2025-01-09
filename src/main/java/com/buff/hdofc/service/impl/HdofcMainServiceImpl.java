package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.HdofcMainMapper;
import com.buff.hdofc.service.HdofcMainService;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.QsVO;
import com.buff.vo.hdofc.HdofcAmtVO;
import com.buff.vo.hdofc.HdofcCntVO;

@Service
public class HdofcMainServiceImpl implements HdofcMainService{
	
	
	@Autowired
	HdofcMainMapper mainMapper;
	/**
	* @methodName  : selectCnt
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : BUFF 현황, 물류관리, 최근 1년간 구매 발주, 갯수 등
	*/
	public HdofcCntVO selectCnt() {
		return this.mainMapper.selectCnt();
	};
	
	/**
	* @methodName  : selectDscsnEvent
	* @author      : 송예진
	* @date        : 2024.10.10
	* @param map
	* @return      : 상담 캘린더 이벤트
	*/
	public List<FrcsDscsnVO> selectDscsnEvent(Map<String, Object> map){
		return this.mainMapper.selectDscsnEvent(map);
	};
	
	/**
	* @methodName  : selectRgnAmt
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 지역별 매출
	*/
	public Map<String, Object> selectAmt(String date){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rgn", this.mainMapper.selectRgnAmt(date));
		map.put("ordr", this.mainMapper.selectOrdrAmt(date));
		return map;
	}


	/**
	* @methodName  : selectChkGrade
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 가맹점 점검 분포
	*/
	public List<HdofcAmtVO> selectChkGrade(){
		return this.mainMapper.selectChkGrade();
	};
	
	
	/**
	* @methodName  : selectDscsn
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 상담 예정인 사람들
	*/
	public List<FrcsDscsnVO> selectDscsn(){
		return this.mainMapper.selectDscsn();
	};
	
	/**
	* @methodName  : selectQs
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 답변필요 문의사항
	*/
	public List<QsVO> selectQs(){
		return this.mainMapper.selectQs();
	};
	
	/**
	* @methodName  : selectEvent
	* @author      : 송예진
	* @date        : 2024.10.10
	* @return      : 진행중인 이벤트
	*/
	public List<EventVO> selectEvent(){
		return this.mainMapper.selectEvent();
	};
}