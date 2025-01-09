<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<link href="/resources/cust/css/insertOrder.css" rel="stylesheet">

<div class="wrap order-wrap">
	
	<!-- 공통 컨테이너 영역 -->	
	<div class="wrap-cont">
	
		<!-- 공통 타이틀 영역 -->
		<div class="wrap-title">주문하기</div>
		<!-- /.wrap-title -->
		
		<!-- 탭 영역 -->
		<div class="order-tap">
			<div class="tap-select tap-frcs active">가맹점 선택</div>
			<div class="tap-select tap-cart">장바구니 (0)</div>
		</div>
		<!-- /.tap-wrap -->
		
		<!-- 주문 상세 영역 -->
		<div class="dtl-wrap">
			
			<!-- 주문 상세 오른쪽 영역 -->
			<div class="dtl-cont left">
				
				<!-- 가맹점 선택 영역 -->
				<div class="dtl-inner frcs">
				
					<!-- 셀렉트 영역 -->
					<div class="select-wrap">
						<!-- 지역 선택 셀렉트 영역 -->
						<select name="rgnNo" id="rgnNo" class="select2-custom">
							<option value="">지역을 선택해주세요</option>
							<%-- <c:forEach var="rgn" items="${rgn}">
								<option value="${rgn.comNo}">${rgn.comNm}</option>
							</c:forEach> --%>
						</select>
						<!-- 가맹점 셀렉트 영역 -->
 						<select class="select2-custom" name="frcsNo" id="frcsNo">
								<option value="">가맹점을 선택해주세요</option>
							<!-- ajax() 출력 영역 --> 
						</select>
					</div>	
					<!-- /.select-wrap -->	
					
					<!-- 메뉴 영역 -->
				 	<div class="frcs-menu">
				 		<ul class="list-box">
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
                               		<div class="list-input">
                               			<div class="cart-qty">
					                        <input type="button" value="-" class="minus-qty">
					                        <input type="text" value="0" class="num">
					                        <input type="button" value="+" class="plus-qty">
					                    </div>
										<button type="button" class="menu-add">담기</button>
	                            	</div>
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
                               		<div class="list-input">
                               			<div class="cart-qty">
					                        <input type="button" value="-" class="minus-qty">
					                        <input type="text" value="0" class="num">
					                        <input type="button" value="+" class="plus-qty">
					                    </div>
										<button type="button" class="menu-add">담기</button>
	                            	</div>
                          		</div>                                     
                        	</li>
							<li> 
								<div class="img-box">
							    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu2_img20_noicon.jpg)"></span>
								</div>
	                          	<div class="list-txt">
	                          		불고기 햄버거 세트
                          		</div>
	                          	<div class="list-price">
									<p>6,500<em>원</em></p>
	                          	</div>
	                           		<div class="preservation">
                               		<div class="list-input">
                               			<div class="cart-qty">
					                        <input type="button" value="-" class="minus-qty">
					                        <input type="text" value="0" class="num">
					                        <input type="button" value="+" class="plus-qty">
					                    </div>
										<button type="button" class="menu-add">담기</button>
	                            	</div>
                          		</div>                                     
                        	</li>
							<li> 
								<div class="img-box">
							    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/menu2_img12.jpg)"></span>
								</div>
	                          	<div class="list-txt">
	                          		불고기 햄버거 세트
                          		</div>
	                          	<div class="list-price">
									<p>6,500<em>원</em></p>
	                          	</div>
	                           		<div class="preservation">
                               		<div class="list-input">
                               			<div class="cart-qty">
					                        <input type="button" value="-" class="minus-qty">
					                        <input type="text" value="0" class="num">
					                        <input type="button" value="+" class="plus-qty">
					                    </div>
										<button type="button" class="menu-add">담기</button>
	                            	</div>
                          		</div>                                     
                        	</li>
							<li> 
								<div class="img-box">
							    	<span style="background-image: url(https://frankburger.co.kr/img/page/2022_menu/01/set_img17.jpg)"></span>
								</div>
	                          	<div class="list-txt">
	                          		불고기 햄버거 세트
                          		</div>
	                          	<div class="list-price">
									<p>6,500<em>원</em></p>
	                          	</div>
	                           		<div class="preservation">
                               		<div class="list-input">
                               			<div class="cart-qty">
					                        <input type="button" value="-" class="minus-qty">
					                        <input type="text" value="0" class="num">
					                        <input type="button" value="+" class="plus-qty">
					                    </div>
										<button type="button" class="menu-add">담기</button>
	                            	</div>
                          		</div>                                     
                        	</li>
                        </ul>
				 	</div>
								
				</div>
				<!-- /.frcs-menu -->
				
				<!-- 장바구니 영역 -->
				<div class="dtl-inner cart" style="display:none">
					<div class="cart-top">
						<div class="cart-title">선택한 메뉴</div>
						<div class="cart-controll">
							<div class="cart-all" id="allChk">전체선택</div>
							<div class="cart-delete" id="cartDelete">삭제</div>
						</div>
					</div>
          			<ul class="cart-wrap menu-list">
	                	<li class="cart-cont">
							<div class="menu-info">
		                		<div class="">
									<input type="checkbox" class="check-btn" id="menuChk" name="menuChk">	
						       		<label for="menuChk"></label>
						       </div>
	                        	<img class="menu-img" alt="메뉴사진" src="https://frankburger.co.kr/img/page/2022_menu/01/set_img17.jpg">
	                           	<p>불고기 햄버거 세트</p>
                           </div>
	                    	<div class="menu-price list-input">
	                         	<div class="cart-qty">
			                       <input type="button" value="-" class="minus-qty">
			                       <input type="text" value="0" class="num">
			                       <input type="button" value="+" class="plus-qty">
			                   	</div>
		                        <div class="menu-price">12,900원</div>
		                        <div class="menu-delete">
		                          	<span class="material-symbols-outlined" id="menuDelete" onclick="">close</span>
		                        </div>
                  			</div>
          				</li>
	                	<li class="cart-cont">
							<div class="menu-info">
		                		<div class="">
									<input type="checkbox" class="check-btn" id="menuChk" name="menuChk">	
						       		<label for="menuChk"></label>
						       </div>
	                        	<img class="menu-img" alt="메뉴사진" src="https://frankburger.co.kr/img/page/2022_menu/01/set_img17.jpg">
	                           	<p>불고기 햄버거 세트</p>
                           </div>
	                    	<div class="menu-price list-input">
	                         	<div class="cart-qty">
			                       <input type="button" value="-" class="minus-qty">
			                       <input type="text" value="0" class="num">
			                       <input type="button" value="+" class="plus-qty">
			                   	</div>
		                        <div class="menu-price">12,900원</div>
		                        <div class="menu-delete">
		                          	<span class="material-symbols-outlined" id="menuDelete" onclick="">close</span>
		                        </div>
                  			</div>
          				</li>
	                	<li class="cart-cont">
							<div class="menu-info">
		                		<div class="">
									<input type="checkbox" class="check-btn" id="menuChk" name="menuChk">	
						       		<label for="menuChk"></label>
						       </div>
	                        	<img class="menu-img" alt="메뉴사진" src="https://frankburger.co.kr/img/page/2022_menu/01/set_img17.jpg">
	                           	<p>불고기 햄버거 세트</p>
                           </div>
	                    	<div class="menu-price list-input">
	                         	<div class="cart-qty">
			                       <input type="button" value="-" class="minus-qty">
			                       <input type="text" value="0" class="num">
			                       <input type="button" value="+" class="plus-qty">
			                   	</div>
		                        <div class="menu-price">12,900원</div>
		                        <div class="menu-delete">
		                          	<span class="material-symbols-outlined" id="menuDelete" onclick="">close</span>
		                        </div>
                  			</div>
          				</li>
	                </ul>
	                <!-- /.menu-list -->
	                
	                <div class="menu-none">
	                	<div class="cart-wrap">
	                		<div class="error-info">
								<span class="icon material-symbols-outlined">error</span>
								<div class="error-msg">선택한 메뉴가 없습니다</div>
							</div>
	                	</div>
	                </div>
				</div>
				<!-- /.select-menu -->
			
			</div>
			<!-- /.dtl-cont.left -->
			
			<!-- 주문 상세 왼쪽 영역 -->
			<div class="dtl-cont right">
				
				<div class="dtl-right">
				
					<!-- 주문 확인 영역 -->
					<div class="chk-inner">
						<p class="chk-title">주문을 확인하세요!</p>
						
						<div class="chk-wrap top">
							<div class="chk-cont">
								<div class="rigth">총 수량</div>
								<div class="left">3개</div>
							</div>
							<div class="chk-cont">
								<div class="rigth">합산금액</div>
								<div class="left">28,000원</div>
							</div>
							<div class="chk-cont">
								<div class="rigth">쿠폰사용</div>
								<div class="left">
									<button type="button" id="couponModal">쿠폰선택</button>
								</div>
							</div>
							<div class="chk-coupon">
								불고기 버거 세트 1000원 할인 <span class="material-symbols-outlined">subdirectory_arrow_left</span> 
							</div>
							<div class="chk-cont">
								<div class="rigth">주문유형</div>
								<div class="left">
									<input type="radio" class="radio-btn" id="ordr02" name="ordr" value="ordr02">	
						       		<label for="ordr02"> 포장</label>
									<input type="radio" class="radio-btn" id="ordr01" name="ordr" value="ordr01" checked>	
						       		<label for="ordr01"> 매장</label>
						       </div>
							</div>
						</div>
						<!-- /.chk-wrap.top-->
						
						<div class="chk-wrap bom">
							<div class="chk-cont">
								<div class="rigth">결제예정금액</div>
								<div class="left">28,000원</div>
							</div>
						</div>
						<!-- /.chk-wrap.bom-->
						
					</div>
					<!-- /.chk-inner-->
					
					<!-- 주문하기 버튼 영역 -->
					<div class="order-btn">
						<button type="button" id="orderBtn">주문하기</button>
					</div>
					<!-- /.order-btn -->
				
				</div>
				
			</div>
			<!-- /.dtl-cont.rigth -->
			
		</div>
		<!-- /.dtl-wrap -->
		
	</div>
	<!--  /.wrap-cont -->
	
</div>
<!-- wrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/resources/cust/js/insertOrder.js"></script>










