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
// 유효값 검사 
if (request.getParameter("qNo")!= null
	|| request.getParameter("id") != null
	|| request.getParameter("aContent")!= null) {
	//폼에서 전달된 파라미터 값 가져오기
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String id = request.getParameter("id");
	String aContent = request.getParameter("aContent");
	
	//디버깅 
	System.out.println(LIM + qNo+"<- addAnswer qNO");
	System.out.println(id+"<- addAnswer id");
	System.out.println(aContent+"<- addAnswer aContent"+ RESET);
	
	//입력받은 값으로 Answer 객체 생성
	Answer answer = new Answer();
	answer.setqNo(qNo);
	answer.setId(id);
	answer.setaContent(aContent);
	int row = answerDao.addAnswer(answer); 
	
	response.sendRedirect(request.getContextPath() + "/question/questionListOne.jsp?qNo="+qNo);
}
%>
