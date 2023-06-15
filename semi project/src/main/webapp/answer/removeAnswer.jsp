<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	if (request.getParameter("qNo")== null
	&& request.getParameter("aNo")== null
	&& request.getParameter("productNo")== null){
	}
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));	
	int productNo = Integer.parseInt(request.getParameter("productNo"));	
	
	//클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
	ArrayList<Employees> list = dao.selectEmployeesList(); 
	
	//관리자가 아니면 답변을 삭제 할 수없음 // 이전에서는 삭제버튼이작성자와 관리자2만 보이게 지정되어있지만 여기서 작성자 이름을 받을 수없어 이중검사.
	boolean checkId = false;
	for (Employees e : list){
	   if (session.getAttribute("loginId").equals(e.getId())){
	      checkId = true;
	      break;
	   }
	}
	if (checkId==false){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeQuestion</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/answer/removeAnswerAction.jsp?qNo=<%=qNo%>&aNo=<%=aNo%>&productNo=<%=productNo%>" method="post">
<table>
	<tr>
		<th>답변을 삭제하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 삭제 </button></td>
	</tr>
</table>
</form>
</body>
</html>