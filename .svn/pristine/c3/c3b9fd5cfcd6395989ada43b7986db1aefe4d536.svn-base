package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.CouponGroupVO;
import com.buff.vo.EventVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;
import com.buff.vo.NoticeVO;

public interface HdofcNoticeService {

	/** 공지사항 목록 시작 */
	// 1. 테이블목록조회(검색기능포함), 2. 검색조건(담당자), 3. 전체 갯수(탭에서 사용)
	public Map<String, Object> selectNoticeAjax(Map<String, Object> map); 
	public int updateFixd(List<NoticeVO> noticeVOList); // 상단 고정 해체
	/** 공지사항 목록 끝 */
	
	/** 공지사항 상세 시작 **/
	public NoticeVO selectNoticeDtl(String ntcSeq); // url 파라미터가 있는 경우 조회
	public int noticeInsert(NoticeVO noticeVO); // 공지사항 추가
	public int updateNoticeDtlAjax(NoticeVO noticeVO); // 공지사항 수정
	public int noticeDelete(NoticeVO noticeVO); // 공지사항 삭제

	


}
