<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값
	String id = request.getParameter("id");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- removeEmployees id" + RESET);
	
	// 클래스 객체 생성
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
	<div>
		<h1>직원삭제</h1>
		<h3>직원을 삭제하려면 활성화 여부를 N으로 바꿔주세요</h3>
		<!-- 직원 삭제폼 -->
		<form action="<%=request.getContextPath() %>/employees/removeEmployeesAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" value="<%=employees.getId() %>" readonly="readonly"></td>					
				</tr>
				<tr>
					<td>이름</td>
					<td><%=employees.getEmpName() %></td>					
				</tr>
				<tr>
					<td>관리자 레벨</td>
					<td><%=employees.getEmpLevel() %></td>	
				</tr>
				<!-- 활성화 여부를 N으로 바꾸면 삭제 -->
				<tr>
					<td>활성화 여부</td>
					<td>
						<label><input type="radio" name="active" value="Y" <%if((employees.getActive()).equals("Y")) { %>checked<% } %>>Y</label>
						<label><input type="radio" name="active" value="N" <%if((employees.getActive()).equals("N")) { %>checked<% } %>>N</label>
					</td>
				</tr>
			</table>
			<button type="submit">삭제</button>
		</form>
	</div>

</body>
</html>