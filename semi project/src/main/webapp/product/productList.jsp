<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<!-- 상품 리스트 출력	  + 페이징예정 -->
	<table>
		<tr>
			<th>product_no</th>
			<th>product_name</th>
			<th>이미지</th>
			<th>product_price</th>
			<th>product_status</th>
		</tr>
	<% 
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = productDao.productListByPage(0, 10);
		for(Product product : productList) {
	%>
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>">
				<%=product.getProductNo()%>
				</a>
			</td>
			<td><%=product.getProductName()%></td>
			<td>대충 음식 사진 들어갈 곳</td>
			<td><%=product.getProductPrice()%></td>
			<td><%=product.getProductStatus()%></td>
		</tr>
	<% 
		}
	%>
	</table>
</body>
</html>