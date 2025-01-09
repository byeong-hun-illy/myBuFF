package com.buff.cust.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.cust.mapper.CustCenterMapper;
import com.buff.cust.mapper.MemberMapper;
import com.buff.cust.service.CustCenterService;
import com.buff.cust.service.CustHomeService;
import com.buff.cust.service.CustMyPageService;
import com.buff.util.UploadController;
import com.buff.vo.BzentVO;
import com.buff.vo.CouponVO;
import com.buff.vo.FrcsDscsnVO;
import com.buff.vo.MenuVO;
import com.buff.vo.QsVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 고객이 로그인 했을 때만 사용할 수 있는 화면 controller
 
 가맹점 상담 신청, 주문시 가맹점 조회, 가맹점 메뉴 조회 , 모달을 사용 사용했을 때, getTotal로 가맹점 갯수 확인
 * 
* @packageName  : com.buff.controller.cust
* @fileName     : CustController.java
* @author       : 
* @date         : 2024.09.13
* @description  :
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.13        이름     	  			최초 생성
*/

@PreAuthorize("hasRole('ROLE_CUST')")
@Slf4j
@RequestMapping("/cust")
@Controller
public class CustMemberController {
	
	@Autowired
	CustCenterService centerService;
	
	@Autowired
	CustMyPageService myPageService;
	
	@Autowired
	CustCenterMapper centerMapper;
	
	@Autowired
	CustHomeService HomeServcie;
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	UploadController uploadController;
	
	/**
	 * @methodName  : selectMenu
	 * @author      : 서윤정
	 * @date        : 2024.09.12
	 * @param :  
	 * @return  주문 메뉴
	 */

	@GetMapping("/selectMenu")
	public String selectMenu() {
		
		return "cust/main/selectMenu";
	}
	
	
	

	/**
	 * @methodName  : insertDscsnPost
	 * @author      : 서윤정
	 * @date        : 2024.09.20
	 * @param : BzentVO
	 * @return  가맹점 상담 신청, 중복 확인 
	 */
	@PostMapping("/insertDscsnPost")
	@ResponseBody
	public int insertDscsnPost( @RequestBody FrcsDscsnVO frcsDscsnVO,  Principal principal) {

		log.info("insertDscsnPost->frcsDscsnVO : " + frcsDscsnVO);
		
		String mbrId = principal.getName();
		log.info("insertDscsnPost -> : " + mbrId);
		
		// 중복 확인 
		int cnt = HomeServcie.checkId(mbrId);
		log.info("cnt : " + cnt);
		
		int result = 0;		
		
		if(cnt<1) {
		    try {
		        result = HomeServcie.insertDscsnPost(frcsDscsnVO);
		        return result; 
		    } catch (Exception e) {
		        return 0; 
		    }
		}else {
			return 3;
		}
	}
	
	
	/**
	 * @methodName  : insertOrdr
	 * @author      : 서윤정
	 * @date        : 2024.09.12
	 * @param : BzentVO
	 * @return 고객 _ 주문 시 가맹점 조회,
	 * 모달로 표현시, 가맹점 전체 갯수 조회 가능, 카드로 가맹점의 정보 조회
	 * 
	 */
	@GetMapping("/insertOrdr")
	public String insertOrdr(@RequestParam Map<String, Object> map, Model model) {

		List<BzentVO> bzentVOList = HomeServcie.selectOrdrStore(map);
		
		int total = HomeServcie.getTotal(map);
		log.info("selectStore -> total :" + total);
		 
		model.addAttribute("bzentVOList", bzentVOList);
		model.addAttribute("total", total);

		return "cust/main/insertOrdr";
	}
	
	
	/**
	 * @methodName  : selectFrcsAjax
	 * @author      : 서윤정
	 * @date        : 2024.09.12
	 * @param : BzentVO
	 * @return 
	 *  모달 x, 가맹점을 선택하는 ajax 
	 */
  @ResponseBody
  @PostMapping("/selectFrcsAjax") 
  public Map<String,Object> selectFrcsAjax(
		  @RequestParam(value="rgnNo",required=false,defaultValue="") String rgnNo, 
		  @RequestParam(value="keyword",required=false,defaultValue="") String keyword,
		  Model model) {

	  log.info("selectRgnAjax->rgnNo : " + rgnNo);

	  log.info("selectRgnAjax->keyword : " + keyword);
	  
	  Map<String,Object> map = new HashMap<String, Object>();
	  map.put("rgnNo", rgnNo);
	  map.put("keyword", keyword);
	  
	  List<BzentVO> bzentVOList = HomeServcie.selectOrdrStore(map);
	  
	  int total = HomeServcie.getTotal(map); 
	  log.info("selectStore -> total :" + total);
	  
	  map.put("bzentVOList", bzentVOList); 
	  map.put("total",total);
	  
	  return map; 
  }
 
	
  /**
	* @methodName  : selectStore
	* @author      : 서윤정
	* @date        : 2024.09.12
	* @param : BzentVO
	* @return 본사 메뉴 조회
	*/
  @PostMapping("/selectOrdrMenuAjax")
  @ResponseBody
  public Map<String, Object> selectOrdrMenuAjax(
          @RequestParam(value = "bzentNo", required = false, defaultValue = "") String bzentNo,
          @RequestParam(value = "menuGubun", required = false, defaultValue = "") String menuGubun) {

      log.info("menuGubun : " + menuGubun);
      log.info("bzentNo : " + bzentNo);

      
      Map<String, Object> map = new HashMap<>();
      map.put("menuGubun", menuGubun);
      map.put("bzentNo", bzentNo);

      // 메뉴 목록 조회
      List<MenuVO> menuVOList = this.HomeServcie.selectOrdrMenu(map);
      log.info("selectOrdrMenuAjax -> menuVOList : " + menuVOList);

      map.put("menuVOList", menuVOList);
      
      return map;
  }


  
  
  
  /**
	* @methodName  : insertEventCoupon
	* @author      : 서윤정
	* @date        : 2024.10.01
	* @param : mbrId
	* @return 이벤트 - 쿠폰 발급 (중복체크)
	*
	*/

  @PostMapping("/insertEventCouponPost")
  @ResponseBody
  public Map<String, Object> insertEventCouponPost( @RequestBody CouponVO couponVO) {

      log.info("insertEventCouponPost -> couponVO: " + couponVO);

      String mbrId = couponVO.getMbrId(); 
      String couponCode = couponVO.getCouponCode(); 
      log.info("insertEventCouponPost -> mbrId: " + mbrId + ", couponCode: " + couponCode);

      Map<String, Object> map = new HashMap<>();
      map.put("mbrId", mbrId);
      map.put("couponCode", couponCode); 
      log.info("insertEventCouponPost -> map: " + map);

      // 쿠폰이 있는지 체크->있으면 1
      int cnt = HomeServcie.chkCoupon(map);
      log.info("insertEventCouponPost -> cnt: " + cnt);

      Map<String, Object> response = new HashMap<>();

      if (cnt > 0) {
          // 쿠폰이 중복되는 경우
          response.put("isDuplicate", "Y");
          response.put("message", "이미 발급된 쿠폰입니다.");
      } else {
          // 쿠폰을 발급하는 경우
          int result = HomeServcie.insertEventCouponPost(map);
          log.info("insertEventCouponAjax -> result: " + result);

          response.put("isDuplicate", "N");
          response.put("message", "쿠폰 발급이 완료되었습니다.");
      }

      return response; 
  }
  
  @PostMapping("/dupChkEventCouponPost")
  @ResponseBody
  public Map<String, Object> dupChkEventCouponPost(
		  @RequestBody CouponVO couponVO) {
	  
	  log.info("insertEventCouponPost -> couponVO: " + couponVO);
	  
	  String mbrId = couponVO.getMbrId(); 
	  String couponCode = couponVO.getCouponCode();
	  log.info("insertEventCouponPost -> mbrId: " + mbrId + ", couponCode: " + couponCode);
	  
	  Map<String, Object> map = new HashMap<>();
	  map.put("mbrId", mbrId); 
	  map.put("couponCode", couponCode);
	  log.info("insertEventCouponPost -> map: " + map);
	  
	  // 쿠폰이 있는지 체크->있으면 1
	  int cnt = HomeServcie.chkCoupon(map);
	  log.info("insertEventCouponPost -> cnt: " + cnt);
	  
	  Map<String, Object> response = new HashMap<>();
	  
	  if (cnt > 0) {
		  // 쿠폰이 중복되는 경우
		  response.put("isDuplicate", "Y");
		  response.put("message", "이미 발급된 쿠폰입니다.");
	  } 
	  
	  return response; 
  }

  /**
	* @methodName  : insertEventCoupon
	* @author      : 서윤정
	* @date        : 2024.10.01
	* @param : mbrId
	* @return 관심 매장 등록
	*/
  @PostMapping("/selectStoreAjax")
  @ResponseBody
  public Map<String, Object> selectStoreAjax(@RequestParam(value="bzentNo") String bzentNo, Principal principal) {
      String mbrId = principal.getName();
      Map<String, Object> response = new HashMap<>();
      
      Map<String,Object> map = new HashMap<>();
      map.put("mbrId", mbrId);
      map.put("bzentNo", bzentNo);
      log.info("selectStoreAjax -> bzentNo : " + bzentNo);
      
      
      int cnt = HomeServcie.chkLikeStore(map);
      int result =0;
      
      log.info("selectStoreAjax -> cnt : " + cnt);
      
      if (cnt > 0) {
    	  result = HomeServcie.deleteLikeStore(map);
    	  log.info("deleteLikeStore -> result : " + result);
          response.put("isDuplicate", "N");
      } else {
          result = HomeServcie.insertLikeStore(map);
          log.info("insertLikeStore -> result : " + result);
          response.put("isDuplicate", "Y");
      }
      
      return response; 
  }

  
  /**
 	* @methodName  : selectQsDetail
 	* @author      : 서윤정
 	* @date        : 2024.10.01
 	* @param : mbrId
 	* @return 문의상세 조회 _ 회원이어야지 볼 수 있음.
 	*/
	  
	  @GetMapping("/selectQsDetail")
	  	public String selectQsDetail(Model model, Principal principal, @RequestParam(value="qsSeq") String qsSeq  ) {
		  
		  log.info("selectQsDetail -> qsSeq : {}", qsSeq);
		  
	      String mbrId = principal.getName();
	      
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("qsSeq", qsSeq);
	      map.put("mbrId", mbrId);
	      
	      QsVO qsVO = centerService.selectQsDetail(map);
	      log.info("selectQsDetail -> qsVO : ", qsVO);
	      
	      model.addAttribute("qsVO",qsVO);
	      return "cust/custCenter/selectQsDetail";
	  }
  
	  /**
		 * @methodName  : selectStore
		 * @author      : 서윤정
		 * @date        : 2024.09.12
		 * @param : qsVO
		 * @return 고객센터 - 문의 게시글 작성
		 */
		
		@PostMapping("/insertQsPostAjax")
		@ResponseBody
		public int insertQsPostAjax(@ModelAttribute QsVO qsVO ) {
			
			log.info("insertQsPostAjax->qsVO : " + qsVO);
			
			int result = this.centerService.insertQsPostAjax(qsVO);

			return result;
		}
		
		/**
		* @methodName  : updateQsAjax
		* @author      : 서윤정
		 * @param qsVO 
		* @date        : 2024.10.11
		* @return : 고객센터 - 문의 사항 수정 
		*/
		@PostMapping("/updateQsAjax")
		@ResponseBody
		public int updateQsAjax(Principal principal, @ModelAttribute QsVO qsVO) {
			
			String mbrId = principal.getName();
			qsVO.setMbrId(mbrId);

			log.info("updateQsAjax -> mbrId : " + mbrId);
			log.info("updateQsAjax -> qsVO : " + qsVO);
			
			int result = this.centerService.updateQsAjax(qsVO);
			
			return result;
		}
		
		
		/**
		* @methodName  : deleteQsAjax
		* @author      : 서윤정
		 * @param qsVO 
		* @date        : 2024.10.11
		* @return : 고객센터 - 문의 사항 삭제 
		*/
		@PostMapping("/deleteQsAjax")
		@ResponseBody
		public int deleteQsAjax(@RequestBody String qsSeq ) {
			
			log.info("deleteQsAjax -> qsSeq : " + qsSeq);
			
			int result = this.centerService.deleteQsAjax(qsSeq);
			
			return result;
		}
		
		
		
		/**
		* @methodName  : deleteQsAjax
		* @author      : 서윤정
		 * @param qsVO 
		* @date        : 2024.10.12
		* @return : 고객센터 - 문의 사항 파일  삭제 
		*/
		@PostMapping("/updateFileAjax")
		@ResponseBody
		public int updateFileAjax(@RequestBody String qsSeq ) {
			
			log.info("updateFileAjax -> qsSeq : " + qsSeq);
			
			int result = this.centerService.updateFileAjax(qsSeq);
			
			return result;
		}
		
		
		
  	
}







