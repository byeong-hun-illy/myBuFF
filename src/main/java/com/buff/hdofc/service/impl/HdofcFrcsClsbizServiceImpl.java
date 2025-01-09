package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.hdofc.mapper.HdofcFrcsClsbizMapper;
import com.buff.hdofc.mapper.HdofcFrcsMapper;
import com.buff.hdofc.service.HdofcFrcsClsbizService;
import com.buff.vo.BzentVO;
import com.buff.vo.FrcsVO;

@Service
public class HdofcFrcsClsbizServiceImpl implements HdofcFrcsClsbizService{
	
	@Autowired
	HdofcFrcsClsbizMapper clsbizMapper;
	
	@Autowired
	HdofcFrcsMapper hdofcFrcsMapper;
	
	/**
	* @methodName  : selectFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param map   : 검색 조건 페이징
	* @return      : 폐업 예정/완료된 가맹점 조회
	*/
	public List<FrcsVO> selectFrcsClsbiz(Map<String, Object> map){
		return this.clsbizMapper.selectFrcsClsbiz(map);
	};
	
	/**
	* @methodName  : selectTotalFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param map   : 검색 조건
	* @return      : 폐업 예정/완료된 가맹점 총 갯수
	*/
	public Map<String, Object> selectTotalFrcsClsbiz(Map<String, Object> map) {
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		
		map.put("clsbizType", "CLS01");
		cnt.put("pre", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		map.put("clsbizType", "CLS02");
		cnt.put("noCln", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		map.put("clsbizType", "CLS03");
		cnt.put("cln", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		map.put("clsbizType", "CLS04");
		cnt.put("aprv", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		map.remove("clsbizType");
		cnt.put("all", this.clsbizMapper.selectTotalFrcsClsbiz(map));
		return cnt;
	};

	/**
	* @methodName  : selectFrcsClsbizDtl
	* @author      : 송예진
	* @date        : 2024.09.21
	* @param frcsNo
	* @return      : 폐업 상세
	*/
	public FrcsVO selectFrcsClsbizDtl(String frcsNo) {
		return this.clsbizMapper.selectFrcsClsbizDtl(frcsNo);
	};
	
	/**
	* @methodName  : updateOneFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.21
	* @return      : 단일 폐업
	*/
	public int updateOneFrcsClsbiz(String frcsNo) {
		return this.clsbizMapper.updateOneFrcsClsbiz(frcsNo);
	}
	
	/**
	* @methodName  : updateFrcsClsbiz
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param frcsNo
	* @return      : 통합적인 폐업관리 변경
	*/
	@Transactional
	public int updateFrcsClsbiz(String frcsNo) {
		BzentVO bzentVO = new BzentVO();
		bzentVO.setBzentNo(frcsNo);
		// 권한 삭제
		int cnt = this.hdofcFrcsMapper.deleteRoleFrcs(bzentVO);
		// 회원 구분 고객으로 변경
		cnt += this.hdofcFrcsMapper.updateMbrType(bzentVO);
		// 폐업 타입 변경
		cnt += this.clsbizMapper.updateFrcsType(frcsNo);
		// 폐업 승인처리
		cnt += this.clsbizMapper.updateOneFrcsClsbiz(frcsNo);
		return cnt;
	};
	
	
	/**
	* @methodName  : updateClclnChk
	* @author      : 송예진
	* @date        : 2024.10.07
	* @return      : cls02 > cls03으로 정산이 완료된 가맹점들 변경
	*/
	public int updateClclnChk() {
		return this.clsbizMapper.updateClclnChk();
	}
}
