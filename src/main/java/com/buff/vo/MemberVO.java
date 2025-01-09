package com.buff.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int rnum;
	
	private String mbrId;			// 회원 아이디
	private String mbrPswd;			// 비밀번호
	private String mbrNm;			// 회원 명
	private String mbrZip;			// 우편번호
	private String mbrAddr;			// 주소
	private String mbrDaddr;		// 상세주소
	private String mbrTelno;		// 전화 번호
	private String mbrBrdt;			// 생년월일
	private String mbrEmlAddr;		// 이메일 
	private String enabled;			// 권한 사용 여부
	private String delYn;			// 탈퇴 여부
	private String joinYmd;			// 가입 일자
	private String mbrType;			// 회원 유형
	private String mbrTypeNm;			// 회원 유형 이름
	private String mbrAprvYn;		// 회원 승인여부
	private String mbrImgPath;		// 회원 이미지 경로
	private String rgnNo;			// 지역 번호
	
	private String rgnNm;			// 지역 이름
	
	private String bzentNo;	// 로그인 시 사용하기 위한 정보

	private String mngrType;	// 로그인 시 사용하기 위한 정보
	
	// 회원(MemberVO) : 권한 테이블(AuthVO) 1 : N
	private List<AuthVO> authList;
	
	// 회원 : 쿠폰 = 1 : N
	private List<CouponVO> couponVOList;
	
	// 회원 : 가맹점 = 1 : 1
	private BzentVO bzentVO;
	
	// 회원 : 관심 매장 = 1 : N 
	private List<FavFrcsVO> favFrcsVOList;
}
