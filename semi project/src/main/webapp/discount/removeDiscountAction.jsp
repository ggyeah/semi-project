<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<%

//비밀번호확인 완성되면 추가 해야함 (세션아이디 값과 비밀번호를 가져와서 비교해야함)
DiscountDao discountDao = new DiscountDao();

if (request.getParameter("productNo") != null){
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int row = discountDao.removeDiscount(productNo); 
}
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
%>