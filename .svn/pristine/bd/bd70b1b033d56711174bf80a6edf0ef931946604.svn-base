package com.buff.frcs.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.FrcsSlsVO;

/**
* @packageName  : com.buff.frcs.service
* @fileName     : FrcsNetProfitService.java
* @author       : 정현종
* @date         : 2024.10.09
* @description  : 가맹점 순수익 Service
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.09        정현종     	  			최초 생성
*/
public interface FrcsNetProfitService {

	/**
	* @methodName  : selectFrcsNetProfitList
	* @author      : 정현종
	* @date        : 2024.10.09
	* @param       : map
	* @return	   : 순수익 조회화면 리스트 출력
	*/
	public List<FrcsSlsVO> selectFrcsNetProfitList(Map<String, Object> map);
	
	/**
	* @methodName  : selectTotalFrcsNetProfit
	* @author      : 정현종
	* @date        : 2024.10.10
	* @param       : map
	* @return      : 페이징을 위한 전체 행의 수
	*/
	public int selectTotalFrcsNetProfit(Map<String, Object> map);

	public int updateNetProfitAjax(FrcsSlsVO frcsSlsVO);

	/**
	* @methodName  : selectInsertChk
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param bzentNo
	* @return      : clclnlYm에 없는 insert값 찾기
	*/
	public int selectInsertChk(String mbrId);
	
	/**
	* @methodName  : insertSls
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param bzentNo
	* @return      : 없는 순수익값 추가
	*/
	public int insertSls(String bzentNo);
	
	
	/**
	* @methodName  : selectSlsDtl
	* @author      : 송예진
	* @date        : 2024.10.14
	* @param frcsSlsVO
	* @return      : 순수익 상세
	*/
	public FrcsSlsVO selectSlsDtl(FrcsSlsVO frcsSlsVO);

}
