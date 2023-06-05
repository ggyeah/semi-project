<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자일때만 카테고리 수정 가능
	
	// 에러메시지 담을 때 사용할 변수
	String msg = null;
	
	/* 세션값 유효성 검사 */
	

	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryList 객체 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyCategory</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<h1>카테고리 수정</h1>
	<form action="<%=request.getContextPath()%>/category/modifyCategoryAction.jsp" method="post">
		<div>	
			<table>
				<tr>
					<th>수정할 카테고리 이름을 선택해 주세요</th>
				</tr>
				<tr>
					<td>기존 카테고리명</td>
				</tr>
				<tr>
					<td>
						<select class="form-select" name="crntCategoryName">
						<%
							for(Category category : categoryList) {
						%>
							<option value="<%=category.getCategoryName()%>"><%=category.getCategoryName()%></option>
						<% 
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<td>카테고리명 수정</td>
				</tr>
				<tr>
					<td><input type="text" name="newCategoryName"></td>
				</tr>
			</table>
		</div>
		
		<!-- 오류 메시지 -->
		<div class="text-danger">
			<%
				if(request.getParameter("msg") != null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>
		</div>
		
		<div>
			<button type="submit">수정</button>
			<br>
			<a href="<%=request.getContextPath()%>/category/categoryList.jsp">이전으로</a>
		</div>
	</form>
</body>
</html>