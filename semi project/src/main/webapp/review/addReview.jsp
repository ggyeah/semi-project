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
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">

<title>addReview</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
<body>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
  <div class="container">
      <div class="checkout__form">
      <h4>상품리뷰</h4>
		<form id="signinForm" action="<%=request.getContextPath()%>/review/addReviewAction.jsp" method="post"  enctype="multipart/form-data">
            <div class="row">
             <div class="col-lg-8 col-md-6">
                <div class="checkout__input">
						<p>주문번호</p>
						<input type="text" name="orderNo" value="<%=orderNo%>" readonly="readonly">
					</div>
                    <div class="checkout__input">
						<p>상품번호</p>
						<input type="text" name="productNo" value="<%=productNo%>" readonly="readonly">
					</div>
                    <div class="checkout__input">
						<p>아이디 </p>
						<input type="text" name="id" value="<%=loginId%>" readonly="readonly">
					</div>
                    <div class="checkout__input">
						<p>제목<span>*</span></p>
						<input type="text" name="reviewTitle"  id="title">
						<span id="titleMsg" class="msg"></span>
					</div>
                    <div class="checkout__input">
						<p>내용<span>*</span></p>
						<input type="text" name="reviewContent"  id="content">
						<span id="contentMsg" class="msg"></span>
					</div>
                    <div class="checkout__input">
	                    <p>이미지</p>
					 	<input type="file" name="reviewImg" readonly="readonly">
					</div>
					<button type="submit" class="site-btn" id="signinBtn"> 추가 </button>
                 </div>
             </div>
         </form>
     </div>
 </div>
 <!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
</div>
 
</body>
</html>