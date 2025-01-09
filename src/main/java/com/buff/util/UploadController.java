package com.buff.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.buff.com.mapper.FileGroupMapper;
import com.buff.vo.FileDetailVO;
import com.buff.vo.FileGroupVO;
import lombok.extern.slf4j.Slf4j;

//자바빈 객체로 등록
@Slf4j
@Controller
public class UploadController {
	
	//DI, IoC
	//root-context.xml에 <bean.. 으로 존재함 c:\\upload
	@Autowired
	FileGroupMapper fileGroupMapper;
	
    // application.properties에서 정의된 값을 주입
    @Autowired
    String uploadPath;

    @Autowired
    String uploadFolderDirect;
	
//	@Autowired
//	private ServletContext servletContext;
	  
	/**
	 * 본사 메뉴 등록시 사용
	 * 단일 이미지 업로드
	 * return 파일 경로
	 * 
	 */
    @Transactional
	public String imageUpload(MultipartFile file) {
	    // 파일 저장 경로를 저장할 변수
	    String savedFilePath = "";
	    
	    
	    // 예진 upload 프로젝트 경로
        // 주입된 경로를 로그로 출력
	    File file1 = new File(this.uploadPath, "menu");
	    File file2 = new File(this.uploadFolderDirect, "menu");
	    log.info("path>>>> "+file1.getAbsolutePath());
	    log.info("path>>>> "+file2.getAbsolutePath());
        
	    // 상대 경로를 사용하는 방식으로 수정
	    // 현재 클래스의 위치를 기준으로 상대 경로 설정
	    
	    if (!file1.exists()) {
	    	boolean dirCreated = file1.mkdirs();
	    	if (!dirCreated) {
	    	    log.error("디렉토리 생성에 실패했습니다: " + file1.getAbsolutePath());
	    	} else {
	    	    log.info("디렉토리 생성 성공: " + file1.getAbsolutePath());
	    	}
	    }
	    if (!file2.exists()) {
	    	boolean dirCreated = file2.mkdirs();
	    	if (!dirCreated) {
	    		log.error("디렉토리 생성에 실패했습니다: " + file2.getAbsolutePath());
	    	} else {
	    		log.info("디렉토리 생성 성공: " + file2.getAbsolutePath());
	    	}
	    }
	    
	    // 원본 파일명
	    String fileName = "";
	    
	    // 파일 처리
	    fileName = file.getOriginalFilename();
	    
	    UUID uuid = UUID.randomUUID();
	    fileName = uuid.toString() + "_" + fileName;
	    
	    // 실제 파일 저장 경로 생성
	    File saveFile = new File(file1, fileName);
	    File saveFile2 = new File(file2, fileName);
	    
	    try {
	        // 파일 복사 실행
	        file.transferTo(saveFile);
	        file.transferTo(saveFile2);
	        
	        // 저장된 파일 경로 저장
	        savedFilePath = "/resources/upload/menu/" + fileName;

	        // FILE_DETAIL 테이블에 insert
	    } catch (IllegalStateException | IOException e) {
	        log.error(e.getMessage());
	    }
	    
	    // 파일 경로 반환
	    return savedFilePath;
	}

	
	/**다중 이미지 업로드
	 * return : 20240808001(FILE_GROUP.FILE_GROUP_NO)
	 */	
	@Transactional
	public long multiImageUpload(MultipartFile[] multipartFiles) {
	    
	    long fileGroupNo = 0L;
	    int result = 0;
	    int counter = 1; // FILE_SN 컬럼을 위함(20240808001의1)(20240808001의2)
	    
	    // 경로 설정 - 원하는 경로로 설정
	    File file = new File(this.uploadPath, this.getFolder());
	    File file2 = new File(this.uploadFolderDirect, this.getFolder());
	    
	    if (file.exists() == false) {
	        file.mkdirs();
	    }
	    if (file2.exists() == false) {
	    	file2.mkdirs();
	    }
	    
	    // 원본 파일명
	    String fileName = "";
	    // MIME(Multipurpose Internet Mail Extension) 타입
	    String contentType = "";
	    // 파일 크기
	    long fileSize = 0L; 
	    
	    // 1) FILE_GROUP 테이블에 insert
	    FileGroupVO fileGroupVO = new FileGroupVO();
	    // 실행 전 {fileGroupNo=0, fileRegdate=null}
	    result += this.fileGroupMapper.insertFileGroup(fileGroupVO);
	    // 실행 후 {fileGroupNo=20240808001, fileRegdate=null}
	    
	    // 향상된 for문(multipartFiles : 파일들)
	    for (MultipartFile multipartFile : multipartFiles) {
	        fileName = multipartFile.getOriginalFilename();
	        contentType = multipartFile.getContentType();
	        fileSize = multipartFile.getSize();
	        
	        UUID uuid = UUID.randomUUID();
	        fileName = uuid.toString() + "_" + fileName;
	        
	        // File 객체 설계(복사할 대상 경로, 파일명)
	        // C:\\sts-bundle\\workspace\\buff\\src\\main\\webapp\\resources\\upload\\2024\\08\\08 + "\\" + asdfasdf_파일명.jpg
	        File saveFile = new File(file, fileName);
	        File saveFile2 = new File(file2, fileName);
	        
	        try {
	            // 파일 복사 실행
	            // 파일 객체.transferTo(설계)
	            multipartFile.transferTo(saveFile);
	            multipartFile.transferTo(saveFile2);
	            
	            // 2) FILE_DETAIL 테이블에 insert
	            FileDetailVO fileDetailVO = new FileDetailVO();
	            fileDetailVO.setFileSn(counter++);
	            fileDetailVO.setFileGroupNo(fileGroupVO.getFileGroupNo());
	            fileDetailVO.setFileOriginalName(multipartFile.getOriginalFilename());
	            fileDetailVO.setFileSaveName(fileName); // uuid + 파일명
	            // /upload/ == C:\\sts-bundle\\workspace\\buff\\src\\main\\webapp\\resources\\upload\\2024\\08\\08 + "\\" + asdfasdf_파일명.jpg
	            fileDetailVO.setFileSaveLocate(
	                "/resources/upload/" +
	                this.getFolder().replace("\\", "/") +
	                "/" + fileName
	            );
	            fileDetailVO.setFileSize(fileSize);
	            fileDetailVO.setFileExt(
	                fileName.substring(fileName.lastIndexOf(".") + 1) // asdfasdf_파일명.jpg
	            );
	            fileDetailVO.setFileMime(contentType);
	            fileDetailVO.setFileFancysize(makeFancySize(String.valueOf(fileSize))); // bytes -> MB
	            fileDetailVO.setFileSaveDate(null);
	            fileDetailVO.setFileDowncount(0);
	            
	            result += this.fileGroupMapper.insertFileDetail(fileDetailVO);
	            
	            fileGroupNo = fileGroupVO.getFileGroupNo();
	        } catch (IllegalStateException | IOException e) {
	            log.error(e.getMessage());
	        }
	    }
	    
	    log.info("result : " + result);
	    
	    return fileGroupNo;
	}
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-11-16 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2022-11-16
		String str = sdf.format(date);
		//2024-01-30 -> 2024\\01\\30
		return str.replace("-", File.separator);
	}
	
	//이미지인지 판단. 썸네일은 이미지만 가능하므로..
	public boolean checkImageType(File file) {
		//MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		//MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	//fancySize 리턴("1059000")	
	public String makeFancySize(String bytes) {
		log.info("bytes : " + bytes);
		String retFormat = "0";
		//숫자형문자->실수형으로 형변환(1059000)
		Double size = Double.parseDouble(bytes);
		
		String[] s = { "bytes", "KB", "MB", "GB", "TB", "PB" };
		
		if (bytes != "0") {
		  //bytes->KB
		  int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
		  DecimalFormat df = new DecimalFormat("#,###.##");
		  double ret = ((size / Math.pow(1024, Math.floor(idx))));
		  retFormat = df.format(ret) + " " + s[idx];
		} else {
		  retFormat += " " + s[0];
		}
		
		return retFormat;
	}
}





