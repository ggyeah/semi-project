<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
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