<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" async="" src="https://cdn.channel.io/plugin/ch-plugin-web.js" charset="UTF-8"></script>
    <script async="" src="https://www.googletagmanager.com/gtm.js?id=GTM-N344JGC3"></script>
<link href="/resources/cust/css/custOrdr.css" rel="stylesheet">
<link rel="stylesheet" href="https://imecomall.co.kr/v2/theme/basic/css/swiper-bundle.min.css">

<link rel="stylesheet" href="https://imecomall.co.kr/v2/theme/basic/css/shop_add.css?ver=1">
<link rel="stylesheet" href="https://imecomall.co.kr/v2/theme/basic/css/swiper-bundle.min.css">
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PT4ZVDB" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<style>
/* 셀렉트 커스텀 */
.select2-selection[aria-labelledby="select2-mngrId-container"] { // select2-인풋Id명-container
	width: 500px !important;
}
.select2-selection[aria-labelledby="select2-mngrId-container"] .select2-dropdown {
	width: 198px !important;
}
</style>


<script>

$(document).ready(function() {
	select2Custom(); // 셀렉트 디자인 라이브러리. common.js에서 호출 됨	
});

$(function(){
	$("#cartForm").on("click", function(){
		console.log("개똥이 나와줘~!!")
		$.ajax({
			url: "/cust/testOrdrCart",
			contentType: "application/json;charset=utf-8",
			type: "POST",
			dataType: "json",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log("result : ", result);
				
			}
		});
	});
});//end 달러function


$(document).ready(function() {
    $("#OrdrCart").click(function(event) {
        event.preventDefault(); // 링크의 기본 동작을 막음
        
        $(this).addClass("on");
        
        $("#Ordr").removeClass("on");
        
        // 페이지 이동
     //   window.location.href = $(this).find("a").attr("href");
        
    });
       
    $("#Ordr").click(function(event) {
        event.preventDefault(); // 링크의 기본 동작을 막음
        
        $(this).addClass("on");
        
        $("#OrdrCart").removeClass("on");
        
        // 페이지 이동
        window.location.href = $(this).find("a").attr("href");
        
    });
        
});
</script>


<div class="green_bg">
            <div class="inner in_1170">
                <div class="tit_type1 mb50">주문</div>
                <div class="tab_type1 tab2">
                    <ul>
                        <li class="on" id="Ordr">
                            <a href="/cust/testOrdr">메뉴 보기</a>
                        </li>
                        <li id="OrdrCart">
                            <a href="#">장바구니</a>
                        </li>
                    </ul>
                </div> <!--tab_type1 tab2 끝  -->
                
                
                 <!-- 메뉴 영역 -->
	<div class="cont" >
		<!-- 폼 시작-->
		<form id="selectModal" method="get" action="/cust/insertOrdr">
			<div class="cont" style="display: -webkit-inline-box;">
				<!-- 검색 조건 시작 -->
				<div class="search-wrap">
					<!-- 희망 지역 -->
					<div class="search-cont" style="width:200px;">
						<p>지역</p>
						<select class="select2-custom" name="rgnNo" id="rgnNo" >
							<option value="" selected>전체</option>
							<option value="RGN11"
								<c:if test="${param.rgnNo == 'RGN11'}">selected</c:if>>서울특별시</option>
							<option value="RGN21"
								<c:if test="${param.rgnNo == 'RGN21'}">selected</c:if>>부산광역시</option>
							<option value="RGN22"
								<c:if test="${param.rgnNo == 'RGN22'}">selected</c:if>>대구광역시</option>
							<option value="RGN23"
								<c:if test="${param.rgnNo == 'RGN23'}">selected</c:if>>인천광역시</option>
							<option value="RGN24"
								<c:if test="${param.rgnNo == 'RGN24'}">selected</c:if>>광주광역시</option>
							<option value="RGN25"
								<c:if test="${param.rgnNo == 'RGN25'}">selected</c:if>>대전광역시</option>
							<option value="RGN26"
								<c:if test="${param.rgnNo == 'RGN26'}">selected</c:if>>울산광역시</option>
							<option value="RGN29"
								<c:if test="${param.rgnNo == 'RGN29'}">selected</c:if>>세종특별자치시</option>
							<option value="RGN31"
								<c:if test="${param.rgnNo == 'RGN31'}">selected</c:if>>경기도</option>
							<option value="RGN32"
								<c:if test="${param.rgnNo == 'RGN32'}">selected</c:if>>강원도</option>
							<option value="RGN33"
								<c:if test="${param.rgnNo == 'RGN33'}">selected</c:if>>충청북도</option>
							<option value="RGN34"
								<c:if test="${param.rgnNo == 'RGN34'}">selected</c:if>>충청남도</option>
							<option value="RGN35"
								<c:if test="${param.rgnNo == 'RGN35'}">selected</c:if>>전라북도</option>
							<option value="RGN36"
								<c:if test="${param.rgnNo == 'RGN36'}">selected</c:if>>전라남도</option>
							<option value="RGN37"
								<c:if test="${param.rgnNo == 'RGN37'}">selected</c:if>>경상북도</option>
							<option value="RGN38"
								<c:if test="${param.rgnNo == 'RGN38'}">selected</c:if>>경상남도</option>
							<option value="RGN39"
								<c:if test="${param.rgnNo == 'RGN39'}">selected</c:if>>제주특별자치도</option>
						</select>
					</div>
				</div>

				<!-- 검색어 -->
				<div class="search-cont">
					<p>검색어</p>
					<div class="search-input-btn"  style="width: 200px;">
					<select class="select2-custom h2BzentNm" name="bzentCard" id="bzentCard">
					<option value="" selected>전체</option>
						
					</select>
					</div>
				</div>
			</div>
		</form>
		<!-- 검색 조건 끝 -->
		<!-- 선택 끝 -->
	</div>
<!-- 가맹점 선택  끝 -->
  
                <!-- 장바구니 영역 -->
                <div class="shopping_cart">
                    <div class="lef">
                        <div class="product_tbl">
                            <div class="order_history">
 					<form name="cartForm" id="cartForm" method="post">
					            <input type="hidden" name="act" id="act" value="">                                
					            <input type="hidden" name="ad_id" id="ad_id" value="16479">
					            <input type="hidden" name="od_b_name" id="od_b_name" value="서윤정">
					            <input type="hidden" name="od_b_zip" id="od_b_zip" value="35322">
					            <input type="hidden" name="od_b_hp" id="od_b_hp" value="010-5430-1589">
					            <input type="hidden" name="od_b_addr1" id="od_b_addr1" value="대전 서구 도마로57번길 38">
					            <input type="hidden" name="od_b_addr2" id="od_b_addr2" value="805호">
					            <input type="hidden" name="od_b_addr3" id="od_b_addr3" value="(변동, 동건아파트)">
					            <input type="hidden" name="od_b_addr_jibeon" id="od_b_addr_jibeon" value="">
					            <input type="hidden" name="od_b_receive" id="od_b_receive" value="">
					            <input type="hidden" name="od_b_memo" id="od_b_memo" value="">     
					
					                <script>
					                    var goods = new Array();
					                </script>
                
                                <div class="area eco_d">
                                    <div class="d_info">
                                        <div class="top">
                                            <div class="d_tit">
                                    			단품 메뉴
                                    		</div>
                                        </div>
                                    </div>
                                    <div class="box_area">

                                        <ul class="list">

                                        
                                            <li class="lists" id="list_up_0">
                                            
                                                <input type="hidden" name="it_id[0]" value="1625707636">
                                                <input type="hidden" name="it_name[0]" value="[아임에코] 30% 사탕수수 용기 깨끗한샘 500mL x 20병">         
                                                <input type="hidden" name="ct_qty[0]" class="ct_qty" value="2" id="ct_qty_0"> 
                                                <input type="hidden" name="io_price[0]" class="io_price" value="0">
                                                <input type="hidden" name="it_price[0]" class="it_price" id="it_price_0" value="13800">
                                                <input type="hidden" class="cust_price" id="cust_price_0" value="17556">
                                                <input type="hidden" class="point" id="point_0" value="138">
                                                <input type="hidden" class="sendcost" id="sendcost_0" value="0">
												<input type="hidden" class="itsctype" id="itsctype_0" value="1">
												<input type="hidden" class="it_maker" id="it_maker_0" value="산수음료(주)">
												<input type="hidden" class="it_sc_price" id="it_sc_price_0" value="0">
												<input type="hidden" class="it_sc_minimum" id="it_sc_minimum_0" value="0">
												<input type="hidden" class="it_sc_qty" id="it_sc_qty_0" value="0">
                                                <input type="hidden" id="it_buy_min_qty_0" value="2">

                                                <div class="box">
                                                    <div class="chk_type chk_type2 small">
                                                        <label>
                                                            <input type="checkbox" class="chk" data-val="1625707636" data-id="산수음료(주)" name="ct_chk[0]" value="1" id="ct_chk_regular_0" checked="">
                                                            <span></span>
                                                        </label>
                                                    </div>
                                                    <div class="product_info">
                                                        <div class="img" style="background-image:url(https://imecomall.co.kr/v2/data/item/1625707636/thumb-7JWE7J6E7JeQ7L2U_6rmo64GX7ZWc7IOY_500ml_82x82.jpg)"></div>
                                                        <ul class="txt">
                                                            <li>
                                                                <p><a href="https://imecomall.co.kr/v2/shop/item.php?it_id=1625707636" class="prd_name"><b>[아임에코] 30% 사탕수수 용기 깨끗한샘 500mL x 20병</b></a></p>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="box">
                                                    <div class="amount">
                                                    <button type="button" class="down" onclick="minusQty(0)"></button>
                                                        <span>2</span>
                                                        <button type="button" class="up" onclick="plusQty(0)"></button>
                                                    </div>
                                                    <dl class="price_type">
                                                        <dt>상품금액</dt>
                                                        <dd><span><em class="en_font">13,800</em>원</span></dd>
                                                    </dl>
                                                    <dl class="price_type">
                                                        <dt>배송비</dt>
                                                        <dd class="p_sc_price" data-id="산수음료(주)">무료배송</dd>
                                                    </dl>
                                                    <div class="close">
                                                        <button type="button" onclick="deleteThis(0);"></button>
                                                    </div>
                                                </div>
																								
                                            </li>
                        
                                        </ul>
                                        
                                        <div class="price">
                                            <p>
                                                상품가격&nbsp;&nbsp;<strong class="en_font g_custPrice">17,556</strong>원
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-plus.svg" alt="">
                                            </em>
                                            <p>
                                                배송비&nbsp;&nbsp;<strong class="g_sendcost" data-maker="산수음료(주)">0</strong>
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-minus.svg" alt="">
                                            </em>
                                            <p>
                                                할인금액&nbsp;&nbsp;<span><strong class="en_font g_salePrice">3,756</strong>원</span>
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-equal.svg" alt="">
                                            </em>
                                            <p>
                                                <strong class="en_font g_totalPrice">13,800</strong>원
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="area eco_d">
                                    <div class="d_info">
                                        <div class="top">
                                            <div class="d_tit">
                                            	세트메뉴
								         	</div>
                                        </div>
                                    </div>
                                    <div class="box_area">

                                        <ul class="list">

                                        
                                            <li class="lists" id="list_up_1">
                                                <div class="box">
                                                    <div class="chk_type chk_type2 small">
                                                        <label>
                                                            <input type="checkbox" class="chk" data-val="1710748670" data-id="윈텍" name="ct_chk[1]" value="1" id="ct_chk_regular_1" checked="">
                                                            <span></span>
                                                        </label>
                                                    </div>
                                                    <div class="product_info">
                                                        <div class="img" style="background-image:url(https://imecomall.co.kr/v2/data/item/1710748670/thumb-6465_WTH1620_82x82.jpg)"></div>
                                                        <ul class="txt">
                                                            <li>
                                                                <p><a href="https://imecomall.co.kr/v2/shop/item.php?it_id=1710748670" class="prd_name"><b>[윈세프] 가벼운 헤어드라이어, WTH-1620B, 블랙</b></a></p>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="box">
                                                    <div class="amount">
                                                    <button type="button" class="down" onclick="minusQty(1)"></button>
                                                        <span>1</span>
                                                        <button type="button" class="up" onclick="plusQty(1)"></button>
                                                    </div>
                                                    <dl class="price_type">
                                                        <dt>상품금액</dt>
                                                        <dd><span><em class="en_font">26,900</em>원</span></dd>
                                                    </dl>
                                                    <dl class="price_type">
                                                        <dt>배송비</dt>
                                                        <dd class="p_sc_price" data-id="윈텍">무료배송</dd>
                                                    </dl>
                                                    <div class="close">
                                                        <button type="button" onclick="deleteThis(1);"></button>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="price">
                                            <p>
                                                상품가격&nbsp;&nbsp;<strong class="en_font g_custPrice">32,000</strong>원
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-plus.svg" alt="">
                                            </em>
                                            <p>
                                                배송비&nbsp;&nbsp;<strong class="g_sendcost" data-maker="윈텍">0</strong>
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-minus.svg" alt="">
                                            </em>
                                            <p>
                                                할인금액&nbsp;&nbsp;<span><strong class="en_font g_salePrice">5,100</strong>원</span>
                                            </p>
                                            <em>
                                                <img src="https://imecomall.co.kr/v2/theme/basic/images/bl-equal.svg" alt="">
                                            </em>
                                            <p>
                                                <strong class="en_font g_totalPrice">26,900</strong>원
                                            </p>
                                        </div>
                                    </div>
                                </div>
								</form>
                            </div>
                        </div>
                    </div>
                    <div class="rig">
                        <div class="box">
                            <div class="top">
                                
                                <div class="address">
                                    <span>보유 쿠폰</span>
                                    <button type="button" class="_btn co_bor_btn h_44">사용 가능한 쿠폰</button>
                                </div>
                                <div class="price">
                                    <ul>
                                        <li>
                                            <span>상품금액</span>
                                            <strong id="tot_cart_price">49,556<em>원</em></strong>
                                        </li>
                                        <li>
                                            <span>상품할인금액</span>
                                            <strong id="tot_sale_price">-8,856<em>원</em></strong>
                                        </li>
                                    </ul>
                                    <div class="total">
                                        <span>결제예정금액</span>
                                        <strong id="tot_price">40,700<em>원</em></strong>
                                    </div>
                                </div>
                            </div>
                            <div class="bot">
                                <div class="point">
                                    <span class="penguin">주문 유형</span>
                                     <button class="badge4 on" id="ordrBtn" type="button">매장</button>
                                     <button class="badge3" id="ordrBtn" type="button">포장</button>
                                </div>
                            </div>
                        </div>
                        <button class="_btn co_btn" type="button" onclick="submitOrder()">주문하기</button>
                    </div>
                </div>
            </div>
        </div>
