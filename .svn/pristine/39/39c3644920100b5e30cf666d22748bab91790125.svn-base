package com.buff.com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.FrcsClclnMapper;
import com.buff.com.service.FrcsClclnService;
import com.buff.vo.FrcsClclnMaxVO;
import com.buff.vo.FrcsClclnVO;
import com.buff.vo.FrcsVO;

@Service
public class FrcsClclnServiceImpl implements FrcsClclnService{
	
	@Autowired
	FrcsClclnMapper clclnMapper;
	
	/**
	* @methodName  : selectFrceClclnMonth
	* @author      : 송예진
	* @date        : 2024.10.05
	* @return      : 이번달 정산 예정 금액/ 완료 금액
	*/
	public FrcsClclnMaxVO selectFrceClclnMonth() {
		return this.clclnMapper.selectFrceClclnMonth();
	};
	
	/**
	* @methodName  : selectFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param map
	* @return
	*/
	public List<FrcsClclnVO> selectFrcsClcln(Map<String, Object> map){
		return this.clclnMapper.selectFrcsClcln(map);
	};
	
	/**
	* @methodName  : selectTotalFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param map
	* @return
	*/
	public Map<String, Object> selectTotalFrcsClcln(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.clclnMapper.selectTotalFrcsClcln(map));
		
		// 분류
		map.put("clclnYn", "Y");
		cnt.put("y", this.clclnMapper.selectTotalFrcsClcln(map));
		map.put("clclnYn", "N");
		cnt.put("n", this.clclnMapper.selectTotalFrcsClcln(map));
		map.remove("clclnYn");
		cnt.put("all", this.clclnMapper.selectTotalFrcsClcln(map));
		
		return cnt;
	};
	
	/**
	* @methodName  : insertFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.05
	* @param clclnYm (년, 월)
	* @return      :  년 월을 입력받아 해당 월에 판매되었던 매출의 내역따라 정산 내역 출력
	*/
	@Transactional
	public int insertFrcsClcln(String clclnYm) {
		int cnt = this.updateClsbizType(); /// 폐업예정을 폐업미납으로 변경
		cnt += this.clclnMapper.insertFrcsClcln(clclnYm);
		return cnt;
	};
	
	
	/**
	* @methodName  : selectFrcsClclnDtl
	* @author      : 송예진
	* @date        : 2024.10.06
	* @param frcsClclnVO (frcsNo, clclnYm)
	* @return      : 상세 조회
	*/
	public FrcsClclnVO selectFrcsClclnDtl(FrcsClclnVO frcsClclnVO) {
	    return this.clclnMapper.selectFrcsClclnDtl(frcsClclnVO);
	}
	
	/**
	* @methodName  : updateFrcsClcln
	* @author      : 송예진
	* @date        : 2024.10.06
	* @param frcsClclnVO (npmntAmt, frcsNo, clclnYm)
	* @return      : 가맹점이 정산 처리
	*/
	public int updateFrcsClcln(FrcsClclnVO frcsClclnVO) {
		return this.clclnMapper.updateFrcsClcln(frcsClclnVO);
	};
	
	
	/**
	* @methodName  : updateClsbizType
	* @author      : 송예진
	* @date        : 2024.10.07
	* @return      : 본사가 등록시 cls01 > cls02로 변경
	*/
	public int updateClsbizType() {
		return this.clclnMapper.updateClsbizType();
	};
}
