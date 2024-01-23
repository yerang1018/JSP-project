<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>




<div class="frame center">
<c:if test="${pageContext.request.method == 'GET' }">
	<form method="POST">
		<p><input type="hidden" name="userid" value="${login.userid }"></p>
		<p><input type="password" name="userpw" placeholder="password" required></p>
		<p><input type="submit" value="회원탈퇴"></p>
	</form>
</c:if>
</div>

<c:if test="${pageContext.request.method == 'POST' }">
	<jsp:useBean id="dto" class="member.MemberDTO" />
	<jsp:setProperty property="*" name="dto" />
	<c:set var="row" value="${memberDAO.delete(dto) }" />


	<c:if test="${row != 0 }">
		<c:redirect url="/logout.jsp" />

	</c:if>

</c:if>


</body>
</html>