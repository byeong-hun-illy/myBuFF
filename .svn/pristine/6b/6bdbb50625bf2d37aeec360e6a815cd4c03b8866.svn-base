package com.buff.cust.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.buff.cust.mapper.CustCenterMapper;
import com.buff.cust.service.CustCenterService;
import com.buff.util.UploadController;
import com.buff.vo.FaqVO;
import com.buff.vo.NoticeVO;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cust.service.impl
* @fileName     : CustCenterServiceImpl.java
* @author       : 서윤정
* @date         : 2024.09.17
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.17        이름     	  			최초 생성
*/
@Service
@Slf4j
public class CustCenterServiceImpl implements CustCenterService {
	@Inject 
	UploadController uploadController;
	
	@Inject
	CustCenterMapper centerMapper;
	
	
	/**
	* @methodName  : selectFaq
	* @author      : 서윤정
	* @date        : 2024.09.13
	* @param  	   : 
	* @return      : FAQ 리스트 목록
	*/
	@Override
	public List<FaqVO> selectFaq(String faqCategory) {
		return this.centerMapper.selectFaq(faqCategory);
	}
	
	
	/**
	* @methodName  : selectNotice
	* @author      : 서윤정
	* @date        : 2024.09.17
	* @param  	   : 
	* @return      : 공지사항 리스트 목록
	*/

	@Override
	public List<NoticeVO> selectNotice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.centerMapper.selectNotice(map);
	}
	
	/**
	* @methodName  : noticeTotalCnt
	* @author      : 서윤정
	 * @param noticeCategory 
	* @date        : 2024.09.17
	* @param NoticeVO : 공지사항이  담긴 객체
	* @return : NoticeVO
	*/
	@Override
	public int noticeTotalCnt(Map<String, Object> map) {
		return this.centerMapper.noticeTotalCnt(map);
	}

	/**
	* @methodName  : selectNoticeDetail
	* @author      : 서윤정
	* @date        : 2024.09.17
	* @param  	   : 
	* @return      : 공지사항 상세 조회
	*/
	@Override
	public NoticeVO selectNoticeDetail(int ntcSeq) {
		// TODO Auto-generated method stub
		return this.centerMapper.selectNoticeDetail(ntcSeq);
	}

	/**
	* @methodName  : insertQs
	* @author      : 서윤정
	* @date        : 2024.10.05
	* @param  	   : 
	* @return      : 문의사항 작성 
	*/
	@Override
	public int insertQsPostAjax(QsVO qsVO) {
		
		MultipartFile[] multipartFile = qsVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
//		if(multipartFile != null && multipartFile.length > 0 && multipartFile[0].getOriginalFilename().length() > 0) { 
		if(multipartFile != null && multipartFile[0].getOriginalFilename().length() > 0) { 

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// qsVO 테이블에 INSERT
			qsVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			qsVO.setFileGroupNo(0); 
		}
		
		return this.centerMapper.insertQsPostAjax(qsVO);
	}

	/**
	* @methodName  : inqCnt
	* @author      : 서윤정
	* @date        : 2024.10.05
	* @param  	   : 
	* @return      : 공지사항 조회수 확인
	*/
	@Override
	public void inqCnt(int ntcSeq) {
		this.centerMapper.inqCnt(ntcSeq);
	}

	/**
	* @methodName  : selectQsDetail
	* @author      : 서윤정
	 * @param qsVO 
	* @date        : 2024.09.17
	* @return : 고객이 쓴 문의 사항 리스트 출력, 문의 사항 상세 출력 
	*/
	@Override
	public QsVO selectQsDetail(Map<String, Object> map) {
		return this.centerMapper.selectQsDetail(map);
	}

	/**
	* @methodName  : updateQsAjax
	* @author      : 서윤정
	 * @param qsVO 
	* @date        : 2024.10.11
	* @return : 문의 사항 수정 
	*/
	@Override
	public int updateQsAjax(QsVO qsVO) {
		
	MultipartFile[] multipartFile = qsVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
		if(multipartFile != null && multipartFile[0].getOriginalFilename().length() > 0) { 

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// qsVO 테이블에 INSERT
			qsVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			qsVO.setFileGroupNo(0); 
		}
		
		return this.centerMapper.updateQsAjax(qsVO);
	}
	
	/**
	* @methodName  : deleteQsAjax
	* @author      : 서윤정
	* @param qsVO 
	* @date        : 2024.10.11
	* @return : 문의 사항 삭제
	*/
	@Override
	public int deleteQsAjax(String qsSeq) {
		return this.centerMapper.deleteQsAjax(qsSeq);
	}

	/**
	* @methodName  : updateFileAjax
	* @author      : 서윤정
	* @param qsVO 
	* @date        : 2024.10.13
	* @return : 문의 사항 파일 삭제
	*/
	@Override
	public int updateFileAjax(String qsSeq) {
		return this.centerMapper.updateFileAjax(qsSeq);
	}








}
