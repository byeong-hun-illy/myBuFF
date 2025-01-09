package com.buff.com.service.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.com.service.MemberService;
import com.buff.cust.mapper.MemberMapper;
import com.buff.vo.AuthVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.service
* @fileName     : MemberServiceImpl.java
* @author       : 
* @date         : 2024.09.13
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/
@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	/**
	* @methodName  : selectId
	* @author      : 이병훈
	* @date        : 2024.09.13
	* @param 	   : 사용자 정보가 담긴 VO객체
	* @return      : 해당 회원 ID
	*/
	@Override
	public String selectId(MemberVO memberVO) {
		return this.memberMapper.selectId(memberVO);
	}

	
	/**
	* @methodName  : selectPswd
	* @author      : 이병훈
	* @date        : 2024.09.13
	* @param 	   : 사용자 정보가 담긴 VO객체
	* @return      : 해당 회원 Password
	*/
//	@Override
//	public String selectPswd(MemberVO memberVO) {
//		return this.memberMapper.selectPswd(memberVO);
//	}
//	
	
	
	/**
	* @methodName  : sendTempPswd
	* @author      : 이병훈 
	* @date        : 2024.09.14
	* @param memberVO : 사용자 정보가 담긴 VO객체
	* @return 	   : 성공 여부 
	*/
	@Override
	public String sendTempPswd(MemberVO memberVO) {
		
		// 임시 비밀번호 생성
		String tempPswd = generateTempPassword();
		
		// 생성된 임시비밀번호를 암호화
		String encodedPswd = passwordEncoder.encode(tempPswd);
		
		// 비밀번호를 임시 비밀번호로 변경(update)
		memberVO.setMbrPswd(encodedPswd);
		// DB에서 비밀번호 변경 처리
		this.memberMapper.updatePswd(memberVO);
		
		// 임시 비밀번호를 이메일로 전송
		try { // 사용자에게는 암호화 되지 않은 비밀번호를 보내야 됨.
			sendEmailWithTempPswd(memberVO.getMbrEmlAddr(), tempPswd);
			log.info("임시 비밀번호가 이메일로 전송되었습니다.");
			return "임시 비밀번호가 이메일로 전송되었습니다.";
		} catch (EmailException e) {
			log.error("임시 비밀번호 전송에 실패했습니다. " + e.getMessage(), e);
			return "임시 비밀번호 전송에 실패했습니다.";
		}
		
	}
	
	
	/**
	* @methodName  : generateTempPassword
	* @author      : 이병훈 
	* @date        : 2024.09.14
	* @return	   : 임시 비밀번호
	*/
	@Override
	public String generateTempPassword() {
		// 8자리의 랜덤 비밀번호를 생성
		return RandomStringUtils.randomAlphabetic(8);
	}
	
	
	/**
	* @methodName  : sendEmailWithTempPswd
	* @author      : 이병훈
	* @date        : 2024.09.14
	* @param email : 사용자 이메일
	* @param tempPswd : 생성된 임시 비밀번호
	* @throws EmailException : 이메일 전송중 예외 발생 시
	*/
	@Override
	public void sendEmailWithTempPswd(String email, String tempPswd) throws EmailException{
		
		// SMTP 서버 설정
		String host = "smtp.gmail.com";
		
		// Java Mail 라이브러리로 이메일전송
		final String userMail = "zan421@gmail.com";
		final String userPswd = "gufx vcjx sqly mdsm";
		
		// Properties 객체 생성 - SMTP Properties 설정
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.trust", host);      // SSL 신뢰 서버 설정
		// 스프링에서는 ssl 프로토콜 버젼 설정 중요!
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		// 인증 및 세션 생성
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userMail, userPswd);
			}
			
		});
			try {
				// MIME 형식의 이메일 메시지 설정
				Message message =  new MimeMessage(session);
				
				// 발신자 정보 설정
				message.setFrom(new InternetAddress("zan421@gmail.com"));
				
				// 수신자 설정
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));  // 수신자 설정
				// 이메일 제목 설정
				message.setSubject("임시 비밀번호 안내");
				
				// 이메일 본문 설정 (HTML 형식)
		        String emailContent = "<div style='font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f4;'>"
		                            + "<h2 style='color: #333;'>임시 비밀번호 안내</h2>"
		                            + "<p style='font-size: 16px;'>안녕하세요,</p>"
		                            + "<p style='font-size: 16px;'>회원님의 요청에 따라 임시 비밀번호가 생성되었습니다.</p>"
		                            + "<p style='font-size: 18px; color: #007BFF; font-weight: bold;'>임시 비밀번호: " + tempPswd + "</p>"
		                            + "<p style='font-size: 16px;'>로그인 후, 비밀번호를 변경하시는 것을 권장드립니다.</p>"
		                            + "<hr style='border: none; border-top: 1px solid #ccc;'/>"
		                            + "<p style='font-size: 12px; color: #777;'>이 메일은 자동으로 발송된 메일이므로, 회신하지 말아주세요.</p>"
		                            + "</div>";
				
				// HTML 형식의 본문 설정
				message.setContent(emailContent, "text/html; charset=utf-8"); 
				
				// 이메일 전송
				Transport.send(message);
				
				log.info("message : " + message);
				
				
				
			} catch (MessagingException e) {
				e.printStackTrace();
				log.info("이메일 전송에 실패하였습니다.");
			}
	
	}
	
	
	
	
	/**
	* @methodName	: insertMember
	* @author		: 김현빈
	* @date			: 2024.09.27
	* @param		: memberVO
	* @return		: 회원 테이블, 권한 테이블 insert
	*/
	@Transactional
	@Override
	public int insertMember(MemberVO memberVO) {
		/*
		MemberVO(rnum=0, mbrId=aaaaaaaaaa, mbrPswd=1111, mbrNm=김민구, mbrZip=06083, mbrAddr=서울 강남구 봉은사로111길 5, mbrDaddr=33
		, mbrTelno=01000006333, mbrBrdt=19990808, mbrEmlAddr=hosinominguddd@mingu.com, enabled=null, delYn=null
		, joinYmd=null, mbrType=MBR02, mbrTypeNm=null, mbrAprvYn=null, mbrImgPath=스크린샷 2024-06-18 114709.png, rgnNo=RGN11
		, rgnNm=null, bzentNo=null, mngrType=null, authList=null, couponVOList=null, bzentVO=null)
		 */
		// MBR_TYPE이 유효한지 확인
		//memberVO.getMbrType() : MBR02
		if ("MBR01".equals(memberVO.getMbrType()) || "MBR03".equals(memberVO.getMbrType()) || "MBR04".equals(memberVO.getMbrType())) {
			// 회원 테이블, 권한 테이블에 insert
			int result = memberMapper.insertMemberSign(memberVO);
			// authList에 List<AuthVO> 타입의 데이터가 있어야 함
			//<foreach collection="authList" item="authVO" separator=",">
			
			//1. 고객(ROLE_CUST)
			if(memberVO.getMbrType().equals("MBR01")) {
				List<AuthVO> authList = new ArrayList<AuthVO>();
				AuthVO authVO = new AuthVO();
				
				authVO.setMbrId(memberVO.getMbrId());
				authVO.setAuth("ROLE_CUST");
				authList.add(authVO);
				
				// authList를 memberVO에 설정
				memberVO.setAuthList(authList);
				
				// 권한 테이블에 insert
				result = memberMapper.insertAuthSign(memberVO);
			}
			return result;
		} else {
			log.warn("잘못된 회원 유형입니다.");
			return 0;  // 잘못된 유형
		}
	}

	/**
	* @methodName	: checkIdDuplicate
	* @author		: 김현빈
	* @date			: 2024.09.27
	* @param		: mbrId
	* @return		: 중복아이디 체크
	*/
	@Override
	public int checkIdDuplicate(String mbrId) {
		return this.memberMapper.checkIdDuplicate(mbrId);
	}
	
    
    /**
    * @methodName  : insertRoleCust
    * @author      : 송예진
    * @date        : 2024.10.02
    * @param mbrId
    * @return      : 거래처나 본사 회원권한 추가
    */
    public int insertRoleCust(String mbrId) {
    	return this.memberMapper.insertRoleCust(mbrId);
    };
    
    
    /**
     * @methodName  : updatePswd
     * @author      : 송예진
     * @date        : 2024.10.04
     * @param mbrId
     * @return      : 임시비밀번호로 DB 비밀번호 업데이트 저장
     */
    @Override
	public void updatePswd(MemberVO memberVO) {
		this.memberMapper.updatePswd(memberVO);
		
	};
    
    
}
