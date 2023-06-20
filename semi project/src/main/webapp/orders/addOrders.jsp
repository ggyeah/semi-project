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
	
	/* 인코딩 */
	request.setCharacterEncoding("utf-8");
	
	/* 세션값 확인 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--addOrders loginId param"+RESET);
	
	/* 유효성 검사 */
	if(session.getAttribute("loginId") == null
	|| request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	String id = loginId;
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(KIM+loginId+" <-- addOrders id parameter"+RESET);
	System.out.println(KIM+productNo+" <-- addOrders productNo parameter"+RESET);
	
	CustomerDao customerDao = new CustomerDao();
	Customer customerOne = customerDao.selectCustomerOne(id);
	
	CartDao cartDao = new CartDao();
	Cart cart = cartDao.selectCartOne(loginId);
	String address= "";
	
	// 배송지를 변경했을 시 변경된 주소를 address 변수에 복사
	if(request.getParameter("check") != null){
		address = request.getParameter("check");
	}
	
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
	<meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ogani | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
</head>
<body>
<!-------------- 상단 네비게이션 바(메인메뉴) -------------->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<!----------------------- 메세지 ----------------------->
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
<!----------------------- 주문 추가 폼 ----------------------->	
	<form action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=cart.getProductNo()%>">
		<table>
			<tr>
				<th><h2><%=customerOne.getId()%></h2></th>
			</tr>
<!--[begin] css 적용 예정 -->
    <section class="blog-details-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2></h2>
                        <ul>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!--[end] css 적용 예정 -->
			<tr>
				<td><%=customerOne.getCstmName()%></td>
				<td><%=customerOne.getCstmPhone()%></td>
				<td><%=customerOne.getCstmEmail()%></td>
			</tr>
		</table>
		
		<table>
				
			<tr>
				<th><h2>배송지 정보</h2></th>
				<td><a href="<%=request.getContextPath()%>/address/addressList.jsp?productNo=<%=cart.getProductNo()%>" class="delivery-change" onclick="openUserDeliveryListPop();"><span class="">배송지관리</span></a></td>
			
			</tr>
			<tr>
				<td>받는분
					<td><input type="text" name="cstmName" value="<%=customerOne.getCstmName()%>"></td>
				</td>
			</tr>
			<tr>	
				<td>배송지
					<td><input type="text" name="address" value="<%=address%>"></td>
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