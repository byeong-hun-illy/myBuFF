package com.buff.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

/**
* @packageName  : com.buff.security
* @fileName     : SecurityConfig.java
* @author       : 이병훈
* @date         : 2024.09.12
* @description  : 
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.12        이름     	  			최초 생성 
*/

@Configuration			// 이 클래스가 스프링 설정 클래스임을 나타냄
@EnableWebSecurity		// 스프링 시큐리티의 웹 보안을 활성화함을 나타냄
public class SecurityConfig extends WebSecurityConfigurerAdapter{
		
	/**
	* @methodName  : passwordEncoder
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @return 	   : 비밀번호를 BCrypt로 암호화
	* 
	* PasswordEncoder 빈 등록 : BCryptPasswordEncoder 사용하여 비밀번호를 암호화하는데 사용합니다.
	* 스프링 시큐리티는 비밀번호를 암호화하여 저장하고, 인증 시에도 암호화된 비밀번호를 검증합니다.
	*/
	
    @Bean
    public CustomAuthenticationFailureHandler customAuthenticationFailureHandler() {
        return new CustomAuthenticationFailureHandler();
    }
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	
	/**
	* @methodName  : customLogoutSuccessHandler
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @return	   : 로그아웃 성공 시 추가작업을 처리
	* 
	* 이 메소드는 로그아웃 후 세션 무효화, 리다이렉트 등의 작업을 수행
	*/
	@Bean
	public LogoutSuccessHandler customLogoutSuccessHandler() {
		return new CustomLogoutSuccessHandler();
	}
	
	
	
	/**
	* @methodName  : configure
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @description : UserDetailsService는 사용자 정보를 DB에서 조회하여 제공하고, PasswordEncoder는 비밀번호를 암호화 및 검증
	* 				 스프링 시큐리티는 사용자가 로그인할 때 입력한 비밀번호와 데이터베이스에 저장된 암호화된 비밀번호를 비교한다. 
	* 
	*/
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception{
		// 사용자 인증을 위한 서비스와 비밀번호 인코더 설정
		auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
		
	}
	
	/**
	* @methodName  : contigure
	* @author      : 이병훈
	* @date        : 2024.09.12
	* @param http  : HTTP 요청에 대한 시큐리티 설정 정보가 담긴 객체
	* @throws Exception
	* @description : HTTP 요청에 대한 접근 권한을 설정하고, 로그인 및 로그아웃 처리
	* 				 특정 URL에 대한 권한 기반 접근 제어
	*/
	@Override
	protected void configure(HttpSecurity http) throws Exception{
		http
//			.csrf()
//				.disable()
			// 접근 권한 설정
			.authorizeRequests()
				.antMatchers("/login", "/logout", "/image/upload", "/find/pswdAjax").permitAll() 	// 로그인과 로그아웃은 모두 허용
				//.anyRequest().authenticated()					// 그 외 모든 요청은 인증이 필요하도록
			.and()
			.formLogin()
				.loginPage("/login")							// 커스텀 로그인 페이지 설정
				.successHandler(new CustomLoginSuccessHandler())
				.permitAll()									// 로그인 페이지는 모든 사용자에게 허용
			.and()
			.logout()
				.logoutUrl("/logout")							// 로그아웃 요청 URL
				.logoutSuccessHandler(customLogoutSuccessHandler())	// 로그아웃 성공 시 커스텀 핸들러
				.permitAll()									// 로그아웃은 인증 여부와 상관없이 누구나 접근 가능
				.invalidateHttpSession(true)					// 로그아웃 시, 세션 무효화(사용자의 모든 세션 정보 삭제)
				.deleteCookies("JSESSIONID")					// 로그아웃 시, 세션 쿠키 삭제(JSESSIONID 쿠키 삭제)
			.and()	
			.sessionManagement()
				.invalidSessionUrl("/")							// 세션이 유효하지 않은 페이지에 접근 시 이동할 페이지
				.maximumSessions(1)								// 최대 세션 수 설정 (1로 설정하면 같은 계정으로 여러 세션이 불가능)
				.maxSessionsPreventsLogin(true)					// 최대 세션 수를 초과하면 로그인 방지
				.expiredUrl("/")								// 세션이 만료되었을 때 이동하는 페이지
			.and()
				.sessionFixation().migrateSession()				// 세션 공격 방지
				;
		
	}
	
	
}
