<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

   
   <div class="frame">
   <c:set var="dto" value="${boardDAO.selectOne(param.idx) }"></c:set>
   <div class="flex" id="boardView">
      
      <div class="viewimage"><img  src="${cpath }/reviewImage${dto.image }"></div>
      
      <div class="viewboard">       
            <p class="title">${dto.title }</p>
            <p class="content">${dto.content }</p>
      </div>
      </div>
     <div>
        <c:if test="${login.userid == dto.writer}">
            <a class="deleteBtn" idx="${dto.idx }" href="${cpath }/boardDelete.jsp?idx=${dto.idx }"><button>삭제</button></a>
            <a href="${cpath }/boardUpdate.jsp?idx=${dto.idx }"><button>수정</button></a>
         </c:if>
         
         <c:if test="${not empty login }">
            <a href="${cpath }/savePost.jsp?board_idx=${dto.idx }"><button>저장</button></a>
            
         </c:if>
         
     </div>
     
     <div class="topSpace">
        <c:if test="${not empty login }">
        <form method="POST" id="replyWriteForm">
           <p><textarea class="viewtext" name="content" placeholder="댓글 작성" rows="8" cols="100"></textarea></p>
           <p><input type="hidden" name="board_idx" value="${dto.idx }"></p>
           <p><input type="hidden" name="writer" value="${login.userid }"></p>
           <p><input type="hidden" name="parent_idx" value="0"></p>
           <p><input type="hidden" name="reply_depth" value="0"></p>
           <p><input type="submit" value="댓글등록"></p>   
        </form>
        
        <c:if test="${pageContext.request.method == 'POST' }">
           <jsp:useBean id="reply" class="reply.ReplyDTO" />
           <jsp:setProperty property="*" name="reply" />
           <c:set var="row" value="${replyDAO.insert(reply) }" />
           
           <c:redirect url="/view.jsp?idx=${dto.idx }"></c:redirect>
           
        </c:if>
        
        </c:if>
    
     
        <div class="replyList">
           <c:forEach var="reply" items="${replyDAO.selectreplyList(dto.idx) }">
              <div class=" replyItem" 
                 idx="${reply.idx }" reply_depth="${reply.reply_depth }"
                 style="border: 1px solid grey; 
                       padding: 10px; 
                       margin: -1px; 
                       margin-left: ${reply.reply_depth * 30}px">
                    <p>${reply.writer }</p>
                    <pre>${reply.content }</pre>
                    <button class="replyBtn" onclick="toggleReplyForm(this)">답글달기</button>
              </div>
           </c:forEach>
        </div>
    </div>      
                    <c:if test="${login.userid == list.writer }">
                       <a href="${cpath }/replyDelete.jsp?idx=${list.idx }&board_idx=${list.board_idx }"><button>삭제</button></a>
                    </c:if>
           
           
        
   
   <script type="text/javascript">
   function toggleReplyForm(btn) {
       const form = document.getElementById('replyWriteForm');
       const reply = btn.parentNode;

      
      form.querySelector('input[name="parent_idx"]').value = reply.getAttribute('idx')
      form.querySelector('input[name="reply_depth"]').value = +reply.getAttribute('reply_depth') + 1
      
      reply.style.border = '2px solid orange'
      reply.appendChild(form)
      form.querySelector('textarea').focus()
      
      btn.style.display = 'none'
      
   }
   
   replyBtnList.forEach(e => e.onclick = replyBtnHandler)
   
   const replyItemList = document.querySelectorAll('div.replyItem')
   
   replyItemList.forEach((div, index) => {
      const depth = div.getAttribute('reply_depth')
      if(depth == 0){
         div.style.marginTop = '10px'
         div.style.background = 'white'
      }
      else if(index != 0) {
         const preDiv = replyItemList[index -1]
         const preDepth = prevDiv.getAttribute('reply_depth')
         if(depth - prevDepth == 1){
            
         const line = document.createElement('div')
         line.innerText = '⨽'
         div.style.position = 'relative'
         line.style.postion = 'absolute'
         line.style.top = '0'
         line.style.left = '-35px'
         div.appendChile(line)
         }
      }
   })
   
   </script>
   
   
</body>
</html>