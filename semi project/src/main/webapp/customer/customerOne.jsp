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
	System.out.println(YANG + id + " <-- customerOne id" + RESET);
	
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
	<!-- 회원상세정보 폼 -->
	<div>
		<h1>회원상세정보</h1>
		<table>
			<tr>
				<td>아이디</td>
				<td><%=customer.getId()%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=customer.getCstmName()%></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><%=customer.cstmAddress%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=customer.cstmEmail%></td>
			</tr>
			<tr>
				<td>생일</td>
				<td><%=customer.cstmBirth%></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td><%=customer.cstmPhone%></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><%=customer.cstmGender%></td>
			</tr>
			<tr>
				<td>회원등급</td>
				<td><%=customer.cstmRank%></td>
			</tr>
			<tr>
				<td>포인트</td>
				<td><%=customer.cstmPoint%>점</td>
			</tr>
			<tr>
				<td>마지막 방문일</td>
				<td><%=customer.cstmLastLogin%></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=customer.createdate%></td>
			</tr>
			<tr>
				<td>수정일</td>
				<td><%=customer.updatedate%></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath() %>/customer/modifyCustomer.jsp?id=<%=customer.getId() %>"><button type="button">회원정보수정</button></a>
		<a href="<%=request.getContextPath() %>/customer/removeCustomer.jsp?id=<%=customer.getId() %>"><button type="button">탈퇴</button></a>
	</div>
</body>
</html>