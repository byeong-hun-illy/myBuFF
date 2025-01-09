package com.buff.cust.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.buff.vo.FaqVO;
import com.buff.vo.NoticeVO;
import com.buff.vo.QsVO;

@Mapper
public interface CustCenterMapper {
	
	/**
	* @methodName  : selectFaq
	* @author      : 서윤정
	 * @param faqCategory 
	* @date        : 2024.09.13
	* @param FaqVO : faq가 담긴 객체
	* @return : faqVO
	*/

	public List<FaqVO> selectFaq(String faqCategory);

	
	/**
	* @methodName  : selectNotice
	* @author      : 서윤정
	 * @param noticeCategory 
	* @date        : 2024.09.17
	* @param NoticeVO : 공지사항이  담긴 객체
	* @return : NoticeVO
	*/
	public List<NoticeVO> selectNotice(Map<String, Object> map);
	
	/**
	* @methodName  : noticeTotalCnt
	* @author      : 서윤정
	 * @param noticeCategory 
	* @date        : 2024.09.17
	* @param NoticeVO : 공지사항이  담긴 객체
	* @return : NoticeVO
	*/
	public int noticeTotalCnt(Map<String, Object> map);
	
	/**
	* @methodName  : selectNoticeDetail;
	* @author      : 서윤정
	* @date        : 2024.09.17
	* @param NoticeVO : 공지사항 상세가  담긴 객체
	* @return : NoticeVO
	*/
	
	public NoticeVO selectNoticeDetail(int ntcSeq);

	/**
	* @methodName  : insertQsPost;
	* @author      : 서윤정
	 * @param qsVO 
	* @date        : 2024.09.17
	* @return : 문의 등록
	*/
	public int insertQsPostAjax(QsVO qsVO);

	/**
	* @methodName  : inqCnt;
	* @author      : 서윤정
	 * @param ntcSeq 
	* @date        : 2024.09.17
	* @return : 공지사항 조회수 
	*/
	public int inqCnt(int ntcSeq);
	
	
	
	/**
     * @methodName  : deleteLikeStoreAjax
     * @author      : 서윤정
     * @date        : 2024.10.09
     * @param mbrId
     * @return      : 고객센터 _문의 상세 조회
     */
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
	* @date        : 2024.10.13
	* @return : 문의 사항 파일 삭제
	*/
	public int updateFileAjax(String qsSeq);
}
