package com.buff.com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.com.service.MemberService;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.com.controller
* @fileName     : JoinController.java
* @author       : 김현빈
* @date         : 2024.09.26
* @description  : 회원가입을 위한 메서드
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.26       	김현빈    	  		      최초 생성
*/

@Slf4j
@Controller
public class JoinController {
	
	// DI, IOC 주입
	@Autowired
	MemberService memberService;
	
	@Inject
	ComService comService;
	
	//비밀번호 인코딩을 위해서 DI
	@Inject
	PasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/join")
	public String insertMember(Model model) {
		log.info("insertMember에 왔다");
		return "join";
	}
	
	@GetMapping("/admin/join")
	public String insertBzent(Model model) {
		log.info("insertMember에 왔다");
		return "adminJoin";
	}
	
	/**
	* @methodName  : submitJoin
	* @author      : 김현빈
	* @date        : 2024.09.27
	* @param       : memberVO, model
	* @return	   : 회원(MEMBER)가입 insert후 MBT_TYPE에 따라서 AUTH테이블 insert를 선택, MBR_PSWD는 시큐리티로 암호화한다.
	*/
	@PostMapping("/joinSubmit")
	public String submitJoin(@ModelAttribute MemberVO memberVO, Model model) {
		// 회원가입 처리 로직
		//log.info 
		// ,는 {} 있어야 함
		// +는 {} 없어도 됨
		/*
		MemberVO(rnum=0, mbrId=aaaaaaaaaa, mbrPswd=1111, mbrNm=김민구, mbrZip=06083, mbrAddr=서울 강남구 봉은사로111길 5, mbrDaddr=33
		, mbrTelno=01000006333, mbrBrdt=19990808, mbrEmlAddr=hosinominguddd@mingu.com, enabled=null, delYn=null
		, joinYmd=null, mbrType=MBR02, mbrTypeNm=null, mbrAprvYn=null, mbrImgPath=스크린샷 2024-06-18 114709.png, rgnNo=null
		, rgnNm=null, bzentNo=null, mngrType=null, authList=null, couponVOList=null, bzentVO=null)
		 */
		log.info("memberVO : -> {}", memberVO);
		
		//비밀번호 인코딩 처리
		//1. memberVO에서 비밀번호 추출
		String beforEncoding = memberVO.getMbrPswd();
		//2. 추출한 비밀번호 인코딩
		beforEncoding = bcryptPasswordEncoder.encode(beforEncoding);
		//3. 인코딩 된 비밀번호를 memberVO에 적용
		memberVO.setMbrPswd(beforEncoding);
		
		//서울 강남구 봉은사로111길 5
		String addr = memberVO.getMbrAddr();
		
		//RGN11
		String rgnNo = this.comService.rgnNoSearch(addr);
		
		/*
		MemberVO(rnum=0, mbrId=aaaaaaaaaa, mbrPswd=1111, mbrNm=김민구, mbrZip=06083, mbrAddr=서울 강남구 봉은사로111길 5, mbrDaddr=33
		, mbrTelno=01000006333, mbrBrdt=19990808, mbrEmlAddr=hosinominguddd@mingu.com, enabled=null, delYn=null
		, joinYmd=null, mbrType=MBR02, mbrTypeNm=null, mbrAprvYn=null, mbrImgPath=스크린샷 2024-06-18 114709.png, rgnNo=RGN11
		, rgnNm=null, bzentNo=null, mngrType=null, authList=null, couponVOList=null, bzentVO=null)
		 */
		memberVO.setRgnNo(rgnNo);
		
		// 회원가입 처리
		int result = memberService.insertMember(memberVO);//result : 0
		if (result > 0) {
			/*
			 join.jsp에서 radio로 선택된 값이 mbrType 프로퍼티에 들어왔으므로 분기(if) 
			 1. memberVO.mbrType 값이 MBR03 또는 MBR04 : "redirect:/admin/login"
			 2. memberVO.mbrType 값이 MBR01 : "redirect:/login"
			 */
			// 성공적으로 가입한 경우 로그인 페이지로 이동
			
	        // 회원 유형에 따른 리다이렉트 분기 처리
	        String mbrType = memberVO.getMbrType();
	        if ("MBR01".equals(mbrType)) {
	            // MBR01인 경우 일반 회원 로그인 페이지로 이동
	            return "redirect:/login";
	        } else if ("MBR03".equals(mbrType) || "MBR04".equals(mbrType)) {
	            // MBR03 또는 MBR04인 경우 관리자 로그인 페이지로 이동
	            return "redirect:/admin/login";
	        }
	    } else {
			// 회원가입 실패 시 오류 메시지 표시
			model.addAttribute("errorMessage", "회원가입에 실패했습니다. 다시 시도해주세요.");
			return "join";
		}
		
		return "redirect:/login"; // 기본 리다이렉트 경로 (안전장치)
	}
	
	
	@ResponseBody
	@PostMapping("/checkIdDuplicate")
	public Map<String, String> checkIdDuplicate(@RequestBody Map<String, String> data) {
		String mbrId = data.get("mbrId");
	    int count = memberService.checkIdDuplicate(mbrId); // 중복 아이디 검사
	    log.info("mbrId : " + mbrId);
	    log.info("count : " + count);
	    Map<String, String> result = new HashMap<>();
	    if (count > 0) {
	        result.put("status", "no");  // 중복 아이디 존재
	    } else {
	        result.put("status", "yes"); // 사용 가능한 아이디
	    }
	    return result;
	}
}
