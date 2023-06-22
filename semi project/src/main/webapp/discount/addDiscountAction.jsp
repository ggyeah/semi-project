<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<% 
//ANSI CODE	
final String LIM = "\u001B[41m";
final String RESET = "\u001B[0m"; 
final String KIM = "\u001B[42m";
final String SONG = "\u001B[43m";
final String YANG = "\u001B[44m";

request.setCharacterEncoding("utf-8");
DiscountDao discountDao = new DiscountDao();
// 유효값 검사 
if (request.getParameter("productNo")== null
	|| request.getParameter("discountStart") == null
	|| request.getParameter("discountEnd")== null 
	|| request.getParameter("discountRate")== null) {
	response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
	return;
	}
	//폼에서 전달된 파라미터 값 가져오기
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountStart = request.getParameter("discountStart");
	String discountEnd = request.getParameter("discountEnd");
	String discountRateStr = request.getParameter("discountRate");
	Double discountRate = Double.valueOf(discountRateStr);
	
	//디버깅 
	System.out.println(LIM + productNo+"addDiscount productNo");
	System.out.println(discountStart+"addDiscount discountStart");
	System.out.println(discountEnd+"addDiscount discountEnd");
	System.out.println(discountRate+"addDiscount discountRate" + RESET);
	
	//입력받은 값으로 Discount 객체 생성
	Discount discount = new Discount();
	discount.setProductNo(productNo);
	discount.setDiscountStart(discountStart);
	discount.setDiscountEnd(discountEnd);
	discount.setDiscountRate(discountRate);
	int row = discountDao.addDiscount(discount); 

	if (row == 1) {
	    System.out.println("추가 성공");
	} else {
	    System.out.println("추가 실패");
	}
	response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");

%>

