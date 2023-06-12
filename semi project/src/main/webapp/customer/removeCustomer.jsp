<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import ="vo.*" %>
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
	System.out.println(YANG + id + " <-- removeCustomer id" + RESET);

	// 클래스 객체 생성
	CustomerDao dao = new CustomerDao();
		
	// 회원 상세 정보 보여주는 메소드 호출
	Customer customer = dao.selectCustomerOne(id);

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
		<h1>회원탈퇴</h1>
		<h3>탈퇴하려면 비밀번호를 입력해주세요</h3>
		<form action="<%=request.getContextPath() %>/customer/removeCustomerAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" value="<%=customer.getId() %>" readonly="readonly"></td>				
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="lastPw"></td>
				</tr>

			</table>	
			<button type="submit">탈퇴</button>
		</form>
	</div>

</body>
</html>