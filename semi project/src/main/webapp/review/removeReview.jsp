<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
int orderNo = Integer.parseInt(request.getParameter("orderNo"));

System.out.println(orderNo+"<- removeReview");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeReview</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/review/removeReviewAction.jsp" method="post">
<table>
	<tr>
		<th>삭제하시려면 비밀번호를 입력하십시오</th>
		<td><input type="password" name="last_pw"></td>
		<td><button type="submit" class="btn btn-danger"> 삭제 </button></td>
	</tr>
</table>
</form>
</body>
</html>