<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import = "vo.*" %>
<%
	//세션 유효성 검사
	if(session.getAttribute("loginId") != null) {
		response.sendRedirect(request.getContextPath()+"/homepage/home.jsp");
		return;
	}

	// 요청값 변수 선언
	String id = request.getParameter("id");
	String lastPw = request.getParameter("lastPw");
	
	// 요청값 객체에 묶어 저장
	Id loginId  = new Id();
	loginId.id = id;
	loginId.lastPw = lastPw;
	
	// 디버깅
	System.out.println(id + " <-- id");
	System.out.println(lastPw + " <-- lastPw");
	
	// sql 클래스 객체 생성
	IdDao dao = new IdDao();
	
	ResultSet loginRs = dao.selectId(loginId);
	
	if(loginRs.next()) { //로그인 성공
		session.setAttribute("loginId", loginRs.getString("id"));
		System.out.println("로그인 성공 세션정보 : " + session.getAttribute("loginId"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} else { // 로그인 실패
	      System.out.println("로그인 실패");
	      response.sendRedirect(request.getContextPath()+"/home.jsp");
	}
	


%>