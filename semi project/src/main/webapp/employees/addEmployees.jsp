<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h1>직원추가</h1>
		<%
		if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<!-- 직원추가 폼 -->
			<!-- id_list -->
			<form method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="id"><button type="submit" formaction="<%=request.getContextPath() %>/id/ckIdEmpAction.jsp">중복확인</button>
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pw"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="ckPw"></td>
					</tr>
			<!-- employees -->
					<tr>
						<td>이름</td>
						<td>
							<input type="text" name="empName">
						</td>
					</tr>
					<tr>
						<td>관리자 레벨</td>
						<td>
							<label><input type="radio" name="empLevel" value="1">1</label>
							<label><input type="radio" name="empLevel" value="2">2</label>
						</td>
					</tr>
				</table>
				<button type="submit" formaction="<%=request.getContextPath() %>/employees/addEmployeesAction.jsp">추가</button>
			</form>
			
	</div>
</body>
</html>