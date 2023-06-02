<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	/* 요청값 유효성 검사 */
	if(request.getParameter("productNo") == null  
		|| request.getParameter("productNo").equals("")) {
		// productList.jsp으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	// 유효성 검사를 통과하면 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// 디버깅
	System.out.println(SONG + productNo + RESET);
	ProductDao prodDao = new ProductDao(); // ProductDao 객체 생성
	Product productOne = prodDao.ProductListOne(productNo); // productNo 매개변수로 productOne 메서드 호출하여, 상세보기에 표시할 productOne 객체 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productListOne</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
<!------------  상품상세보기 ------------>
<div>
	<table>
		<tr>
			<th>product_no</th>
			<td><%=productOne.getProductNo()%></td>
		</tr>
		<tr>
			<th>category_name</th>
			<td><%=productOne.getCategoryName()%></td>
		</tr>
		<tr>	
			<th>product_name</th>
			<td><%=productOne.getProductName()%></td>
		</tr>
		<tr>
			<th>product_price</th>
			<td><%=productOne.getProductPrice()%></td>
		</tr>
		<tr>
			<th>product_status</th>
			<td><%=productOne.getProductStatus()%></td>
		</tr>
		<tr>
			<th>product_stock</th>
			<td><%=productOne.getProductStock()%></td>
		</tr>
		<tr>
			<th>이미지</th>
			<td>대충 음식 사진 들어갈 곳</td>
		</tr>
		<tr>
			<th>product_info</th>
			<td><%=productOne.getProductInfo()%></td>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=productOne.getCreatedate()%></td>
		</tr>
		<tr>
			<th>updatedate</th>
			<td><%=productOne.getUpdatedate()%></td>
		</tr>
		<tr>
			<th>장바구니</th>
			<td>대충 장바구니 버튼 들어갈 곳</td>
		</tr>
	</table>
</div>
</body>
</html>