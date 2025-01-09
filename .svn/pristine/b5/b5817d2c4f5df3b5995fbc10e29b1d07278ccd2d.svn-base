/*******************************************
  @fileName    : common.js
  @author      : 정기
  @description : 공통 스크립트. 주로 공통 ui 요소에 대한 js를 처리한다. 
********************************************/

 
$(document).ready(function() {
	// @methodName  : onCheckAll
	// @author      : 정기쁨
	// @used         : 일자를 선택하는 input type="date"
	// @description : 오늘 날짜를 선택 되게 하는 기능. id 값에 currentDate를 추가하면 됨
	if(document.getElementById('currentDate')!=null){
		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	}
	
	// @methodName  : 없음
	// @author      : 정기쁨
	// @location    : 공통
	// @description : 셀렉트 박스에 검색어가 없는 경우 사용
	var x, i, j, l, ll, selElmnt, a, b, c;
	/*look for any elements with the class "select-custom":*/
	x = document.getElementsByClassName("select-custom");
	l = x.length;
	for (i = 0; i < l; i++) {
	  selElmnt = x[i].getElementsByTagName("select")[0];
	  ll = selElmnt.length;
	  /*for each element, create a new DIV that will act as the selected item:*/
	  a = document.createElement("DIV");
	  a.setAttribute("class", "select-selected");
	  a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
	  x[i].appendChild(a);
	  /*for each element, create a new DIV that will contain the option list:*/
	  b = document.createElement("DIV");
	  b.setAttribute("class", "select-items select-hide");
	  for (j = 0; j < ll; j++) {
	    /*for each option in the original select element,
	    create a new DIV that will act as an option item:*/
	    c = document.createElement("DIV");
	    c.innerHTML = selElmnt.options[j].innerHTML;
	    c.addEventListener("click", function(e) {
	        /*when an item is clicked, update the original select box,
	        and the selected item:*/
	        var y, i, k, s, h, sl, yl;
	        s = this.parentNode.parentNode.getElementsByTagName("select")[0];
	        sl = s.length;
	        h = this.parentNode.previousSibling;
	        for (i = 0; i < sl; i++) {
	          if (s.options[i].innerHTML == this.innerHTML) {
	            s.selectedIndex = i;
	            h.innerHTML = this.innerHTML;
	            y = this.parentNode.getElementsByClassName("same-as-selected");
	            yl = y.length;
	            for (k = 0; k < yl; k++) {
	              y[k].removeAttribute("class");
	            }
	            this.setAttribute("class", "same-as-selected");
	            break;
	          }
	        }
	        h.click();
	    });
	    b.appendChild(c);
	  }
	  x[i].appendChild(b);
	  a.addEventListener("click", function(e) {
	      /*when the select box is clicked, close any other select boxes,
	      and open/close the current select box:*/
	      e.stopPropagation();
	      closeAllSelect(this);
	      this.nextSibling.classList.toggle("select-hide");
	      this.classList.toggle("select-arrow-active");
	    });
	}
	// @methodName  : 셀렉트박스 (검색어 x)

})

// 셀렉트박스 없을 때 사용
function closeAllSelect(elmnt) {
  /*a function that will close all select boxes in the document,
  except the current select box:*/
  var x, y, i, xl, yl, arrNo = [];
  x = document.getElementsByClassName("select-items");
  y = document.getElementsByClassName("select-selected");
  xl = x.length;
  yl = y.length;
  for (i = 0; i < yl; i++) {
    if (elmnt == y[i]) {
      arrNo.push(i)
    } else {
      y[i].classList.remove("select-arrow-active");
    }
  }
  for (i = 0; i < xl; i++) {
    if (arrNo.indexOf(i)) {
      x[i].classList.add("select-hide");
    }
  }
}

// @methodName  : select2Custom();
// @author      : 정기쁨
// @location    : 공통
// @description : 셀렉트 박스에 검색어가 있는 경우 사용
function select2Custom(){
	$('.select2-custom').select2({
	    width: '100%',
	    searchInputPlaceholder: '검색결과가 없습니다',
	    language: {
	      noResults: function() {
	        return '검색결과가 없습니다';
	      },
	    },
	    escapeMarkup: function(markup) {
	      return markup;
	    }
	});
	$(".select2-custom").on("select2:open", function(event) {
	    $('input.select2-search__field').attr('placeholder', '검색어를 입력하세요');
	});
}
 
// @methodName  : tooltipCustom();
// @author      : 정기쁨
// @location    : 공통
// @description : 툴팁이 필요한 경우 사용
function tooltipCustom(){
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl) // 초기화
	})
}

function thClickEvent(sortElement){
    $('.sort').removeClass('active');
    sortElement.addClass('active');

    // 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
    var sortAsc = $('.sort-arrow', sortElement).find('.sort-asc');
    var sortDesc = $('.sort-arrow', sortElement).find('.sort-desc');

    var currentSort = sortElement.data('sort'); // 데이터 속성 가져오기

    // 첫 번째 자식이 active 클래스가 있는지 확인
    if (sortAsc.hasClass('active')) { // desc
        $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
        sortDesc.addClass('active');
        orderby = 'desc';
    } else { // asc
        $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
        sortAsc.addClass('active');
        orderby = 'asc';
    }
    
    // 정렬 필드를 업데이트
    sortField = currentSort; // 정렬 필드를 업데이트
}

// @methodName  : resetSort();
// @author      : 정기쁨
// @location    : 공통
// @description : 테이블 정렬 클릭 시 색상 변경
function resetSort(sort, orderby){
	// 정렬 조건 색상 변경
	$('.sort').removeClass('active');		
	sort.addClass('active');
	
	// 첫 번째 자식인 .sort-asc와 두 번째 자식인 .sort-desc를 선택
    var sortAsc = $('.sort-arrow', sort).find('.sort-asc');
    var sortDesc = $('.sort-arrow', sort).find('.sort-desc');
	
	// 첫 번째 자식이 active 클래스가 있는지 확인
	if (orderby == 'desc' ) { // desc
	 // 모든 th의 active 클래스를 제거
	    $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	  	sortDesc.addClass('active');
	  	orderby = 'desc';
	} else{ // asc
	 // 모든 th의 active 클래스를 제거
	    $('.sort-arrow .sort-asc, .sort-arrow .sort-desc').removeClass('active');
	  	sortAsc.addClass('active');
	  	orderby = 'asc';
	}
}

// @methodName  : getCsrfTokens();
// @author      : 정기쁨
// @location    : 공통
// @description : post를 위해 꼭 호출해야 하는 이벤트
function getCsrfTokens() {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    
    return { csrfToken, csrfHeader };
}

// @methodName  : toastAlert();
// @author      : 정기쁨
// @location    : 공통
// @description : 알럿창 ui설정
function toastAlert(){
	var Toast = Swal.mixin({
	  toast: true,
	  position: 'top-end',
	  showConfirmButton: false,
	  timer: 3000 //3초간 유지
	});
	
	return Toast;
}

// @methodName  : searchToggle();
// @author      : 정기쁨
// @location    : 공통
// @description : 요약보기 이벤트
function searchToggle(toggle){
	if ($(toggle).hasClass('active')){
		$(toggle).removeClass('active');
		$('.search-toggle').html(`요약보기<span class="icon material-symbols-outlined">Add</span>`);
		$('.search-original').slideDown(300);
		$('.search-summary').slideUp(300);
	} else {
		$(toggle).addClass('active');
		$('.search-toggle').html(`전체보기<span class="icon material-symbols-outlined">Remove</span>`);
		$('.search-original').slideUp(300);
		$('.search-summary').slideDown(300);
	} 
}

 /*************************************************************************************
			3개월이 지났는 지 확인 날짜 비교
**************************************************************************************/
// @methodName  : somethingNew(rlsYmd);
// @author      : 송예진
// @location    : 공통
// @description : 메뉴 출시일 비교
// 출시일이 오늘 날짜와 비교하여 3개월이 안 지났는지 확인하는 함수
function somethingNew(rlsYmd) { // 출시일 DB그대로 가져올것
	// 출시일을 Date 객체로 변환 (YYYYMMDD 형식)
    const year = parseInt(rlsYmd.slice(0, 4));
    const month = parseInt(rlsYmd.slice(4, 6)) - 1; // 월은 0부터 시작하므로 -1
    const day = parseInt(rlsYmd.slice(6, 8));
    const releaseDate = new Date(year, month, day);

    // 오늘 날짜
    const today = new Date();

    // 3개월 전 날짜 계산
    const threeMonthsAgo = new Date();
    threeMonthsAgo.setMonth(today.getMonth() - 3);

    // 비교하여 3개월 이내에 출시되었는지 확인
    return releaseDate >= threeMonthsAgo && releaseDate <= today;
}





















