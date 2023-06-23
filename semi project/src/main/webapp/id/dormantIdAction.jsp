<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
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
	
	// 요청값 객체에 묶어 저장
	Id loginId = new Id();
	loginId.id = id;
	
	// sql 클래스 객체 생성
	IdDao dao = new IdDao();
	
	// 휴면계정 풀어주는 메서드 호출
	int dormantId = dao.updateDormantId(loginId);
	
	if(dormantId >0 ){
		System.out.println(YANG + id + " <-- id 휴면계정 풀기 성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/id/login.jsp");
	}
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>