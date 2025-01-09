package com.buff.com.mapper;

import com.buff.vo.FileDetailVO;
import com.buff.vo.FileGroupVO;

public interface FileGroupMapper {

	//sqlSessionTemplate을 안씀
	
	//FILE_GROUP 테이블에 insert
	//<insert id="insertFileGroup" parameterType="fileGroupVO">
	public int insertFileGroup(FileGroupVO fileGroupVO);

	//FILE_DETAIL 테이블에 insert
	public int insertFileDetail(FileDetailVO fileDetailVO);
}
