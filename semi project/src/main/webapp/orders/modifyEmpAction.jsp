<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*" %>
<%

	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	/* 인코딩 설정 */
	request.setCharacterEncoding("utf-8");
	
	/* 유효성 검사 */
	if(request.getParameter("orderNo") == null
	|| request.getParameter("empOrdersModify") == null
	|| request.getParameter("orderNo").equals("")
	|| request.getParameter("empOrdersModify").equals("")){
		//받아온 데이터가 없을 경우 Form으로 redirect
		response.sendRedirect(request.getContextPath()+"/orders/ordersEmpList.jsp");
		return;
		}
	String deliveryStatus = request.getParameter("empOrdersModify");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(deliveryStatus+KIM+"<--modifyEmpAction parameter deliveryStatus"+RESET);
	System.out.println(orderNo+KIM+"<--modifyEmpAction parameter orderNo"+RESET);
	
	/* 객체에 데이터 담기 */
	Orders orders = new Orders();
	orders.setDeliveryStatus(deliveryStatus);
	orders.setOrderNo(orderNo);
	
	OrdersDao ordersDao = new OrdersDao();
	int row = ordersDao.modifyECOrders(orders);
	System.out.println(row+KIM+"<--modifyEmpAction row"+RESET);
	
	String msg = null;
	if(row == 0){
		msg = URLEncoder.encode("주문 상태 변경 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersEmpList.jsp?msg="+msg);
		return;
	} else {
		msg = URLEncoder.encode("주문 상태 변경", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersEmpList.jsp?msg="+msg);
		return;
	}
	
%>