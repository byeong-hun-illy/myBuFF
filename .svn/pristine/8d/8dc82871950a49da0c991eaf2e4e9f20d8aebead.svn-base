package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.buff.vo.CouponGroupVO;
import com.buff.vo.EventVO;
import com.buff.vo.FileDetailVO;
import com.buff.vo.MemberVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;
import com.buff.vo.NoticeVO;

public interface HdofcNoticeMapper {

	/** 공지사항 목록 시작 */
	// selectNoticeAjax
	public List<MngrVO> selectMngrList(); // 검색조건 전체 담당자 조회
	public int selectAll(); // 전체 갯수 조회 (탭에서 사용)
	public int selectTotal(Map<String, Object> map); // 검색조건에 현재 게시판 갯수
	public List<NoticeVO> selectNofixd(Map<String, Object> map); // 전체 공지사항 조회
	public List<NoticeVO> selectfixd(Map<String, Object> map); // 상단 고정 공지사항
	public int updateFixd(@Param("noticeVOList") List<NoticeVO> noticeVOList); // 상단 고정 해체
	/** 공지사항 목록 끝 */
	
	/** 공지사항 상세 시작 **/
	public NoticeVO selectNoticeDtl(String ntcSeq); // 상세 조회
	public int noticeInsert(NoticeVO noticeVO); // 공지사항 추가
	public int selectMaxNtcSeq(); // 추가 된 공지사항 조회
	public int noticeDelete(NoticeVO noticeVO); // 공지사항 삭제
	/** 공지사항 상세 끝 **/
	
	/** 공지사항 수정 시작 **/
	public int fileDelete(long oldFileGroupNo);
	public int fileGroupDelete(long oldFileGroupNo);
	public int fileGroupNoUpdate(long oldFileGroupNo);
	public int updateNoticeDtlAjax(NoticeVO noticeVO);
	/** 공지사항 수정 끝 **/
	
}
