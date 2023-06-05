<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
QuestionDao questionDao = new QuestionDao();
AnswerDao answerDao = new AnswerDao();

Question question = new Question();
Answer answer = new Answer();

if (request.getParameter("qNo") != null){
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	question = questionDao.questionOne(qNo);
	answer = answerDao.answerOne(qNo);
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
	
	<!-------------------  답변---------------------->
	
	 <% if (answer != null) { %>
	 <h2>답변</h2>
	<table class="table table-bordered">
	
		 <tr>
              <th>아이디</th>
              <td><%=answer.getId()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>내용</th>
              <td><%=answer.getaContent()%></td>
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
	<div>
	<a href="<%=request.getContextPath()%>/answer/modifyAnswer.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>">수정</a>
    <a href="<%=request.getContextPath()%>/answer/removeAnswer.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>">삭제</a>
	</div>	
	  <% } else { %>
	  	<!-------------------  답변추가---------------------->
	<!--  세션으로 관리자만 답변입력이 가능하게 해야함 -->
	<h3>답변</h3>
	<form action="<%=request.getContextPath()%>/answer/addAnswerAction.jsp?qNo=<%=question.getqNo()%>" method="post">
	<table class="table table-bordered">
	<tr>
		<td>문의번호:<%=question.getqNo()%> 아이디 : <!--  세션값으로 변경해야함 일단 테스트용 --><input type="text" name="id" value="admin" readonly="readonly"></td>
	</tr>
	<tr>
		<td><textarea rows="2" cols="60" name="aContent"></textarea>
			<button type="submit" class="btn btn-danger"> 추가 </button></td>
	</tr>
</table>
	</form> 
	  <% } %>
	
</body>
</html>