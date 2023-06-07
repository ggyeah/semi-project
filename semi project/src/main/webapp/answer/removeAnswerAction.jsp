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

   	if (request.getParameter("qNo")!= null
	&& request.getParameter("aNo")!= null
	&& request.getParameter("productNo")!= null){
		
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));	
	int productNo = Integer.parseInt(request.getParameter("productNo"));	

	AnswerDao answerDao = new AnswerDao();
	int rowanswerrow = answerDao.removeAnswer(aNo); 
            
	 response.sendRedirect(request.getContextPath() + "/product/productListOne.jsp?productNo="+productNo);
   	}
%>