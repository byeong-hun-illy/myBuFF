package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.QsVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcQsMapper.java
* @author       : 김현빈
* @date         : 2024.10.01
* @description  : 문의사항 관리
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01               김현빈     	  			최초 생성
*/
public interface HdofcQsMapper {
	
	/**
	* @methodName  : selectQsList
	* @author      : 김현빈
	* @date        : 2024.10.01
	* @param 	   : map
	* @return      : 문의사항의 모든 리스트 출력
	*/
	public List<QsVO> selectQsList(Map<String, Object> map);
	
	/**
	* @methodName  : qsTotalCnt
	* @author      : 김현빈
	* @date        : 2024.10.01
	* @param 	   : map
	* @return      : 문의사항의 모든 갯수
	*/
	public int qsTotalCnt(Map<String, Object> map);
	
	/**
	* @methodName  : tapMaxTotal
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : 문의사항 리스트 문의 유형의 각각 갯수
	*/
	public Map<String, Object> tapMaxTotal();
	
	/**
	* @methodName  : selectQsDetail
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsSeq
	* @return      : 문의사항 상세 출력
	*/
	public QsVO selectQsDetail(String qsSeq);
	
	/**
	* @methodName  : updateQsDetailAns
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsVO
	* @return      : 문의사항 댓글 등록 및 수정
	*/
	public int updateQsDetailAns(QsVO qsVO);
	
	/**
	* @methodName  : deleteQs
	* @author      : 김현빈
	* @date        : 2024.10.02
	* @param 	   : qsSeq
	* @return      : 문의사항 삭제
	*/
	public int deleteQs(String qsSeq);
	
}
