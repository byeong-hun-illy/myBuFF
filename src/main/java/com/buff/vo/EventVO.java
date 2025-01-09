package com.buff.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EventVO {
	private int rnum; // 번호
	private String eventNo; // 이벤트 번호
	private String eventType; // 유형
	private String eventTtl; // 제목
	private String eventCn; // 내용
	private String wrtrYmd; // 등록일자
	private String bgngYmd; // 시작일자
	private String expYmd; // 마감일자
	private String aprvYn; // 승인여부
	private String mngrId; // 담당자 아이디	
	private String mbrNm; // 담당자 이름
	private String rjctRsn; // 반려 사유
	private int    remainDay;
	
	// 검색 기능
	private String comNm;
	private String couponGubun; // 쿠폰 검색
	private String gubun; // 검색어 셀렉트값
	private String keyword; // 검색어 인풋값
	
	// 이벤트 : 쿠폰 = 1 : N
	private List<CouponGroupVO> couponGroupVOList;
	private String couponNm; // 쿠폰 이름
	private int dscntAmt; // 할인 가격
	private int issuQty; // 쿠폰 발급 수량
	
	// 이벤트 메뉴 정보
	private String menuNo; // 메뉴 번호
	private String menuNm; // 메뉴 이름
	
	// 파일 업로드를 위한 속성
	private List<FileDetailVO> FileDetailVOList;
	private FileGroupVO fileGroupVO;
	private long fileGroupNo;
	
	// 이미지 파일객체 (multiple) name값과 동일 해야 함
	// <input type="file" class="custom-file-input" id="uploadFile" name="uploadFile" required multiple />
	private MultipartFile[] uploadFile; 
}

// 이벤트 상세 순서
//mbrNm
//wrtrYmd
//eventTtl
//bgngYmd
//expYmd
//couponNm
//dscntAmt
//issuQty
//menuNm
//menuNo
//eventCn