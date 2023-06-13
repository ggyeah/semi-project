<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>
<%
response.setCharacterEncoding("utf-8");

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
return;
}
int productNo = Integer.parseInt(request.getParameter("productNo"));

//로그인 상태가 아니면 문의를 작성할 수없음
if(session.getAttribute("loginId") == null) {
response.sendRedirect(request.getContextPath() + "/product/productListOne.jsp?productNo="+productNo);
}	
String loginId = (String)session.getAttribute("loginId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addReview</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<form action="<%=request.getContextPath()%>/question/addQuestionAction.jsp" method="post">
<h1>문의</h1>
<table class="table table-bordered">
	<tr>
		<td>상품번호</td>
		<td><input type="text" name="productNo" value="<%=productNo%>" readonly="readonly"></td>
	</tr>
	<tr>
		<td>아이디</td> <!--  세션 값 받아와서 넣어야함 -->
		<td><input type="text" name="id" value="<%=loginId%>" readonly="readonly"></td>
	</tr>
	<tr>
	    <td>카테고리</td>
	    <td>
	        <label><input type="radio" name="qCategory" value="상품"> 상품</label>
	        <label><input type="radio" name="qCategory" value="교환환불"> 교환환불</label>
	        <label><input type="radio" name="qCategory" value="결제"> 결제</label>
	        <label><input type="radio" name="qCategory" value="배송"> 배송</label>
	        <label><input type="radio" name="qCategory" value="기타"> 기타</label>
	    </td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="qTitle"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><input type="text" name="qContent"></td>
	</tr>
	<tr>
		<td>
		<button type="submit" class="btn btn-danger"> 추가 </button>
		</td>
	</tr>
</table>
</form>
</body>
</html>