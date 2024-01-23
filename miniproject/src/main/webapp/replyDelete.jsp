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

   
   
   <jsp:useBean id="reply" class="reply.ReplyDTO" />
    <jsp:setProperty property="*" name="reply" />      
   <c:set var="result" value="${replyDAO.delete(reply.idx) }" />

   <c:if test="${result != null }">
      <c:redirect url="/view.jsp?idx=${reply.board_idx }" />
   
   </c:if>
   
   
   

</body>
</html>