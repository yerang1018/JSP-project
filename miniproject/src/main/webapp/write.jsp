<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<c:if test="${empty login }">
   <script>
      alert('먼저 로그인 후에 작성 가능합니다')
      history.go(-1)
   </script>
</c:if>


<div class="write">
   <h3>글 쓰기</h3>
   <form action="write-action.jsp" method="POST" enctype="multipart/form-data">
      <p><input type="text" name="title" placeholder="제목"></p>
      <p>
         <textarea name="content" placeholder="내용" rows="5" cols="30" required></textarea>
      </p>
      <p><input type="file" name="uploadFile"></p>
      <p>
         <label><input type="radio" name="category" value="관광">관광</label>
         <label><input type="radio" name="category" value="맛집">맛집</label>
      </p>
      <p><input type="submit" value="글 작성"></p>
      <input type="hidden" name="writer" value="${login.userid }">
   </form>

</div>



</body>
</html>