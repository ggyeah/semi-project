<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>
<%
//인코딩
response.setCharacterEncoding("utf-8");

if (request.getParameter("orderNo") != null
	&&request.getParameter("projectNo") != null){
	 response.sendRedirect(request.getContextPath() + "/home.jsp");
}

int orderNo = Integer.parseInt(request.getParameter("orderNo"));
int productNo = Integer.parseInt(request.getParameter("productNo"));

//로그인 상태가 아니면 리뷰를 작성할 수 없음
if(session.getAttribute("loginId") == null) {
 response.sendRedirect(request.getContextPath() + "/review/reviewListOne.jsp?orderNo="+orderNo);
}	
String loginId = (String)session.getAttribute("loginId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addReview</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#title').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#title').val() == '') {
            $('#titleMsg').text('제목을 입력하세요');
            $('#title').focus();
            allCheck = false;
        } else {
            $('#titleMsg').text('');
        }

        if ($('#content').val() == '') {
            $('#contentMsg').text('내용을 입력하세요');
            $('#content').focus();
            allCheck = false;
        } else {
            $('#contentMsg').text('');
        }
        
        return allCheck;
    }
    $('#signinBtn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('#signinForm').submit();
        }
    });
});
</script>
</head>
<body class="container">
<form id="signinForm" action="<%=request.getContextPath()%>/review/addReviewAction.jsp" method="post"  enctype="multipart/form-data">
<h1>상품리뷰</h1>
<table class="table table-bordered">
	<tr>
		<td>주문번호</td>
		<td><input type="text" name="orderNo" value="<%=orderNo%>"></td>
	</tr>
	<tr>
		<td>상품번호</td>
		<td><input type="text" name="productNo" value="<%=productNo%>"></td>
	</tr>
	<tr>
		<td>아이디 </td>
		<td><input type="text" name="id" value="<%=loginId%>"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="reviewTitle"  id="title">
		<span id="titleMsg" class="msg"></span></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><input type="text" name="reviewContent"  id="content">
			<span id="contentMsg" class="msg"></span></td>
	</tr>
	<tr>
	 <td><input type="file" name="reviewImg"></td>
	</tr>
	<tr>
		<td>
		<button type="submit" class="btn btn-danger"  id="signinBtn"> 추가 </button>
		</td>
	</tr>
</table>
</form>
</body>
</html>