package com.buff.com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buff.com.service.ComService;
import com.buff.com.service.DealService;
import com.buff.util.ArticlePage;
import com.buff.util.PdfController;
import com.buff.vo.GdsVO;
import com.buff.vo.PoClclnVO;
import com.buff.vo.PoVO;
import com.buff.vo.StockPoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@PreAuthorize("hasRole('ROLE_CNPT') or hasRole('ROLE_HDOFC') or hasRole('ROLE_FRCS')")
@Slf4j
@RequestMapping("/com/deal")
public class DealController {
	
	@Autowired
	DealService dealService;
	
	@Autowired
	ComService comService;

    @Autowired
    private PdfController pdfController;  // PdfController 주입
    
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectDealAjax(@RequestParam Map<String,Object> map) {
	    int size = 10;
	    map.put("size", size);
	    List<PoVO> polist = this.dealService.selectDeal(map);
	    Map<String, Object> response = this.dealService.selectTotalDeal(map);
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<PoVO>(total, currentPage, size, polist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	/**
	* @methodName  : selectDealDtlAjax
	* @author      : 송예진
	* @date        : 2024.09.27
	* @param poNo
	* @return      : 가맹점 상세 값 가져오기 (발주번호를 받아)
	*/
	@PostMapping("/dtlAjax")
	@ResponseBody
	public Map<String, Object> selectDealDtlAjax(@RequestParam String poNo){
		Map<String, Object> map = new HashMap<String, Object>();
		PoVO poVo = this.dealService.selectDealDtl(poNo);
		map.put("po", poVo);
		return map;
	}
	
	/**
	* @methodName  : deletePoAjax
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poNo
	* @return      : 승인전인 발주 삭제
	*/
	@PostMapping("/deleteAjax")
	@ResponseBody
	public int deletePoAjax(@RequestParam String poNo) {
		return this.dealService.deletePo(poNo);
	}
	
	/**
	* @methodName  : updateStockPo
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param stockPoVOList
	* @return      : 재고 변경 리스트
	* STOCK_PO 추가 (PO_SEQ, PO_NO, BZENT_NO, GDS_CODE, QTY, GDS_AMT) 
	*/
	@PostMapping("/updateStockPo")
	@ResponseBody
	public int updateStockPo(@RequestBody List<StockPoVO> stockPoVOList) {
		return this.dealService.updateStockPo(stockPoVOList);
	}
	
	/**
	* @methodName  : updateAprv
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 승인시
	*/
	@PostMapping("/poAprv")
	@ResponseBody
	public int updateAprv(@RequestBody PoVO poVO) {
		return this.dealService.updateDeli02(poVO);
	}
	
	/**
	* @methodName  : updateNoAprv
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 미승인 시
	*/
	@PostMapping("/poNoAprv")
	@ResponseBody
	public int updateNoAprv(@RequestBody PoVO poVO) {
		return this.dealService.updatePo(poVO);
	}
	
	/**
	* @methodName  : updatePo
	* @author      : 송예진
	* @date        : 2024.09.28
	* @param poVO
	* @return      : 배송 완료시 
	*/
	@PostMapping("/updateDeliEnd")
	@ResponseBody
	public int updatePo(@RequestBody PoVO poVO) {
		// 배송 완료가 되면 해당 발주건의 정산이 부여
		return this.dealService.updateDeli03(poVO);
	}
	
	/**
	* @methodName  : updateClcln
	* @author      : 송예진
	* @date        : 2024.10.04
	* @param poClclnVO
	* @return      : 정산
	*/
	@PostMapping("/updateClcln")
	@ResponseBody
	public int updateClcln(@RequestBody PoClclnVO poClclnVO) {
		return this.dealService.updateClcln(poClclnVO);
	}
	
	@GetMapping("/billAjax")
    @ResponseBody
    public ResponseEntity<InputStreamResource> billPdfAjax(@RequestParam String poNo) {
        // DealService에서 poNo로 PoVO 가져오기
        PoVO poVo = this.dealService.selectDealDtl(poNo);
        
        log.info("poVO >>> " + poVo);

        // PoVO를 사용해 PDF 파일 생성 및 다운로드 응답
        try {
            return pdfController.createReceiptPdf(poVo);
        } catch (IOException e) {
            e.printStackTrace();
            // 오류 발생 시 에러 응답
            return ResponseEntity.status(500).build();
        }
    }
	
}
