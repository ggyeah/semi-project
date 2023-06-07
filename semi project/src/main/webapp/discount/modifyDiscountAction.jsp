
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
//유효값 검사 

if (request.getParameter("productNo") != null
	&&request.getParameter("discountStart") != null
	&&request.getParameter("discountEnd")!= null
	&& request.getParameter("discountRate") != null) {
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountStart = request.getParameter("discountStart");
	String discountEnd = request.getParameter("discountEnd");
	String discountRateStr = request.getParameter("discountRate");
	Double discountRate = new Double(discountRateStr);
	//폼에서 전달된 파라미터 값 가져오기
	
	// 디버깅
	System.out.println(LIM+productNo+"modifyDiscount productNo");
	System.out.println(discountStart+"modifyDiscount discountStart");
	System.out.println(discountEnd+"modifyDiscount discountEnd");
	System.out.println(discountRate+"modifyDiscount discountRate"+RESET);
	
	//입력받은 값으로 Review 객체 생성
	Discount discount = new Discount();
	discount.setDiscountStart(discountStart);
	discount.setDiscountEnd(discountEnd);
	discount.setDiscountRate(discountRate);
	discount.setProductNo(productNo);
	
	int row = discountDao.modifyDiscount(discount); 

	response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}


%>

