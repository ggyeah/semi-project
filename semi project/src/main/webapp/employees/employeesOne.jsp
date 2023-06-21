<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	
	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값
	String id = request.getParameter("id");
		
	// 요청값 디버깅
	System.out.println(YANG + id + " <--employeesOne id" + RESET);

	// 클랙스 객체 생성
	EmployeesDao dao = new EmployeesDao();
	
	// 직원 상세 정보 보여주는 메소드 호출
	
	Employees employees = dao.selectEmployeesOne(id);
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<!-- 직원상세정보 폼 -->
	<div>
		<h1>직원상세정보</h1>
		<table>
			<tr>
				<td>아이디</td>
				<td><%=employees.getId() %></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=employees.getEmpName() %></td>
			</tr>
			<tr>
				<td>관리자 레벨</td>
				<td><%=employees.getEmpLevel() %></td>
			</tr>
			<tr>
				<td>등록일</td>
				<td><%=employees.getCreatedate() %></td>
			</tr>
			<tr>
				<td>수정일</td>
				<td><%=employees.getUpdatedate() %></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath() %>/id/modifyPw.jsp?id=<%=employees.getId() %>"><button type="button">비밀번호변경</button></a>
	</div>
</body>
</html>