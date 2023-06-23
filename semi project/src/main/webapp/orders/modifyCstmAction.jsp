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
	|| request.getParameter("loginId") == null
	|| request.getParameter("deliveryStatus") == null
	|| request.getParameter("orderNo").equals("")
	|| request.getParameter("loginId").equals("")
	|| request.getParameter("deliveryStatus").equals("")){
		//받아온 데이터가 없을 경우 Form으로 redirect
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp");
		return;
		}
	String loginId = request.getParameter("loginId");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String deliveryStatus = request.getParameter("deliveryStatus");
	System.out.println(orderNo+KIM+"<--modifyCstmAction parameter orderNo"+RESET);
	
	//구매확정 시 포인트 추가
	OrdersDao ordersDao = new OrdersDao();
	int row = ordersDao.modifyCustomerOrders(loginId, orderNo);
	int row2 = ordersDao.addCustomerPoint(orderNo);
	System.out.println(row+KIM+"<--modifyCstmAction row"+RESET);
	System.out.println(row2+KIM+"<--modifyCstmAction row2"+RESET);
	
	String msg = null;
	if(row2 == 0){
		msg = URLEncoder.encode("구매확정 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp?msg="+msg);
		return;
	} else {
		msg = URLEncoder.encode("구매확정: 1000p 추가 완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/orders/ordersCstmList.jsp?msg="+msg);
		return;
	}
	
%>