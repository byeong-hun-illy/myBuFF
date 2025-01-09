<%--
 	@fileName    : insertEvent.jsp
 	@programName : 이벤트 등록
 	@description : 이벤트 등록을 위한 페이지
 	@author      : 정기쁨
 	@date        : 2024. 09. 19
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="/resources/hdofc/css/event.css"/>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/hdofc/js/event.js"></script>
<script type="text/javascript">
var menuType = '';
var menuNo = '';
var evnetNo = '';
$(function(){
 	// CKEditor5
	$(".ck-blurred").keydown(function(){
		// window.editor : CKEditor 객체
		//console.log("str : "+window.editor.getData());
		$("#eventCn").val(window.editor.getData());
	})
	// CKEditor로부터 커서 및 마우스 이동 시 마지막 단어까지 출력 되도록 처리
	$(".ck-blurred").on("focusout",function(){
		$("#eventCn").val(window.editor.getData());
	})
	
	/* 메뉴 모달창 시작  */
	menuModalAjax();
	
	// 메뉴 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	    
	    menuType = $(this).data('type');
	    
	    console.log(menuType);
	    
	    menuModalAjax();
	})
	
	// 메뉴 tr 클릭 시 menuNo 가져오기
	$(document).on('click','#menuNo',function(){
		$('#menuNm').val($(this).data('nm'));
		$('#menuNo').val($(this).data('no'));
	})
	/* 메뉴 모달창 끝 */
	
	// 초기화 버튼 클릭 시
	$('#resetBtn').on('click',function(){
		$('#eventInserform')[0].reset();
	})
	
	// 이벤트 등록 저장 클릭 시
	$('#submitBtn').on('click',function(){
		$('#eventInserform').submit();
	})
	
})
</script>

<!-- content-header: 이벤트 관리 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="window.location.href='/hdofc/event/selectEventList'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">이벤트 등록</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default" id="resetBtn">초기화</button>
			<button type="button" class="btn-active" id="submitBtn">저장하기 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->


<!-- wrap -->
<div class="wrap">

	<!-- cont: 이벤트 등록을 위한 테이블 -->
	<div class="cont">
		<!-- table-wrap -->
		<form id="eventInserform" action="/hdofc/event/eventInsert" method="post" enctype="multipart/form-data">
		<div class="table-wrap">
			<div class="table-title blue">
				<div class="cont-title">이벤트 정보 입력</div> 
			</div>
			<table class="table-blue">
				<tr>
					<th>제목</th>
					<td style="width: 480px;">
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.memberVO" var="user"/>
							<input type="text" id=mngrId name="mngrId" class="text-input" value="${user.mbrId}" hidden="hidden" />
						</sec:authorize>
						<input type="text" id="eventTtl" name="eventTtl" class="text-input" placeholder="입력해주세요" />
					</td>
					<th>기간</th>
					<td colspan="5">
						<input type="date" id="bgngYmd" name="bgngYmd" /> 
							~ 
						<input type="date" id="expYmd" name="expYmd" />
					</td>
				</tr>
				<tr>
					<th>쿠폰 이름</th>
					<td>
						<input type="text" id="couponNm" name="couponNm" class="text-input" placeholder="입력해주세요" />
					</td>
					<th>할인 가격</th>
					<td>
						<input type="number" id="dscntAmt" name="dscntAmt" class="text-input" placeholder="입력해주세요" />
					</td>
					<th>쿠폰 발급 수량</th>
					<td>
						<input type="number" id="issuQty" name="issuQty" class="text-input" placeholder="0" />
					</td>
				</tr>
				<tr>
					<th>메뉴</th>
					<td colspan="5">
						<div class="menu-wrap">
							<div class="menu-cont">
								<input type="text" id="menuNm" name="menuNm" class="text-input" placeholder="메뉴를 선택해주세요" disabled />
								<input type="text" id="menuNo" name="menuNo" hidden="hidden" />
							</div>
							<div class="menu-cont">
								<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalMenu">메뉴 선택 <span class="icon material-symbols-outlined">East</span></button>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5">
						<div id="TEXTAREATEMP"></div>
						<textarea id="eventCn" name="eventCn" rows="13" cols="1" spellcheck="false" hidden="hidden"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<sec:csrfInput/>
		<!-- table-wrap -->
		</form>
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
</div>
<!-- /.wrap -->	


<div class="modal fade" id="modalMenu">
	<div class="modal-dialog modal-m">
		<div class="modal-content">
			<div class="modal-header row align-items-center justify-content-between">
				<div>
					<h4 class="modal-title">메뉴 선택</h4>
				</div>
				<div>
				  	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
      		</div>
      	<div class="modal-body">
			<div class="table-wrap">
				<div class="tap-wrap">
					<div data-type='' class="tap-cont active">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-total">1021</span>
					</div>
					<div data-type='MENU01' class="tap-cont">
						<span class="tap-title">세트</span>
						<span class="bge bge-warning" id="tap-set">1021</span>
					</div>
					<div data-type='MENU02' class="tap-cont">
						<span class="tap-title">햄버거</span>
						<span class="bge bge-active" id="tap-hambur">1021</span>
					</div>
					<div data-type='MENU03' class="tap-cont">
						<span class="tap-title">사이드</span>
						<span class="bge bge-danger" id="tap-side">1021</span>
					</div>
					<div data-type='MENU04' class="tap-cont">
						<span class="tap-title">음료</span>
						<span class="bge bge-info" id="tap-drink">1021</span>
					</div>
				</div>
			
				<table class="table-default event-menu-table">
					<!-- menuModalAjax()로 출력 될 영역 -->
				</table>
			</div>
			<!-- table-wrap -->
		</div>
		<!-- /.modal-body -->
	</div>
    <!-- /.modal-content -->
	</div>
  <!-- /.modal-dialog -->
</div>

<!-- 시큐리터 -->
<script type="text/javascript">
// uploadUrl : 이미지 업로드 시 요청 할 요청URI
// editor : CKEditor가 생성된 후 바로 그 객체
// window.editor : editor 객체를 'window.editor'라고 선언
ClassicEditor.create( document.querySelector('#TEXTAREATEMP'),{ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});
</script>


















