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
		<h1>비밀번호 변경</h1>
		<!-- 비밀번호 변경 폼 -->
		<form action="<%=request.getContextPath() %>/id/modifyPwAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" value="<%=request.getParameter("id")%>"readonly="readonly"></td>
				</tr>
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<td>새로운 비밀번호</td>
					<td><input type="password" name="newPw"></td>
				</tr>
				<tr>
					<td>새로운 비밀번호 확인</td>
					<td><input type="password" name="newPwCk"></td>
				</tr>
			</table>
			<button type="submit">변경</button>
		</form>
	</div>
</body>
</html>