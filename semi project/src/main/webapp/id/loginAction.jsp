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
	
	// 직원인지 고객인지 구분하는 메서드 호출
	String empCstm = null;
	String lastLogin = null;
	if(login == 1){
		empCstm = dao.selectEmpCstm(loginId);
		System.out.println(YANG + empCstm + RESET);
	}
	
	// 직원이면 로그인
	if(empCstm.equals("직원")){
		session.setAttribute("loginId", loginId.id);
		System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	
	
	// 고객이면 최근 방문 시간 체크하는메서드 호출
	}else if (empCstm.equals("고객")){
		lastLogin = dao.selectCstmLastLogin(loginId);
		System.out.println(YANG + lastLogin + RESET);		
	}
		
	if(lastLogin.equals("정상계정")){
		session.setAttribute("loginId", loginId.id);
		System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}else if(lastLogin.equals("휴면계정")){
		System.out.println(YANG + loginId.id + " : 마지막 로그인 날짜 6개월 이상 -> 휴면처리"+ RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} else {
		System.out.println(YANG + loginId.id + " : 탈퇴회원"+ RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}

%>