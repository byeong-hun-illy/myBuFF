package com.buff.hdofc.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.HdofcQsMapper;
import com.buff.hdofc.service.HdofcQsService;
import com.buff.vo.QsVO;

/**
* @packageName  : com.buff.service.hdofc.impl
* @fileName     : HdofcQsServiceImpl.java
* @author       : 김현빈
* @date         : 2024.10.01
* @description  : 문의사항 관리 ServiceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        김현빈     	  			최초 생성
*/
@Service
public class HdofcQsServiceImpl implements HdofcQsService {
	
	@Inject
	HdofcQsMapper hdofcQsMapper;
	
	/**
	* @methodName  : selectQsList
	* @author      : 김현빈
	* @date        : 2024.10.01
	* @param 	   : map
	* @return      : 문의사항의 모든 리스트 출력
	*/
	@Override
	public List<QsVO> selectQsList(Map<String, Object> map) {
		return this.hdofcQsMapper.selectQsList(map);
	}
	
	/**
	* @methodName  : qsTotalCnt
	* @author      : 김현빈
	* @date        : 2024.10.01
	* @param 	   : map
	* @return      : 문의사항의 모든 갯수
	*/
	@Override
	public int qsTotalCnt(Map<String, Object> map) {
		return this.hdofcQsMapper.qsTotalCnt(map);
	}
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : 문의사항 리스트 문의 유형의 각각 갯수
	*/
	@Override
	public Map<String, Object> tapMaxTotal() {
		return this.hdofcQsMapper.tapMaxTotal();
	}
	
	/**
	* @methodName  : selectQsDetail
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsSeq
	* @return      : 문의사항 상세 출력
	*/
	@Override
	public QsVO selectQsDetail(String qsSeq) {
		return this.hdofcQsMapper.selectQsDetail(qsSeq);
	}
	
	/**
	* @methodName  : updateQsDetailAns
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsVO
	* @return      : 문의사항 댓글 등록 및 수정
	*/
	@Override
	public int updateQsDetailAns(QsVO qsVO) {
		return this.hdofcQsMapper.updateQsDetailAns(qsVO);
	}
	
	/**
	* @methodName  : deleteQs
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsSeq
	* @return      : 문의사항 삭제
	*/
	@Override
	public int deleteQs(String qsSeq) {
		return this.hdofcQsMapper.deleteQs(qsSeq);
	}
	
}
