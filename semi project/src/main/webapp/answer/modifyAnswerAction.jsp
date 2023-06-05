
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
AnswerDao answerDao = new AnswerDao();
//유효값 검사 
if (request.getParameter("qNo") != null
	&& request.getParameter("aNo") != null
	&& request.getParameter("aContent") != null) {
	//폼에서 전달된 파라미터 값 가져오기
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	String aContent = request.getParameter("aContent");
	
	// 디버깅
	System.out.println(LIM+qNo+"<-- modifyAnswer qNo");
	System.out.println(aContent+"<-- modifyAnswer aContent"+RESET);
	

	int row = answerDao.modifyAnswer(aNo, aContent); 

	response.sendRedirect(request.getContextPath() + "/question/questionListOne.jsp?qNo="+qNo);
}


%>

