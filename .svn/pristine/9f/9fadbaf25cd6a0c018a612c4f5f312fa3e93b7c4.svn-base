package com.buff.hdofc.service;

import java.util.List;
import java.util.Map;

import com.buff.vo.CouponGroupVO;
import com.buff.vo.EventVO;
import com.buff.vo.MenuVO;
import com.buff.vo.MngrVO;

public interface HdofcEventService {

	/** 이벤트 목록 시작 */
	// 검색어 조건 중 쿠폰과 사원을 조회
	public List<CouponGroupVO> selectCouponGroupList(); // 전체 쿠폰 조회
	public List<MngrVO> selectMngrList(); // 전체 사원 조회
	public int selectAll(); // 전체 이벤트 갯수
	public int selectWaiting(); // 대기 중인 이벤트 갯수
	public int selectCancelled(); // 취소 된 이벤트 갯수
	public int selectScheduled(); // 예정 된 이벤트 갯수
	public int selectProgress(); // 진행 중인 이벤트 갯수
	public int selectCompleted(); // 완료 된 이벤트 갯수
	public int selectTotal(Map<String, Object> map); // 검색조건에 현재 게시판 갯수. total로 반환 됨
	public List<EventVO> selectEventList(Map<String, Object> map); // 전체 이벤트 조회
	/** 이벤트 목록 끝 */
	
	/** 이벤트 추가 시작 */
	public String eventInsert(EventVO eventVO); // 이벤트 추가
	public List<MenuVO> selectMenuList(String menuType); // 메뉴 리스트 조회
	public int selectTotalMENU(); // 전체 메뉴 조회
	public int selectMENU01(); // 세트 메뉴 갯수 조회
	public int selectMENU02(); // 햄버거 메뉴 갯수 조회
	public int selectMENU03(); // 사이드 메뉴 갯수 조회
	public int selectMENU04(); // 음료 메뉴 갯수 조회
	/** 이벤트 추가 끝 */
	
	/** 이벤트 상세 시작 */
	public EventVO selectEventDetail(String eventNo); // 이벤트 상세 조회
	public int updateEventAjax(EventVO eventVO); // 최상위관리자: 승인여부처리
	public int updateEventDtlAjax(EventVO eventVO); // 일반관리자: 이벤트 수정
	public List<EventVO> selectFileImgList(String eventNo); // 파일 불러오기
	public int eventDelete(EventVO eventVO); // 이벤트 삭제
	/** 이벤트 상세 끝 */
	
	/** 쿠폰 컨트롤 */
	public Map<String, Object> selectCouponList(String couponCode); // 쿠폰 리스트 조회
}
