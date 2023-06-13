<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>
<%
response.setCharacterEncoding("utf-8");
// 관리자 2가 아니면 홈으로 되돌아감
if (session.getAttribute("loginId").equals("admin")) { 	
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}



int productNo = Integer.parseInt(request.getParameter("productNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addDiscount</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<form action="<%=request.getContextPath()%>/discount/addDiscountAction.jsp" method="post">
<h1>할인추가</h1>
<table class="table table-bordered">
	<tr>
		<td>상품번호</td>
		<td><input type="text" name="productNo" value="<%=productNo%>" readonly="readonly"></td>
	</tr>
	<tr>
		<td>할인시작일</td> 
		<td><input type="date" name="discountStart"></td>
	</tr>
	<tr>
		<td>할인종료일</td> 
		<td><input type="date" name="discountEnd"></td>
	</tr>
		<tr>
		<td>할인율</td> 
		<td><input type="number" step="0.1" name="discountRate"></td>
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