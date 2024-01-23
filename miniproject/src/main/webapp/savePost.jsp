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

   <div>${param.board_idx }</div>
   <div>${login.userid }</div>
   
   
   <c:set var="checked" value="${savedDAO.checkLike(param.board_idx, login.userid) }" />
   <div>${checked }</div>
       
   <c:if test="${checked == null}">
      <c:set var="in" value="${savedDAO.likeInsert(param.board_idx, login.userid) }" />
      <c:if test="${in != 0}">
         <c:redirect url="/view.jsp?idx=${param.board_idx }" />
      </c:if>
   </c:if>



</body>
</html>