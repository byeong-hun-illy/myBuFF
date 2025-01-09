package com.buff.cnpt.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.cnpt.mapper.CnptGdsMapper;
import com.buff.cnpt.service.CnptGdsService;
import com.buff.com.mapper.ComMapper;
import com.buff.vo.ComVO;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cnpt.service.impl
* @fileName     : CnptGdsServiceImpl.java
* @author       : 이병훈
* @date         : 2024.09.23
* @description  : 거래처 상품 재고 관련 서비스 Impl
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.09.23        이병훈     	  			최초 생성
*/

@Slf4j
@Service
public class CnptGdsServiceImpl implements CnptGdsService {
	
	@Autowired
	CnptGdsMapper cnptGdsMapper;
	
	@Autowired
	ComMapper comMapper;
	
	
	/**
	* @methodName  : selectGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param 	   : 검색 조건
	* @return      : 거래처 상품 재고 현황
	*/
	@Override
	public List<GdsVO> selectCnptGds(Map<String, Object> map) {
		return this.cnptGdsMapper.selectCnptGds(map);
	}
	
	/**
	* @methodName  : downloadExcel
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param 	   : 서버 응답
	* @return      : 엑셀 다운로드 
	*/
	@Override
	public void downloadExcel(HttpServletResponse response, String bzentNo) {
		try {
	    
	    // 1. Workbook 생성(XLSX 형식)
	    Workbook workbook = new XSSFWorkbook();
	    Sheet sheet = workbook.createSheet("재고 현황");
	    
	    // 2. 헤더 설정
	    Row headerRow = sheet.createRow(0);
	    String[] columns = {"번호", "상품명", "수량", "단위", "상품 단가"};
	    
	    for (int i=0; i< columns.length; i++) {
	    	Cell cell = headerRow.createCell(i);
	    	cell.setCellValue(columns[i]);
	    }
	    
	    // 3. 데이터 가져오기 -
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("bzentNo", bzentNo);
	    List<GdsVO> gdsList = this.cnptGdsMapper.selectExcel(map);
	    
	    // 데이터가 잘 들어왔는지 파악하기
	    if(gdsList == null || gdsList.isEmpty()) {
	    	log.warn("조회된 데이터가 없습니다.");
	    } else {
	    	log.info("조회된 데이터 개수 : " + gdsList.size());
	    }
	    
	    // 4. 데이터 행 생성
	    int rowNum = 1;
	    for(GdsVO gds : gdsList) {
	    	Row row = sheet.createRow(rowNum++);
	    	row.createCell(0).setCellValue(gds.getRnum());
	    	row.createCell(1).setCellValue(gds.getGdsNm());
	    	row.createCell(2).setCellValue(gds.getStockVOList().get(0).getQty());
	    	row.createCell(3).setCellValue(gds.getUnitNm());
	    	row.createCell(4).setCellValue(gds.getStockVOList().get(0).getGdsAmtVOList().get(0).getAmt());
	    	
	    	// stockVOList가 null인지 확인
	    	if(gds.getStockVOList() != null && !gds.getStockVOList().isEmpty()) {
	    		row.createCell(2).setCellValue(gds.getStockVOList().get(0).getQty());
	    		row.createCell(4).setCellValue(gds.getStockVOList().get(0).getGdsAmtVOList().get(0).getAmt());
	    	} else {
	    		row.createCell(2).setCellValue("데이터 없음");
	    		row.createCell(4).setCellValue("데이터 없음");
	    	}
	    	
	    }
	    
	    // 5. 자동 너비 조정
	    for(int i=0; i<columns.length; i++) {
	    	sheet.autoSizeColumn(i);
	    }
	    // 엑셀 파일의 확장자와 Content-Type 설정
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment; filename=\"gdsStockList.xlsx\"");
	    
	    // 6. 엑셀 파일을 response의 OutputStream에 작성
			workbook.write(response.getOutputStream());
			workbook.close();
			
		} catch (IOException e) {
			e.printStackTrace();
			log.error("Excel download error: ", e);
		    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	    

	}
	/**
	* @methodName  : selectTotalGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param 	   : 검색 조건
	* @return      : 검색조건 페이지 총 갯수
	*/
	@Override
	public int selectTotalGds(Map<String, Object> map) {
		return this.cnptGdsMapper.selectTotalGds(map);
	}

	/**
	* @methodName  : selectAllGds
	* @author      : 이병훈
	* @date        : 2024.09.23
	* @param 	   : 검색 조건
	* @return      : 전체 상품 수
	*/
	@Override
	public int selectAllGds(Map<String, Object> map) {
		return this.cnptGdsMapper.selectAllGds(map);
	}
	
	/**
	* @methodName  : hasStock
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param 	   : 상품 코드
	* @return      : 해당 거래처 재고 유무 확인
	*/
	@Override
	public boolean hasStock(String bzentNo) {
		int result = this.cnptGdsMapper.selectHasStock(bzentNo);
		log.info("재고 갯수 {} : "+ result);
		
		return result > 0;
	}

	@Override
	public List<ComVO> selectGdsType(String bzentType) {
		return this.cnptGdsMapper.selectGdsType(bzentType);
	}

	/**
	* @methodName  : selectBzentType
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param 	   : 상품 코드
	* @return      : 상품 유형 확인
	*/
	@Override
	public String selectBzentType(String bzentNo) {
		return this.cnptGdsMapper.selectBzentType(bzentNo);
	}
	
	/**
	* @methodName  : selectGdsDtl
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param 	   : 재고 정보가 담긴 VO객체
	* @return      : 상품 상세 페이지
	*/
	@Override
	public GdsVO selectGdsDtl(StockVO stockVO) {
		return this.cnptGdsMapper.selectGdsDtl(stockVO);
	}
	
	/**
	* @methodName  : selectUpdateChk
	* @author      : 이병훈
	* @date        : 2024.09.26
	* @param 	   : 재고 정보가 담긴 VO객체
	* @return      : 상품 수정을 할수 있는지 여부 확인
	*/
	@Override
	public int selectUpdateChk(StockVO stockVO) {
		return this.cnptGdsMapper.selectUpdateChk(stockVO);
	}

	/**
	* @methodName  : updateGds
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param 	   : 상품 정보가 담긴 VO객체
	* @return      : 상품 수정
	*/
	@Override
	public int updateGds(GdsVO gdsVO) {
		return this.cnptGdsMapper.updateGds(gdsVO);
	}

	/**
	* @methodName  : insertStock
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param 	   : 단가 정보가 담긴 gdsAmtVO 객체
	* @return      : 단가 추가 시 선행 작업, stock테이블에 추가
	*/
	@Override
	public int insertStock(GdsAmtVO gdsAmtVO) {
		return this.cnptGdsMapper.insertStock(gdsAmtVO);
	}
	
	/**
	* @methodName  : updateGdsAmt
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param 	   : 단가 정보가 담긴 gdsAmtVO 객체
	* @return      : 단가 추가
	*/
//	@Override
//	public int insertGdsAmt(GdsAmtVO gdsAmtVO) {
//		return this.cnptGdsMapper.insertGdsAmt(gdsAmtVO);
//	}
	
	/**
	* @methodName  : updateNtsl
	* @author      : 이병훈
	* @date        : 2024.09.27
	* @param 	   : 판매상태유형 변경 정보가 담긴 stockVO 객체
	* @return      : 판매상태 유형 변경
	*/
	@Override
	public int updateNtsl(StockVO stockVO) {
		return this.cnptGdsMapper.updateNtsl(stockVO);
	}
	
	/**
	* @methodName  : insertGds
	* @author      : 이병훈
	* @date        : 2024.09.28
	* @param 	   : 상품 정보가 담긴 VO 객체
	* @return      : 상품테이블에 상품 추가
	*/
	@Override
	public int insertGds(GdsVO gdsVO) {
		return this.comMapper.insertGds(gdsVO);
	}
	
	/**
	* @methodName  : insertGdsAmt
	* @author      : 이병훈
	* @date        : 2024.09.28
	* @param 	   : 상품 단가 정보가 담긴 VO 객체
	* @return      : 상품 단가테이블에 단가 추가
	*/
	@Override
	public int insertGdsAmt(GdsAmtVO gdsAmtVO) {
		return this.comMapper.insertGdsAmt(gdsAmtVO);
	}
	
	/**
	* @methodName  : insertAllGds
	* @author      : 이병훈
	* @date        : 2024.09.30
	* @param 	   : 상품 단가 정보가 담긴 VO 객체
	* @return      : gds와 gdsAmt를 동시에 처리
	*/
	@Transactional
	public String insertAllGds(Map<String, Object> map) {
		ObjectMapper objMapper = new ObjectMapper();
		int chk = 0;
		
		// Map데이터를 VO로 변환
		GdsVO gdsVO = objMapper.convertValue(map.get("gdsVO"), GdsVO.class);
		GdsAmtVO gdsAmtVO = objMapper.convertValue(map.get("gdsAmtVO"), GdsAmtVO.class);
		
		// 상품 추가(comMapper)
		chk += this.insertGds(gdsVO);
		String gdsCode = gdsVO.getGdsCode();
		
		if(gdsAmtVO.getAmt()!=0) {
			gdsAmtVO.setGdsCode(gdsCode);
			// 재고 추가
			this.insertStock(gdsAmtVO);
			// 단가 추가(comMapper)
			this.insertGdsAmt(gdsAmtVO);
		}
		return gdsCode;
	}
	
	/**
	* @methodName  : updateAllStock
	* @author      : 이병훈
	* @date        : 2024.09.30
	* 판매상태 유형과 단가 추가
	*/
	@Transactional
	public int updateAllStock(Map<String, Object> map) {
		ObjectMapper objMapper = new ObjectMapper();
		
		// Map데이터를 VO 데이터로 변환
		StockVO stockVO = objMapper.convertValue(map.get("stockVO"), StockVO.class);
		GdsAmtVO gdsAmtVO = objMapper.convertValue(map.get("gdsAmtVO"), GdsAmtVO.class);
		
		// 상품코드로 해당하는 재고가 있는지 확인하는 코드
		int chk = this.selectUpdateChk(stockVO);
		if(chk==0) {
			this.insertStock(gdsAmtVO);
		}
		
		if(gdsAmtVO.getAmt()!=0) {
			//gdsAmtVO(bzentNo, gdsCode, amt) 단가 변경
			chk = this.insertGdsAmt(gdsAmtVO);
		}
		 // bzentNo, gdsCode, ntslType 판매 상태 변경
		chk += this.updateNtsl(stockVO);
		return chk;
	}
	
	/**
	* @methodName  : deleteGds
	* @author      : 이병훈
	* @date        : 2024.09.30
	* 재고가 없을 때 상품 삭제
	*/
//	@Override
//	public int deleteGds(String gdsCode) {
//		return this.cnptGdsMapper.deleteGds(gdsCode);
//	}
	
	/**
	* @methodName  : deleteStock
	* @author      : 이병훈
	* @date        : 2024.10.01
	* 재고 테이블에서 상품 삭제
	*/
//	@Override
//	public int deleteStock(String gdsCode) {
//		return this.cnptGdsMapper.deleteStock(gdsCode);
//	}
	
	/**
	* @methodName  : deleteAll
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param gdsCode
	*/
	@Transactional
	public int deleteAll(Map<String, Object> map) {
		
		int cnt = this.cnptGdsMapper.deleteStockAjmt(map);
		
		cnt += this.cnptGdsMapper.deleteGdsAmt(map);
		
		cnt += this.cnptGdsMapper.deleteStock(map);
		
//		cnt += this.cnptGdsMapper.deleteGds(map);
		
		return cnt;
	}
	
	/**
	* @methodName  : selectSellingCnt
	* @author      : 이병훈
	* @date        : 2024.10.04
	* @param gdsCode
	* 판매중인 상품 총 갯수
	*/
	@Override
	public int selectSellingCnt(Map<String, Object> map) {
		return this.cnptGdsMapper.selectSellingCnt(map);
	}
	
	/**
	* @methodName  : selectNotSellingCnt
	* @author      : 이병훈
	* @date        : 2024.10.04
	* @param gdsCode
	* 미판매중인 상품 총 갯수
	*/
	@Override
	public int selectNotSellingCnt(Map<String, Object> map) {
		return this.cnptGdsMapper.selectNotSellingCnt(map);
	}

	
}
