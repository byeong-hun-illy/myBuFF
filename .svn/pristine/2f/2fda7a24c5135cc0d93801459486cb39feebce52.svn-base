package com.buff.cust.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.FaqVO;
import com.buff.vo.NoticeVO;
import com.buff.vo.QsVO;

public interface CustCenterService {
	/**
	* @methodName  : selectMyPage
	* @author      : 서윤정
	 *@param faqCategory, NoticeVO, QsVO
	* @return : 고객센터 페이지 조회
	*/
	public List<FaqVO> selectFaq(String faqCategory);

	public List<NoticeVO> selectNotice(Map<String, Object> map);
	
	/**
	* @methodName  : noticeTotalCnt
	* @author      : 서윤정
	* @date        : 2024.09.17
	* @param NoticeVO : 공지사항이  담긴 객체
	* @return : NoticeVO
	*/
	public int noticeTotalCnt(Map<String, Object> map);

	public NoticeVO selectNoticeDetail(int ntcSeq);

	public int insertQsPostAjax(QsVO qsVO);

	public void inqCnt(int ntcSeq);

	public QsVO selectQsDetail(Map<String, Object> map);
	
	/**
	* @methodName  : updateQsAjax
	* @author      : 서윤정
	* @param qsVO 
	* @date        : 2024.10.11
	* @return : 문의 사항 수정 
	*/
	public int updateQsAjax(QsVO qsVO);
	
	/**
	* @methodName  : updateQsAjax
	* @author      : 서윤정
	* @param qsVO 
	* @date        : 2024.10.11
	* @return : 문의 사항 삭제
	*/
	public int deleteQsAjax(String qsSeq);
	/**
	* @methodName  : updateFileAjax
	* @author      : 서윤정
	* @param qsVO 
	* @date        : 2024.10.11
	* @return : 문의 사항 파일 삭제
	*/
	public int updateFileAjax(String qsSeq);
}
