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
	
	<section class="frame">
		
		
		<div>
		<jsp:useBean id="dto" class="board.BoardDTO"></jsp:useBean>
		<jsp:setProperty property="*" name="dto"/>
		<c:set var="list" value="${boardDAO.selectListByCategory(dto.category) }"></c:set>
		
		<c:forEach var="dto" items="${list }">
		
		<div class="flex">
				<div class="imagebox">
						
						<a href="${cpath }/view.jsp?idx=${dto.idx}">
							<img src="${cpath }/reviewImage${dto.image}">
						</a>
				</div>
				<a style="display: block;" href="${cpath }/view.jsp?idx=${dto.idx}">
				<div class="imageboard">
									
						<p class="title">${dto.title }</p>
						<p class="content">${dto.content }</p>
				
					
				</div></a>
				
			</div>
			</c:forEach>
		</div>
	
	</section>
	
	

</body>
</html>