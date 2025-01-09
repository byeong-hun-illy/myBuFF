<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<link href="/resources/cust/css/selectMenu.css" rel="stylesheet">

<div class="wrap menu-wrap">
	
	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">메뉴 소개</div>
		<!-- /.wrap-title -->
		
		<!-- 탭 영역 -->
		<div class="menu-tap">
			<div class="tap-select tap-set active">
				<div class="tap-icon">
					<span class="material-symbols-outlined">fastfood</span>
				</div> 
				<div class="tap-nm">세트</div>
			</div>
			<div class="tap-select tap-set">
				<div class="tap-icon">
					<span class="material-symbols-outlined">lunch_dining</span>
				</div> 
				<div class="tap-nm">햄버거</div>
			</div>
			<div class="tap-select tap-set">
				<div class="tap-icon">
					<span class="material-symbols-outlined">icecream</span>
				</div> 
				<div class="tap-nm">사이드</div>
			</div>
			<div class="tap-select tap-set">
				<div class="tap-icon">
					<span class="material-symbols-outlined">local_cafe</span>
				</div> 
				<div class="tap-nm">음료</div>
			</div>
		</div>
		<!-- /.tap-wrap -->
				
		<!-- 메뉴 영역 -->
	 	<div class="menu-list">
	 		<ul class="list-box">
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu2_img17.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			베이컨과 바삭한 닭다리살 치킨패티에 바베큐 특제소스로 깊은 풍미와 식감을 최상으로 느낄 수 있는 치킨 버거
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu2_img3.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			비프 앤 쉬림프 버거 + 프렌치 프라이 + 탄산음료
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu1_img22.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			겉은 바삭하고 속은 육즙가득한 닭다리살 치킨패티에 신선한 야채를 더한 오리지널 치킨 버거
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu2_img5.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			스파이시 시즈닝을 입힌 부드러운 닭안심살을 매콤 바삭하게 튀겨낸 치킨 텐더 (2조각)
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu1_img21.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			베이컨과 바삭한 닭다리살 치킨패티에 바베큐 특제소스로 깊은 풍미와 식감을 최상으로 느낄 수 있는 치킨 버거
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu1_img21.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			베이컨과 바삭한 닭다리살 치킨패티에 바베큐 특제소스로 깊은 풍미와 식감을 최상으로 느낄 수 있는 치킨 버거
	        		</div>
	        	</li>
				<li> 
					<div class="img-box">
				    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu1_img21.jpg)"></span>
					</div>
	               	<div class="list-txt">
	               		불고기 햄버거 세트
	            	</div>
	               	<div class="list-price">
						<p>6,500<em>원</em></p>
	               	</div>
	        		<div class="preservation">
	        			베이컨과 바삭한 닭다리살 치킨패티에 바베큐 특제소스로 깊은 풍미와 식감을 최상으로 느낄 수 있는 치킨 버거
	        		</div>
	        	</li>
	        </ul>
	 	</div>
	 	<!-- /.menu-list -->
		
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>










