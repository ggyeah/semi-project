<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 수정 가능
	
	// 에러메시지 담을 때 사용할 변수
	String msg = null;
	
	/* 세션값 유효성 검사 */
	

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
	System.out.println(SONG + productNo + " <-- modifyProduct " + RESET);	
	
	ProductDao prodDao = new ProductDao(); // ProductDao 객체 생성
	Product productOne = prodDao.ProductListOne(productNo); // productNo 매개변수로 productOne 메서드 호출하여, 수정페이지에 표시할 상품정보 productOne 객체 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyProduct</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
<h1>상품 수정 페이지</h1>
<form action="<%=request.getContextPath()%>/product/modifyProductAction.jsp" method="post">
	<table>
		<tr>
			<th>category_name</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name="categoryName" value="<%=productOne.getCategoryName()%>"></td>
		</tr>
		<tr>	
			<th>product_name</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name=productName value="<%=productOne.getProductName()%>"></td>
		</tr>
		<tr>
			<th>product_price</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name="productPrice" value="<%=productOne.getProductPrice()%>"></td>
		</tr>
		<tr>
			<th>product_status</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name="productStatus" value="<%=productOne.getProductStatus()%>"></td>
		</tr>
		<tr>
			<th>product_stock</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name="productStock" value="<%=productOne.getProductStock()%>"></td>
		</tr>
		<tr>
			<th>product_img</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="file" name="productImg" required="required"></td>
		</tr>
		<tr>
			<th>product_info</th>
			<td><input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>"></td>
			<td><input type="text" name="productInfo" value="<%=productOne.getProductInfo()%>"></td>
		</tr>
	</table>
	<button type="submit">수정</button>
</form>

</body>
</html>