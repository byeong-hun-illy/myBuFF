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

import com.buff.com.service.FrcsClclnService;
import com.buff.util.ArticlePage;
import com.buff.util.PdfController;
import com.buff.vo.FrcsClclnVO;
import com.buff.vo.PoVO;

import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasRole('ROLE_HDOFC') or hasRole('ROLE_FRCS')")
@Controller
@RequestMapping("/com/frcsClcln")
@Slf4j
public class FrcsClclnController {
	
	@Autowired
	FrcsClclnService clclnService;
	
    @Autowired
    private PdfController pdfController;  // PdfController 주입
	
	@GetMapping("/listAjax")
	@ResponseBody
	public Map<String, Object> selectFrcsClclnAjax(@RequestParam Map<String, Object> map){
		int size = 10;
	    map.put("size", size);
	    List<FrcsClclnVO> frcslist = this.clclnService.selectFrcsClcln(map);
	    Map<String, Object> response = this.clclnService.selectTotalFrcsClcln(map); // map 갯수를 포함한 map과 정산 금액 vo
	    int total = (int) response.get("total");
	    int currentPage = Integer.parseInt((String) map.get("currentPage"));
	    
	    // 분류 숫자 계산
	    // 응답 데이터를 담을 Map 생성
	    response.put("articlePage", new ArticlePage<FrcsClclnVO>(total, currentPage, size, frcslist, map));
	    
	    return response; // 여러 데이터를 포함한 Map 반환
	}
	
	@PostMapping("/dtlAjax")
	@ResponseBody
	public Map<String, Object> selectFrcsClclnDtlAjax(@RequestBody FrcsClclnVO frcsClclnVO){
		Map<String, Object> map = new HashMap<String, Object>();
		FrcsClclnVO frcsCl = this.clclnService.selectFrcsClclnDtl(frcsClclnVO);
		map.put("frcsClclnVO", frcsCl);
		return map;
	}
	
	@GetMapping("/billAjax")
    @ResponseBody
    public ResponseEntity<InputStreamResource> billPdfAjax(@RequestParam String frcsNo, 
    														@RequestParam String clclnYm) {
		
		FrcsClclnVO frcsClclnVO = new FrcsClclnVO();
		frcsClclnVO.setFrcsNo(frcsNo);
		frcsClclnVO.setClclnYm(Integer.parseInt(clclnYm));
		
		frcsClclnVO = this.clclnService.selectFrcsClclnDtl(frcsClclnVO);
        
        // PoVO를 사용해 PDF 파일 생성 및 다운로드 응답
        try {
            return pdfController.createFrcsClclnPdf(frcsClclnVO);
        } catch (IOException e) {
        	log.debug("오류");
            // 오류 발생 시 에러 응답
            return ResponseEntity.status(500).build();
        }
    }
	
}
