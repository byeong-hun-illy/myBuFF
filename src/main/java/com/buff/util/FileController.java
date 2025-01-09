package com.buff.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

//import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FileController {
	
	@Autowired
	String uploadFolderDirect;
	
//	String uploadFolderDirect = "C:\\sts-bundle\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\buff\\resources\\upload";
//	String uploadFolderDirect = "Users\\jeong-gippeum\\Desktop\\ddit\\finalProj\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\buff\\resources\\upload";
	
	//c:\\upload
	@Inject
	String uploadPath;
	
	///Users/jeong-gippeum/Desktop/ddit/finalProj/workspace/buff/src/main/webapp/
	@Inject
	String downloadPath;
	
	// 요청URI :
	// /download?fileName=/upload/2022/11/16/76890bda-122c-4b7b-8af3-1eedbe99c5ce_ksh.jpg
	@ResponseBody
	@RequestMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(
			@RequestParam String fileName, HttpSession session) {
		// ?fileName=/upload/2022/11/16/76890bda-122c-4b7b-8af3-1eedbe99c5ce_ksh.jpg
		log.info("download file : " + fileName);
		
		//fileName = "/upload/2024/09/27/16e43e64-1bad-4afe-8453-3fddff2199f0_18.jpg";

		// 경로 설정
		//String realPath = session.getServletContext().getRealPath("");
		//String realPath = "C:\\sts-bundle\\workspace\\buff\\src\\main\\webapp";
		String realPath = downloadPath;
		
		
		// core.io
		// c: + /upload/2022/11/..
		Resource resource = new FileSystemResource(realPath + fileName);
		log.info("path : " + (realPath + fileName));

		String resourceName = resource.getFilename();
		log.info("resourceName : " + resourceName);

		// springframework.http
		// 헤더를 통해서 파일을 보냄
		HttpHeaders headers = new HttpHeaders();

		try {
			// 파일명을 한글처리함
			headers.add("Content-Disposition",
					"attachment;filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// resource : 파일 / header : 파일명 등 정보 / HttpStatus.OK : 상태200(성공)
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	

	//이미지를 웹 경로에 저장
	@ResponseBody
	@PostMapping("/image/upload")
	public Map<String, Object> image(MultipartHttpServletRequest request) throws Exception {
		// ckeditor 에서 파일을 보낼 때 {upload:[파일]} 형식으로 해서 
		//		넘어오기 때문에 upload라는 키의 밸류를 받아서 uploadFile에 저장함
		MultipartFile uploadFile = request.getFile("upload");
		log.info("uploads->uploadFile : " + uploadFile);
		
		//파일의 오리지널 명
		String originalFileName = uploadFile.getOriginalFilename();
		log.info("uploads->originalFileName : " + originalFileName);
		
		//파일의 확장자(개똥이.jpg)
		String ext = originalFileName.substring(originalFileName.indexOf("."));
		log.info("uploads->ext : " + ext);//.jpg
		
		String newFileName = UUID.randomUUID() + ext; //sadlfkjsafd.jpg
		
		// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
		// String realPath = request.getServletContext().getRealPath("/");
		String url = request.getRequestURL().toString();
		log.info("uploads->url(bef) : " + url);
		// http://localhost/
		// http://192.168.93.73/
		url = url.substring(0, url.indexOf("/", 7));
		log.info("uploads->url(aft) : " + url);
		
		//물리적 저장 경로 .../upload + "\\" + sadlfkjsafd.jpg
		String savePath = this.uploadFolderDirect + "\\" + newFileName;
		String savePath2 = this.uploadPath + "\\" + newFileName;
		log.info("uploads->savePath : " + savePath);
		
		//웹 경로
		/* /resources/upload/
		 1. C:\\sts-bundle\\workspace\\buff\\src\\main\\webapp\\resources\\upload
		 2. C:\\sts-bundle\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\buff\\resources\\upload
		 */
		String uploadPath = "/resources/upload/" + newFileName;
		
		//설계
		File file = new File(savePath);
		File file2 = new File(savePath2);
		//파일 업로드 처리
		uploadFile.transferTo(file);
		uploadFile.transferTo(file2);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("uploaded", true);
		map.put("url", url + uploadPath);
		//map : {uploaded=true, url=http://localhost/resources/upload/b8baefc3-34c0-44c8-af3b-4a9464a61e7c.jpg}
		log.info("uploads->map : " + map);
		
		return map;
	}
	
	//이미지를 base64로 저장
	@ResponseBody
	@PostMapping(value = "/image/uploadBase64")
	public Map<String, Object> uploadBase64(MultipartHttpServletRequest request) throws Exception {

		// ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
		// modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
		// jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단
		// WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로 등록해야
		// 함
		ModelAndView mav = new ModelAndView("jsonView");

		// ckeditor 에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서
		// uploadFile에 저장함
		MultipartFile uploadFile = request.getFile("upload");
		log.info("uploadFile : " + uploadFile);

		// 파일의 오리지널 네임
		String originalFileName = uploadFile.getOriginalFilename();
		log.info("originalFileName : " + originalFileName);

		// 파일의 확장자
		String ext = originalFileName.substring(originalFileName.indexOf("."));
		log.info("ext : " + ext);

		// 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
		String newFileName = UUID.randomUUID() + ext;

		// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
//		String realPath = request.getServletContext().getRealPath("/");
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("/", 7));
		log.info("url : " + url);

		// 현재경로/upload/파일명이 저장 경로
		String savePath = uploadFolderDirect + "\\" + newFileName;
		String savePath2 = uploadPath + "\\" + newFileName;
		log.info("savePath : " + savePath);
		
		// 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 상대경로를 쓰거나 이미지 불러오는 jsp 또는 클래스 파일을 만들어
		// 가져오는 식으로 우회해야 함
		// 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
		String uploadPath = "/resources/upload/" + newFileName;

		// 저장 경로로 파일 객체 생성
		File file = new File(savePath);
		File file2 = new File(savePath2);

		// 파일 업로드
		uploadFile.transferTo(file);
		uploadFile.transferTo(file2);
		
		//파일 업로드 완료 후 base64이미지 처리
		String base64Img = imageToBase64(savePath);

		// uploaded, url 값을 modelandview를 통해 보냄
//		mav.addObject("uploaded", true); // 업로드 완료
//		mav.addObject("url", uploadPath); // 업로드 파일의 경로

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uploaded", true);
		//1) <img src="/resources/upload/개동이.jpg">
//		map.put("url", url + uploadPath);
		//2) <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략...">
		map.put("url", "data:image/jpeg;base64," + base64Img);
		// map : {uploaded=true,
		// url=/resources/upload/b8baefc3-34c0-44c8-af3b-4a9464a61e7c.jpg}
		log.info("map : " + map);

		return map;
	}

	/**
	 * 이미지를 Base64로 변환하기 서버에 저장되어있는 이미지를 웹화면에 뿌려주어야할 때 base64로 변환하여 표현하는 방법을 사용한다
	 * <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략..."> 이 값을
	 * 만들기 위해 필요한 로직을 알아보자 가. Parameter : 1. 파일의 경로 filePath, 2. 파일명 fileName 나.
	 * Return : 1. base64 문자열 base64Img
	 * 
	 * @throws Exception
	 */
	public String imageToBase64(String savePath) throws Exception {
		String base64Img = "";
		
		log.info("imageToBase64->savePath : " + savePath);
		
		File f = new File(savePath);
		if (f.exists() && f.isFile() && f.length() > 0) {
			byte[] bt = new byte[(int) f.length()];
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(f);
				fis.read(bt);
				// org.apache.tomcat.util.codec.binary.Base64
//				base64Img = new String(Base64.encodeBase64(bt));
			} catch (Exception e) {
				throw e;
			} finally {
				try {
					if (fis != null) {
						fis.close();
					}
				} catch (IOException e) {
				} catch (Exception e) {
				}
			}
		}

		return base64Img;
	}
}
