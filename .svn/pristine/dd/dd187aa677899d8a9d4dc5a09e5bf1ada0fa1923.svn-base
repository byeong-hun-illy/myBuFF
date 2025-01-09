package com.buff.frcs.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.frcs.mapper.FrcsOrdrMapper;
import com.buff.frcs.service.FrcsOrdrService;

@Service
public class FrcsOrdrServiceImpl implements FrcsOrdrService {
	
	@Autowired
	FrcsOrdrMapper ordrMapper;
	
	/**
	* @methodName  : updateOrdrStock
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return      : 재고 출고를 한꺼번에 수행
	*/
	@Transactional
	public int updateOrdrStock(String frcsNo) {
		int cnt = this.updateStockAjmt(frcsNo);
		cnt+= this.insertStockAjmt(frcsNo);
		cnt+= this.updateOrdrSpmt(frcsNo);
		return cnt;
	};
	
	//재고 출고 순서
//	updateStockAjmt >  insertStockAjmt > updateOrdrSpmt
	
	/**
	* @methodName  : updateStockAjmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출고를 아직 안한 메뉴에 대해 재고에서 빠져나가게함
	*/
	public int updateStockAjmt(String frcsNo) {
		return this.ordrMapper.updateStockAjmt(frcsNo);
	};
	
	/**
	* @methodName  : insertStockAjmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출고를 아직 안한 메뉴에 대해 재고에서 빠져나간 기록 추가
	*/
	public int insertStockAjmt(String frcsNo) {
		return this.ordrMapper.insertStockAjmt(frcsNo);
	};
	
	/**
	* @methodName  : updateOrdrSpmt
	* @author      : 송예진
	* @date        : 2024.09.30
	* @param frcsNo
	* @return 출력 완료 업데이트
	*/
	public int updateOrdrSpmt(String frcsNo) {
		return this.ordrMapper.updateOrdrSpmt(frcsNo);
	};
}
