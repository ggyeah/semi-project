<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
AnswerDao answerDao = new AnswerDao();
Answer answer = null;

if (request.getParameter("aNo") != null
	&&(request.getParameter("qNo") != null)){
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	answer = answerDao.answerOne(qNo);
 }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if (answer != null) { // answer가 null이 아닌 경우에만 폼을 보여줌
%>
<form action="<%=request.getContextPath()%>/answer/modifyAnswerAction.jsp?qNo=<%=answer.getqNo()%>&aNo=<%=answer.getaNo()%>" method="post">
 <h2>답변</h2>
	<table class="table table-bordered">
		 <tr>
              <th>아이디</th>
              <td><%=answer.getId()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>내용</th>
              <td><textarea rows="2" cols="60" name="aContent" ><%=answer.getaContent()%></textarea></td>
             
           </tr>
           <tr>
              <th>생성일</th>
              <td><%=answer.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=answer.getUpdatedate()%></td>
           </tr>
	</table>
	<button type="submit" class="btn btn-danger">수정</button>
</form>
<%
} 
%>
</body>
</html>