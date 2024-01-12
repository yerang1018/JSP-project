<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.* , reply.*, board.*"%>
 <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath }" />
<c:set var="memberDAO" value="${MemberDAO.getInstance() }" />
<c:set var="replyDAO" value="${ReplyDAO.getInstance() }" />
<c:set var="boardDAO" value="${BoardDAO.getInstance() }" />






<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
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
        div.login {
            text-align: end;
        }
        div.login > a {
            padding: 0px 20px;
        }
        div.category  {
            padding-top: 150px;
        }
        div.category > p.categoryLeft {
            padding-left: 50px;
        }
        div.category > p.categoryRight {
            padding-right: 50px;
        }
        div.imagebox {
        	height: 400px;
        	padding-right: 20px;
        }
        div.imagebox > a > img {
        	width: 300px;
        	height: 300px;
        	
        }
       div.imageboard{
       	border : 1px solid black;
       	height: 300px;
       	width: 600px;
       }
 		p.title {
        font-size: 30px ;
        font-weight: bold;
     	font-family: 'Black Han Sans', sans-serif;
     	}
       p.content{
       	font-size: 15px;
       }
       a {
       	text-decoration: none;
       }
        
    </style>

</head>
<body>

	
	
<div class="login">
	<c:if test="${login == null }">
		<a href="${cpath }/login.jsp">로그인</a>
		<a href="${cpath }/join.jsp">회원가입</a>
	</c:if>
	
	<c:if test="${login != null }">
		<p>${login.userid }님 접속중</p>
		<a href="${cpath }/myboard.jsp">마이페이지</a>
		<a href="${cpath }/logout.jsp">로그아웃</a>
		<a href="${cpath }/join.jsp">회원가입</a>
	</c:if>
	
</div>

    <div class="frame category">
        <div class="sb">
        <p class="categoryLeft"><a href="${cpath }/board.jsp?category=관광">관광</a></p>
        <p class="categoryRight"><a href="${cpath }/board.jsp?category=맛집">맛집</a></p>
        </div>
    </div>
    



