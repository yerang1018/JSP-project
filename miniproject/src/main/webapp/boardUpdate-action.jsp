<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:set var="dto" value="${fileUtil.getDTO(pageContext.request) }"></c:set>
<c:set var="row" value="${boardDAO.update(dto) }"></c:set>

<script>
	const row = '${row}'
	if(row != 0) {
		alert('수정 성공')
		location.href = '${cpath}'
	}
	else {
		alert('수정 실패')
		history.go(-1)
	}
</script>

</body>
</html>