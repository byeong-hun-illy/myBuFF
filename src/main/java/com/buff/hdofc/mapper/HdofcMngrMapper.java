package com.buff.hdofc.mapper;

import java.util.List;
import java.util.Map;

import com.buff.vo.BzentVO;
import com.buff.vo.MngrVO;

public interface HdofcMngrMapper {
	
	public int selectAll();
	public List<MngrVO> selectBoxMngr();
	public List<BzentVO> selectBoxFrcs();
	public List<BzentVO> selectBoxCntp();
	public int selectTotalMngrList(Map<String, Object> map);
	public List<MngrVO> selectMngrList(Map<String, Object> map);


}
