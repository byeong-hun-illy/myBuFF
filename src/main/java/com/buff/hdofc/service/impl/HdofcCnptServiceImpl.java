package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.ComMapper;
import com.buff.hdofc.mapper.HdofcCnptMapper;
import com.buff.hdofc.service.HdofcCnptService;
import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.hdofc.service.impl
* @fileName     : HodfcCnptServiceImpl.java
* @author       : 송예진
* @date         : 2024.09.24
* @description  : 거래처 impl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.24        송예진     	  			최초 생성
*/
@Service
@Slf4j
public class HdofcCnptServiceImpl implements HdofcCnptService{
	
	@Autowired 
	HdofcCnptMapper cnptMapper;
	
	@Autowired
	ComMapper comMapper;
	
	/**
	* @methodName  : selectCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @return      : 거래처 리스트
	*/
	public List<BzentVO> selectCnpt(Map<String, Object> map){
		return this.cnptMapper.selectCnpt(map);
	};
	
	/**
	* @methodName  : selectTotalCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @return      : 거래처 갯수
	*/
	public Map<String, Object> selectTotalCnpt(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.cnptMapper.selectTotalCnpt(map));
		
		map.put("bzentType", "BZ_C01");
		cnt.put("c01", this.cnptMapper.selectTotalCnpt(map));
		map.put("bzentType", "BZ_C02");
		cnt.put("c02", this.cnptMapper.selectTotalCnpt(map));
		map.put("bzentType", "BZ_C03");
		cnt.put("c03", this.cnptMapper.selectTotalCnpt(map));
		map.remove("bzentType");
		cnt.put("all", this.cnptMapper.selectTotalCnpt(map));
		return cnt;
	};
	
	/**
	* @methodName  : selectCnptMbr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param map
	* @return      : 아직 거래처를 담당하지 않은 허락되지않은 회원 조회
	*/
	public List<MemberVO> selectCnptMbr(Map<String, Object> map){
		return this.cnptMapper.selectCnptMbr(map);
	};
	
	/**
	* @methodName  : selectTotalCnptMbr
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param map
	* @return      : 아직 거래처를 담당하지 않은 허락되지않은 회원 조회 갯수
	*/
	public int selectTotalCnptMbr(Map<String, Object> map) {
		return this.cnptMapper.selectTotalCnptMbr(map);
	};
	
	
	/**
	* @methodName  : insertCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 추가
	*/
	@Transactional
	public int insertCnpt(BzentVO bzentVO) {
		String addr = bzentVO.getBzentAddr();
		String rgnNo = this.comMapper.rgnNoSearch(addr);
		bzentVO.setRgnNo(rgnNo);
		if(bzentVO.getMbrId()!=null && !bzentVO.getMbrId().trim().isEmpty()) {
			this.insertRoleCnpt(bzentVO);
		}
		return this.cnptMapper.insertCnpt(bzentVO);
	};
	
	/**
	* @methodName  : insertRoleCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 권한 추가
	*/
	public int insertRoleCnpt(BzentVO bzentVO) {
		return this.cnptMapper.insertRoleCnpt(bzentVO);
	};
	
	///////////////////////////////// 수정
	
	/**
	* @methodName  : deleteRoleCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 권한 삭제
	*/
	public int deleteRoleCnpt(BzentVO bzentVO) {
		return this.cnptMapper.deleteRoleCnpt(bzentVO);
	};
	
	/**
	* @methodName  : updateBzent
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentVO
	* @return      : 거래처 수정
	*/
	@Transactional
	public int updateBzent(BzentVO bzentVO) {
		String addr = bzentVO.getBzentAddr();
		String rgnNo = this.comMapper.rgnNoSearch(addr);
		bzentVO.setRgnNo(rgnNo);
		if(bzentVO.getMbrId()!=null && !bzentVO.getMbrId().trim().isEmpty()) {
			this.deleteRoleCnpt(bzentVO);
			this.insertRoleCnpt(bzentVO);
		}
		return this.cnptMapper.updateBzent(bzentVO);
	};
	
	
	/**
	* @methodName  : selectCnptDtl
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 거래처 상세
	*/
	public BzentVO selectCnptDtl(String bzentNo) {
		return this.cnptMapper.selectCnptDtl(bzentNo);
	};
	
	
	/**
	* @methodName  : deleteCnpt
	* @author      : 송예진
	* @date        : 2024.09.24
	* @param bzentNo
	* @return      : 재고 정보가없는 거래처 삭제
	*/
	@Transactional
	public int deleteCnpt(String bzentNo) {
		BzentVO bzentVO = new BzentVO();
		bzentVO.setBzentNo(bzentNo);
		this.deleteRoleCnpt(bzentVO);
		return this.cnptMapper.deleteCnpt(bzentNo);
	};
}
