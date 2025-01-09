package com.buff.vo;

import java.util.List;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : FavFrcsVO.java
* @author       : 서윤정
* @date         : 2024.10.07
* @description  : 관심 매장을 조회하기 위한 VO
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.07        이름     	  			최초 생성
*/
@Data
public class FavFrcsVO {
	
	private String frcsNo;
	private String menuNo;
	private String mbrId;
	
	//FAV_FRCS : BZENT = 1 : 1
	private BzentVO bzentVO;
	
	//FAV_FRCS : FrcsVO = 1 : n
	private List<FrcsVO> frcsVOList;
}
