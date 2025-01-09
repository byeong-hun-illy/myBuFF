package com.buff.vo;

import lombok.Data;

/**
* @packageName  : com.buff.vo
* @fileName     : BankVO.java
* @author       : 이병훈
* @date         : 2024.09.18
* @description  : 은행 번호와 이름을 가져옴
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.18        이병훈     	  			최초 생성
*/
@Data
public class BankVO {
	private String bankNo;
	private String bankNm;
}
