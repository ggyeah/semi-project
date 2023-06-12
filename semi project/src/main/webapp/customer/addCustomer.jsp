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
		<h1>회원가입</h1>
			<%
		if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<!-- 회원가입 폼 -->
			<!-- id_list -->
			<form method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="id"><button type="submit" formaction="<%=request.getContextPath() %>/id/ckIdCstmAction.jsp">중복확인</button>
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
			<!-- customer -->
					<tr>
						<td>이름</td>
						<td>
							<input type="text" name="cstmName">
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>
							<textarea cols="30" rows="2" name="cstmAddress"></textarea>
						</td>
					</tr>
					<tr>
					<td>이메일</td>
					<td><input type="email" name="cstmEmail"></td>
				</tr>
				<tr>
					<td>생일</td>
					<td><input type="date" name="cstmBirth"></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="tel" name="cstmPhone"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" name="cstmGender" value="M">남</label>
						<label><input type="radio" name="cstmGender" value="F">여</label>
					</td>
				</tr>
				<tr>
					<td>약관동의</td>
					<td>
						<input type="radio" name="cstmAgree" value="Y">동의
						<input type="radio" name="cstmAgree" value="N">비동의
					</td>
				</tr>
			</table>
			<button type="submit" formaction="<%=request.getContextPath() %>/customer/addCustomerAction.jsp">가입</button>
		</form>
	</div>
</body>
</html>