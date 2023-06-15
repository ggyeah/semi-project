<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo+"<- removeReviewImg orderNo");


	final String LIM = "\u001B[41m";
	final String RESET = "\u001B[0m"; 
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	ReviewImgDao reviewImgDao = new ReviewImgDao();
	
	String dir = request.getServletContext().getRealPath("/reviewImgUpload");
    System.out.println(dir +"< -- dir"); // getRealPath 실제위치
    
       int deleteImgRow = reviewImgDao.deleteReviewImgFile(orderNo, dir);
       if (deleteImgRow == 1) {
           System.out.println("파일 삭제 성공");
       } else {
           System.out.println("파일 삭제 실패" + RESET);
       }
       response.sendRedirect(request.getContextPath() + "/review/modifyReview.jsp?orderNo="+orderNo);  
%>