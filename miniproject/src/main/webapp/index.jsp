<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

	
	
	
	<div class="frame" >
	
		<c:set var="list" value="${boardDAO.selectList() }"></c:set>
		<c:forEach var="dto" items="${list }">
		<div class="">
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
	
	
	
	
	
	
	
</body>
</html>