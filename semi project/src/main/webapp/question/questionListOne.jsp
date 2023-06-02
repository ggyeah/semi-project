<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
QuestionDao questionDao = new QuestionDao();

Question question = new Question();

if (request.getParameter("qNo") != null){
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	question = questionDao.questionOne(qNo);
 }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<h2>문의</h2>
	<table class="table table-bordered">
		
		<tr>
              <th>문의번호</th>
              <td><%=question.getqNo()%></td>
         </tr>
		<tr>
              <th>상품번호</th>
              <td><%=question.getProductNo()%></td>
         </tr>
		 <tr>
              <th>아이디</th>
              <td><%=question.getId()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>카테고리</th>
              <td><%=question.getqCategory()%></td>
           </tr>
		 <tr>
		<tr>
              <th>제목</th>
              <td><%=question.getqTitle()%></td>
           </tr>
		 <tr>
              <th>내용</th>
              <td><%=question.getqContent()%></td>
           </tr>
           <tr>
              <th>생성일</th>
              <td><%=question.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=question.getUpdatedate()%></td>
           </tr>
	</table>

	<div>
		<a href="<%=request.getContextPath()%>/question/modifyQuestion.jsp?qNo=<%=question.getqNo()%>">수정</a>
		<a href="<%=request.getContextPath()%>/question/removeQuestion.jsp?qNo=<%=question.getqNo()%>">삭제</a>
	</div>	
	
	<!--  답변추가 폼  기능구현해야함-->
	<h2>답변추가</h2>
	<input type="text">
</body>
</html>