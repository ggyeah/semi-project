<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
if (request.getParameter("qNo")== null
&& request.getParameter("aNo")== null){
	
}

	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeQuestion</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/answer/removeAnswerAction.jsp?qNo=<%=qNo%>&aNo=<%=aNo%>" method="post">
<table>
	<tr>
		<th>답변을 삭제하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 삭제 </button></td>
	</tr>
</table>
</form>
</body>
</html>