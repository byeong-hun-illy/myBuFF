package com.buff.hdofc.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.buff.hdofc.mapper.HdofcFaqMapper;
import com.buff.hdofc.service.HdofcFaqService;
import com.buff.vo.FaqVO;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.hdofc.service.impl
* @fileName     : HdofcFaqServiceImpl.java
* @author       : 김현빈
* @date         : 2024.09.30
* @description  : Faq crud ServiceImpl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30               김현빈     	  			최초 생성
*/
@Service
public class HdofcFaqServiceImpl implements HdofcFaqService {
	
	@Inject
	HdofcFaqMapper hdofcFaqMapper;
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ의 모든 리스트 출력
	*/
	@Override
	public List<FaqVO> selectFaqList(Map<String, Object> map) {
		return this.hdofcFaqMapper.selectFaqList(map);
	}
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ리스트의 모든 갯수
	*/
	@Override
	public int faqTotalCnt(Map<String, Object> map) {
		return this.hdofcFaqMapper.faqTotalCnt(map);
	}
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ리스트 문의 유형의 각각 갯수
	*/
	@Override
	public Map<String, Object> tapMaxTotal() {
		return this.hdofcFaqMapper.tapMaxTotal();
	}
	
	/**
	* @methodName  : selectFaqDetail
	* @author      : 김현빈
	* @date        : 2024.10.01
	* @param 	   : 
	* @return      : FAQ 상세보기 Detail
	*/
	@Override
	public FaqVO selectFaqDetail(String faqSeq) {
		return this.hdofcFaqMapper.selectFaqDetail(faqSeq);
	}
	
	/**
	 * @methodName  : updateFaqDetail
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ 상세보기 update
	 */
	@Override
	public int updateFaqDetail(FaqVO faqVO) {
		return this.hdofcFaqMapper.updateFaqDetail(faqVO);
	}
	
	/**
	 * @methodName  : insertFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ insert 등록
	 */
	@Override
	public int insertFaqList(FaqVO faqVO) {
		return this.hdofcFaqMapper.insertFaqList(faqVO);
	}
	
	/**
	 * @methodName  : insertFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ insert 등록시 출력한 관리자 명
	 */
	@Override
	public MemberVO selectMbrNm(String mbrId) {
		return this.hdofcFaqMapper.selectMbrNm(mbrId);
	}
	
	/**
	 * @methodName  : deleteFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.17
	 * @param 	   : 
	 * @return      : FAQ 삭제
	 */
	@Override
	public int deleteFaq(String faqSeq) {
		return this.hdofcFaqMapper.deleteFaq(faqSeq);
	}
	
}
