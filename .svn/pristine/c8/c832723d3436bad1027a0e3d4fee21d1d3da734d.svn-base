package com.buff.util;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import com.buff.vo.FrcsClclnVO;
import com.buff.vo.PoVO;
import com.google.common.net.HttpHeaders;

import lombok.extern.slf4j.Slf4j;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import java.text.NumberFormat;
import java.util.Locale;

@Slf4j
@Controller
public class PdfController {
    
	public ResponseEntity<InputStreamResource> createFrcsClclnPdf(FrcsClclnVO frcsClclnVO) throws IOException {
    	PDDocument document = new PDDocument();
    	// PDF 문서 생성
    	PDPage page = new PDPage(PDRectangle.A4);
    	document.addPage(page);
    	
    	// ContentStream 생성
    	PDPageContentStream contentStream = new PDPageContentStream(document, page);
        
        try {
            // 폰트 로드 및 페이지 여백 설정
            ClassLoader classLoader = getClass().getClassLoader();
            InputStream fontStream = classLoader.getResourceAsStream("font/NanumGothic.ttf");
            PDType0Font font = PDType0Font.load(document, fontStream);
            InputStream fontStream2 = classLoader.getResourceAsStream("font/NanumGothicBold.ttf");
            PDType0Font fontBold = PDType0Font.load(document, fontStream2);

            float margin = 50;
            float yStart = page.getMediaBox().getHeight() - margin;

            NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
            
            // "발주 영수증" 제목
            contentStream.beginText();
            contentStream.setFont(fontBold, 16);
            contentStream.newLineAtOffset(50, 750);
            contentStream.showText("월간 정산 영수증");
            contentStream.endText();

            yStart -= 80;

            // 수주처 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("가맹점 정보");
            contentStream.endText();

            yStart -= 30;
            
            String tel = Telno.splitTelStr(frcsClclnVO.getBzentVO().getBzentTelno());
            
            String[] purHeaders = {};
            String[][] purData = {
                    {"상호명", frcsClclnVO.getBzentVO().getBzentNm()},
                    {"연락처", tel},
                    {"주소", "(" + frcsClclnVO.getBzentVO().getBzentZip() + ")\n"+frcsClclnVO.getBzentVO().getBzentAddr() + ", "+ frcsClclnVO.getBzentVO().getBzentDaddr()}
            };
            drawTable(contentStream, margin, yStart, purHeaders, purData, font, fontBold);

            if(frcsClclnVO.getClclnYn().equals("Y")) {
            	
            	yStart -= 100;
            	
            	// 결제 정보
            	contentStream.beginText();
            	contentStream.setFont(fontBold, 12);
            	contentStream.newLineAtOffset(margin, yStart);
            	contentStream.showText("결제 정보");
            	contentStream.endText();
            	
            	yStart -= 30;
            	String reg = convertToDashedFormat(frcsClclnVO.getRegYmd());
            	String clclnYmd = convertToDashedFormat(frcsClclnVO.getClclnYmd());
            	
            	String[] dateHeaders = {};
            	String[][] dateData = {
               		 {"등록일자", reg},
                     {"정산완료일자", clclnYmd},
                     {"정산 계좌", frcsClclnVO.getBankTypeNm()+"은행, "+ maskActno(frcsClclnVO.getActno())}
            	};
            	
            	drawTable(contentStream, margin, yStart, dateHeaders, dateData, font, fontBold);
            }

            yStart -= 100;
            
            // 정산 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("정산 금액 상세");
            contentStream.endText();

            yStart -= 30;

            String[] summaryHeaders = {};
            
            String[][] summaryData = {
            		{"로열티", numberFormat.format(frcsClclnVO.getRoyalty())},
        			{"할인금액", numberFormat.format(frcsClclnVO.getDscntAmt())},
        			{"체납금액", numberFormat.format(frcsClclnVO.getNpmntAmt())},
        			{"총 금액", numberFormat.format(frcsClclnVO.getRoyalty() + frcsClclnVO.getNpmntAmt() - frcsClclnVO.getDscntAmt())}
            };

            drawTable(contentStream, margin, yStart, summaryHeaders, summaryData, font, fontBold);
            
            // 마지막으로 contentStream 닫기
            contentStream.close();

        } finally {
            // 모든 contentStream 닫기
            contentStream.close();
        }

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        document.save(byteArrayOutputStream);
        document.close();

        InputStream inputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        InputStreamResource resource = new InputStreamResource(inputStream);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename="+frcsClclnVO.getClclnYm()+"_bill.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(byteArrayOutputStream.size())
                .body(resource);
    }
	
    
    public ResponseEntity<InputStreamResource> createReceiptPdf(PoVO poVO) throws IOException {
    	PDDocument document = new PDDocument();
    	// PDF 문서 생성
    	PDPage page = new PDPage(PDRectangle.A4);
    	document.addPage(page);
    	
    	// ContentStream 생성
    	PDPageContentStream contentStream = new PDPageContentStream(document, page);
        
        try {
            // 폰트 로드 및 페이지 여백 설정
            ClassLoader classLoader = getClass().getClassLoader();
            InputStream fontStream = classLoader.getResourceAsStream("font/NanumGothic.ttf");
            PDType0Font font = PDType0Font.load(document, fontStream);
            InputStream fontStream2 = classLoader.getResourceAsStream("font/NanumGothicBold.ttf");
            PDType0Font fontBold = PDType0Font.load(document, fontStream2);

            float margin = 50;
            float yStart = page.getMediaBox().getHeight() - margin;

            NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
            
            // "발주 영수증" 제목
            contentStream.beginText();
            contentStream.setFont(fontBold, 16);
            contentStream.newLineAtOffset(50, 750);
            contentStream.showText("발주 영수증");
            contentStream.endText();

            yStart -= 80;

            // 수주처 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("수주처 정보");
            contentStream.endText();

            yStart -= 30;
            
            String tel = Telno.splitTelStr(poVO.getBzentVO().getBzentTelno());
            
            String[] purHeaders = {};
            String[][] purData = {
                    {"상호명", poVO.getBzentVO().getBzentNm()},
                    {"연락처", tel},
                    {"주소", "(" + poVO.getBzentVO().getBzentZip() + ")\n"+poVO.getBzentVO().getBzentAddr() + ", "+ poVO.getBzentVO().getBzentDaddr()}
            };
            drawTable(contentStream, margin, yStart, purHeaders, purData, font, fontBold);

            yStart -= 80;

            // 공급자 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("공급자 정보");
            contentStream.endText();

            yStart -= 30;
            
            String tel2 = Telno.splitTelStr(poVO.getStockPoVOList().get(0).getBzentVO().getBzentTelno());

            String[] supHeaders = {};
            String[][] supData = {
                    {"상호명", poVO.getStockPoVOList().get(0).getBzentVO().getBzentNm()},
                    {"연락처", tel2},
                    {"주소", "(" + poVO.getStockPoVOList().get(0).getBzentVO().getBzentZip() + ")\n"+poVO.getStockPoVOList().get(0).getBzentVO().getBzentAddr() + ", " + poVO.getStockPoVOList().get(0).getBzentVO().getBzentDaddr()}
            };
            drawTable(contentStream, margin, yStart, supHeaders, supData, font, fontBold);

            yStart -= 80;

            // 결제 금액 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("결제 금액");
            contentStream.endText();

            yStart -= 30;

            String[] summaryHeaders = {};
            String[][] summaryData = {
                    {"발주 금액", numberFormat.format(poVO.getPoClclnVO().getClclnAmt())},
                    {"체납 금액", numberFormat.format(poVO.getPoClclnVO().getNpmntAmt())},
                    {"총 금액", numberFormat.format(poVO.getPoClclnVO().getClclnAmt() + poVO.getPoClclnVO().getNpmntAmt())}
            };

            drawTable(contentStream, margin, yStart, summaryHeaders, summaryData, font, fontBold);

            if(poVO.getPoClclnVO().getClclnYn().equals("Y")) {
                
                yStart -= 100;
                
                // 결제 정보
                contentStream.beginText();
                contentStream.setFont(fontBold, 12);
                contentStream.newLineAtOffset(margin, yStart);
                contentStream.showText("결제 정보");
                contentStream.endText();
                
                yStart -= 30;
                String reg = convertToDashedFormat(poVO.getPoClclnVO().getRegYmd());
                String clclnYmd = convertToDashedFormat(poVO.getPoClclnVO().getClclnYmd());
                
                String[] dateHeaders = {};
                String[][] dateData = {
                        {"등록일자", reg},
                        {"정산완료일자", clclnYmd},
                        {"정산 계좌", poVO.getPoClclnVO().getBankTypeNm()+"은행, "+maskActno(poVO.getPoClclnVO().getActno())}
                };

                drawTable(contentStream, margin, yStart, dateHeaders, dateData, font, fontBold);
            }
            
            yStart = page.getMediaBox().getHeight() - margin;
            
            // PDF 문서 생성
        	page = new PDPage(PDRectangle.A4);
        	document.addPage(page);
        	
        	// 반드시 생성하기 전에 이전에 사용한 것을 닫아야한다!!!!
        	contentStream.close();
        	// ContentStream 생성
        	contentStream = new PDPageContentStream(document, page);
            
            // 상품 상세 정보
            contentStream.beginText();
            contentStream.setFont(fontBold, 12);
            contentStream.newLineAtOffset(margin, yStart);
            contentStream.showText("상품 상세");
            contentStream.endText();

            yStart -= 30;
            
            int size = poVO.getStockPoVOList().size();
            int start = 0;

            while (size > 0) {
                // 수량과 금액에 쉼표 추가 및 오른쪽 정렬
                String[] orderHeaders = {"상품명", "수량", "단위", "단가", "금액"};
                // 현재 페이지에서 출력할 데이터 양을 35개로 제한
                int displaySize = Math.min(35, size);
                String[][] orderData = new String[displaySize][5];

                // 현재 페이지에서 출력할 데이터 추출
                for (int i = 0; i < displaySize; i++) {
                    orderData[i][0] = poVO.getStockPoVOList().get(start + i).getGdsVO().getGdsNm();  // 상품명
                    orderData[i][1] = numberFormat.format(poVO.getStockPoVOList().get(start + i).getQty());  // 수량
                    orderData[i][2] = poVO.getStockPoVOList().get(start + i).getGdsVO().getUnitNm();  // 단위
                    orderData[i][3] = numberFormat.format(poVO.getStockPoVOList().get(start + i).getGdsAmt());  // 단가
                    orderData[i][4] = numberFormat.format(poVO.getStockPoVOList().get(start + i).getQty() * poVO.getStockPoVOList().get(start + i).getGdsAmt());  // 금액
                }

                // 표 그리기
                drawTable(contentStream, margin, yStart, orderHeaders, orderData, font, fontBold);

                // 데이터 크기와 시작 인덱스 업데이트
                size -= displaySize;
                start += displaySize;

                // 다음 페이지가 필요한 경우 새 페이지 추가
                if (size > 0) {
                    // PDF 문서 생성
                    page = new PDPage(PDRectangle.A4);
                    document.addPage(page);
                    
                    // ContentStream 종료 및 새 페이지를 위한 새로운 ContentStream 생성
                    contentStream.close();
                    contentStream = new PDPageContentStream(document, page);
                    
                    // 새로운 페이지에서 yStart 재설정
                    yStart = page.getMediaBox().getHeight() - margin;
                }
            }

            // 마지막으로 contentStream 닫기
            contentStream.close();

            
        } finally {
            // 모든 contentStream 닫기
            contentStream.close();
        }

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        document.save(byteArrayOutputStream);
        document.close();

        InputStream inputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        InputStreamResource resource = new InputStreamResource(inputStream);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename="+poVO.getPoNo()+"_bill.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(byteArrayOutputStream.size())
                .body(resource);
    }

    private void drawTable(PDPageContentStream contentStream, float x, float y, String[] headers, String[][] data, PDType0Font font, PDType0Font fontBold) throws IOException {
        float margin = 50;
        float yStart = y;
        float totalTableWidth = 600;  // 전체 테이블 너비
        float rowHeight = 20;
        float cellMargin = 5;
        int cols = data[0].length;  // 열의 개수는 데이터의 첫 번째 행의 길이로 설정
        int rows = data.length;

        // 고정된 너비 (첫 번째 열에만 적용)
        float nameWidth = 150;  // 200px로 설정
        float firstColumnWidth = 100;  // 첫 번째 열의 너비를 100px로 설정
        float secondColumnWidth = 500; // 두 번째 열의 너비를 400px로 설정
        float otherColumnsTotalWidth = 350;  // 나머지 열들의 총 너비를 400px로 설정
        float otherColumnWidth = otherColumnsTotalWidth / (cols - 1);  // 나머지 열들의 너비

        // 헤더가 있으면 헤더 그리기
        if (headers != null && headers.length > 0) {
            float xOffset = x;
            for (int i = 0; i < cols; i++) {
                float cellWidth;
                // 행이 2개일 때는 고정 너비를 사용하고, 그렇지 않으면 동적 너비 사용
                if (cols == 2) {
                    cellWidth = (i == 0) ? firstColumnWidth : secondColumnWidth;
                } else {
                    cellWidth = (i == 0) ? nameWidth : otherColumnWidth;
                }
                contentStream.addRect(xOffset, yStart, cellWidth, rowHeight);
                contentStream.beginText();
                contentStream.setFont(fontBold, 12);
                contentStream.newLineAtOffset(xOffset + cellMargin, yStart + cellMargin);
                contentStream.showText(headers[i]);
                contentStream.endText();
                xOffset += cellWidth;  // xOffset 업데이트
            }
            yStart -= rowHeight;  // 헤더를 그린 후 Y 좌표 업데이트
        }
        
        // 테이블 데이터 그리기
        for (int i = 0; i < rows; i++) {
            float xOffset = x;
            for (int j = 0; j < cols; j++) {
                float cellWidth;

                // 행이 2개일 때는 고정 너비를 사용하고, 그렇지 않으면 동적 너비 사용
                if (cols == 2) {
                    cellWidth = (j == 0) ? firstColumnWidth : secondColumnWidth;
                    contentStream.addRect(x , yStart, cellWidth, rowHeight);
                } else {
                    cellWidth = (j == 0) ? nameWidth : otherColumnWidth;
                    contentStream.addRect(xOffset, yStart, cellWidth, rowHeight);
                }
                contentStream.beginText();
                contentStream.setFont(font, 12);

                String cellText = data[i][j];
                // 숫자 여부를 체크해서 숫자만 오른쪽 정렬
                if (isNumeric(cellText)) { // 오른쪽 정렬
                    float textWidth = font.getStringWidth(cellText) / 1000 * 12;
                    if (cols == 2) {
                        if(j==1) {
                            contentStream.newLineAtOffset(x + cellWidth - textWidth - cellMargin, yStart + cellMargin);  // 오른쪽 정렬
                        } else {
                            contentStream.newLineAtOffset(x + cellWidth - textWidth - cellMargin, yStart + cellMargin);  // 오른쪽 정렬
                        }
                    } else {
                    	contentStream.newLineAtOffset(xOffset + cellWidth - textWidth - cellMargin, yStart + cellMargin);  // 오른쪽 정렬
                    }
                } else { // 왼쪽 정렬
                    if (cols == 2) {
                        if(j==1) {
                            contentStream.newLineAtOffset(x + firstColumnWidth + cellMargin, yStart + cellMargin);  // 왼쪽 정렬
                        }else {
                            contentStream.newLineAtOffset(x + cellMargin, yStart + cellMargin);  // 왼쪽 정렬
                        }
                    } else {
                        contentStream.newLineAtOffset(xOffset + cellMargin, yStart + cellMargin);
                    }
                }

                contentStream.showText(cellText);
                contentStream.endText();
                xOffset += cellWidth;  // xOffset 업데이트
            }
            yStart -= rowHeight;  // 다음 행으로 이동
        }

        contentStream.stroke();  // 테이블 선 그리기
    }
    
    public static String convertToDashedFormat(String yyyymmdd) {
        if (yyyymmdd == null || yyyymmdd.length() != 8) {
            throw new IllegalArgumentException("Invalid date format. Expected YYYYMMDD.");
        }
        
        String year = yyyymmdd.substring(0, 4);
        String month = yyyymmdd.substring(4, 6);
        String day = yyyymmdd.substring(6, 8);
        
        return year + "-" + month + "-" + day;
    }
    
    // 숫자 확인 함수
    private static boolean isNumeric(String str) {
        if (str == null || str.isEmpty()) {
            return false;
        }
        try {
            Double.parseDouble(str.replace(",", ""));  // 쉼표가 있는 숫자도 처리 가능
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    public String maskActno(String actno) {
        if (actno == null || actno.length() <= 6) {
            return actno; // actno가 6자리 이하일 경우 마스킹하지 않음
        }
        String visiblePart = actno.substring(0, actno.length() - 6); // 앞부분 그대로
        String maskedPart = "******"; // 마지막 6자리는 마스킹
        return visiblePart + maskedPart; // 합쳐서 반환
    }
}