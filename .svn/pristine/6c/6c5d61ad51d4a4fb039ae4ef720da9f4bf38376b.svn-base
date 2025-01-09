package com.buff.frcs.service;

/**
* @packageName  : com.buff.frcs.service
* @fileName     : FrcsOrdrService.java
* @author       : 송예진
* @date         : 2024.09.30
* @description  : 주문에 따른 재고 소진영역
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30        송예진     	  			최초 생성
*/
public interface FrcsOrdrService {
	
	/**
	* @methodName  : updateOrdrStock
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return      : 재고 출고를 한꺼번에 수행
	*/
	public int updateOrdrStock(String frcsNo);
	
	//재고 출고 순서
//	updateStockAjmt >  insertStockAjmt > updateOrdrSpmt
	
	/**
	* @methodName  : updateStockAjmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출고를 아직 안한 메뉴에 대해 재고에서 빠져나가게함
	*/
	public int updateStockAjmt(String frcsNo);
	
	/**
	* @methodName  : insertStockAjmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출고를 아직 안한 메뉴에 대해 재고에서 빠져나간 기록 추가
	*/
	public int insertStockAjmt(String frcsNo);
	
	/**
	* @methodName  : updateOrdrSpmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출력 완료 업데이트
	*/
	public int updateOrdrSpmt(String frcsNo);
}
