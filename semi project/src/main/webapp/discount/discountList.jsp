<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 	
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

DiscountDao discountDao = new DiscountDao();
ArrayList<Discount> dList = discountDao.discountList(0,10);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
  function removeCheck() {
    if (confirm("해당 상품의 할인을 삭제하시겠습니까?")) {
      document.removefrm.submit();
    }
    return false; // 기본 동작 중지
  }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<h2>할인상품</h2>
	<table class="table table-bordered">
		<tr>
			<th>상품번호</th>
			<th>카테고리</th>
			<th>상품이름</th>
			<th>상태</th>
			<th>수량</th>
			<th>할인비율</th>
			<th>할인적용가격</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	<% 
		for(Discount discount : dList) {
	%>
		<tr>
	        <td><%= discount.getProductNo() %></td>
	        <td><%= discount.getCategoryName() %></td>
			<td>
				<a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=discount.getProductNo()%>">
	      		<%= discount.getProductName() %></a>
	      	</td>
	        <td><%= discount.getProductStatus() %></td>
	        <td><%= discount.getProductStock() %></td>
			<td>
			    <%
			    double discountRate = discount.getDiscountRate();
			    if (discountRate == 0.0) {
			    %>
			        <a href="<%=request.getContextPath()%>/discount/addDiscount.jsp?productNo=<%=discount.getProductNo()%>">
			            할인추가
			        </a>
			    <%
			    } else {
			        out.print(discountRate);
			    }
			    %>
			</td>
	        <td><%= discount.getDiscountedPrice() %></td>
	        <% 
	        if (discountRate != 0.0) { 
	        %>
			<td><a href="<%=request.getContextPath()%>/discount/modifyDiscount.jsp?productNo=<%=discount.getProductNo()%>">수정</a></td>
			<td><a href="<%=request.getContextPath()%>/discount/removeDiscountAction.jsp?productNo=<%=discount.getProductNo()%>" onclick="return removeCheck()">삭제</a></td>
		</tr>
	<% 
			}
		}
	%>
	</table>	
	
	<!------------ 페이징 예정 ------------>
</body>
</html>