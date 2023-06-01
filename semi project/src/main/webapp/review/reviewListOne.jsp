<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
ReviewDao reviewDao = new ReviewDao();

Review review = new Review();

if (request.getParameter("orderNo") != null){
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	review = reviewDao.reviewListOne(orderNo);
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
<h2>상세보기</h2>
	<table class="table table-bordered">
		<tr>
              <th>번호</th>
              <td><%=review.getOrderNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>아이디</th>
              <td><%=review.getProductNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>이름</th>
              <td><%=review.getReviewTitle()%></td>
           </tr>
		 <tr>
		<tr>
              <th>히스토리</th>
              <td><%=review.getReviewContent()%></td>
           </tr>
		 <tr>
              <th>생성일</th>
              <td><%=review.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=review.getUpdatedate()%></td>
           </tr>
	</table>

	<div>
		<a href="<%=request.getContextPath()%>/review/modifyReview.jsp?orderNo=<%=review.getOrderNo()%>">수정</a>
		<a href="<%=request.getContextPath()%>/review/removeReview.jsp?orderNo=<%=review.getOrderNo()%>">삭제</a>
	</div>	
</body>
</html>