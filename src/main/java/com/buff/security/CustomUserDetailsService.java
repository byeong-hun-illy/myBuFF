package com.buff.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.buff.cust.mapper.MemberMapper;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.security
* @fileName     : CustomUserDetailsService.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 이 클래스는 스프링 시큐리티에서 사용자 정보를 데이터베이스(DB)에서 조회하여 인증과정에 사용하는 
  				  UserDetailsService 인터페이스를 구현한 클래스. 
 				  사용자의 ID(또는 사용자 명)를 기반으로 사용자 정보를 조회하고, 이를 시큐리티에 사용할 수 있는
 				  UserDetails로 변환하는 역할을 한다.
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	
	// DI(의존성 주입)
	// MemberMapper : 데이터베이스와 상호작용하는 Mapper 객체
	@Autowired
	MemberMapper memberMapper;
	
	
	
	// 사용자의 ID(username)를 통해 사용자의 정보를 조회하고, 
	// UserDetails로 반환하는 메소드
	@Override
	public UserDetails loadUserByUsername(String username) 
			throws UsernameNotFoundException {

		MemberVO memberVO = new MemberVO();

		
		// 사용자ID(username)으로 데이터베이스(DB)에서 사용자 정보 조회
		// 예를 들어, Mapper는 'SELECT * FROM MEMBER WHERE USERNAME = ?'과 같은 쿼리를 수행
		memberVO = this.memberMapper.getLogin(username);
		
		log.info("memberVO : " + memberVO);
		
		
		// 사용자 없을 경우, 예외처리
		if(memberVO == null) {
			throw new UsernameNotFoundException("해당 사용자가 없습니다.");
		}
		
		log.info("memberVO.getMbrPswd(): " + memberVO.getMbrPswd());
		
		log.warn("MemberMapper에 의해 쿼리를 실행할 것임 : " + memberVO);
		
		// 3항 연산자. 
		// memberVO가 null이면 null을 리턴하고, 
		// null이 아니면 조회된 사용자 정보를 CustomUser 객체로 변환하여 반환
		return memberVO==null ? null : new CustomUser(memberVO);
		
	}
	
}






