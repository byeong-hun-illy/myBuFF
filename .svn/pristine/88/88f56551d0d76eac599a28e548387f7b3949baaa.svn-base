package com.buff.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.buff.vo.AuthVO;
import com.buff.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;


/**
* @packageName  : com.buff.security
* @fileName     : CustomUser.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 스프링 시큐리티의 User 클래스를 확장한 커스텀 사용자 정보 클래스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성
*/
@Slf4j
public class CustomUser extends User {
	
	//principal == CustomUser
	// 사용자의 전체 정보를 담을 MemberVO객체
	//<sec:authentication property="principal.MemberVO" var="user"/>
	private MemberVO memberVO;
	
	// 기본 생성자
	// username과 password, 권한 정보를 스프링 시큐리티의 User 생성자에게 전달
	public CustomUser(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	/**
	 *  MemberVO 타입의 memberVO 객체를
	 *  시큐리티에서 제공하는 CustomUser로 변환하는 생성자
	 	memberVO에 담겨진 사용자의 정보들을 스프링 시큐리티에서 사용되는 UserDetails 타입으로 변환
	 	MbrId와 MbrPswd, 권한목록은 부모 User 클래스에 전달하는데
	 	권한 목록은 SimpleGrantedAuthority 타입으로 변환하여 시큐리티에서 사용할 수 있게 처리
	 	변환한 후, 다시 리스트 처리  
	 * @param memberVO
	 */
	
	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMbrId(), memberVO.getMbrPswd(), 
			  memberVO.getAuthList().stream()
			  .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
			  .collect(Collectors.toList()));
		log.info("CustomUser에 왔어요");
		log.info("CustomUser_memberVo.getMbrPswd : " + memberVO.getMbrPswd());
		this.memberVO = memberVO;
	}
	
	// MemberVO의 getter/setter
	// 외부에서 이 정보를 조회하거나 설정할 수 있게 만든다. 
	public MemberVO getMemberVO() {
		return memberVO;
	}
	
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

}







