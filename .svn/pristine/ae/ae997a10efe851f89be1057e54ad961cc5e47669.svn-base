package com.buff.util;

import java.util.List;
import java.util.Map;

//페이징 관련 정보 + 게시글 정보
public class ArticlePage<T> {
	//전체글 수
	private int total;
	//현재 페이지 번호
	private int currentPage;
	//전체 페이지 수
	private int totalPages;
	// 블록 사이즈
	private int blockSize;
	//블록의 시작 번호
	private int startPage;
	//블록의 종료 번호
	private int endPage;
	//검색어
	private String keyword = "";
	//요청URl
	private String url = "";
	//select 결과 데이터
	private List<T> content;
	//페이징 처리
	private String pagingArea = "";

	//오버로딩 : 동일한 클래스 안에 같은 이름의 메소드를 여러개 사용
	//		  파라미터의 개수가 다르거나 매개변수의 타입을 다르게 함
	//생성자(Constructor) : 페이징 정보를 생성
	//					753				1				10			select결과
	public ArticlePage(int total, int currentPage, int size, List<T> content
			, Map<String,Object> map) {
		//size : 한 화면에 보여질 목록의 행 수
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		this.blockSize = 5;
		//map.get("yr")의 리턴타입 : Object
		/*
		Object가 Interger가 아니라면 ClassCastException에러가 발생할 수도 있으며, 
		Object가 null일 경우에는 NullPointerException이 발생하기에 
				Object의 타입이 Interger임이 분명할 때 사용기를 권장하는 방법입니다.
		 */
		//this.yr = (int)map.get("yr");
		/*
		 ,defaultValue="0") int amt
		 매개변수를 보면 int타입으로 받고 있음. 
		 Map<String,Object> map 처럼 Object로 값을 넣었으므로
		 map.get("amp") -> Object로 리턴됨. 그래서 String으로 변환 후
		 int 타입으로 형변환 함
		 */
		//전체글 수가 0이면?
		if(total==0) {
			totalPages = 0;
			startPage = 0;	//블록 시작번호
			endPage = 0;	//블록 종료번호
		}else {	//글이 있다면
			//전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
			totalPages = total / size;// 31 / 10 = 3
			//나머지가 있다면, 페이지를 1 증가
			if(total %size > 0) {
				totalPages++;
			}
			
			//블록 시작 번호를 구하는 공식
			//블록 시작 번호 = 현재페이지 / 블록크기 * 블록크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;
			
			//현재페이지 % 페이지크기 => 0일 때 보정
			if(currentPage % blockSize ==0) {
				startPage -= blockSize;
			}
			
			//블록종료번호 = 블록시작번호 + (블록크기 - 1)
			//   [blockSize]        [1]    +   blockSize   - 1
			//[1][2][3][blockSize][다음]
			endPage = startPage + (blockSize - 1);
			
			//블록종료번호 > 전체페이지수
			if(endPage > totalPages) {
				endPage = totalPages;
			}
		}//end if
		
		this.pagingArea = "<ul class='pagination pagination-sm m-0 float-right'>"; 
		this.pagingArea += "<li class='page-item "; 
		if(this.startPage<5) {
			this.pagingArea += "disabled";
		}
		this.pagingArea += "'><a class='page-link' "; 
		this.pagingArea += "href='/buyprod/list?yr="+"&currentPage="+(this.startPage-blockSize)+"'>«</a></li>";
		for(int pNo=this.startPage;pNo<=this.endPage;pNo++) {
			this.pagingArea += "<li class='page-item ";
				if(this.currentPage==pNo) {
					this.pagingArea += " active";
				}//end if
			this.pagingArea += "'><a class='page-link' ";
			this.pagingArea += " href='/buyprod/list?yr="+"&currentPage="+pNo+"'>"+pNo+"</a></li>"; 
		}//end for
		this.pagingArea += "<li class='page-item";
		if(this.endPage >= this.totalPages) {
			this.pagingArea += " disabled ";
		}
		this.pagingArea += "'><a class='page-link'";
		this.pagingArea += "href='/buyprod/list?yr="+"&currentPage="+(this.startPage+5)+"'>»</a></li>"; 
		this.pagingArea += "</ul>";	
	}//생성자 끝

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<T> getContent() {
		return content;
	}

	public void setContent(List<T> content) {
		this.content = content;
	}

	public String getPagingArea() {
		return pagingArea;
	}

	public void setPagingArea(String pagingArea) {
		this.pagingArea = pagingArea;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	
}





