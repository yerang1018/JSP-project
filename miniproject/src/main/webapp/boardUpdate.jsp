<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<div class="boardUpdate">
	<div><h3>게시글 수정하기</h3></div>
	
	
	<c:set var="dto" value="${boardDAO.selectOne(param.idx) }"></c:set>
	
	<div >
		<form method="POST" action="boardUpdate-action.jsp" enctype="multipart/form-data">
			<p><input type="text" name="title" value="${dto.title }"  placeholder="제목" ></p>
			<p><textarea name="content" rows="5" cols="80" placeholder="내용작성" >${dto.content }</textarea></p>
			<p><input type="file" name="uploadFile" ></p>
			<p>
				<label><input type="radio" name="category" value="관광" ${dto.category == '관광' ? 'checked' : '' } required >관광</label>
				<label><input type="radio" name="category" value="맛집" ${dto.category == '맛집' ? 'checked' : '' } required>맛집</label>
			</p>
			

			<input type="hidden" name="idx" value="${dto.idx }">
			<input type="hidden" name="writer" value="${login.userid}">
			
			
			<p><input type="submit" value="수정완료"></p>
		</form>
	</div>
</div>




</body>
</html>