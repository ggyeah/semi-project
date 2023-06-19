<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

//관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

DiscountDao discountDao = new DiscountDao();

Discount discount = new Discount();

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}

int productNo = Integer.parseInt(request.getParameter("productNo"));
discount= discountDao.discountOne(productNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyDiscount</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 할인시작일 입력 폼에 포커스
    $('#discountStart').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        // 할인시작일 유효성 검사
        if ($('#discountStart').val() == '') {
            $('#discountStartMsg').text('할인시작일을 입력하세요');
            $('#discountStart').focus();
            allCheck = false;
        } else {
            $('#discountStartMsg').text('');
        }

        // 할인종료일 유효성 검사
        if ($('#discountEnd').val() == '') {
            $('#discountEndMsg').text('할인종료일을 입력하세요');
            $('#discountEnd').focus();
            allCheck = false;
        } else {
            $('#discountEndMsg').text('');
        }
        
        // 할인율 유효성 검사
        if ($('#discountRate').val() == '') {
            $('#discountRateMsg').text('할인율을 입력하세요');
            $('#discountRate').focus();
            allCheck = false;
        } else {
            $('#discountRateMsg').text('');
        }
        
        return allCheck;
    }
    
    $('#btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('form').submit();
        }
    });
});
</script>
</head>
<body class="container">
<h2>수정</h2>
<%
if (discount != null) { // discount 객체가 null이 아닐 때만 수정 페이지를 표시합니다.
%>
<form id="form" action="<%=request.getContextPath()%>/discount/modifyDiscountAction.jsp?productNo=<%=discount.getProductNo()%>" method="post">
	<table class="table table-bordered">
		<tr>
              <th>할인번호</th>
              <td><%=discount.getDiscountNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>상품번호</th>
              <td><%=discount.getProductNo()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>할인시작일</th>
              <td><input type= "date" name = "discountStart" value ="<%=discount.getDiscountStart()%>" id="discountStart">
           	  <span id="discountStartMsg" class="msg"></span></td>
           </tr>
		 <tr>
         <tr>
              <th>할인종료일</th>
              <td><input type="date" name = "discountEnd" value ="<%=discount.getDiscountEnd()%>" id="discountEnd">
         	  <span id="discountEndMsg" class="msg"></span></td>
         </tr>
		 <tr>
              <th>할인율</th>
              <td><input type= "number" step="0.1" name = "discountRate" value ="<%=discount.getDiscountRate()%>" id="discountRate">
           	  <span id="discountRateMsg" class="msg"></span></td>
         </tr>
		 <tr>
              <th>생성일</th>
              <td><%=discount.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=discount.getUpdatedate()%></td>
           </tr>
	<tr>
		<th>수정하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 수정</button></td>
	</tr>
</table>
</form>
<%
} else { // discount 객체가 null인 경우에는 해당 정보가 없음을 표시합니다.
%>
    <p>해당 상품의 할인 정보가 없습니다.</p>
<%
}
%>
</body>
</html>