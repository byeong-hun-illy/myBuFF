<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
$(function(){
	
	/* 부스트랩 툴팁 사용 */
	tooltipCustom();
	 
	// 셀렉트 디자인 라이브러리. common.js에서 호출 됨
	select2Custom(); 
	
	// 유형 셀렉트 바뀌면 탭의 유형도 변화
	$('#eventType').on('change',function(){
		$('.tap-cont').removeClass('active');
		eventTyep = $(this).val();
		
		if(eventTyep == 'EVT01'){
			$('.tap-cont[data-type="EVT01"]').addClass('active');
		}
		else if(eventTyep == 'EVT02'){
			$('.tap-cont[data-type="EVT02"]').addClass('active');
		}
		else if(eventTyep == 'EVT03'){
			$('.tap-cont[data-type="EVT03"]').addClass('active');
		}
		else if(eventTyep == 'EVT04'){
			$('.tap-cont[data-type="EVT04"]').addClass('active');
		}
		else if(eventTyep == 'EVT05'){
			$('.tap-cont[data-type="EVT05"]').addClass('active');
		}
		else{
			$('.tap-cont[data-type=""]').addClass('active');
		}
	})
	
	// th 정렬 기능
	$('.sort').on('click',function(){
		 // 1페이지 부터 시작
		 currentPage=1; 
		 // 정렬 색상 변경 이벤트 호출
		 sort = $(this);
		 thClickEvent(sort);
		 // 리스트 호출
		 selectMngrAjax();
	})
	
	// 검색영역 초기화
	$('.search-reset').on('click', function(){
		// 인풋 데이터 가져오기
		let bgngYmd= $('#bgngYmd').val('');
		let expYmd= $('#expYmd').val('');
		let couponGubun= $('#couponGubun').val('');
		let eventTtl = $('#eventTtl').val('');
		$('#dateSummary, #couponSummary, #ttlSummary').text('미선택');
		
		// 정렬 초기화 이벤트 호출
		resetSort( $('.sort[data-sort="jncmpYmdSort"]'), $('.sort[data-orderby="desc"]') ); // 초기값 꼭 넣어주기!!!!
				
		selectEventAjax();
	})
	//.search-reset
	
	
	// 검색영역 요약보기
	$('.search-toggle').on('click',function(){
		
	   	if ($(this).hasClass('active')){
	   		$(this).removeClass('active');
	   		$('.search-toggle').html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
	   		$('.search-original').slideDown(300);
	   		$('.search-summary').slideUp(300);
	   	} else {
	   		$(this).addClass('active');
	   		$('.search-toggle').html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
	   		$('.search-original').slideUp(300);
	   		$('.search-summary').slideDown(300);
	   	} 
		
	   	/* 아래 부분은 구현하는 페이지에 맞춰서 작성해주세요!! */
		// 인풋 데이터 가져오기
		let bgngYmd= $('#bgngYmd').val();
		let expYmd= $('#expYmd').val();
		let couponGubun= $('#couponGubun').val();
		let eventTtl = $('#eventTtl').val();

		dateStr = `\${bgngYmd} ~ \${expYmd}`;
		
		// 이벤트 기간 데이터 입력
		if(bgngYmd=='' & expYmd==''){
			$('#dateSummary').text('미선택');
		}else {
			$('#dateSummary').text(dateStr);
		}
		// 쿠폰 데이터 입력
		if(couponGubun==''){
			$('#couponSummary').text('미선택');
		}else {
			$('#couponSummary').text(couponGubun);
		}
		// 제목 데이터 입력
		if(eventTtl==''){
			$('#ttlSummary').text('미선택');
		}else {
			$('#ttlSummary').text(eventTtl);
		}
		
	})
	//.search-toggle
	
	// 테이블 탭 클릭 시 스타일 변화와 데이터 변화
	$('.page-tap-cont').on('click', function(){
		// 모든 tap-cont에서 active 클래스를 제거
	    $('.page-tap-cont').removeClass('active');
	    // 클릭된 tap-cont에 active 클래스를 추가
	    $(this).addClass('active');
	})
	
	// 전체 선택 체크박스
	$('.check-btn.all').on('click',function(){
		if($(this).is(":checked")){ // 선택 되었다면
			$('.check-btn').prop("checked", true);
		}else { // 선택 되지 않았다면
			$('.check-btn').prop("checked", false);
		}
	})
})
</script>

<style>
.select2-selection[aria-labelledby="select2-couponGubun-container"] {
	width: 250px !important;
}
.select2-selection[aria-labelledby="select2-couponGubun-container"] .select2-dropdown {
	width: 148px !important;
}
</style>

<!-- content-header: 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">페이지명</h1>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- content-header: 상세 페이지 이름 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 align-items-center">
      	<button type="button" class="btn btn-default mr-3"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
        <h1 class="m-0">페이지명</h1>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- content-header: 상세 페이지 버튼 있는 버전 -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2 justify-content-between">
      	<div class="row align-items-center">
	      	<button type="button" class="btn btn-default mr-3"><span class="icon material-symbols-outlined">keyboard_backspace</span> 목록으로</button>
	        <h1 class="m-0">페이지명</h1>
      	</div>
    	<div class="btn-wrap">
			<button type="button" class="btn-default" id="resetBtn">초기화</button>
			<button type="button" class="btn-active" id="submitBtn">등록 <span class="icon material-symbols-outlined">East</span></button>
		</div>
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- wrap -->
<div class="wrap">
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">기본 태그</div>
		<div style="display:flex; flex-direction:column; gap: 4px;">
			<a href="#none">a tag</a>
			<p>p tag</p>
			<span>span tag</span>
			<div>div tag</div>
			<ul>
				<li>li tag</li>
				<li>li tag</li>
				<li>li tag</li>
				<li>li tag</li>
			</ul>	
			<div>
				<input type="checkbox" class="check-btn" id="toolti-checkbox" name="toolti-checkbox">	
	       		<label for="toolti-checkbox"><span>선택</span></label>
	       </div>
			<div class="tooltip-wrap">
				<button type="button" class="tooltip-custom"
					data-bs-toggle="tooltip"
					title="툴팁으로 보여줄 내용을 작성해주세요!">
				<span class="tooltip-icon material-symbols-outlined">info</span>
				</button>
			</div>
		</div>		
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">인풋</div>
		<div>
			<input type="text" placeholder="활성화"/>
			<input type="text" placeholder="비활성" disabled/>
		</div>
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">버튼</div> 
		<div>
			<button class="btn-default">btn-default</button>
			<button class="btn-active">btn-active</button>
			<button class="btn-disabled">btn-disabled</button>
			<button class="btn-default" id="gdsExcel">엑셀<span class="material-symbols-outlined icon">download</span></button> 
		</div>
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">뱃지</div> 
		<div style="display:flex; gap: 4px;">
			<span class="bge bge-default">bge-default</span>
			<span class="bge bge-active">bge-active</span>
			<span class="bge bge-danger">badge-danger</span>
			<span class="bge bge-warning">badge-warning</span>
			<span class="bge bge-info">bge-info</span>
			<span class="bge bge-default-border">bge-default</span>
			<span class="bge bge-active-border">bge-active</span>
			<span class="bge bge-danger-border">badge-danger</span>
			<span class="bge bge-warning-border">badge-warning</span>
			<span class="bge bge-info-border">badge-info</span>
		</div>
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- search-section: 검색 영역 -->
	<div class="search-section">
		<!-- cont: 검색 영역 -->
		<div class="cont search-original">
			<div class="search-wrap">
				<!-- 진행상태 검색조건 -->
				<div class="search-cont">
					<p class="search-title">진행상태</p>
					<div class="select-custom" style="width:150px">
						<select name="eventType" id="eventType">
							<option value="">전체</option>
							<option value="EVT01" selected>대기</option>
							<option value="EVT04">진행</option>
							<option value="EVT03">예정</option>
							<option value="EVT05">완료</option>
							<option value="EVT02">취소</option>
						</select>
					</div>
				</div>
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간</p>
					<div class="search-date-wrap">
						<input type="date" id="bgngYmd" name="bgngYmd"> 
							~ 
						<input type="date" id="expYmd" name="expYmd">
					</div>
				</div>
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">쿠폰</p>
					<div class="search-coupon-wrap">
						<select class="select2-custom" id="couponGubun" name="couponGubun">
							<option value="" selected>전체</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
							<option value="">test</option>
						</select>
					</div>
				</div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목</p>
					<input type="text" id="eventTtl" name="eventTtl" placeholder="검색어를 입력하세요"> 
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- cont:  검색 접기 영역 -->
		<div class="cont search-summary">
			<div class="search-wrap">
				<!-- 일자 검색조건 -->
				<div class="search-cont">
					<p class="search-title">이벤트 기간 <span class="summary" id="dateSummary">이벤트기간</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 셀렉트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">쿠폰 <span class="summary" id="couponSummary">쿠폰</span></p>
				</div>
				<div class="divide-border"></div>
				<!-- 텍스트 검색조건 -->
				<div class="search-cont">
					<p class="search-title">제목 <span class="summary" id="ttlSummary">제목</span></p>
				</div>
			</div>
			<!-- /.search-wrap -->
		</div>
		<!-- /.cont: 검색 영역 -->
		
		<!-- 검색 버튼 영역 -->
		<div class="search-control">
			<div class="search-control-btns">
				<div class="search-toggle">
					요약보기<span class="icon material-symbols-outlined">Add</span>
				</div>
				<div class="search-reset">
					초기화<span class="icon material-symbols-outlined">restart_alt</span>
				</div>
				<div>
					<button class="btn btn-default search" id="searchBtn">검색 <span class="icon material-symbols-outlined">search</span></button>
				</div>		
			</div>
		</div>
		<!-- /.검색 버튼 영역 -->
		<!-- /.search-section: 검색어 영역 -->
	</div>
	<!-- /.search-section -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">진행탭 예시</div> 
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-wrap">
				<div data-type=''  class="tap-cont">
					<span class="tap-title">전체</span>
					<span class="bge bge-default" id="tap-all">1021</span>
				</div>
				<div data-type='EVT01'  class="tap-cont active">
					<span class="tap-title">대기</span>
					<span class="bge bge-info" id="tap-waiting">1021</span>
				</div>
				<div data-type='EVT04'  class="tap-cont">
					<span class="tap-title">진행</span>
					<span class="bge bge-active" id="tap-progress">1021</span>
				</div>
				<div data-type='EVT03'  class="tap-cont">
					<span class="tap-title">예정</span>
					<span class="bge bge-warning" id="tap-scheduled">1021</span>
				</div>
				<div data-type='EVT05'  class="tap-cont">
					<span class="tap-title">완료</span>
					<span class="bge bge-danger" id="tap-completed">1021</span>
				</div>
				<div data-type='EVT02'  class="tap-cont">
					<span class="tap-title">취소</span>
					<span class="bge bge-danger" id="tap-cancelled">1021</span>
				</div>
			</div>
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th>아이디</th>
						<th class="center">이름</th>
						<th class="center">생년월일</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>주소</th>
						<th class="center">가입일자</th>
						<th class="center">탈퇴여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center">1</td>
						<td>tieawu5d</td>
						<td class="center">배서영</td>
						<td class="center">20030303</td>
						<td>010-1234-0665</td>
						<td>1rz0fn7b@naver.com</td>
						<td>강원도 춘천시 중앙로 890 101호</td>
						<td class="center">20230501</td>
						<td class="center">-</td>
					</tr>
				</tbody>
			</table>
			<!-- pagination-wrap -->
			<div class="pagination-wrap">
				<div class="pagination">
				  <a href="#none"><span class="icon material-symbols-outlined">chevron_left</span></a>
				  <a href="#none">1</a>
				  <a href="#none" class="active">2</a>
				  <a href="#none">3</a>
				  <a href="#none">4</a>
				  <a href="#none">5</a>
				  <a href="#none"><span class="icon material-symbols-outlined">chevron_right</span></a>
				</div>
			</div>
			<!-- pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">진행탭+버튼 예시</div> 
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div data-type=''  class="tap-cont">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all">1021</span>
					</div>
					<div data-type='EVT01'  class="tap-cont active">
						<span class="tap-title">대기</span>
						<span class="bge bge-info" id="tap-waiting">1021</span>
					</div>
					<div data-type='EVT04'  class="tap-cont">
						<span class="tap-title">진행</span>
						<span class="bge bge-active" id="tap-progress">1021</span>
					</div>
					<div data-type='EVT03'  class="tap-cont">
						<span class="tap-title">예정</span>
						<span class="bge bge-warning" id="tap-scheduled">1021</span>
					</div>
					<div data-type='EVT05'  class="tap-cont">
						<span class="tap-title">완료</span>
						<span class="bge bge-danger" id="tap-completed">1021</span>
					</div>
					<div data-type='EVT02'  class="tap-cont">
						<span class="tap-title">취소</span>
						<span class="bge bge-danger" id="tap-cancelled">1021</span>
					</div>
				</div>
				<div class="btn-wrap">
					<button class="btn-default">버튼</button>
					<button class="btn-active">버튼</button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="center">번호</th>
						<th>아이디</th>
						<th class="center">사진</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>주소</th>
						<th class="center">가입일자</th>
						<th class="center">탈퇴여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center">1</td>
						<td>tieawu5d</td>
						<!-- td-img클래스로 사진너비를 테이블 크기와 맞춤,사진 크기는 여기서 조정해줄 것 -->
						<td class="center td-img" style="width:15%"> 
							<div class="position-relative">
								<img alt="" src="https://frankburger.co.kr/img/page/2022_menu/01/menu1_img21.jpg">
								<div class="ribbon-wrapper ribbon-s">
									<div class="ribbon bg-danger text-s">
										NEW
									</div>
								</div>
							</div>
						</td>
						<!-- 사진 td끝 -->
						<td>010-1234-0665</td>
						<td>1rz0fn7b@naver.com</td>
						<td>강원도 춘천시 중앙로 890 101호</td>
						<td class="center">20230501</td>
						<td class="center">-</td>
					</tr>
				</tbody>
			</table>
			<!-- pagination-wrap -->
			<div class="pagination-wrap">
				<div class="pagination">
				  <a href="#none"><span class="icon material-symbols-outlined">chevron_left</span></a>
				  <a href="#none">1</a>
				  <a href="#none" class="active">2</a>
				  <a href="#none">3</a>
				  <a href="#none">4</a>
				  <a href="#none">5</a>
				  <a href="#none"><span class="icon material-symbols-outlined">chevron_right</span></a>
				</div>
			</div>
			<!-- /.pagination-wrap -->
		</div>
		<!-- table-wrap -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명  -->
	<div class="cont">
		<div class="cont-title">검색 결과 없을 때 예시</div> 
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="tap-btn-wrap">
				<div class="tap-wrap">
					<div data-type=''  class="tap-cont">
						<span class="tap-title">전체</span>
						<span class="bge bge-default" id="tap-all">1021</span>
					</div>
					<div data-type='EVT01'  class="tap-cont active">
						<span class="tap-title">대기</span>
						<span class="bge bge-info" id="tap-waiting">1021</span>
					</div>
					<div data-type='EVT04'  class="tap-cont">
						<span class="tap-title">진행</span>
						<span class="bge bge-active" id="tap-progress">1021</span>
					</div>
					<div data-type='EVT03'  class="tap-cont">
						<span class="tap-title">예정</span>
						<span class="bge bge-warning" id="tap-scheduled">1021</span>
					</div>
					<div data-type='EVT05'  class="tap-cont">
						<span class="tap-title">완료</span>
						<span class="bge bge-danger" id="tap-completed">1021</span>
					</div>
					<div data-type='EVT02'  class="tap-cont">
						<span class="tap-title">취소</span>
						<span class="bge bge-danger" id="tap-cancelled">1021</span>
					</div>
				</div>
				<div class="btn-wrap">
					<button class="btn-default">버튼</button>
					<button class="btn-active">버튼</button>
				</div>
			</div>
			<!-- /tap-btn-wrap -->
			<table class="table-default">
				<thead>
					<tr>
						<th class="center" style="width: 3%">번호</th>
						<th class="center" style="width: 3%">진행상태</th>
						<th style="width: 20%">제목</th>
						<th style="width: 3%">담당자</th>
						<th style="width: 5%">이벤트 쿠폰</th>
						<th class="center" style="width: 5%">이벤트 기간</th>
						<th class="center" style="width: 5%">등록일자</th>
					</tr>
				</thead>
				<tbody id="table-body" class="table-error">
					<tr>
						<td class="error-info" colspan="7">
							<span class="icon material-symbols-outlined">error</span>
							<div class="error-msg">검색 결과가 없습니다</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- table-wrap -->
		</div>
		<!-- table-wrap -->
		<!-- pagination-wrap -->
		<div class="pagination-wrap">
			<div class="pagination">
			  <a href="#none"><span class="icon material-symbols-outlined">chevron_left</span></a>
			  <a href="#none">1</a>
			  <a href="#none" class="active">2</a>
			  <a href="#none">3</a>
			  <a href="#none">4</a>
			  <a href="#none">5</a>
			  <a href="#none"><span class="icon material-symbols-outlined">chevron_right</span></a>
			</div>
		</div>
		<!-- /.pagination-wrap -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<div class="cont">
		<div class="cont-title">체크박스+다운로드+링크이동 예시</div> 
		<table class="table-default">
			<thead>
				<tr>
					<th class="right" style="width: 50px">
						<input type="checkbox" class="check-btn all" id="chkBox" name="chkBox"/>
				       	<label for="chkBox"><span></span></label>
					</th>
					<th class="center" style="width: 60px">번호</th>
					<th style="width: 300px">제목</th>
					<th class="center" style="width: 200px">담당자</th>
					<th class="center sort active" data-sort="wrtrDtSort" style="width: 100px" >
						등록일자
						<div class="sort-icon">
							<div class="sort-arrow">
							  <span class="sort-asc active">▲</span>
							  <span class="sort-desc">▼</span>
							</div>
						</div>
					</th>
					<th class="center sort"  data-sort="intCntSort" style="width: 100px" >
						조회수
						<div class="sort-icon">
							<div class="sort-arrow">
							  <span class="sort-asc">▲</span>
							  <span class="sort-desc">▼</span>
							</div>
						</div>	
					</th>
					<th class="center" style="width: 100px">파일</th>
				</tr>
			</thead>
			<tbody id="table-body">
				<tr>
					<td class="right py-10">
						<input type="checkbox" class="check-btn" id="chkBox1" name="chkBox1"/>
				       	<label for="chkBox1"><span></span></label>
					</td>
					<td class="center py-10">1</td>
					<td>
						<a href="#none">제목이 입력 될 영역</a>
					</td>
					<td class="center py-10">김현빈</td>
					<td class="center py-10">2024-09-27</td>
					<td class="center py-10">10</td>
					<td class="center py-10">
						<button type="button" class="btn btn-download">
						 	다운로드<span class="icon material-symbols-outlined">Download</span> 
						</button>
					</td>
				</tr>
				<tr>
					<td class="right py-10">
						<input type="checkbox" class="check-btn" id="chkBox2" name="chkBox2"/>
				       	<label for="chkBox2"><span></span></label>
					</td>
					<td class="center py-10">1</td>
					<td>
						<a href="#none">제목이 입력 될 영역</a>
					</td>
					<td class="center py-10">김현빈</td>
					<td class="center py-10">2024-09-27</td>
					<td class="center py-10">10</td>
					<td class="center py-10">
						<button type="button" class="btn btn-disabled">
						 	다운로드<span class="icon material-symbols-outlined">Download</span> 
						</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title">테이블 디자인</div> 
				<div class="btn-wrap">
					<button type="button" class="btn-default">버튼</button>
					<button type="button" class="btn-active">버튼</button>
				</div>
			</div>
			<table class="table-blue">
				<tr>
					<th>제목</th>
					<td><input type="text" class="text-input" placeholder="입력해주세요"></td>
					<th>제목</th>
					<td><input type="text" class="text-input" placeholder="입력해주세요"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3">text</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="5" cols="1" spellcheck="false"></textarea></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>text</td>
					<th>내용</th>
					<td>text</td>
				</tr>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap -->
		<div class="table-wrap">
			<div class="page-tap-wrap">
				<div class="page-tap-cont event active">
					<span class="material-symbols-outlined title-icon">festival</span>이벤트 상세 관리
				</div>
				<div class="page-tap-cont coupon">
					<span class="material-symbols-outlined title-icon">confirmation_number</span>쿠폰 발급 조회
				</div>
			</div>
			<table class="table-blue">
				<tr>
					<th>제목</th>
					<td><input type="text" class="text-input" placeholder="입력해주세요"></td>
					<th>제목</th>
					<td><input type="text" class="text-input" placeholder="입력해주세요"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3">text</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="5" cols="1" spellcheck="false"></textarea></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>text</td>
					<th>내용</th>
					<td>text</td>
				</tr>
			</table>
		</div>
		<!-- table-wrap -->
	</div>
	<!-- /.cont: 해당 영역의 설명 -->
	
	<!-- cont: 해당 영역의 설명 -->
	<div class="cont">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title">
					<span class="material-symbols-outlined title-icon">store</span>가맹점 정보
				</div> 
			</div>
			<table class="table-blue">
				<tr>
					<th>전화번호</th>
					<td colspan="3">
						<div class="tel-wrap">
							<input type="text" class="input-tel">-
							<input type="text" class="input-tel">-
							<input type="text" class="input-tel">
						</div>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						<div class="addr-zip-wrap">
							<div class="addr-wrap">
								<input class="input-zip" readonly="readonly" type="text"/>
								<button class="btn-default" type="button" onclick="openHomeSearch()">우편번호 검색</button>
							</div>
							<div class="addr-wrap">
								<input class="input-addr" readonly="readonly" type="text"/>
								<input class="input-addr" type="text"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- /.table-wrap -->
	</div>
	<!-- cont 끝 -->
	<div class="cont">
		<!-- table-wrap 가맹점 정보-->
		<div class="table-wrap">
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">store</span>가맹점</div> 
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">add_business</span>가맹점 상세</div> 
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">person</span>일반 회원(가맹점주, 거래처담당자 등)</div> 
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">manage_accounts</span>관리자</div> 
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">payments</span>거래처</div>  
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">list_alt</span>정보</div> 
			</div>
			<div class="table-title">
				<div class="cont-title"><span class="material-symbols-outlined title-icon">playlist_add</span>상세내용</div> 
			</div>
			<div class="table-title">
				<div class="cont-title chart-title">
			        <span class="material-symbols-outlined title-icon">bar_chart</span><p id="chart-title-text">월간 매출 현황 차트</p>
			    </div>
			</div>
			<div class="table-title">    
			    <div class="cont-title chart-title">
			        <span class="material-symbols-outlined title-icon">donut_small</span><p id="chart-title-text">일간 매출 현황 차트</p>
			    </div>
			</div>
		</div>
	</div>
	<!-- cont 끝 -->

</div>
<!-- /.wrap -->	












