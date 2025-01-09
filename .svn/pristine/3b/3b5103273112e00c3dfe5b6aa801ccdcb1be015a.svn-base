package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.buff.hdofc.mapper.HdofcNoticeMapper;
import com.buff.hdofc.service.HdofcNoticeService;
import com.buff.util.ArticlePage;
import com.buff.util.UploadController;
import com.buff.vo.CouponGroupVO;
import com.buff.vo.NoticeVO;
import com.buff.vo.FileDetailVO;
import com.buff.vo.MemberVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HdofcNoticeServiceImpl implements HdofcNoticeService {

	@Inject
	HdofcNoticeMapper HdofcNoticeMapper;
	
	@Inject
	UploadController uploadController;

	/** 공지사항 목록 시작 */
	@Override
	public Map<String, Object> selectNoticeAjax(Map<String, Object> map) {

		// 검색조건 전체 담당자 조회 √
		List<MngrVO> mngrVOList = this.HdofcNoticeMapper.selectMngrList();
		
		// 전체 갯수 조회 (탭에서 사용) √
		int all = this.HdofcNoticeMapper.selectAll();

		// 페이징을 위한 데이터
		int total = this.HdofcNoticeMapper.selectTotal(map); // 검색조건에 현재 게시판 갯수 √
		int currentPage = Integer.parseInt((String) map.get("currentPage"));
		int size = 10; // 페이징 사이즈
		List<NoticeVO> fixList = this.HdofcNoticeMapper.selectfixd(map); // 상단 고정 공지사항 √
		if (fixList != null) {size -= fixList.size();}
		map.put("size", size);
		List<NoticeVO> noticeVOList = this.HdofcNoticeMapper.selectNofixd(map); // 전체 공지사항 조회 (고정X) √
		
		
		// 응답 데이터를 담을 Map 생성
		Map<String, Object> response = new HashMap<>();
		response.put("mngrVOList", mngrVOList);
		response.put("fixList", fixList);
		response.put("all", all);
		response.put("articlePage", new ArticlePage<NoticeVO>(total, currentPage, size, noticeVOList, map));
		
		return response;
	}
	
	// 상단 고정해체
	@Override
	public int updateFixd(List<NoticeVO> noticeVOList) {
		return this.HdofcNoticeMapper.updateFixd(noticeVOList);
	}
	/** 공지사항 목록 끝 */

	
	/** 공지사항 상세 시작 */
	// 상세 조회
	@Override
	public NoticeVO selectNoticeDtl(String ntcSeq) {
		return this.HdofcNoticeMapper.selectNoticeDtl(ntcSeq);
	}
	// 공지사항 추가
	@Override
	public int noticeInsert(NoticeVO noticeVO) {
		
		// 파일 업로드 처리 1) FILE_GROUP 테이블에 INSERT , 2) FILE_DETAIL 테이블에 INSERT
		MultipartFile[] multipartFile = noticeVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
		// multipartFile[0] : 파일객체들 중에서 첫번째 파일객체를 가져옴
		if(multipartFile != null && multipartFile.length > 0 && multipartFile[0].getOriginalFilename().length() > 0) { // 파일이 있음

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// Notice 테이블에 INSERT
			noticeVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			noticeVO.setFileGroupNo(0); 
		}
		
		// 공지사항 추가
		int result = this.HdofcNoticeMapper.noticeInsert(noticeVO);
		log.info("noticeInsert : result => ", result);
		
		// 추가 된 공지글 번호 조회
		int ntcSeq = this.HdofcNoticeMapper.selectMaxNtcSeq();
		
		return ntcSeq;
	}
	
	// 공지사항 수정
	@Override
	public int updateNoticeDtlAjax(NoticeVO noticeVO) {
		int result = 0;
		long oldFileGroupNo = noticeVO.getFileGroupNo();
		log.info("oldFileGroupNo",oldFileGroupNo);
		// 기존 파일 삭제
		if(oldFileGroupNo>0) { // 새로운 파일이 있음
			result += this.HdofcNoticeMapper.fileDelete(oldFileGroupNo);
			result += this.HdofcNoticeMapper.fileGroupDelete(oldFileGroupNo);
			result += this.HdofcNoticeMapper.fileGroupNoUpdate(oldFileGroupNo);
		}
		
		// 파일 업로드 처리 1) FILE_GROUP 테이블에 INSERT , 2) FILE_DETAIL 테이블에 INSERT
		MultipartFile[] multipartFile = noticeVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
		// multipartFile[0] : 파일객체들 중에서 첫번째 파일객체를 가져옴
		if(multipartFile != null && multipartFile.length > 0 && multipartFile[0].getOriginalFilename().length() > 0) { // 파일이 있음

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// Event 테이블에 INSERT
			noticeVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			noticeVO.setFileGroupNo(0); 
		}

		// 공지사항 수정
		result += this.HdofcNoticeMapper.updateNoticeDtlAjax(noticeVO);
		
		return result;
	}

	// 공지사항 삭제
	@Override
	public int noticeDelete(NoticeVO noticeVO) {
		int result = this.HdofcNoticeMapper.noticeDelete(noticeVO);
		
		if (noticeVO.getFileGroupNo() != 0) {
			long oldFileGroupNo = noticeVO.getFileGroupNo();
			result += this.HdofcNoticeMapper.fileGroupDelete(oldFileGroupNo);
		}
		
		return result;
	}
	
	/** 공지사항 상세 끝 */




}
