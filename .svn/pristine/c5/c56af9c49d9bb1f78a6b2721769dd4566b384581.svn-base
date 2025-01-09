package com.buff.frcs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.frcs.mapper.FrcsNetProfitMapper;
import com.buff.frcs.service.FrcsNetProfitService;
import com.buff.vo.FrcsSlsVO;

/**
* @packageName  : com.buff.frcs.service.impl
* @fileName     : FrcsNetProfitServiceImpl.java
* @author       : 정현종
* @date         : 2024.10.09
* @description  : 가맹점 순수익 ServiceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.09        정현종     	  			최초 생성
*/
@Service
public class FrcsNetProfitServiceImpl implements FrcsNetProfitService {

	@Autowired
	FrcsNetProfitMapper frcsNetProfitMapper;
	
	/**
	* @methodName  : selectFrcsNetProfitList
	* @author      : 정현종
	* @date        : 2024.10.09
	* @param       : map
	* @return	   : 순수익 조회화면 리스트 출력
	*/
	@Override
	public List<FrcsSlsVO> selectFrcsNetProfitList(Map<String, Object> map) {
		return this.frcsNetProfitMapper.selectFrcsNetProfitList(map);
	}
	
	/**
	* @methodName  : selectTotalFrcsNetProfit
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param       : map
	* @return      : 페이징을 위한 전체 행의 수
	*/
	@Override
	public int selectTotalFrcsNetProfit(Map<String, Object> map) {
		return this.frcsNetProfitMapper.selectTotalFrcsNetProfit(map);
	}

	@Override
	public int updateNetProfitAjax(FrcsSlsVO frcsSlsVO) {
		return this.frcsNetProfitMapper.updateNetProfitAjax(frcsSlsVO);
	}
	
	
	/**
	* @methodName  : selectInsertChk
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param bzentNo
	* @return      : clclnlYm에 없는 insert값 찾기
	*/
	public int selectInsertChk(String mbrId) {
		return this.frcsNetProfitMapper.selectInsertChk(mbrId);
	};
	
	/**
	* @methodName  : insertSls
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param bzentNo
	* @return      : 없는 순수익값 추가
	*/
	public int insertSls(String bzentNo) {
		return this.frcsNetProfitMapper.insertSls(bzentNo);
	};
	
	
	/**
	* @methodName  : selectSlsDtl
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param frcsSlsVO
	* @return      : 순수익 상세
	*/
	public FrcsSlsVO selectSlsDtl(FrcsSlsVO frcsSlsVO) {
		return this.frcsNetProfitMapper.selectSlsDtl(frcsSlsVO);
	};


}
