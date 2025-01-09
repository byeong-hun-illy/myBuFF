package com.buff.hdofc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.mapper.ComMapper;
import com.buff.hdofc.mapper.MngrMapper;
import com.buff.hdofc.service.HdofcMngrService;
import com.buff.util.ArticlePage;
import com.buff.vo.BzentVO;
import com.buff.vo.ComVO;
import com.buff.vo.MemberVO;
import com.buff.vo.MngrVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class HdofcMngrServiceImpl implements HdofcMngrService {
	
	@Inject
	MngrMapper mngrMapper;
	
	@Autowired
	ComMapper comMapper;

	/** 사원 목록 */
	@Override
	public Map<String, Object> selectNoticeAjax(Map<String, Object> map) {
		
		// 전체 갯수
		Map<String,Object> tapNum = this.mngrMapper.selectTapNum();
		// 담당자 조회
		List<MngrVO> selectMngrList = this.mngrMapper.selectBoxMngr();
		// 가맹점 조회
		List<BzentVO> selectFrcsList = this.mngrMapper.selectBoxFrcs();
		// 거래처 조회
		List<BzentVO> selectCntpList = this.mngrMapper.selectBoxCntp();
		
		// 페이징을 위한 데이터
		int total = this.mngrMapper.selectTotalMngrList(map); // 검색조건에 현재 게시판 갯수 √
		int currentPage = Integer.parseInt((String) map.get("currentPage"));
		int size = 10; // 페이징 사이즈
		map.put("size", size);
		List<MngrVO> mngrVOList = this.mngrMapper.selectMngrList(map);
		log.info("selectNoticeAjax => "+total, currentPage, size);
		
		Map<String, Object> response = new HashMap<>();
		response.put("tapNum", tapNum);
		response.put("selectMngrList", selectMngrList);
		response.put("selectFrcsList", selectFrcsList);
		response.put("selectCntpList", selectCntpList);
		response.put("articlePage", new ArticlePage<MngrVO>(total, currentPage, size, mngrVOList, map));
		
		return response;
	}
	
	/**
	* @methodName  : updateAuthAjax
	* @author      : 정기쁨
	* @date        : 2024.10.02
	* @param memberVOList
	* @return      : 사원 id로 권한 부여
	*/
	@Transactional
	@Override
	public int updateAuthAjax(List<MemberVO> memberVOList) {
		int result = 0;
		for(MemberVO memberVO : memberVOList) {
			String mbrId = memberVO.getMbrId();
			result += this.mngrMapper.updateAuth(mbrId);
			result += this.mngrMapper.updateMngr(mbrId);
		}
		return result;
	}
	
	/** 사원 상세  */
	// 사원정보 조회
	@Override
	public Map<String, Object> MngrDtl(String mngrId) {
		// 사원 정보 조회
		MngrVO mngrVO = this.mngrMapper.selectMngrDtl(mngrId);
		// 사원 담당 업체 조회
		List<BzentVO> bzentList = this.mngrMapper.selectMngrBzent(mngrId);
		
		Map<String, Object> mngrMap = new HashMap<String, Object>();
		mngrMap.put("mngrVO", mngrVO);
		mngrMap.put("bzentList", bzentList);
		
		return mngrMap;
	}
	// 사원 정보 변경
	@Override
	public int updateMngrInfo(MemberVO memberVO) {
		return this.mngrMapper.updateMngrInfo(memberVO);
	}
	// 사원 담당 업체 변경 (추가/삭제)
	@Override
	public int updateMngrBzent(BzentVO bzentVO) {
		return this.mngrMapper.updateMngrBzent(bzentVO);
	}

	/**
	* @methodName  : selectCom
	* @author      : 정기쁨
	* @date        : 2024.10.01
	* @param groupNo
	* @return      : 그룹번호를 통해 select할 지역 전체 가져오기
	*/
	public List<ComVO> selectCom(String groupNo) {
		return this.comMapper.selectCom(groupNo);
	}

	/**
	* @methodName  : selectBzentAjax
	* @author      : 정기쁨
	* @date        : 2024.10.01
	* @param map
	* @return      : 업체 선택 모달창의 테이블에 필요한 항목 모음
	*/
	@Override
	public Map<String, Object> selectBzentAjax(Map<String, Object> map) {
		
		// 전체업체수, 가맹점 수, 거래처 수
		Map<String, Object> bzentNum = this.mngrMapper.selectBzentNum();
		int totalNum = ((Number) bzentNum.get("TOTAL_NUM")).intValue();
		int frcsNum = ((Number) bzentNum.get("FRCS_NUM")).intValue();
		int cntpNum = ((Number) bzentNum.get("CNPT_NUM")).intValue();
		
		// 업체 리스트
		List<BzentVO> bzentVOList =  this.mngrMapper.selectBzentList(map);
		
		// 조회된 값 전달
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("totalNum",totalNum);
		response.put("frcsNum",frcsNum);
		response.put("cntpNum",cntpNum);
		response.put("bzentVOList",bzentVOList);
		
		return response;
	}

	/**
	* @methodName  : deleteMngrBzent
	* @author      : 정기쁨
	* @date        : 2024.10.01
	* @param map
	* @return      : 업체 삭제
	*/
	@Override
	public int deleteMngrBzent(Map<String,Object> map) {
		return this.mngrMapper.deleteMngrBzent(map);
	}

	
}


















