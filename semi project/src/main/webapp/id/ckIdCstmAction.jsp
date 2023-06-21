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
	if (ckId > 0) {
        msg = "이미 존재하는 아이디입니다";
    } else {
        msg = "사용 가능한 아이디입니다";
    }

    // 오류 메시지를 포함한 응답 출력
    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(msg);
%>