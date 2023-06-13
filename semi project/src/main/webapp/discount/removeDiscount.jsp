<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//관리자 2가 아니면 홈으로 되돌아감
	if (!session.getAttribute("loginId").equals("admin")) { 
	response.sendRedirect(request.getContextPath() + "/home.jsp");
	}

	if (request.getParameter("productNo")== null){	
		response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeQuestion</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/discount/removeDiscountAction.jsp?productNo=<%=productNo%>" method="post">
<table>
	<tr>
		<th>해당상품의 할인을 삭제하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 삭제 </button></td>
	</tr>
</table>
</form>
</body>
</html>