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

   <div class="frame myPageBox">
      <p>${login.userid } 님 환영합니다</p>
      
      
      <div class="flex">
         <div class="form">
            <form>
               <p><input type="text" value="${login.userid }"></p>
               <p><input type="password" value="${login.userpw }"></p>
            </form>
         </div>
         <div class="myBoard">
            <p><a href="${cpath }/delete.jsp">회원 탈퇴</a>
            <p><a href="${cpath }/myboard.jsp">내 글 관리</a></p>
            <p><a href="${cpath }/mysaved.jsp">즐겨찾기</a></p>
         </div>
      </div>
   </div>


</body>
</html>