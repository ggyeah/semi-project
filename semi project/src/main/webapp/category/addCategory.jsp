<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 추가 가능
	
	// 에러메시지 담을 때 사용할 변수
	String msg = null;

	/* 세션 유효성 검사 */
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCategory</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<h1>카테고리 추가</h1>
	<!-- 에러메세지 -->
	<div>
	<%
		if(request.getParameter("msg") != null){
	%>
		<%=request.getParameter("msg")%>
	<%
		}
	%>
	</div>
	
	<!-- 새로운 카테고리 입력 -->
	<form action="<%=request.getContextPath()%>/category/addCategoryAction.jsp" method="post">
	<table>
		
		<tr>
			<th>추가할 카테고리 이름을 입력해 주세요</th>
		</tr>
		<tr>
			<td><input type="text" name="categoryName"></td>
		</tr>
	</table>
		<button type="submit">추가</button>
		<br>
		<a href="<%=request.getContextPath()%>/category/categoryList.jsp">이전으로</a>
	</form>
</body>
</html>