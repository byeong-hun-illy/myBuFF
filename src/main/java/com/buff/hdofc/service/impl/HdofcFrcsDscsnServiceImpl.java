package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.hdofc.mapper.HdofcFrcsDscsnMapper;
import com.buff.hdofc.mapper.HdofcFrcsMapper;
import com.buff.hdofc.service.HdofcFrcsDscsnService;
import com.buff.vo.FrcsDscsnVO;

/**
* @packageName  : com.buff.hdofc.service.impl
* @fileName     : HdofcFrcsDscsnServiceImpl.java
* @author       : 송예진
* @date         : 2024.09.23
* @description  : 가맹점 상담
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.23        송예진     	  			최초 생성
*/
@Service
public class HdofcFrcsDscsnServiceImpl implements HdofcFrcsDscsnService{
	
	@Autowired
	HdofcFrcsDscsnMapper dscsnMapper;
	
	/**
	* @methodName  : selectFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param map   : 검색조건
	* @return      : 상담 내역 조회
	*/
	public List<FrcsDscsnVO> selectFrcsDscsn(Map<String, Object> map){
		return this.dscsnMapper.selectFrcsDscsn(map);
	};
	
	/**
	* @methodName  : selectTotalFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param map   : 검색조건
	* @return      : 상담내역 갯수
	*/
	public Map<String, Object> selectTotalFrcsDscsn(Map<String, Object> map){
		Map<String, Object> cnt = new HashMap<String, Object>();
		cnt.put("total", this.dscsnMapper.selectTotalFrcsDscsn(map));
		
		map.put("dscsnType","DSC01");
		cnt.put("dsc01", this.dscsnMapper.selectTotalFrcsDscsn(map));
		map.put("dscsnType","DSC02");
		cnt.put("dsc02", this.dscsnMapper.selectTotalFrcsDscsn(map));
		map.put("dscsnType","DSC03");
		cnt.put("dsc03", this.dscsnMapper.selectTotalFrcsDscsn(map));
		map.put("dscsnType","DSC04");
		cnt.put("dsc04", this.dscsnMapper.selectTotalFrcsDscsn(map));
		map.remove("dscsnType");
		cnt.put("all", this.dscsnMapper.selectTotalFrcsDscsn(map));
		return cnt;
	};
	
	/**
	* @methodName  : selectFrcsDscsnDtl
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param dscsnCode
	* @return      : 상담 상세
	*/
	public FrcsDscsnVO selectFrcsDscsnDtl(String dscsnCode) {
		return this.dscsnMapper.selectFrcsDscsnDtl(dscsnCode);
	};
	
	/**
	* @methodName  : updateFrcsDscsn
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO(dscsnCode, mngrId, dscsnType, rgnNo, dscsnPlanYmd) 선택 사항  dscsnCn
	* @return
	*/
	@Transactional
	public int updateFrcsDscsn(FrcsDscsnVO frcsDscsnVO) {
		if(frcsDscsnVO.getDscsnType().equals("DSC04")) {
			this.updateMbrType02(frcsDscsnVO);
		} else {
			this.dscsnMapper.updateMbrType01(frcsDscsnVO);
		}
		return this.dscsnMapper.updateFrcsDscsn(frcsDscsnVO);
	};
	
	/**
	* @methodName  : updateMbrType02
	* @author      : 송예진
	* @date        : 2024.09.23
	* @param frcsDscsnVO
	* @return : 회원구분 변경 DSC04로 바뀔때 함께 변경
	*/
	public int updateMbrType02(FrcsDscsnVO frcsDscsnVO) {
		return this.dscsnMapper.updateMbrType02(frcsDscsnVO);
	};
}
