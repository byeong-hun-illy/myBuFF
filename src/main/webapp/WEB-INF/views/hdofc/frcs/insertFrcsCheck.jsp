<%--
 	@fileName    : insertFrcsCheck.jsp
 	@programName : 가맹점 점검 추가
 	@description : 점검 추가를 위한 페이지
 	@author      : 송예진
 	@date        : 2024. 09. 19
--%>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="/resources/hdofc/css/frcs.css" rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/hdofc/js/frcs.js"></script>
<script src="/resources/hdofc/js/frcsCheck.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<sec:authentication property="principal.MemberVO" var="user"/>
<script>
let currentPage = 1;
let chk = 'chk';
let sort = 'chckYmd';
let orderby = 'asc';
let mngrId = '${user.mbrId}';
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
$(function(){
	/* 부스트랩 툴팁 사용 */
	tooltipCustom();
	
	select2Custom();
	// 누르기 전에 라디오 버튼 안눌리게 하기
	 $('input[type="radio"]').prop('disabled', true);
	 $('.all').prop('disabled', true);
	
	 // uploadUrl => 이미지 업로드 시 요청할 요청URI
    // editor => CKEditor가 생성된 후 바로 그 객체
    // window.editor : 그 객체를 이렇게 부르겠다 정의
    ClassicEditor.create(document.querySelector('#TEXTAREATEMP'), {
        ckfinder: {
            uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}',
        }
    })
    .then(editor => {
        window.editor = editor;

        // Update the textarea whenever the editor data changes
        editor.model.document.on('change:data', () => {
            const data = editor.getData();
//             console.log("str : " + data);
            $("#chckCn").val(data);  // Update the textarea
        });
        $('#resetBtn').click(function() {
            editor.setData('');  // Clear the CKEditor content
            $("#chckCn").val('');  // Clear the textarea content
        });
    })
    .catch(err => {
        console.error(err.stack);
    });
	
	var frcsModal = new bootstrap.Modal(document.getElementById('frcsModal'), {
		 backdrop: 'static',  // 모달 외부 클릭 시 닫히지 않도록 설정
	     keyboard: false      // ESC 키로 모달 닫기 비활성화
	})
	
	// 모달 닫기
	$('.modal-close').on('click',function(){
		frcsModal.hide();
	})
	
	$('#frcs').on('click', function(){
		frcsModal.show();
		selectFrcsListAjax();
	})
	// 검색어 검색 결과
	$('#submit').on('click',function(){
		currentPage=1;
		selectFrcsListAjax();
	})
	// 분류 조건 클릭 시 스타일 변화와 데이터 변화
	$('.tap-cont').on('click', function(){
		currentPage=1;
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.tap-cont').removeClass('active');

	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
 		chk = $(this).data('type');
 		selectFrcsListAjax();
	})
	// 페이징 처리
	$(document).on('click','.page-link',function(){
		currentPage = $(this).data('page');
		console.log($(this).data('page'));
		console.log(currentPage);
		selectFrcsListAjax();
	})
	
	//////////////////////// 정렬  ////////////////////////////////
	$('.sort').on('click',function(){
		
	      // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
	      var sortAsc = $('.sort-arrow', this).find('.sort-asc');
	      var sortDesc = $('.sort-arrow', this).find('.sort-desc');
	      
	      sort = $(this).data('sort');
	      $('.sort').removeClass('active');
	      $(this).addClass('active');
	      // 첫 번째 자식이 active 클래스가 있는지 확인
	      if (!sortAsc.hasClass('active')) { // desc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	      
	        	sortAsc.addClass('active');
	        	
	        	orderby = 'asc';
	      } else{ // asc
	    	  // 모든 th의 active 클래스를 제거
	          $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	    	  
	        	sortDesc.addClass('active');
	        	orderby = 'desc';
	    	  
	      }
	      currentPage=1;
	      selectFrcsListAjax();
	})
	
	/////////////////////////////////////////////////////////////////////
	
	// 선택
	$(document).on('click','.frcsDtl', function(){
		frcsModal.hide();
		let bzentNo = $(this).data("no");
		let bzentNm = $(this).data("nm");
		let rgnNm = $(this).data("rgn");
		
		$('#rgnNm').val(rgnNm);
		$('#bzentNm').val(bzentNm);
		$('#bzentNo').val(bzentNo);
		
		// 가맹점이 입력되면 라디오버튼 활성화
		$('input[type="radio"]').prop('disabled', false);
		$('.all').prop('disabled', false);
	})
	
	// 표를 눌러도 radio버튼 눌리게 설정
	$('.td-chk').on('click', function(){
		let child = $(this).find('input');
		
	    // disabled 속성이 false일 때만 체크 가능하도록 설정
	    if (!child.prop('disabled')) {
	        child.prop('checked', true);
	    }
	})
	
	$('.all').on('click', function(){
		let classNm = $(this).data('class');
		
		 // 해당 클래스를 가진 버튼들을 선택하여 checked 상태로 만듦
	    $('.' + classNm).prop('checked', true);
	})
	
	$('#insertFrcsCheck').on('click', function(){
		let allCheck = true;
		let cnt = 0;
		$('.chk-table').each(function(){
			if($(this).is(':checked')){
				cnt++;
			};
		})
		
		if(cnt<10){
			allCheck = false;
		}
		
		if(allCheck){
			Swal.fire({
				  title: "확인",
				  html: "점검 항목은 삭제가 가능하나 수정이 불가합니다<br>정말로 생성하시겠습니까?",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#00C157",
				  cancelButtonColor: "#E73940",
				  confirmButtonText: "생성",
				  cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						insertFrcsCheck();
						Swal.fire({
							  icon: "success",
							  title: "점검 추가가 완료되었습니다",
							  showConfirmButton: false,
							  timer: 1000
						});
					}
				});
		} else{
			Swal.fire({
				  title: "에러",
				  html: "필수 정보를 입력해주세요.",
				  icon: "error",
				  confirmButtonColor: "#00C157",
				  confirmButtonText: "확인"
				});
		}
	})
	/////// 초기화
	$('#resetBtn').on('click', function(){
		$('input').val('');
		$('input[type="radio"]').prop('checked', false);
	})
})
</script>
<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3" onclick="location.href='/hdofc/frcs/check/list'"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">점검 등록</h1>
	        <div style="margin-left: var(--gap--l)"><span class="es">*</span> 표기된 항목은 필수입력 항목입니다.</div>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default" id="resetBtn">초기화</button>
			<button type="button" class="btn-active" id="insertFrcsCheck">저장하기 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap 시작 -->
<div class="wrap">
	
	<!-- cont 시작  가맹점 선택-->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>가맹점 정보 <span class="es">*</span></div> 
			</div>
			<table class="table-blue">
				<tr>
					<th style="width:15%;">가맹점명</th>
					<td>
						<input placeholder="선택해주세요" required disabled type="text" id="bzentNm" name="bzentNm"/>
						<button type="button" id="frcs" class="update-btn update-mngr"></button>
						<input placeholder="선택해주세요" type="text" id="bzentNo" name="bzentNo" hidden/>
					</td>
					<th style="width:15%;">지역</th>
					<td><input disabled placeholder="선택해주세요" type="text" id="rgnNm" name="rgnNm"/></td>
				</tr>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
	<!-- cont 끝  가맹점 선택-->
	
	<!-- cont 시작 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>점검 정보 <span class="es">*</span></div> 
			</div>
			<table class="table-blue">
				<tr>
					<th style="text-align: center;" rowspan="2">구 분</th>
					<th style="text-align: center;" rowspan="2">점검 항목</th>
					<th style="text-align: center;" colspan="3">
						<div class="row" style="justify-content: center;align-items: center; gap:var(--gap--s);">
						<span>점검 결과</span>
						<div class="tooltip-wrap">
							<button type="button" class="tooltip-custom"
								data-bs-toggle="tooltip"
								title="버튼을 클릭하면 모든 상태가 한 번에 변경됩니다. 되돌릴 수 없으니 신중히 선택해주세요.">
							<span class="tooltip-icon material-symbols-outlined">info</span>
							</button>
						</div>
						</div>
					</th>
				</tr>
				<tr>
					<th style="text-align: center;">
						<button class="all btn btn-info" data-class="good">양호</button>
					</th>
					<th style="text-align: center;">
						<button class="all btn btn-info" data-class="nomal">보통</button>
					</th>
					<th style="text-align: center;">
						<button class="all btn btn-info" data-class="bad">부적합</button>
					</th>
				</tr>
				<tr>
					<td rowspan="5">위생</td>
					<td>조리기구 및 식기 세척 상태</td>
					<td class="center td-chk"><input required type="radio" name="cln1" class="chk-table cln good" value="10"></td>
					<td class="center td-chk"><input required type="radio" name="cln1" class="chk-table cln nomal" value="5"></td>
					<td class="center td-chk"><input required type="radio" name="cln1" class="chk-table cln bad" value="0"></td>
				</tr>
				<tr>
					<td>매장 내 청결 상태</td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln good" name="cln2" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln nomal" name="cln2" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln bad" name="cln2" value="0"></td>
				</tr>
				<tr>
					<td>쓰레기통 및 폐기물 관리</td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln good" name="cln3" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln nomal" name="cln3" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln bad" name="cln3" value="0"></td>
				</tr>
				<tr>
					<td>유통기한(신선도) 준수 여부</td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln good" name="cln4" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln nomal" name="cln4" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln bad" name="cln4" value="0"></td>
				</tr>
				<tr>
					<td>조리 시 개인 위생 수칙 준수</td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln good" name="cln5" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln nomal" name="cln5" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table cln bad" name="cln5" value="0"></td>
				</tr>
				<tr>
					<td rowspan="5">서비스</td>
					<td>직원의 친절도 및 고객 응대 태도</td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv good" name="srv1" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv nomal" name="srv1" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv bad" name="srv1" value="0"></td>
				</tr>
				<tr>
					<td>고객 문의에 대한 신속한 응대 여부</td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv good" name="srv2" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv nomal" name="srv2" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv bad" name="srv2" value="0"></td>
				</tr>
				<tr>
					<td>주문 처리의 정확성 및 신속함</td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv good" name="srv3" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv nomal" name="srv3" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv bad" name="srv3" value="0"></td>
				</tr>
				<tr>
					<td>고객 대기 시간의 적정선</td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv good" name="srv4" value="10"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv nomal" name="srv4" value="5"></td>
					<td class="center td-chk"><input required type="radio" class="chk-table srv bad" name="srv4" value="0"></td>
				</tr>
				<tr>
					<td>고객의 의견 및 불만 사항 처리 절차</td>
					<td class="center td-chk"><input required type="radio"
						class="chk-table srv good" name="srv5" value="10"></td>
					<td class="center td-chk"><input required type="radio"
						class="chk-table srv nomal" name="srv5" value="5"></td>
					<td class="center td-chk"><input required type="radio"
						class="chk-table srv bad" name="srv5" value="0"></td>
				</tr>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
	<!-- cont 끝 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
		<div class="table-title">
			<div class="cont-title"><span class="material-symbols-outlined title-icon">playlist_add</span>점검 상세 정보</div> 
			</div>
			<div class="bar"></div>
			<div id="TEXTAREATEMP"></div>
			<textarea rows="3" id="chckCn" cols="" hidden></textarea>
		</div>
	</div>
</div>
<!-- wrap 끝 -->

<!-- 가맹점 추가 모달 창 -->
<jsp:include page="/WEB-INF/views/hdofc/modal/frcsCheckModal.jsp" />