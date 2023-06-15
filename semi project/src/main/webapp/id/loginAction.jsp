<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.net.*" %>

<%

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	//세션 유효성 검사
	if(session.getAttribute("loginId") != null) {
	response.sendRedirect(request.getContextPath()+"/home.jsp");
	return;
	}

	// 요청값 변수 선언
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
   
	// 디버깅
	System.out.println(YANG + id + " <-- id" + RESET);
	System.out.println(YANG + pw + " <-- pw" + RESET);
   
	// 요청값 객체에 묶어 저장
	Id loginId = new Id();
	loginId.id = id;
	loginId.lastPw = pw;
	
	// sql 클래스 객체 생성
	IdDao dao = new IdDao();
   
	// 로그인 메서드 호출
	int login = dao.selectId(loginId);
	
	String empCstm = null;
	if(login == 1){
		empCstm = dao.selectEmpCstm(loginId);
		System.out.println(empCstm);
	}
	
	
   /*
	if(login == 1) { //로그인 성공
		session.setAttribute("loginId", loginId.id);
		System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} else { // 로그인 실패
		System.out.println(YANG + "로그인 실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
*/
%>