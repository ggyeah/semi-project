<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<%
//비밀번호확인 완성되면 추가 해야함 (세션아이디 값과 비밀번호를 가져와서 비교해야함)
ReviewDao reviewDao = new ReviewDao();

if (request.getParameter("orderNo") != null){
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int row = reviewDao.removeReview(orderNo); 
}
response.sendRedirect(request.getContextPath() + "/review/reviewList.jsp");
%>