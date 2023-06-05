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

//비밀번호확인 완성되면 추가 해야함 (세션아이디 값과 비밀번호를 가져와서 비교해야함)


if (request.getParameter("qNo") != null
	&& request.getParameter("aNo") != null) {
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	
	AnswerDao answerDao = new AnswerDao();
	int row = answerDao.removeAnswer(aNo); 
	
	response.sendRedirect(request.getContextPath() + "/question/questionListOne.jsp?qNo="+qNo);
}
%>