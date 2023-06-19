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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(document).on("click", ".remove-discount", function(e) {
      e.preventDefault();
      if (confirm("정말 삭제하시겠습니까?")) {
        var deleteLink = $(this);
        $.get(deleteLink.attr("href"), function() {
          deleteLink.closest("tr").remove();
          location.reload(); // 삭제 후에 화면을 다시 로드
        }).fail(function() {
          alert("삭제에 실패했습니다. 다시 시도해주세요.");
        });
      }
    });
  });
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
			<th>할인시작일</th>
			<th>할인종료일</th>
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
	       <% if(discount.getDiscountStart()!=null && discount.getDiscountEnd()!= null) {%>
	        <td><%= discount.getDiscountStart()%></td>
	        <td><%= discount.getDiscountEnd()%></td>
	        <%}else{%>
	        <td>할인적용안됨</td>
	        <td>할인적용안됨</td>
			<%} %>
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
			 <% if(discount.getDiscountStart()!=null && discount.getDiscountEnd()!= null) {%>
			<td><a href="<%=request.getContextPath()%>/discount/modifyDiscount.jsp?productNo=<%=discount.getProductNo()%>">수정</a></td>
			<td><a href="<%=request.getContextPath()%>/discount/removeDiscountAction.jsp?discountNo=<%=discount.getDiscountNo()%>" class="remove-discount">삭제</a></td>
		</tr>
	<% }else {%>
	<% } }%>
	</table>	
	
	<!------------ 페이징 예정 ------------>
</body>
</html>