<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<%


if (request.getParameter("discountNo") != null){
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	
	System.out.println("discountNo: " + discountNo);
	
	DiscountDao discountDao = new DiscountDao();
	
	int row = discountDao.removeDiscount(discountNo); 
	
    if (row == 1) {
        response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
    } else {
        out.println("할인 삭제에 실패했습니다.");
    }
}

%>