package com.buff.hdofc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.buff.hdofc.mapper.HdofcEventMapper;
import com.buff.hdofc.service.HdofcEventService;
import com.buff.util.UploadController;
import com.buff.vo.CouponGroupVO;
import com.buff.vo.EventVO;
import com.buff.vo.FileDetailVO;
import com.buff.vo.MemberVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HdofcEventServiceImpl implements HdofcEventService {

	@Inject
	HdofcEventMapper HdofcEventMapper;
	
	@Inject
	UploadController uploadController;
	

	/** 이벤트 목록 시작 */
	// 전체 쿠폰 조회
	@Override
	public List<CouponGroupVO> selectCouponGroupList() {
		return this.HdofcEventMapper.selectCouponGroupList();
	}

	// 전체 사원 조회
	@Override
	public List<MngrVO> selectMngrList() {
		return this.HdofcEventMapper.selectMngrList();
	}

	// 전체 이벤트 갯수
	@Override
	public int selectAll() {
		return this.HdofcEventMapper.selectAll();
	}

	// 대기 중인 이벤트 갯수
	@Override
	public int selectWaiting() {
		return this.HdofcEventMapper.selectWaiting();
	}

	// 취소 된 이벤트 갯수
	@Override
	public int selectCancelled() {
		return this.HdofcEventMapper.selectCancelled();
	}

	// 예정 된 이벤트 갯수
	@Override
	public int selectScheduled() {
		return this.HdofcEventMapper.selectScheduled();
	}

	// 진행 중인 이벤트 갯수
	@Override
	public int selectProgress() {
		return this.HdofcEventMapper.selectProgress();
	}

	// 완료 된 이벤트 갯수
	@Override
	public int selectCompleted() {
		return this.HdofcEventMapper.selectCompleted();
	}

	// 검색조건에 현재 게시판 갯수. total로 반환 됨
	@Override
	public int selectTotal(Map<String, Object> map) {
		return this.HdofcEventMapper.selectTotal(map);
	}
	
	// 전체 이벤트 조회
	@Override
	public List<EventVO> selectEventList(Map<String, Object> map) {
		return this.HdofcEventMapper.selectEventList(map);
	}
	/** 이벤트 목록 끝 */

	/** 이벤트 추가 시작 */
	@Transactional
	@Override
	public String eventInsert(EventVO eventVO) {

		// 파일 업로드 처리 1) FILE_GROUP 테이블에 INSERT , 2) FILE_DETAIL 테이블에 INSERT
		MultipartFile[] multipartFile = eventVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
		// multipartFile[0] : 파일객체들 중에서 첫번째 파일객체를 가져옴
		if(multipartFile != null && multipartFile.length > 0 && multipartFile[0].getOriginalFilename().length() > 0) { // 파일이 있음

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// Event 테이블에 INSERT
			eventVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			eventVO.setFileGroupNo(0); 
		}

		// 이벤트 추가
		int result = this.HdofcEventMapper.eventInsert(eventVO);
		
		// 추가 된 이벤트 조회
		String eventNo = this.HdofcEventMapper.selectNewEvent();
		eventVO.setEventNo(eventNo);

		// 조회 된 이벤트를 가지고 쿠폰 그룹 추가
		result += this.HdofcEventMapper.couponGroupInsert(eventVO);
		
		//  조회 된 이벤트의 파일 이미지 객체 가져오기
		List<FileDetailVO> fileDetailVOList = this.HdofcEventMapper.selectFileDetail(eventVO);
		log.info("ServiceImpl -> result"+result);
		log.info("ServiceImpl -> fileDetailVOList"+fileDetailVOList);
		
		return eventNo;
	}
	
	// 전체 메뉴 갯수 조회
	@Override
	public int selectTotalMENU() {
		return this.HdofcEventMapper.selectTotalMENU();
	}
	
	// 세트 갯수 조회
	@Override
	public int selectMENU01() {
		return this.HdofcEventMapper.selectMENU01();
	}

	// 햄버거 갯수 조회
	@Override
	public int selectMENU02() {
		return this.HdofcEventMapper.selectMENU02();
	}

	// 사이드 갯수 조회
	@Override
	public int selectMENU03() {
		return this.HdofcEventMapper.selectMENU03();
	}

	// 음료 갯수 조회
	@Override
	public int selectMENU04() {
		return this.HdofcEventMapper.selectMENU04();
	}
	
	// 메뉴 조회
	@Override
	public List<MenuVO> selectMenuList(String menuType) {
		return this.HdofcEventMapper.selectMenuList(menuType);
	}
	/** 이벤트 추가 끝 */

	/** 이벤트 상세 시작 */
	// 이벤트 조회 시작
	@Override
	public EventVO selectEventDetail(String eventNo) {
		return this.HdofcEventMapper.selectEventDetail(eventNo);
	}
	// 최상위관리자: 승인여부 처리
	@Override
	public int updateEventAjax(EventVO eventVO) {
		return this.HdofcEventMapper.updateEventAjax(eventVO);
	}
	// 일반관리자: 이벤트 수정
	@Transactional
	@Override
	public int updateEventDtlAjax(EventVO eventVO) {
		int result = 0;
		long oldFileGroupNo = eventVO.getFileGroupNo();
		log.info("oldFileGroupNo",oldFileGroupNo);
		// 기존 파일 삭제
		if(oldFileGroupNo>0) { // 새로운 파일이 있음
			result += this.HdofcEventMapper.fileDelete(oldFileGroupNo);
			result += this.HdofcEventMapper.fileGroupDelete(oldFileGroupNo);
			result += this.HdofcEventMapper.fileGroupNoUpdate(oldFileGroupNo);
		}
		
		// 파일 업로드 처리 1) FILE_GROUP 테이블에 INSERT , 2) FILE_DETAIL 테이블에 INSERT
		MultipartFile[] multipartFile = eventVO.getUploadFile();
		
		// 파일을 선택한 경우만 실행함
		// multipartFile[0] : 파일객체들 중에서 첫번째 파일객체를 가져옴
		if(multipartFile != null && multipartFile.length > 0 && multipartFile[0].getOriginalFilename().length() > 0) { // 파일이 있음

			// 공통 멀티파일업로드 메소드 호출
			// return값 : FILE_GROUP.FILE_GROUP_NO의 값
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			log.info("registPost -> fileGroupNO : "+fileGroupNo);

			// Event 테이블에 INSERT
			eventVO.setFileGroupNo(fileGroupNo);
		} else {
			// null
			eventVO.setFileGroupNo(0); 
		}

		// 이벤트 수정
		result += this.HdofcEventMapper.updateEventDtlAjax(eventVO);
		
		// 기존 쿠폰 삭제
		result += this.HdofcEventMapper.deletCouponGroup(eventVO);
		
		log.info("eventVO -> "+eventVO);
		
		// 조회 된 이벤트를 가지고 쿠폰 그룹 추가
		result += this.HdofcEventMapper.couponGroupInsert(eventVO);
		
		return result;
	}
	// 파일 불러오기
	@Override
	public List<EventVO> selectFileImgList(String eventNo) {
		return this.HdofcEventMapper.selectFileImgList(eventNo);
	}
	// 이벤트 삭제
	@Override
	public int eventDelete(EventVO eventVO) {
		long oldFileGroupNo = eventVO.getFileGroupNo();
		String eventNo = eventVO.getEventNo();
		// 이벤트 삭제 (쿠폰그룹 종속 삭제됨) 
		int result = this.HdofcEventMapper.eventDelete(eventNo);
		// 파일그룹 삭제 (파일디테일 종속 삭제됨)
		int fileResult = this.HdofcEventMapper.fileGroupDelete(oldFileGroupNo);
		log.info("eventDelete",fileResult);
		return result;
	}
	// 쿠폰 리스트 조회
	@Transactional
	@Override
	public Map<String, Object> selectCouponList(String couponCode) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<MemberVO> memberVOList = this.HdofcEventMapper.selectCouponList(couponCode);
		int total =  this.HdofcEventMapper.selectCouponTotal(couponCode);
		map.put("memberVOList", memberVOList);
		map.put("total", total);
		
		return map;
	}
	/** 이벤트 상세 끝 */




}
