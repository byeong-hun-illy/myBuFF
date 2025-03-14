<%--
    @fileName    : selectEvent.jsp
    @programName : 이벤트 조회
    @description : 모든 고객이 이벤트를 조회할 수 있는 화면
    @author      : 서윤정
    @date        : 2024. 09. 11
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<link href="/resources/cust/css/selectEvent.css" rel="stylesheet">


<%
    // 현재 날짜를 가져옵니다.
    Calendar calendar = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    String currentDate = sdf.format(calendar.getTime());
%>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">

// 진행중인 이벤트 조회
function eventIng() {
    $.ajax({
        url: "/buff/selectEventAjax",
        type: "get",
        dataType: "json",
        success: function(result) {
            // 성공 시 진행 중인 이벤트 조회
            console.log("이벤트 실행 성공", result);

            $(".list-box").html("");

            let str = '<ul class="list-box">';

            if (result && result.eventVOList && Array.isArray(result.eventVOList)) {
            	$.each(result.eventVOList, function(index, eventVO) {
                    str += '<li onclick="window.location.href=\'/buff/insertEventCoupon?eventNo=' + eventVO.eventNo + '\'" class="ordrAccordion-item" style="display: list-item;">';
                    str += '<div class="img-box">';
                    str += '<span style="background-image: url('+ eventVO.fileDetailVOList[0].fileSaveLocate +')"></span>';
                    str += '</div>';
                    str += '<div class="list-title">';
                    str += '<a href="/cust/insertEventCoupon?eventNo=' + eventVO.eventNo + '">' + eventVO.eventTtl + '</a>';
                    str += '</div>';
                    str += '<div class="list-txt">';

                    if (eventVO.bgngYmd) {
                        let year = eventVO.bgngYmd.substring(0, 4);
                        let month = eventVO.bgngYmd.substring(4, 6);
                        let day = eventVO.bgngYmd.substring(6, 8);
                        let formattedDate = year + '-' + month + '-' + day;

                        if (eventVO.expYmd) {
                            let expYear = eventVO.expYmd.substring(0, 4);
                            let expMonth = eventVO.expYmd.substring(4, 6);
                            let expDay = eventVO.expYmd.substring(6, 8);
                            let formattedExpDate = expYear + '-' + expMonth + '-' + expDay;

                            str += formattedDate + ' ~ ' + formattedExpDate;
                        }
                    }
                    str += '</div>';
                    str += '</li>';
                    
                    
                 
                });
            } else {
                str += '<li>진행 이벤트가 없습니다.</li>';
            }

            str += '</ul>';
            $(".event-list").html(str);
            console.log("str -> ", str);
         	
            // 더보기 4개씩 보이게 하기
            moreItem(".event-list", ".ordrAccordion-item", 4);
        },
        error: function(err) {
            console.error("AJAX 요청 실패:", err);
        }
    });
}

// 더보기 
function moreItem(bigFrame, executionPlace, cnt) {
	// 큰 틀 : bigFrame , 실행될 틀 : executionPlace, 더보기는 4개씩
    // 모든 항목 숨김
    $(executionPlace).hide();
    
    // 처음 N개 항목만 표시
    $(executionPlace).slice(0, cnt).show();

    // 기존의 더보기 버튼이 있을 경우 제거
    $(bigFrame).find(".view-more").remove();

    // 더보기 버튼 추가
    if ($(executionPlace).length > cnt) {
        $(bigFrame).append(`
            <div class="view-more">
                <div class="more-btn">
                    <span class="material-symbols-outlined">add</span>더보기
                </div>
            </div>
        `);
    }

    // 더보기 버튼 클릭 이벤트
    $(".more-btn").off("click").on("click", function(e) {
        e.preventDefault();

        // 숨겨진 다음 N개 항목 선택
        var hiddenItems = $(executionPlace + ":hidden").slice(0, cnt); 
        hiddenItems.show(); // 선택된 항목을 보여줌

        // 더 이상 숨겨진 항목이 없을 경우 더보기 버튼 숨김
        if ($(executionPlace + ":hidden").length === 0) {
            $(this).closest(".view-more").hide();
        }
    });
}

// 이벤트 ajax
$(document).ready(function() {
	// 진행중인 이벤트가 먼저 뜨게 함
	eventIng();
	
    // 초기 5개의 항목만 표시
    $(".ordrAccordion-item").slice(0, 4).show();  // show()를 사용하여 첫 5개 항목을 표시

    $(".more-btn").click(function(e) {
        e.preventDefault();

        // 더보기 버튼 클릭 시, 숨겨진 다음 5개의 항목을 표시
        var hiddenItems = $(".ordrAccordion-item:hidden").slice(0, 4);  // 아직 보여지지 않은 항목 중 5개 선택
        hiddenItems.show();  // 선택된 항목을 보여줌

        // 더 이상 숨겨진 항목이 없을 경우 '더보기' 버튼 숨김
        if ($(".ordrAccordion-item:hidden").length === 0) {
            $(".more-btn").hide();
        }
    });
    

    
    $('.tap-select.tap-stop').on('click',function(){
        console.log("액티브1");
          if($(this).is('.tap-select.tap-stop')) {
              $(".tap-select.tap-ing.active").removeClass('active');
              $(this).addClass('active');
          } // if 끝

     });// .tap-select tap-stop' 끝
     
     
     $('.tap-select.tap-ing').on('click',function(){
        console.log("액티브2");
        $("#listBox").hide();
         if($(this).is('.tap-select.tap-ing')) {
             $('.tap-select.tap-stop.active').removeClass('active');
             $(this).addClass('active');
             } // if 끝

    });// .tap-select tap-ing 끝
    
    
    $(".tap-select.tap-ing").on("click", function() {
        console.log("selectEventAjax -> 이벤트 실행");
        // 진행 이벤트 ajax 실행
        eventIng();
       
    }); // ajax 끝

   
   	// 종료된 이벤트 조회
    $(".tap-select.tap-stop").on("click", function() {
        console.log("selectEndEventAjax -> 종료된 이벤트 실행");
        $("#listBox").hide();
        
        
        $.ajax({
            url: "/buff/selectEndEventAjax",
            type: "get",
            dataType: "json",
            success: function(result) {
                // 성공 시 진행 중인 이벤트 조회
                console.log("이벤트 실행 성공", result);

                $(".list-box").html("");
            let str = '';
               str += '<ul class="list-box">';

                if (result && result.eventVOList && Array.isArray(result.eventVOList)) {
                    $.each(result.eventVOList, function(index, eventVO) {
                        str += '<li onclick="window.location.href=\'/buff/insertEventCoupon?eventNo=' + eventVO.eventNo + '\'" class="ordrAccordion-item"  style="display: list-item;">';
                        str += '<div class="img-box">';
                        str += '<span style="background-image: url('+ eventVO.fileDetailVOList[0].fileSaveLocate +'); filter: brightness(0.5);"></span>';
                        str += '</div>';
                        str += '<div class="list-title">';
                        str += '<a href="/cust/insertEventCoupon?eventNo=' + eventVO.eventNo + '">' + eventVO.eventTtl + '</a>';
                        str += '</div>';
                        str += '<div class="list-txt">';

                        if (eventVO.bgngYmd) {
                            let year = eventVO.bgngYmd.substring(0, 4);
                            let month = eventVO.bgngYmd.substring(4, 6);
                            let day = eventVO.bgngYmd.substring(6, 8);
                            let formattedDate = year + '-' + month + '-' + day;

                            if (eventVO.expYmd) {
                                let expYear = eventVO.expYmd.substring(0, 4);
                                let expMonth = eventVO.expYmd.substring(4, 6);
                                let expDay = eventVO.expYmd.substring(6, 8);
                                let formattedExpDate = expYear + '-' + expMonth + '-' + expDay;

                                str += formattedDate + ' ~ ' + formattedExpDate;
                            }
                        }
                        str += '</div>';
                        str += '</li>';
                    });
                } else {
                    str += '<li>진행 이벤트가 없습니다.</li>';
                }

               str += '</ul>';
                $(".event-list").html(str);
                console.log("str -> ", str);
                
                // 더보기 4개씩 보이게 하기
                moreItem(".event-list", ".ordrAccordion-item", 4);
                
            },
            error: function(err) {
                console.error("AJAX 요청 실패:", err);
            }
        });
    }); // ajax 끝

    
    
    
}); // 전체 끝






</script>

<style>

.ordrAccordion-item {
   display: none;"
}

</style>

<div class="wrap menu-wrap">
   <!-- 공통 컨테이너 영역 -->   
   <div class="wrap-cont">

      <!-- 공통 타이틀 영역 -->
      <div class="wrap-title">이벤트 소개</div>
      <!-- /.wrap-title -->
      
      <!-- 탭 영역 -->
      <form action="/buff/selectEvent" method="get">
         <div class="menu-tap">
            <div class="tap-select tap-ing active">
               <div class="tap-icon" id="divFestival">
                  <span class="material-symbols-outlined">festival</span>
               </div> 
               <div class="tap-nm" id="ingEvent">진행</div>
            </div>

            <div class="tap-select tap-stop">
               <div class="tap-icon" id="divBlock">
                  <span class="material-symbols-outlined">block</span>
               </div>
               <div class="tap-nm">종료</div>
            </div>
         </div>
      </form>       
      <!-- /.menu-tap -->

      <!-- 메뉴 영역 -->
      <div class="event-list">
         <!-- ajax 실행될 영역 -->
      </div>
      <!-- /.event-list -->

     <!--  <div class="view-more">
         <div class="more-btn">
            <span class="material-symbols-outlined">add</span>더보기
         </div>
      </div> -->
      <!-- /.view-more -->

   </div>
   <!-- /.wrap-cont -->
</div>
<!-- /.wrap -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
