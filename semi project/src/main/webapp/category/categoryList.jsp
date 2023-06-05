<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	CategoryDao cDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = cDao.categoryList(); // categoryList 메서드 호출하여, 페이지에 표시할 categoryList 객체 가져오기
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<div>
	<h1>카테고리 관리 페이지</h1>
	<table>
		<tr>
			<th>category_name</th>
			<th>createdate</th>
			<th>updatedate</th>
		</tr>
	<%
		for(Category category : categoryList) {
	%>
		<tr>
			<td><%=category.getCategoryName()%></td>
			<td><%=category.getCreatedate()%></td>
			<td><%=category.getUpdatedate()%></td>
		</tr>
	<% 
		}
	%>
	</table>
	
	<br>
	
	<!-- 카테고리정보 관리 버튼 -->
	<a href="<%=request.getContextPath()%>/category/addCategory.jsp">카테고리 추가</a>
	<a href="<%=request.getContextPath()%>/category/modifyCategory.jsp">카테고리 수정</a>
	<a href="<%=request.getContextPath()%>/category/removeCategory.jsp">카테고리 삭제</a>
</div>
</body>
</html>