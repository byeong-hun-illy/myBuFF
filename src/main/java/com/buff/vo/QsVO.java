package com.buff.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class QsVO {

	private int rnum; // 행번호
	private String qsSeq; // 문의사항 순번
	private String mbrId; // 고객 아이디
	private String mbrNm; // 고객 아이디
	private String mngrId; // 본사 담당자 아이디
	private String qsType; // 문의 유형
	private String qsTypeNm; // 문의 유형 이름
	private String qsTtl; // 제목
	private String qsCn; // 내용
	private String wrtrDt; // 작성일시
	private String ansDt; // 답변일시
	private String ansCn; // 답변내용
	
	private int inqCnt; // 조회수
	private String fixdSeq;// 고정글순번
	
	private long fileGroupNo; // 파일 그룹 번호
	
	// 파일 조회를 위한 속성
	private List<FileDetailVO> fileDetailVOList;
	
	// 파일 업로드를 위한 속성
	private MultipartFile[] uploadFile; 
	
	// 공지사항 : 담당자 = 1 : 1
	private MemberVO mngrVO; 
	
	// 담당자 : 회원 = 1 : 1
	private MemberVO memberVO; 
	
}
