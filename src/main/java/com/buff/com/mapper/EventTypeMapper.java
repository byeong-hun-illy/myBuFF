package com.buff.com.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
* @packageName  : com.buff.com.mapper
* @fileName     : ComMapper.java
* @author       : 정기쁨
* @date         : 2024.10.17
* @description  : 이벤트 타입 변경에 사용
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.17        정기쁨              최초생성
*/
@Mapper
public interface EventTypeMapper {
	
	/**
	* @methodName  : updateExpected
	* @author      : 정기쁨
	* @date        : 2024.10.17
	* @return      : 매일 자정에 현재 날짜와 비교하여 EVT03(예정)로 타입 변경
	*/
	public void updateExpected();
	
	/**
	 * @methodName  : updateProgress
	 * @author      : 정기쁨
	 * @date        : 2024.10.17
	 * @return      : 매일 자정에 현재 날짜와 비교하여 EVT04(진행)로 타입 변경
	 */
	public void updateProgress();
	
	/**
	 * @methodName  : updateEnd
	 * @author      : 정기쁨
	 * @date        : 2024.10.17
	 * @return      : 매일 자정에 현재 날짜와 비교하여 EVT05(종료)로 타입 변경
	 */
	public void updateEnd();

}
