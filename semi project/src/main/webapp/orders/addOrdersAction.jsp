<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
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
	
	/* 유효성 검사 */
	if(request.getParameter("productNo") == null
		|| request.getParameter("orderCnt") == null
		|| request.getParameter("orderPrice") == null
		|| request.getParameter("productNo").equals("")
		|| request.getParameter("orderCnt").equals("")
		|| request.getParameter("orderPrice").equals("")){
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp");
		return;
		}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	String loginId = (String)session.getAttribute("loginId");
	// 디버깅
	System.out.println(KIM+loginId+" <--addOrdersAction parameter id"+RESET);
	System.out.println(KIM+productNo+"<--addOrdersAction parameter productNo"+RESET);
	System.out.println(KIM+orderPrice+"<--addOrdersAction parameter orderPrice"+RESET);
	System.out.println(KIM+orderPrice+"<--addOrdersAction parameter orderPrice"+RESET);
	
	/* 객체에 데이터 담기 */
	Orders orders = new Orders();
	orders.setId(loginId);
	orders.setProductNo(productNo);
	orders.setOrderCnt(orderCnt);
	orders.setOrderPrice(orderPrice);
	
	OrdersDao ordersDao = new OrdersDao();
	int row = ordersDao.addCustomerOrders(orders);
	System.out.println(row+KIM+"<--addOrdersAction row"+RESET);
	
	String msg = null;
	if(row == 0){
		msg = URLEncoder.encode("주문 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp");
		return;
	} else {
		msg = URLEncoder.encode("주문 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp");
		return;
	}
%>