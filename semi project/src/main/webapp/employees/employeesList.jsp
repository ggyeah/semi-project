<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 현재 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(YANG + currentPage + " <-- employeesList currentPage" + RESET);
		
	// 클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
		
	// 전체행의 수 
	int totalRow = dao.selectEmployeesCnt();
	System.out.println(YANG + totalRow + " <-- employeesList totalRow" + RESET);
		
	// 페이지당 행의 수
	int rowPerPage = 10;
		
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	int endRow = beginRow + (rowPerPage - 1);
	if(endRow > totalRow) {
			endRow = totalRow;
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
		
	// 직원리스트 불러오는 메소드 호출
	ArrayList<Employees> list  = dao.selectEmployeesListByPage(beginRow, rowPerPage);
	
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;
	int minPage = (((currentPage-1) / pagePerPage) * pagePerPage) + 1;
	int maxPage = minPage + (pagePerPage - 1);
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}

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
		<h1>전체직원목록</h1>
		<!-- 직원 추가 버튼 -->
		<a href ="<%=request.getContextPath() %>/employees/addEmployees.jsp"><button type="button">추가</button></a>
		<!-- 직원목록 테이블 -->
		<table>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>관리자 레벨</td>
				<td>등록일</td>					
				<td>수정일</td>		
				<td>활성화 여부</td>			
				<td>수정</td>
				<td>삭제</td>
			</tr>
			<%
				for(Employees e : list) {
			%>
			<tr>
				<td><%=e.getId() %></td>
				<td><%=e.getEmpName() %></td>
				<td><%=e.getEmpLevel() %></td>
				<td><%=e.getCreatedate() %></td>
				<td><%=e.getUpdatedate() %></td>
				<td><%=e.getActive() %></td>
				<td><a href ="<%=request.getContextPath() %>/employees/modifyEmployees.jsp?id=<%=e.getId() %>">수정</a></td>
				<td><a href ="<%=request.getContextPath() %>/employees/removeEmployees.jsp?id=<%=e.getId() %>">삭제</a></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
		
	<!-- 페이지 네비게이션 -->
	<div>
	<%
		if(minPage > 1) {
	%>
			<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>	
	<%
		}
		
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage) {
	%>
				<span><%=i%></span>&nbsp;
	<%			
			} else {		
	%>
				<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
	<%	
			}
		}
		
		if(maxPage != lastPage) {
	%>
			<!--  maxPage + 1 -->
			<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
   	%>
	</div>
</body>
</html>