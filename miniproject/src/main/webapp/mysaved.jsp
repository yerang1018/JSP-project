<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


         <c:set var="savedCount" value="${savedDAO.SavedCount(login.userid) }"></c:set>
         <c:set var="paramPage" value="${empty param.page ? 1 : param.page }"></c:set>
         <c:set var="paging" value="${savedPaging.newInstance(paramPage, savedCount) }"></c:set>
         <c:set var="list" value="${savedDAO.savedList(login.userid, paging) }"></c:set> 



   <table id="mypageList">
      <thead>
         <tr>
            <th>글 번호</th>
            <th>제목</th>
            <th>작성자</th>
         </tr>
       
      </thead>
      <tbody>
      
<!--  
         <li>게시글 개수 : ${boardCount }</li>
         <li>요청받은 페이지 : ${paramPage }</li>
         <li>paging.offset : ${paging.offset }</li>
         <li>paging.fetch : ${paging.fetch }</li>
         <li>paging.pageCount : ${paging.pageCount }</li>
         <li>paging.begin : ${paging.begin }</li>
         <li>paging.end : ${paging.end }</li>
-->


         <c:forEach var="dto" items="${list }">
            <tr class="clickable-row" data-href="${cpath}/view.jsp?idx=${dto.board_idx}">
           
               <td>${dto.board_idx }</td>
               <td>${dto.title }</td>
               <td>${dto.writer }</td>
           
            </tr>
         </c:forEach>
      </tbody>
   </table>
   
   <script>
	         document.addEventListener("DOMContentLoaded", function () {
	             var rows = document.querySelectorAll(".clickable-row");
	             rows.forEach(function (row) {
	                 row.addEventListener("click", function () {
	                     var href = row.getAttribute("data-href");
	                     if (href) {
	                         window.location.href = href;
	                     }
	                 });
	             });
	         });
         </script>
   
   
   
   
   
   <div class="frame mypageing">
      <c:if test="${paging.prev }">
         <a href="${cpath }/mysaved.jsp?page=${paging.begin - 10}">[이전]</a>
      </c:if>
      
      <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
         <a class="${paging.page == i ? 'bold' : ''}"
         href="${cpath }/mysaved.jsp?page=${i}">[${i }]</a>
      </c:forEach>
      
      <c:if test="${paging.next }">
         <a href="${cpath }/mysaved.jsp?page=${paging.end + 1}">[다음]</a>
      </c:if>
   </div>
   

  



</body>
</html>