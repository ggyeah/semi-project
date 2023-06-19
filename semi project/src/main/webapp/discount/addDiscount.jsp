<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>
<%
response.setCharacterEncoding("utf-8");
// 관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 	
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}



int productNo = Integer.parseInt(request.getParameter("productNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addDiscount</title>
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
<form  id="form" action="<%=request.getContextPath()%>/discount/addDiscountAction.jsp" method="post">
<h1>할인추가</h1>
<table class="table table-bordered">
	<tr>
		<td>상품번호</td>
		<td><input type="text" name="productNo" value="<%=productNo%>" readonly="readonly"></td>
	</tr>
	<tr>
		<td>할인시작일</td> 
		<td><input type="date" name="discountStart"  id="discountStart">
		<span id="discountStartMsg" class="msg"></span></td>
	</tr>
	<tr>
		<td>할인종료일</td> 
		<td><input type="date" name="discountEnd"  id="discountEnd">
		<span id="discountEndMsg" class="msg"></span></td>
	</tr>
		<tr>
		<td>할인율</td> 
		<td><input type="number" step="0.1" name="discountRate"  id="discountRate">
		<span id="discountRateMsg" class="msg"></span></td>
	</tr>
	<tr>
		<td>
		<button type="submit" class="btn btn-danger"   id="btn"> 추가 </button>
		</td>
	</tr>
</table>
</form>
</body>
</html>