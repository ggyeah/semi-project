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
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

<!------------ 상품 리스트 출력	------------>
	<table>
		<tr>
			<th>product_name</th>
			<th>이미지</th>
			<th>product_price</th>
			<th>product_status</th>
			<th>장바구니</th>
		</tr>
	<% 
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = productDao.productListByPage(0, 10);
		for(Product product : productList) {
	%>
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>">
				<%=product.getProductName()%>
				</a>
			</td>
			<td>대충 음식 사진 들어갈 곳</td>
			<td><%=product.getProductPrice()%></td>
			<td><%=product.getProductStatus()%></td>
			<td><a href="<%=request.getContextPath()%>/cart/addCartAction.jsp?productNo=<%=product.getProductNo()%>">장바구니 추가</a></td>
		</tr>
	<% 
		}
	%>
	</table>
	
	<!-- 새로운 상품 추가하는 버튼 -->
	<a href="<%=request.getContextPath()%>/product/addProduct.jsp">상품 추가</a>
	
	<!------------ 페이징 예정 ------------>
</body>
</html>