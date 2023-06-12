<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>
<%
	
	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청값 변수 선언
	String id = request.getParameter("id");
	
	// 디버깅
	System.out.println(YANG + id + " <-- id" + RESET);
	
	// sql 클래스 객체 생성
	IdDao dao = new IdDao();
	
	// 아이디 중복체크 메서드 호출
	int ckId = dao.ckId(id);
	
	String msg = null;
	if(ckId > 0) {
		msg = URLEncoder.encode("이미 존재하는 아이디입니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/employees/addEmployees.jsp?msg=" + msg);
		return;
	} else {
		msg = URLEncoder.encode("사용할 수 있는 아이디입니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/employees/addEmployees.jsp?id=" + request.getParameter("id") + "&msg=" + msg);
		return;
	}
	
%>