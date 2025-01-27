package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.FaqVO;
import com.buff.vo.MemberVO;

/**
* @packageName  : com.buff.hdofc.mapper
* @fileName     : HdofcFaqMapper.java
* @author       : 김현빈
* @date         : 2024.09.30
* @description  : Faq crud Mapper
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.30               김현빈     	  			최초 생성
*/
public interface HdofcFaqMapper {
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ의 모든 리스트 출력
	*/
	public List<FaqVO> selectFaqList(Map<String, Object> map);
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ리스트의 모든 갯수
	*/
	public int faqTotalCnt(Map<String, Object> map);
	
	/**
	* @methodName  : selectFaqList
	* @author      : 김현빈
	* @date        : 2024.09.30
	* @param 	   : 
	* @return      : FAQ리스트 문의 유형의 각각 갯수
	*/
	public Map<String, Object> tapMaxTotal();
	
	/**
	 * @methodName  : selectFaqDetail
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ 상세보기 Detail
	 */
	public FaqVO selectFaqDetail(String faqSeq);
	
	/**
	 * @methodName  : updateFaqDetail
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ 상세보기 update
	 */
	public int updateFaqDetail(FaqVO faqVO);
	
	/**
	 * @methodName  : insertFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ insert 등록
	 */
	public int insertFaqList(FaqVO faqVO);
	
	/**
	 * @methodName  : insertFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.01
	 * @param 	   : 
	 * @return      : FAQ insert 등록시 출력한 관리자 명
	 */
	public MemberVO selectMbrNm(String mbrId);
	
	/**
	 * @methodName  : deleteFaqList
	 * @author      : 김현빈
	 * @date        : 2024.10.17
	 * @param 	   : 
	 * @return      : FAQ 삭제
	 */
	public int deleteFaq(String faqSeq);
	
}
