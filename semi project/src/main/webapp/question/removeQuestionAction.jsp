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

IdDao idDao = new IdDao();
//세션 유효성 검사
if(session.getAttribute("loginId") != null) {
	// 요청값 객체에 묶어 저장
	Id loginId = new Id();
	loginId.id = (String) session.getAttribute("loginId");
	loginId.lastPw = request.getParameter("password");

	// 디버깅
	System.out.println(loginId.id + " <-- id");
	System.out.println(loginId.lastPw + " <-- lastPw");

	 
	 int row = idDao.selectId(loginId);
	 // 디버깅
	 System.out.println(row +"<removeQuestionACtion row"); 
	 
  if (row == 1) {
      // 세션 아이디와 입력된 비밀번호가 일치하면 리뷰 삭제 수행
		if (request.getParameter("qNo") != null){
			QuestionDao questionDao = new QuestionDao();
			int qNo = Integer.parseInt(request.getParameter("qNo"));
			int questionrow = questionDao.removeQuestion(qNo); 
			response.sendRedirect(request.getContextPath() + "/home.jsp");
		}
	}
}
%>