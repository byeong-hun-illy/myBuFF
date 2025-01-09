package com.buff.cnpt.service.impl;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.buff.cnpt.mapper.CnptMapper;
import com.buff.cnpt.service.CnptService;
import com.buff.com.mapper.ComMapper;
import com.buff.vo.BzentVO;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.cnpt.service.impl
* @fileName     : CnptServiceImpl.java
* @author       : 이병훈 
* @date         : 2024.09.17
* @description  : 거래처 ServiceImpl 파일
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.17        이병훈     	  			최초 생성
*/
@Service
public class CnptServiceImpl implements CnptService {
	
	@Autowired
	CnptMapper cnptMapper;
	
	@Autowired
	ComMapper comMapper;
	
	//비밀번호 인코딩을 위해서 DI
	@Inject
	PasswordEncoder bcryptPasswordEncoder;
	
	/**
	* @methodName  : selectCnpt
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param 	   : 업체 번호
	* @return      : 해당 업체 정보 및 업체 담당자 정보
	*/
	@Override
	public BzentVO selectCnpt(String bzentNo) {
		return this.cnptMapper.selectCnpt(bzentNo);
	}

	/**
	* @methodName  : updateCnpt
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param 	   : 업체 번호
	* @return      : 수정된 해당 업체 정보
	*/
	@Override
	public void updateCnpt(BzentVO bzentVO) {
		String addr = bzentVO.getBzentAddr();
		// 주소를 메소드에 입력
		String rgnNo = this.comMapper.rgnNoSearch(addr);
		bzentVO.setRgnNo(rgnNo);
		
		this.cnptMapper.updateCnpt(bzentVO);
		
	}

	/**
	* @methodName  : updateMngr
	* @author      : 이병훈
	* @date        : 2024.09.18
	* @param 	   : 담당자 정보가 담긴 VO객체
	* @return      : 수정된 담당자 정보
	*/
	@Override
	public void updateMngr(MemberVO memberVO) {
		// 주소 입력 시, 우편번호 가져오기
		String address = memberVO.getMbrAddr();
		String rgnNo = this.comMapper.rgnNoSearch(address);
		memberVO.setRgnNo(rgnNo);
		
		//비밀번호 인코딩 처리
		//1. memberVO에서 비밀번호 추출
		String beforEncoding = memberVO.getMbrPswd();
		
		if(beforEncoding !=null && !beforEncoding.isEmpty()) {
			//2. 추출한 비밀번호 인코딩
			beforEncoding = bcryptPasswordEncoder.encode(beforEncoding);
			//3. 인코딩 된 비밀번호를 memberVO에 적용
			memberVO.setMbrPswd(beforEncoding);
		}
		
		this.cnptMapper.updateMngr(memberVO);
		
	}

}
