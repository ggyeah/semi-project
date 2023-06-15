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
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
	<!-- 로그인 폼 -->
	<div>
		<form action="<%=request.getContextPath()%>/id/loginAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
					<td rowspan="2"><button type="submit">로그인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw"></td>
				</tr>
			</table>
		</form>
		<a href="<%=request.getContextPath()%>/customer/addCustomer.jsp"><button type="submit">회원가입</button></a>
	
	</div>

</body>
</html>