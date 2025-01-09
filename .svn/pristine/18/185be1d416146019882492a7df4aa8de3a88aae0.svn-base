/*******************************************
  @fileName    : stockAjmt.js
  @author      : 이병훈
  @date        : 2024. 10. 14
  @description : 거래처 재고 조정 현황 관련 코드
********************************************/

/*******************************************
  해당 거래처 재고 조정시, 조정 현황 페이지
********************************************/
function selectStockAjmtAjax(gdsCode){
   let data = {};

   // 값이 빈 문자열이 아니면 data 객체에 추가
   
   data.sort = 'ajmtYmd';
   data.orderby = 'desc';
   data.currentPage = currentPage;
   data.ajmtType = '';
   data.bzentNo = bzentNo;
   data.gdsCode = gdsCode;
   data.size = 5;
   
   //console.log(data);  // 최종적으로 빈 값이 제외된 data 객체
   
   // 서버전송
   $.ajax({
      url : "/com/stockAjmt/listAjax",
      type : "GET",
      data : data,
      success : function(res){
         // 테이블 처리
         let strTbl = '';
         
         if(res.total == 0){ // 검색 결과가 0인 경우
            strTbl+= `
                     <tr>
                        <td class="error-info" colspan="7"> 
                           <span class="icon material-symbols-outlined">error</span>
                           <div class="error-msg">검색 결과가 없습니다</div>
                        </td>
                     </tr>
            `;
            $('.pagination').html('');
         } else {
            res.articlePage.content.forEach(list => {
            // 등록 일자
            let ajmtYmd = strToDate(list.ajmtYmd);
                
            // 유형
            let type = `<span class='bge ${
                list.ajmtType == 'AJMT01' ? 'bge-info' 
                : list.ajmtType == 'AJMT02' ? 'bge-danger' 
                : list.ajmtType == 'AJMT03' ? 'bge-active' 
                : 'bge-warning'}'>${list.ajmtTypeNm}</span>`;
            
            let ajmtRsn = '-';
                        // 가맹점 처리
                if(list.ajmtRsn && list.ajmtRsn.length > 10) {
                 ajmtRsn = `
                       <div style="white-space:nowrqp; overflow:hidden; text-overflow:ellipsis;">
                          <button type="button" class="tooltip-custom"
                           data-bs-toggle="tooltip"
                           title="${list.ajmtRsn}">
                           <span class="tooltip-icon material-symbols-outlined">info</span>
                        </button>
                          ${list.ajmtRsn}
                       </div>
                 `;
              } else if(list.ajmtRsn){
                 ajmtRsn = list.ajmtRsn;
              } 
            
            
             strTbl += `
                <tr>
                    <td class="center">${list.rnum}</td>
                    <td class="center">${ajmtYmd}</td>
                    <td class="center">${type}</td>
                    <td class="right">${list.qty.toLocaleString()}</td>
                    <td class="center">${list.gdsVO.unitNm}</td>
                    <td style="max-width: 100px">${ajmtRsn}</td>
                    <td><button class="btn-default" onclick="deleteStockAjmt(${list.ajmtNo})" ${list.ajmtType=='AJMT01' || list.ajmtType=='AJMT02' ? '' : 'disabled'}>삭제</button></td>
                </tr>
            `;
            
            });
            
            // 페이징 처리
            let page = '';
            // 'chevron_right' 아이콘 및 다음 페이지 링크 추가
            if (res.articlePage.currentPage < res.articlePage.totalPages) {
                page = `
                    <tr>
                        <td colspan="7" class="moreView"> 
                           더보기(${res.total-currentPage*5}) <span class="icon material-symbols-outlined">stat_minus_1</span>
                        </td>
                     </tr>
                `;
            }else{
                page = `
                    ''
                `;
            }
            $('.ajmtAdd').html(page);
            }
         $('#table-body-ajmt').append(strTbl)
         }
      });         
}




   // 더보기
   $(document).on('click', '.moreView', function(){
      currentPage++;
      selectStockAjmtAjax(gdsCode);
   })