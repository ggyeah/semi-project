<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%

DiscountDao discountDao = new DiscountDao();
ArrayList<Discount> dList = discountDao.discountList(0,10);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<h2>할인상품</h2>
	<table class="table table-bordered">
		<tr>
			<th>상품번호</th>
			<th>카테고리</th>
			<th>상품이름</th>
			<th>상태</th>
			<th>수량</th>
			<th>할인비율</th>
			<th>할인적용가격</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	<% 
		for(Discount discount : dList) {
	%>
		<tr>
	        <td><%= discount.getProductNo() %></td>
	        <td><%= discount.getCategoryName() %></td>
			<td>
				<a href="<%=request.getContextPath()%>/discount/addDiscount.jsp?productNo=<%=discount.getProductNo()%>">
	      		<%= discount.getProductName() %></a>
	      	</td>
	        <td><%= discount.getProductStatus() %></td>
	        <td><%= discount.getProductStock() %></td>
	        <td><%= discount.getDiscountRate() %></td>
	        <td><%= discount.getDiscountedPrice() %></td>
	        <% 
	    	if(discount != null) { 
	        %>
			<td><a href="<%=request.getContextPath()%>/discount/modifyDiscount.jsp?productNo=<%=discount.getProductNo()%>">수정</a></td>
			<td><a href="<%=request.getContextPath()%>/discount/removeDiscount.jsp?productNo=<%=discount.getProductNo()%>">삭제</a></td>
		</tr>
	<% 
			}
		}
	%>
	</table>	
	
	<!------------ 페이징 예정 ------------>
</body>
</html>