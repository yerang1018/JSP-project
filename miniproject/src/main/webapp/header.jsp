
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="member.* , reply.*, board.*, saved.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath }" />
<c:set var="memberDAO" value="${MemberDAO.getInstance() }" />
<c:set var="replyDAO" value="${ReplyDAO.getInstance() }" />
<c:set var="boardDAO" value="${BoardDAO.getInstance() }" />
<c:set var="fileUtil" value="${FileUtil.getInstance() }" />
<c:set var="savedDAO" value="${SavedDAO.getInstance() }" />

<%
request.setCharacterEncoding("UTF-8");
%>
<%
response.setCharacterEncoding("UTF-8");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
   rel="stylesheet">


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet">


   <style>
   div.side {
      position: fixed;
      width: 463px;
      height: 200px;
      text-align: center;
      font-size: 20px;
      font-weight: bold;
      background-color: rgba(#CCC4BE)
   }
   
   div.side>p>a {
      color: black;
   }
   
   div.login {
      text-align: end;
      height: 200px;
      color: black;
   }
   
   div.logo>a>img {
      padding-bottom: 30px;
   }
   
   .box {
      width: 300px;
   }
   
   .frame {
      width: 900px;
      margin: 0 auto;
   }
   
   .flex {
      display: flex;
   }
   
   .sb {
      display: flex;
      justify-content: space-between;
   }
   
   div.sb>p {
      padding-right: 28px;
   }
   
   div.imagebox {
      height: 400px;
      padding-right: 20px;
   }
   
   div.imagebox>a>img {
      width: 300px;
      height: 300px;
      border-radius: 10px;
   }
   
   div.imageboard {
      background-color: rgb(235, 240, 228);
      border: 1px solid black;
      border-radius: 10px;
      height: 300px;
      width: 600px;
   }
   
   p.title {
      padding-left: 20px;
      font-size: 33px;
      font-weight: bold;
      font-family: 'Jua', sans-serif;
   }
   
   p.content {
      padding-left: 20px;
      padding-right: 20px;
      font-size: 15px;
      font-family: 'Noto Sans KR', sans-serif;
   }
   
   a:hover {
      color: #dadada;
   }
   
   a {
      text-decoration: none;
      color: black;
   }
   
   div.login>a {
      text-decoration: none;
      color: black;
   }
   
   div.loginpage, div.joinpage, div.write {
      text-align: center;
      margin: 0 auto;
   }
   
   table.mypage {
      margin: 0 auto;
   }
   
   input[type=search] {
      width: 830px;
      padding: 10px;
      border-radius: 10px;
   }
   
   input[type=submit] {
      padding: 7px;
      border-radius: 10px;
   }
   
   button.write {
      padding: 7.5px;
   }
   
   div.button {
      padding-left: 20px;
   }
   
   div.viewimage>img {
      width: 400px;
      height: 400px;
      padding-right: 20px;
   }
   
   div.viewboard {
      background-color: rgba(235, 240, 228, 0.7);
      border: 1px solid black;
      height: 400px;
      width: 600px;
   }
   
   div.viewboard>p {
      margin-left: 10px;
   }
   
   table#mypageList {
      border-collapse: collapse;
      width: 900px;
      margin: 20px auto;
   }
   
   table#mypageList>thead {
      background-color: orange;
      color: white;
   }
   
   table#mypageList>tbody>tr {
      border-bottom: 1px solid orange;
      transition-duration: 1s;
   }
   
   table#mypageList>tbody>tr:hover {
      background-color: #eee;
      transition-duration: 1s;
   }
   
   table#mypageList td, table#mypageList th {
      padding: 10px;
      text-align: center;
   }
   
   div.mypageing {
      padding-top: 20px;
      padding-bottom: 40px;
      text-align: center;
   }
   
   div.category>p>a {
      font-size: 20px;
      font-weight: lighter;
      text-align: center;
   }
   
   div.topSpace {
      padding-top: 100px;
      border-radius: 10px;
   }
   
   div.replyList {
      border-radius: 10px;
   }
   
   div>pre {
      margin-left: 20px;
   }
   
   .hidden {
      display: none;
   }
   
   p>a {
      font-size: 13px;
      font-family: 'Noto Sans KR', sans-serif;
   }
   
   div.replyItem>form#replyWriteForm {
      padding-top: 70px;
   }
   
   a.content {
      font-size: 17px;
      font-family: 'Noto Sans KR', sans-serif;
      padding-right: 20px;
   }
   
   a.content:hover {
      color: #dadada;
   }
   
   p.content {
      font-size: 15px;
      font-family: 'Noto Sans KR', sans-serif;
      padding-bottom: 20px;
      color: grey;
   }
   
   p>textarea.viewtext {
      width: 100%;
   }
   
   div.loginpage, div.joinpage, div.write, div.boardUpdate {
      text-align: center;
      margin: 0 auto;
   }
   </style>

</head>
<body class="mainboard">


   <div class="login">
      <c:if test="${login == null }">
         <a class="content" href="${cpath }/login.jsp">로그인</a>
         <a class="content" href="${cpath }/join.jsp">회원가입</a>

      </c:if>

      <c:if test="${login != null }">
         <p class="content">${login.userid }님접속중</p>
         <a class="content" href="${cpath }/mypage.jsp">마이페이지</a>
         <a class="content" href="${cpath }/logout.jsp">로그아웃</a>
         <a class="content" href="${cpath }/join.jsp">회원가입</a>
      </c:if>
   </div>


   <div class="side">
      <div class="logo">
         <a href="${cpath }/index.jsp"> <img width="120px" src="돌.png"></a>
      </div>

      <div class="category">
         <p class="categoryLeft">
            <a href="${cpath }/board.jsp?category=관광">관광</a>
         </p>
         <p class="categoryRight">
            <a href="${cpath }/board.jsp?category=맛집">맛집</a>
         </p>
         <p class="write">
            <a href="${cpath }/write.jsp">글 쓰기</a>
         </p>
      </div>

   </div>