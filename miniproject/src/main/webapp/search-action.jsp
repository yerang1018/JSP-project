<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<div class="frame" id="root">
   
   <form action="search-action.jsp">
      <div class="sb">
         <p><input class="searchForm" type="search" placeholder="검색어를 입력하시오" name="search" value="${param.search }"></p>
         <p><input type="submit" value="검색"></p>
      </div>
   </form>
      
   <c:set var="searchCount" value="${boardDAO.selectSearchCount(param.search) }"></c:set>
   <c:set var="list" value="${boardDAO.selectSearchList(param.search)}" />
   <c:forEach var="dto" items="${list }" varStatus="loop">
     
      <div class="flex root item hidden">
         <div class="imagebox">
           
            <a href="${cpath }/view.jsp?idx=${dto.idx}">
               <img src="${cpath }/reviewImage${dto.image}">
            </a>
         </div>
         <a style="display: block;" href="${cpath }/view.jsp?idx=${dto.idx}">
            <div class="imageboard">
               <p class="title">${dto.title }</p>
               <p class="content">${dto.content }</p>   
            </div>
         </a>
      </div>
   </c:forEach>
   
</div>

<script type="text/javascript">
    const root = document.getElementById('root');
    // #root 내부의 모든 item 클래스를 가진 요소들을 선택한다
    const items = document.querySelectorAll('#root .item');
    // 시작 인덱스를 초기화한다
    let start = 0;

    // hidden 걸린 item을 보여주는 함수
    function showHiddenItems() {
    	// 시작 인덱스부터 5개씩 숨겨진 아이템을 보여준다
        for (let i = start; i < items.length && i < start + 5; i++) {
        	// hidden 클래스를 제거하여 해당 아이템을 보이게 만든다
            items[i].classList.remove('hidden')
        }
    	// 그 후 시작 인덱스를 업데이트 한다
        start += 5;
    }

    function scrollHandler() {
    	
    	// 스크롤 관련 정보를 ob에 저장한다
        const ob = {
            scrollTop: window.scrollY,					// 스크롤된 세로의 위치
            clientHeight: window.innerHeight,			// 브라우저에 보여지는 창의 높이
            scrollHeight: document.body.scrollHeight	// 문서 전체의 높이
        };
    	
		console.log(ob) // 스크롤 정보를 콘솔에 출력
//        const currentSize = ob.scrollTop + ob.clientHeight;
//         const flag = ob.scrollHeight + 1.2 <= currentSize && currentSize <= ob.scrollHeight * 1.5;
		// 현재 화면에 맨 아래 도달했는지 체크 하는 조건 
		const flag = ob.scrollTop + ob.clientHeight > ob.scrollHeight
       	// 만약 도달 했다면 추가로 불러오기 함수를 수행하도록 showHiddenItems를 호출한다
		if (flag) {
            console.log('추가 불러오기');
            showHiddenItems();
        }
    }
	// body의 스크롤 이벤트에 scrollHandler 함수를 연결
    document.body.onscroll = scrollHandler;
		
    showHiddenItems(); // 초기 로딩 시 한 번 숨겨진 아이템들을 풀어주도록 설정
</script>

</body>
</html>