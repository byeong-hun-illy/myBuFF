<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link href="/resources/cust/css/selectMain.css" rel="stylesheet">
<%--
 	@fileName    :  home.jsp
 	@programName : 메인홈화면
 	@description : 사용자 메인 화면
 	@author      : 서윤정
 	@date        : 2024. 09. 11
--%>

<!-- 
/buff/home 는 고객의 첫 화면

/cnpt/main 거래처(+고객)의 첫 화면 
 -->
<!-- 권한에 무관하게 로그인 했다면 실행  -->
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한 사용자가 고객 권한이 없다면  -->
	<sec:authorize access="!hasRole('ROLE_CUST')">
		<script type="text/javascript">
			location.href = "/error/cust";
		</script>
	</sec:authorize>
</sec:authorize>

<!-- 이벤트 슬라이드 배너 -->
<div id="carouselMain" class="carousel carousel-dark slide"
	data-bs-ride="carousel">
	<div class="carousel-indicators">
		<button type="button" data-bs-target="#carouselMain"
			data-bs-slide-to="0" class="active" aria-current="true"
			aria-label="Slide 1"></button>
		<button type="button" data-bs-target="#carouselMain"
			data-bs-slide-to="1" aria-label="Slide 2"></button>
		<button type="button" data-bs-target="#carouselMain"
			data-bs-slide-to="2" aria-label="Slide 3"></button>
	</div>
	<div class="carousel-inner">
		<div class="carousel-item active" data-bs-interval="2000">
			<img src="/resources/images/main01.png" class="main-img"
				alt="메인배너이미지">
		</div>
		<div class="carousel-item" data-bs-interval="2000">
			<img src="/resources/images/main02.png" class="main-img"
				alt="메인배너이미지">
		</div>
		<div class="carousel-item" data-bs-interval="2000">
			<img src="/resources/images/main03.png" class="main-img"
				alt="메인배너이미지">
		</div>
	</div>
	<button class="carousel-control-prev" type="button"
		data-bs-target="#carouselMain" data-bs-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Previous</span>
	</button>
	<button class="carousel-control-next" type="button"
		data-bs-target="#carouselMain" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Next</span>
	</button>
</div>


<div class="wrap-main">

	<!-- 주문하기 -->
	<div class="wrap-cont">
		<div class="order-wrap">
			<div class="order-cont here"
				onclick="location.href='/cust/ordr/regist?ordrType=ORDR01'">
				<p class="order-title">
					매장 주문하기 <span class="go-icon material-symbols-outlined">east</span>
				</p>
				<img alt="매장" src="/resources/images/main-here.png">
			</div>
			<div class="order-cont togo"
				onclick="location.href='/cust/ordr/regist?ordrType=ORDR02'">
				<p class="order-title">
					포장 주문하기 <span class="go-icon material-symbols-outlined">east</span>
				</p>
				<img alt="매장" src="/resources/images/main-togo.png">
			</div>
		</div>
	</div>
	<!-- /.wrap-cont -->

	<!-- 메뉴 안내  -->
	<div class="menu-section">
		<div class="wrap-cont">
			<div class="section-cont">
				<p class="section-title">메뉴 소개</p>
				<div class="carouselMenu-btn">
					<button class="carousel-control-prev carouselMenu-prev"
						type="button" data-bs-target="#carouselMenu" data-bs-slide="prev">
						<span class="menu-move-icon material-symbols-outlined">chevron_left</span>
					</button>
					<button class="carousel-control-next carouselMenu-next"
						type="button" data-bs-target="#carouselMenu" data-bs-slide="next">
						<span class="menu-move-icon material-symbols-outlined">chevron_right</span>
					</button>
				</div>
			</div>
			<!-- /.section-cont -->

			<!-- 메뉴 슬라이드 시작 -->
			<div id="carouselMenu" class="carousel carousel-dark slide"
				data-bs-touch="false" data-bs-interval="false">
				<div class="carousel-inner">
					<c:forEach var="i" begin="0" end="${fn:length(menuVOList) / 3 - 1}">
						<div class="carousel-item ${i == 0 ? 'active' : ''}">
							<div class="menu-wrap">
								<c:forEach var="menuVO" items="${menuVOList}" begin="${i * 3}"
									end="${(i + 1) * 3 - 1}">
									<div class="menu-cont">
										<div class="img-box"
											style="background: url('${menuVO.menuImgPath}') no-repeat center"></div>
										<div class="menu-title">${menuVO.menuNm}</div>
										<div class="preservation">${menuVO.menuExpln}</div>
										<div class="menu-price">
											<span class="paid-icon material-symbols-outlined">paid</span>
											<fmt:formatNumber value="${menuVO.menuAmt}" pattern="#,###" />
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- /.carouselMenu -->
		</div>
		<!-- /.wrap-cont -->

		<div id="menuPageBtn"
			onclick="window.location.href='/buff/selectMenu'">
			메뉴소개 더보기 <span class="go-icon material-symbols-outlined">east</span>
		</div>
	</div>
	<!-- /.menu-section -->

	<!-- 가맹점 안내 -->
	<div class="store-section">
		<div class="wrap-cont">
			<div class="section-cont">
				<p class="section-title">매장 소개</p>
				<div class="carouselMenu-btn">
					<button class="carousel-control-prev carouselMenu-prev"
						type="button" data-bs-target="#carouselStore" data-bs-slide="prev">
						<span class="menu-move-icon material-symbols-outlined">chevron_left</span>
					</button>
					<button class="carousel-control-next carouselMenu-next"
						type="button" data-bs-target="#carouselStore" data-bs-slide="next">
						<span class="menu-move-icon material-symbols-outlined">chevron_right</span>
					</button>
				</div>
			</div>
			<!-- /.section-cont -->

			<!-- 가맹점 문의 -->
			<div class="store-inner">
				<div class="store-info"
					onclick="window.location.href='/buff/insertDscsn'">
					<div class="store-title">
						가맹점 문의하기 <span class="go-icon material-symbols-outlined">east</span>
					</div>
				</div>
				<!-- /.store-info -->

				<!-- 매장 소개 -->
				<div id="carouselStore" class="carousel slide" data-bs-touch="false" data-bs-interval="false">
    				<div class="carousel-inner">
			        <!-- 첫 번째 슬라이드 -->
			        <div class="carousel-item active">
			            <div class="store-item">
			                <c:forEach var="bzentVO" items="${bzentVOList}" begin="0" end="2">
			                    <div class="store-cont">
			                        <div class="store-nm">
			                            <span class="location-icon material-symbols-outlined">location_on</span>
			                            ${bzentVO.bzentNm} 지점
			                        </div>
			                        <div class="store-addr">${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}</div>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			        
			        <!-- 두 번째 슬라이드 -->
			        <div class="carousel-item">
			            <div class="store-item">
			                <c:forEach var="bzentVO" items="${bzentVOList}" begin="3" end="5">
			                    <div class="store-cont">
			                        <div class="store-nm">
			                            <span class="location-icon material-symbols-outlined">location_on</span>
			                            ${bzentVO.bzentNm} 지점
			                        </div>
			                        <div class="store-addr">${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}</div>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			
			        <!-- 세 번째 슬라이드 -->
			        <div class="carousel-item">
			            <div class="store-item">
			                <c:forEach var="bzentVO" items="${bzentVOList}" begin="6" end="8">
			                    <div class="store-cont">
			                        <div class="store-nm">
			                            <span class="location-icon material-symbols-outlined">location_on</span>
			                            ${bzentVO.bzentNm} 지점
			                        </div>
			                        <div class="store-addr">${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}</div>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			        
			         <!-- 네 번째 슬라이드 -->
			        <div class="carousel-item">
			            <div class="store-item">
			                <c:forEach var="bzentVO" items="${bzentVOList}" begin="9" end="11">
			                    <div class="store-cont">
			                        <div class="store-nm">
			                            <span class="location-icon material-symbols-outlined">location_on</span>
			                            ${bzentVO.bzentNm} 지점
			                        </div>
			                        <div class="store-addr">${bzentVO.bzentAddr} ${bzentVO.bzentDaddr}</div>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			    </div>
			    
    
    
    <!-- carousel-inner 끝 -->
</div>
				<!-- /.carouselStore -->
			</div>
			<!--store-inner 끝 -->
			<!-- /.wrap-cont -->
		</div>
		<!-- /.store-section -->
	</div>
	<!-- /.wrap-main -->
</div>



<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous"></script>
