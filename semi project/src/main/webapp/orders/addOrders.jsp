<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	/* 세션값 확인 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--addOrders loginId param"+RESET);
	
	/* 유효성 검사 */
	if(loginId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(KIM+loginId+" <-- addOrders id parameter"+RESET);
	System.out.println(KIM+productNo+" <-- addOrders productNo parameter"+RESET);
	
	String id = loginId;
	CustomerDao customerDao = new CustomerDao();
	Customer customerOne = customerDao.selectCustomerOne(id);
	
	CartDao cartDao = new CartDao();
	Cart cart = cartDao.selectCartOne(loginId);
	
	OrdersDao ordersDao = new OrdersDao();
	
	// 주문 상세 정보 조회
	Orders orders = ordersDao.selectCustomerOrdersOne(loginId);
	
	// 상품 가격 조회
	ProductDao productDao = new ProductDao();
	Product product = productDao.ProductListOne(productNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addOrders</title>
</head>
<body>
	<form action="addOrdersAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=cart.getProductNo()%>">
		<table>
			<tr>
				<th><h2><%=customerOne.getId()%></h2></th>
			</tr>
			<tr>
				<td><%=customerOne.getCstmName()%></td>
				<td><%=customerOne.getCstmPhone()%></td>
				<td><%=customerOne.getCstmEmail()%></td>
			</tr>
		</table>
		
		<table>	
				
			<tr>
				<th><h2>배송지 정보</h2></th>
			</tr>
			<tr>
				<td>받는분
					<td><input type="text" name="cstmName" value="<%=customerOne.getCstmName()%>"></td>
				</td>
			</tr>
			<tr>	
				<td>최근 배송지 <!-- 수정 예정 -->
					<td><input type="text" name="address" value="<%=customerOne.getCstmAddress()%>"><a href="<%=request.getContextPath()%>/address/addressList.jsp">주소 리스트</a></td>
				</td>
			</tr>
			<tr>	
				<td>주문 상품
					<td><input type="text" name="productName" value="<%=product.getProductName()%>" readonly="readonly"></td>
				</td>
			</tr>
			<tr>	
				<td>수량
					<td><input type="text" name="orderCnt" value="<%=cart.getCartCnt()%>" readonly="readonly"></td>
				</td>
			</tr>
			<tr>	
				<td>총 결제금액 <!-- 장바구니 상품 수량과 상품의 금액을 곱함 -->
					<td><input type="text" name="orderPrice" value="<%=(cart.getCartCnt())*(product.getProductPrice())%>" readonly="readonly"></td>
				</td>
			</tr>
		</table>
		
		<table>
			<tr>
				<td><input type="submit" value="주문"></td>
			</tr>
		</table>
		
	</form>	
</body>
</html>