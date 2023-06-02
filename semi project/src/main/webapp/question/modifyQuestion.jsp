<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

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
<title>modifyQuestion</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<h2>수정</h2>
<form action="<%=request.getContextPath()%>/question/modifyQuestionAction.jsp?qNo=<%=question.getqNo()%>" method="post">

	<table class="table table-bordered">
		<tr>
              <th>문의번호</th>
              <td><%=question.getqNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>상품번호</th>
              <td><%=question.getProductNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>아이디</th>
              <td><%=question.getId()%></td>
           </tr>
		 <tr>
		<tr>
		    <th>카테고리</th>
		    <td>
		        <label><input type="radio" name="qCategory" value="상품" <% if(question.getqCategory().equals("상품")) { %>checked<% } %>> 상품</label>
		        <label><input type="radio" name="qCategory" value="교환환불" <% if(question.getqCategory().equals("교환환불")) { %>checked<% } %>> 교환환불</label>
		        <label><input type="radio" name="qCategory" value="결제" <% if(question.getqCategory().equals("결제")) { %>checked<% } %>> 결제</label>
		        <label><input type="radio" name="qCategory" value="배송" <% if(question.getqCategory().equals("배송")) { %>checked<% } %>> 배송</label>
		        <label><input type="radio" name="qCategory" value="기타" <% if(question.getqCategory().equals("기타")) { %>checked<% } %>> 기타</label>
		    </td>
		</tr>
         <tr>
              <th>제목</th>
              <td><input type= "text" name = "qTitle" value ="<%=question.getqTitle()%>"></td>
           </tr>
		 <tr>
              <th>내용</th>
              <td><input type= "text" name = "qContent" value ="<%=question.getqContent()%>"></td>
           </tr>
           <tr>
		 <tr>
              <th>생성일</th>
              <td><%=question.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=question.getUpdatedate()%></td>
           </tr>
	<tr>
		<th>수정하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 수정</button></td>
	</tr>
</table>
</form>

</body>
</html>