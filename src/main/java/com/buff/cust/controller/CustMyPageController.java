
/**
 * 
 고객이 로그인 했을 때만 사용할 수 있는 화면 controller
 
마이페이지에서 조회할 수 잇는 보유 쿠폰 조회, 나의 정보 수정, 가맹지점 상담 조회, 주문 내역 조회  * 
* @packageName  : com.buff.controller.cust
* @fileName     : CustMyPageController.java
* @author       : 
* @date         : 2024.09.13
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/

package com.buff.cust.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cust.mapper.CustMyPageMapper;
import com.buff.cust.service.CustMyPageService;
import com.buff.vo.EventVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MemberVO;
import com.buff.vo.OrdrVO;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;


@PreAuthorize("hasRole('ROLE_CUST')")
@Slf4j
@RequestMapping("/custPage")
@Controller
public class CustMyPageController {
	
	@Autowired
	CustMyPageService myPageService;
	
	@Autowired
	CustMyPageMapper myPageMapper;
	
	/*
	<bean id="bcryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" />
	 */
	@Autowired
	private PasswordEncoder bcryptPasswordEncoder;
	
	
	
	/**
	* @methodName  : home
	* @author      : 서윤정
	* @date        : 2024.09.12
	* @param : BzentVO
	* @return 고객 페이지 전체 리스트, 마이페이지 변경으로 안씀.
	*/
	@GetMapping("/myPageMain")
	public String myPageMain(Principal principal, Model model) {
		
		String mbrId = principal.getName();
		log.info("myPageMain -> mbrId :" + mbrId);
		
		List<QsVO> qsVOList = myPageService.myQs(mbrId);
		log.info("myPageMain -> qsVOList : " + qsVOList);
		
		List<FrcsDscsnVO> frcsDscsnVOList = myPageService.myDscsn(mbrId);
		log.info("myPageMain -> frcsDscsnVOList : " + frcsDscsnVOList);
		
		List<OrdrVO> ordrVOList = myPageService.myOrdr(mbrId);
		log.info("myPageMain -> OrdrVOList : " + ordrVOList);
		 
		List<EventVO> eventVOList = myPageService.myCoupon(mbrId);
		log.info("myPageMain -> eventVOList : " + eventVOList);
		
		
		model.addAttribute("qsVOList",qsVOList);
		model.addAttribute("frcsDscsnVOList",frcsDscsnVOList);
		model.addAttribute("ordrVOList",ordrVOList);
		model.addAttribute("eventVOList",eventVOList);
		
		
		return "cust/custPage/myPageMain";
	}
		
	/**
	* @methodName  : selectMyPage
	* @author      : 정기쁨
	* @date        : 2024.10.07
	* @param : BzentVO
	* @return 고객 마이페이지 전체 정보
	*/
	  @GetMapping("/selectMyPage")
		public String selectMyPage(Principal principal, Model model) {
			
			String mbrId = principal.getName();
			log.info("myPageMain -> mbrId :" + mbrId);
			
			//1. 문의 내역
			List<QsVO> qsVOList = myPageService.myQs(mbrId);
			log.info("myPageMain -> qsVOList : " + qsVOList);
			
			//2. 가맹 상담
			List<FrcsDscsnVO> frcsDscsnVOList = myPageService.myDscsn(mbrId);
			log.info("myPageMain -> frcsDscsnVOList : " + frcsDscsnVOList);
			
			//3. 주문
			List<OrdrVO> ordrVOList = myPageService.myOrdr(mbrId);
			log.info("myPageMain -> OrdrVOList : " + ordrVOList);
			
			//4. 쿠폰
			List<EventVO> eventVOList = myPageService.myCoupon(mbrId);
			log.info("myPageMain -> eventVOList : " + eventVOList);
			
			//5. 관심 매장
			MemberVO memberVOList = myPageService.myStore(mbrId);
			log.info("myPageMain -> memberVOList : " + memberVOList);
			
			model.addAttribute("qsVOList",qsVOList);
			model.addAttribute("frcsDscsnVOList",frcsDscsnVOList);
			model.addAttribute("ordrVOList",ordrVOList);
			model.addAttribute("eventVOList",eventVOList);
			model.addAttribute("memberVOList",memberVOList);
			
			return "cust/custPage/selectMyPage";
		}
	  	
	  /**
		* @methodName  : couponListAjax
		* @author      : 서윤정
		* @date        : 2024.10.07
		* @param : 
		* @return 고객 마이페이지 - 쿠폰 조회
		*/
	    @ResponseBody
		@PostMapping("/selectCouponListAjax")
		public List<EventVO> selectCouponListAjax(Principal principal){
			
			String mbrId = principal.getName();
			log.info("selectCouponListAjax -> mbrId :" + mbrId);
			
			//1. 쿠폰
			List<EventVO> eventVOList = myPageService.myCoupon(mbrId);
			log.info("couponListAjax -> eventVOList : " + eventVOList);
			
			return eventVOList;
		}
	    
	    /**
		* @methodName  : orderListAjax
		* @author      : 서윤정
		* @date        : 2024.10.07
		* @param : 
		* @return 고객 마이페이지 - 주문 내역 조회 (6개월)
		*/
	    @ResponseBody
		@PostMapping("/selectOrderListAjax")
		public List<OrdrVO> selectOrderListAjax(Principal principal){
			
			String mbrId = principal.getName();
			log.info("selectOrderListAjax -> mbrId :" + mbrId);
			
			//1. 쿠폰
			List<OrdrVO> ordrVOList = myPageService.myOrdr(mbrId);
			log.info("myPageMain -> OrdrVOList : " + ordrVOList);
			
			
			return ordrVOList;
		}
	    
	    
	    /**
	  		* @methodName  : myStoreListAjax
	  		* @author      : 서윤정
	  		* @date        : 2024.10.07
	  		* @param : 
	  		* @return 고객 마이페이지 - 관심 매장 조회
	  		*/
	    @ResponseBody
		@PostMapping("/selectMyStoreListAjax")
		public MemberVO selectMyStoreListAjax(Principal principal){
			
			String mbrId = principal.getName();
			log.info("selectMyStoreListAjax -> mbrId :" + mbrId);
			
			MemberVO memberVOList = myPageService.myStore(mbrId);
			log.info("myPageMain -> memberVOList : " + memberVOList);
			
			return memberVOList;
		}
	
	   
    /**
	* @methodName  : myStoreListAjax
	* @author      : 서윤정
	* @date        : 2024.10.07
	* @param : 
	* @return 고객 마이페이지 - 가맹점 상담 내역 조회
	*/
    @ResponseBody
	@PostMapping("/selectMyDscsnListAjax")
	public List<FrcsDscsnVO> selectMyDscsnListAjax(Principal principal){
		
		String mbrId = principal.getName();
		log.info("selectMyDscsnListAjax -> mbrId :" + mbrId);
		
		List<FrcsDscsnVO> frcsDscsnVOList = myPageService.myDscsn(mbrId);
		log.info("selectMyDscsnListAjax -> frcsDscsnVOList : " + frcsDscsnVOList);
		
		return frcsDscsnVOList;
	}
    
    /**
	* @methodName  : myStoreListAjax
	* @author      : 서윤정
	* @date        : 2024.10.07
	* @param : 
	* @return 고객 마이페이지 - 문의 내역 조회
	*/
	@ResponseBody
	@PostMapping("/selectMyQsListAjax")
	public List<QsVO> selectMyQsListAjax(Principal principal){
		
		String mbrId = principal.getName();
		log.info("selectMyQsListAjax -> mbrId :" + mbrId);
		
		List<QsVO> qsVOList = myPageService.myQs(mbrId);
		log.info("selectMyQsListAjax -> qsVOList : " + qsVOList);
		
		return qsVOList;
	}
    
    
	  /**
		* @methodName  : chageCustInfoAjax
		* @author      : 서윤정
		* @date        : 2024.10.08
		* @param : 
		* @return 고객 마이페이지 - 개인정보 수정
		*/
	@PostMapping("/updateCustInfoAjax")
    @ResponseBody
	public int updateCustInfoAjax(Principal principal,
			@RequestBody MemberVO memberVO) {
	
		log.info("updateCustInfoAjax -> memberVO : " + memberVO);
		
		String tempPswd = memberVO.getMbrPswd();
		
		// 임시 비밀번호를 암호화
		String mbrPswd = bcryptPasswordEncoder.encode(tempPswd);
		log.info("updateCustInfoAjax->mbrPswd : " + mbrPswd);
		
		memberVO.setMbrPswd(mbrPswd);
		
		log.info("updateCustInfoAjax -> memberVO(비밀번호인코딩후) : " + memberVO);
		
		int result = myPageService.changeCustInfoAjax(memberVO);
		log.info("회원 정보 수정 작업 -> memberVO : " + memberVO);

    	return result;
    }
    
    
	  /**
		* @methodName  : updateMbrAjax
		* @author      : 서윤정
		* @date        : 2024.10.07
		* @param : 
		* @return 고객 마이페이지 - 회원 탈퇴 
		*/
	@PostMapping("/updateMbrAjax")
	@ResponseBody
	public int updateMbrAjax(Principal principal) {
		
		String mbrId = principal.getName();
		log.info("updateMbrAjax -> mbrId " + mbrId);
		
		int result = myPageService.updateMbrAjax(mbrId);
		log.info("updateMbrAjax -> result " + result);
		
		return result;
	}
    
	 /**
	* @methodName  : deleteLikeStoreAjax
	* @author      : 서윤정
	* @date        : 2024.10.07
	* @param : 
	* @return 고객 마이페이지 - 관심 매장 삭제
	*/
    @PostMapping("/deleteLikeStoreAjax")
    @ResponseBody
    public int deleteLikeStoreAjax(	@RequestParam(value="frcsNo", required = false, defaultValue = "") String frcsNo ,Principal principal ) {
    	
    	String mbrId = principal.getName();
    	
    	int result = myPageService.deleteLikeStoreAjax(mbrId, frcsNo);
    	
    	
    	return result;
    }
    
    
    
    
}
