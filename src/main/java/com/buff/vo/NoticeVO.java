package com.buff.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
	private int rnum; 
	private int ntcSeq; // 공지사항 pk
	private String mngrId; // 담당자 아이디
	private String ntcTtl; // 제목
	private String ntcCn; // 내용
	private String wrtrDt; // 등록일자
	private int inqCnt; // 조회수
	private String fixdSeq;// 고정글순번
	private long fileGroupNo; // 파일번호
	
	// 파일 조회를 위한 속성
	private List<FileDetailVO> fileDetailVOList;
	
	// 파일 업로드를 위한 속성
	private MultipartFile[] uploadFile; 
	
	// 공지사항 : 담당자 = 1 : 1
	private MngrVO mngrVO; 
	
	// 담당자 : 회원 = 1 : 1
	private MemberVO memberVO; 
}
