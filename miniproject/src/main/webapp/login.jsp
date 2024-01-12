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

<c:if test="${pageContext.request.method == 'GET' }" >
	<form method="POST">
		<h3>로그인</h3>
		<p><input type="text" name="userid" placeholder="ID" required></p>
		<p><input type="password" name="userpw" placeholder="password" required></p>
		<p><input type="submit" value="로그인"></p>
	</form>
</c:if>


<c:if test="${pageContext.request.method == 'POST' }">
	<jsp:useBean id="dto" class="member.MemberDTO" />
	<jsp:setProperty property="*" name="dto" />
	
	<c:set var="login" value="${memberDAO.login(dto) }" scope="session" />
	
	<c:if test="${row != 0 }">
		<c:redirect url="/" />
	</c:if>

</c:if>


</body>
</html>