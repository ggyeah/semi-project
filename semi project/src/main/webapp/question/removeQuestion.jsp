<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
int qNo= Integer.parseInt(request.getParameter("qNo"));

System.out.println(qNo+"<- removequestion qNo");
//로그인상태가 아니면 홈으로 돌아감
if(session.getAttribute("loginId") == null) {
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
<form action="<%=request.getContextPath()%>/question/removeQuestionAction.jsp?qNo=<%=qNo%>" method="post">
<table>
	<tr>
		<th>삭제하시려면 비밀번호를 입력하십시오</th>
		<td><input type="password" name="password"></td>
		<td><button type="submit" class="btn btn-danger"> 삭제 </button></td>
	</tr>
</table>
</form>
</body>
</html>