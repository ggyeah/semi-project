<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<title>home</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
<meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ogani | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>


<!------------ 최신상품 5개 ------------>
<div>
	<table>
		<tr>
			<th>product_name</th>
			<th>이미지</th>
			<th>product_price</th>
			<th>product_status</th>
		</tr>
	<% 
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = productDao.productListByPage(0, 5);
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
		</tr>
	<% 
		}
	%>
	</table>
	
	<!-- 더보기 누르면 상품리스트로 가도록 -->
	<a href="<%=request.getContextPath()%>/product/productList.jsp">
	더보기
	</a>
</div>



<!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
</div>


</body>
</html>