package com.buff.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : MenuVO.java
* @author       : 정현종
* @date         : 2024.09.12
* @description  : 본사 판매 메뉴 정보
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        정현종     	  			최초 생성
*/
@Data
public class MenuVO {
	private int rnum; // 순번
	
	private String menuNo;      // 메뉴 번호
	private String menuNm;      // 메뉴 이름
	private String menuImgPath; // 메뉴 사진 경로
	private int    menuAmt;     // 메뉴 금액
	private String menuExpln;   // 메뉴 설명
	private String menuType;    // 메뉴 유형
	
	private String menuTypeNm;
	
	private String rlsYmd;      // 출시 일자
	private String regYmd;      // 등록 일자
	private String ntslType;    // 판매 유형
	
	private String ntslTypeNm;
	
	private String frcsNo; 		// 가맹점 번호
	private String ntslYn; 		//판매 여부
	private String menuRegYmd;  //가맹점 메뉴 등록 일자
	
	
	private String mngrId; // 등록자
	
	private int ntslQty;
	
	private long sumOrdrAmt; // 총 매출액
	
	private long ordrQtySum;
	private long ordrAmtSum;
	
	private int regYmdNew; //1, 0, 1(New) 
	
	private String orderHour;	// 시간당 매출 데이터
	private String orderDate;	// 일간 매출 데이터
	private String orderMonth;	// 월간 매출 데이터
	
	// 1:1
	private MemberVO mngrVO;
	
	//MENU(본사 메뉴) : FRCS_MENU(가맹점 메뉴) = 1 : N
	private List<FrcsMenuVO> frcsMenuVOList;
	
	//메뉴(MENU) : 쿠폰그룹(COUPON_GROUP) = 1 : N
	private List<CouponGroupVO> couponGroupVOList;
	
	// 메뉴에 레시피 1:N
	private List<RecipeVO> recipeVOList;
	
	// 세트 메뉴일 경우
	private List<MenuSetVO> menuSetList;
	
	private MultipartFile uploadFile;
}
