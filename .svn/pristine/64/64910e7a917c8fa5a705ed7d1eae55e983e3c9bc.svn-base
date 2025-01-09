package com.buff.cnpt.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buff.cnpt.mapper.CnptStockMapper;
import com.buff.cnpt.service.CnptStockService;
import com.buff.vo.GdsAmtVO;
import com.buff.vo.GdsVO;
import com.buff.vo.StockAjmtVO;
import com.buff.vo.StockVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
* @packageName  : com.buff.cnpt.service.impl
* @fileName     : CnptStockServiceImpl.java
* @author       : 이병훈
* @date         : 2024.10.01
* @description  : 거래처 재고 관련 ServiceImpl 서비스
* ===========================================================
* DATE              AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.10.01        이병훈     	  			최초 생성
*/
@Slf4j
@Service
public class CnptStockServiceImpl implements CnptStockService {
	
	@Autowired
	CnptStockMapper cnptStockMapper;
	
	
	/**
	* @methodName  : insertStockQty
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param map
	* @return      : 재고 조정으로 추가 : 재고수량 추가와, 재고조정 테이블 insert
	*/
	@Transactional
	@Override
	public int insertStockQty(Map<String, Object> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		
		// Map 데이터를 VO로 변환
		StockVO stockVO = objectMapper.convertValue(map.get("stockVO"), StockVO.class);
		StockAjmtVO stockAjmtVO = objectMapper.convertValue(map.get("stockAjmtVO"), StockAjmtVO.class);
		
		log.info("stockVO : " +  stockVO);
		log.info("stockAjmtVO : " +  stockAjmtVO);
		
		int chk = 0;
		
		if(stockVO.getQty() !=0 ) {
			// stockVO(qty, gdsCode, bzentNo)
			chk = this.mergeStockQty(stockVO, stockAjmtVO.getAjmtType());
		} 
		// stockAjmtVO(AJMT_NO, GDS_CODE, BZENT_NO, AJMT_TYPE, QTY, AJMT_YMD, AJMT_RSN)
		chk += this.insertStockAjmt(stockAjmtVO);
		
		log.info("chk : " + chk);
		
		return chk;
	}
	
	/**
	* @methodName  : mergeStockQty
	* @author      : 이병훈
	* @date        : 2024.10.07
	* @param stockVO
	* @param ajmtType
	* @return  	   : 조정유형에 따른 재고수량 수정(입고/폐기)
	*/
	public int mergeStockQty(StockVO stockVO, String ajmtType) {
		Map<String, Object> params = new HashMap<>();
	    params.put("gdsCode", stockVO.getGdsCode());
	    params.put("bzentNo", stockVO.getBzentNo());
	    params.put("qty", stockVO.getQty());
	    params.put("ajmtType", ajmtType);
	    
	    return this.cnptStockMapper.mergeStockQty(params);
	}
	
	/**
	* @methodName  : insertStockAjmt
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param map
	* @return      : 재고 조정 테이블에 재고 및 데이터 추가
	*/
	@Override
	public int insertStockAjmt(StockAjmtVO stockAjmtVO) {
		return this.cnptStockMapper.insertStockAjmt(stockAjmtVO);
	}
	
	/**
	* @methodName  : selectGdsList
	* @author      : 이병훈
	* @date        : 2024.10.01
	* @param map
	* @return      : 해당 거래처 보유 상품 리스트
	*/
	@Override
	public List<GdsVO> selectGdsList(String bzentNo) {
		return this.cnptStockMapper.selectGdsList(bzentNo);
	}
	
	/**
	* @methodName  : downloadTemp
	* @author      : 이병훈
	* @date        : 2024.10.02
	* @param map
	* @return      : 양식 엑셀 파일 다운로드
	*/
	@Override
	public void downloadTemp(HttpServletResponse response, String bzentNo) {
		try {
			// 1. 엑셀 파일 생성
			XSSFWorkbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("재고 양식");
			
			// 열 너비 고정 설정 (첫 번째 열은 20, 두 번째는 15, 세 번째는 10 등)
	        sheet.setColumnWidth(0, 5120);  // 상품명 (너비 20)
	        sheet.setColumnWidth(1, 2560);  // 수량 (너비 10)
	        sheet.setColumnWidth(2, 2560);  // 단위 (너비 10)
	        sheet.setColumnWidth(3, 2560);  // 상품단가 (너비 16)
	        sheet.setColumnWidth(4, 2560);  // 상품유형 (너비 16)
	        sheet.setColumnWidth(10, 2560);  // 참고 사항 (너비 고정 60)
			
			// 2. 헤더 작성
			Row headerRow = sheet.createRow(0);
			headerRow.createCell(0).setCellValue("상품명");
			headerRow.createCell(1).setCellValue("수량");
			headerRow.createCell(2).setCellValue("단위");
			headerRow.createCell(3).setCellValue("상품단가");
			headerRow.createCell(4).setCellValue("상품유형");
			headerRow.createCell(10).setCellValue("!!!!!!데이터 입력 시,필독 참고사항(파일 업로드 시, 입력 데이터 외 모두 삭제바랍니다.!!!!!!!!");
			
			// 3. 예시 데이터 행
			Row dataRow = sheet.createRow(1);
			dataRow.createCell(0).setCellValue("예시 상품명 : 청양고추 패티");
			dataRow.createCell(1).setCellValue(1000);
			dataRow.createCell(2).setCellValue("Kg");
			dataRow.createCell(3).setCellValue(1590);
			dataRow.createCell(4).setCellValue("FD01");
 			dataRow.createCell(10).setCellValue("<<<상품 유형 안내>>>");
 			
 			Row dataRow2 = sheet.createRow(2);
 			dataRow2.createCell(10).setCellValue("FD01");
 			dataRow2.createCell(11).setCellValue("축산");
			
 			Row dataRow3 = sheet.createRow(3);
 			dataRow3.createCell(10).setCellValue("FD02");
 			dataRow3.createCell(11).setCellValue("농산물");

 			Row dataRow4 = sheet.createRow(4);
 			dataRow4.createCell(10).setCellValue("FD03");
 			dataRow4.createCell(11).setCellValue("유제품");

 			Row dataRow5 = sheet.createRow(5);
 			dataRow5.createCell(10).setCellValue("FD04");
 			dataRow5.createCell(11).setCellValue("베이커리");

 			Row dataRow6 = sheet.createRow(6);
 			dataRow6.createCell(10).setCellValue("FD05");
 			dataRow6.createCell(11).setCellValue("조미료/소스");

 			Row dataRow7 = sheet.createRow(7);
 			dataRow7.createCell(10).setCellValue("FD06");
 			dataRow7.createCell(11).setCellValue("냉동식품");

 			Row dataRow8 = sheet.createRow(8);
 			dataRow8.createCell(10).setCellValue("FD07");
 			dataRow8.createCell(11).setCellValue("기타");

 			Row dataRow9 = sheet.createRow(9);
 			dataRow9.createCell(10).setCellValue("PM01");
 			dataRow9.createCell(11).setCellValue("일회용품");

 			Row dataRow10 = sheet.createRow(10);
 			dataRow10.createCell(10).setCellValue("SM01");
 			dataRow10.createCell(11).setCellValue("매장 소모품");

 			Row dataRow11 = sheet.createRow(11);
 			dataRow11.createCell(10).setCellValue("SM02");
 			dataRow11.createCell(11).setCellValue("조리 용품");

 			Row dataRow12 = sheet.createRow(12);
 			dataRow12.createCell(10).setCellValue("SM03");
 			dataRow12.createCell(11).setCellValue("위생 용품");

 			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=\""+bzentNo+"_Stock_Temp.xlsx\"");
			
			// 엑셀 파일을 response의 OutputStream에 작성
			workbook.write(response.getOutputStream());
			workbook.close();
			
		} catch (IOException e) {
			e.printStackTrace();
			log.error("Excel download error: ", e);
		    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	
	/**
	* @methodName  : insertNewAll
	* @author      : 이병훈
	* @date        : 2024.10.05
	* @param map
	* @return      : 신규 거래처 신규재고 등록
	*/
	@Transactional
	@Override
	public void insertNewAll(List<Map<String, Object>> gdsList) {
		try {
			
		// gdsList 안의 데이터를 하나씩 처리
		for(Map<String, Object> gdsData : gdsList) {
			// GdsVO 생성 및 데이터 설정
//			GdsVO gdsVO = new GdsVO();
//			gdsVO.setGdsCode((String) gdsData.get("gdsCode"));
//			gdsVO.setGdsNm((String) gdsData.get("gdsNm"));
//			gdsVO.setGdsType((String) gdsData.get("gdsType"));
//			gdsVO.setUnitNm((String) gdsData.get("unitNm"));
//			gdsVO.setMbrId((String) gdsData.get("mbrId"));
			
			// StockVO 생성 및 데이터 설정
			StockVO stockVO = new StockVO();
			stockVO.setGdsCode((String) gdsData.get("gdsCode"));
			stockVO.setBzentNo((String) gdsData.get("bzentNo"));
			stockVO.setQty(Integer.parseInt(gdsData.get("qty").toString()));
			stockVO.setNtslType((String) gdsData.get("ntslType"));
			
			// Map으로 파라미터 설정
            Map<String, Object> map = new HashMap<>();
            map.put("gdsCode", stockVO.getGdsCode());
            map.put("bzentNo", stockVO.getBzentNo());
			
			 // 이미 존재하는지 확인
            int existingStockCount = this.cnptStockMapper.selectStockExists(map);
            if (existingStockCount > 0) {
                // 이미 등록된 상품이라면 예외 처리
                throw new RuntimeException("이미 등록된 상품입니다: " + stockVO.getGdsCode());
            }

			// GdsAmtVO 생성 및 데이터 설정
			GdsAmtVO gdsAmtVO = new GdsAmtVO();
			gdsAmtVO.setGdsCode(stockVO.getGdsCode());
			gdsAmtVO.setBzentNo(stockVO.getBzentNo());
			gdsAmtVO.setAmt(Integer.parseInt(gdsData.get("amt").toString())); 
			
			// log.info로 데이터를 확인
//	        log.info("GdsVO: {}", gdsVO);
	        log.info("StockVO: {}", stockVO);
	        log.info("GdsAmtVO: {}", gdsAmtVO);
			
			// GDS, STOCK, GDS_AMT 순차 삽입
//			this.cnptStockMapper.insertNewGds(gdsVO);
			this.cnptStockMapper.insertNewStock(stockVO);
			this.cnptStockMapper.insertNewGdsAmt(gdsAmtVO);
			}
		} catch (Exception e) {
			log.error("insertAll 메서드에서 에러발생 : ", e);
			throw e;
		}
		
	}
	
	/**
	* @methodName  : selectGdsAll
	* @author      : 이병훈
	* @date        : 2024.10.05
	* @param map
	* @return      : 상품 총 목록
	*/
	@Override
	public List<GdsVO> selectGdsAll(String bzentType) {
		return this.cnptStockMapper.selectGdsAll(bzentType);
	}
	
	/**
	* @methodName  : selectGdsNm
	* @author      : 이병훈
	* @date        : 2024.10.07
	* @param map
	* @return      : 상품명
	*/
	@Override
	public String selectGdsNm(String gdsCode) {
		return this.cnptStockMapper.selectGdsNm(gdsCode);
	}

	

}
