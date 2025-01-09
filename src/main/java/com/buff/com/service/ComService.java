package com.buff.com.service;

import java.util.List;

import com.buff.vo.ComVO;
import com.buff.vo.FrcsVO;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.NavVO;

public interface ComService {

	/**
	* @methodName  : rgnNoSearch
	* @author      : 송예진
	* @date        : 2024.09.16
	* @param addr
	* @return      : 주소를 받아 지역번호로 반환
	*/
	public String rgnNoSearch(String addr);
	
	/**
	 * @methodName  : selectCom
	 * @author      : 송예진
	 * @date        : 2024.09.20
	 * @param groupNo
	 * @return     : 그룹번호를 통해 select할 값 전체 가져오기
	 */
	public List<ComVO> selectCom(String groupNo);
	
	/**
	* @methodName  : insertGds
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsVO(gdsNm, gdsType, unitNm, mbrId)
	* @return      : 상품 추가
	*/
	public int insertGds(GdsVO gdsVO);
	
	/**
	* @methodName  : insertGdsAmt
	* @author      : 송예진
	* @date        : 2024.09.25
	* @param       : gdsAmtVO(bzentNo, gdsCode, amt)
	* @return      : 상품단가 추가
	*/
	public int insertGdsAmt(GdsAmtVO gdsAmtVO);
	
	
	/**
	* @methodName  : deleteGdsAmt
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param gdsAmtVO
	* @return      : 최근 단가 삭제
	*/
	public int deleteGdsAmt(GdsAmtVO gdsAmtVO);
	
	
	/**
	* @methodName  : selectMinAmt
	* @author      : 송예진
	* @date        : 2024.10.04
	* @param gdsCode : 상품에 대한 최저가 
	* @return      : amt, ajmtDt
	*/
	public List<GdsAmtVO> selectMinAmt(String gdsCode);
	
	
	/**
	* @methodName  : selectFrcsInfo
	* @author      : 송예진
	* @date        : 2024.10.07
	* @param bzentNo : 로그인한 정보를 통해 받는 정보
	* @return     : 가맹점에 대한 폐업 정보
	*/
	public String selectFrcsInfo(String mbrId);
	
	/**
	* @methodName  : selectNav
	* @author      : 송예진
	* @date        : 2024.10.11
	* @param navVO
	* @return      : 메뉴 검색
	*/
	public List<NavVO> selectNav(String navType);
}
