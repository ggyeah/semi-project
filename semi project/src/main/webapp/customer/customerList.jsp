<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%

	// ANSI CODE	
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
	System.out.println(YANG + currentPage + " <-- customerList currentPage" + RESET);
	
	// 클래스 객체 생성
	CustomerDao dao = new CustomerDao();
	
	// 전체행의 수 
	int totalRow = dao.selectCustomerCnt();
	System.out.println(YANG + totalRow + " <-- customerList totalRow" + RESET);
	
	// 페이지당 행의 수
	int rowPerPage = 20;
	
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
	
	// 회원리스트 불러오는 메소드 호출
	ArrayList<Customer> list  = dao.selectCustomerListByPage(beginRow, rowPerPage);
	
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
	<!-- 회원목록 테이블 -->
	<div>
		<h1>전체회원목록</h1>
		<table>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>마지막 방문일</td>
				<td>가입일</td>
				<td>활성화 여부</td>
			</tr>
			<%
				for(Customer c : list) {
			%>
			<tr>
				<td><a href="<%=request.getContextPath() %>/customer/customerOne.jsp?id=<%=c.getId()%>"><%=c.getId() %></a></td>
				<td><%=c.getCstmName() %></td>
				<td><%=c.getCstmLastLogin() %></td>
				<td><%=c.getCreatedate() %></td>
				<td><%=c.getActive() %></td>
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
			<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>	
	<%
		}
		
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage) {
	%>
				<span><%=i%></span>&nbsp;
	<%			
			} else {		
	%>
				<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
	<%	
			}
		}
		
		if(maxPage != lastPage) {
	%>
			<!--  maxPage + 1 -->
			<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
   	%>
	</div>
</body>
</html>