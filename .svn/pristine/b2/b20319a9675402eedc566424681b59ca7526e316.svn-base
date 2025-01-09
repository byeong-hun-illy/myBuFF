/*******************************************
  @fileName    : myPage.js
  @author      : 정기쁨
  @date        : 2024. 10.01
  @description : 마이페이지를 위한 js 모음
********************************************/
$(function(){
	// 셀렉트 디자인 라이브러리
	select2Custom();
})
/*******************************************/
// 변수 선언
/*******************************************/
var currentPage = 1;
const originMbrTelno1 = $('#mbrTelno1').val();
const originMbrTelno2 = $('#mbrTelno2').val();
const originMbrTelno3 = $('#mbrTelno3').val();
const originBzentZip = $('#bzentZip').val();
const originMbrAddr = $('#bzentAddr').val();
const originMbrDaddr = $('#bzentDaddr').val();

// jsp 에서 가져온 값
function getInputData() {
    let data = {};
    // 각 input 필드의 값을 가져와서 data 객체에 추가
    const fields = ['mngrId', 'frcs', 'cnpt', 'hdofYn', 'startJncmpYmd', 'endJncmpYmd', 'mngrType'];
    
    fields.forEach(field => {
        let value = $(`#${field}`).val();
        if (value) {data[field] = value;}
    });
    
    // 항상 추가되는 값
    data.sort = 'jncmpYmdSort';
    data.orderby = 'desc';
    data.currentPage = currentPage;

    return data; // data 객체 반환
}
/*******************************************/
// 개발 로직
/*******************************************/
// 사원 정보 수정버튼 클릭 시
$('.modify').on('click',function(){
    $('.modifing').css('display','block');
    $('.modify').css('display','none');
    $('#openHomeSearch').removeClass('btn-disabled');
    $('#mbrTelno1, #mbrTelno2, #mbrTelno3, #bzentZip, #bzentAddr, #bzentDaddr').removeAttr('disabled');
    
    $('#openHomeSearch').on('click',function(){
    	openHomeSearch();
    });
    
})
// 사원 정보 취소 클릭 시 
$('.cancle-btn').on('click',function(){
    $('.modifing').css('display','none');
    $('.modify').css('display','block');
    $('#openHomeSearch').addClass('btn-disabled');
    $('#mbrTelno1, #mbrTelno2, #mbrTelno3, #bzentZip, #bzentAddr, #bzentDaddr').attr('disabled', true);
    $('#mbrTelno1').val(originMbrTelno1);
    $('#mbrTelno2').val(originMbrTelno2);
    $('#mbrTelno3').val(originMbrTelno3);
    $('#bzentZip').val(originBzentZip);
    $('#bzentAddr').val(originMbrAddr);
    $('#bzentDaddr').val(originMbrDaddr);
})
//다음 api
function openHomeSearch(){
	new daum.Postcode({
	    oncomplete: function(data) {
	    	$('#bzentZip').val(data.zonecode);
	    	$('#bzentAddr').val(data.address);
	    	$('#bzentDaddr').val(data.buildingName);
	    	$('#bzentDaddr').focus();
	    }
	}).open();
}
// 정보 저장 클릭 시
$('#save-btn').on('click',function(){
	
})
