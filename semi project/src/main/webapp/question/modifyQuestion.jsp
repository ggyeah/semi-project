<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

QuestionDao questionDao = new QuestionDao();

Question question = new Question();

if (request.getParameter("qNo") == null){
	response.sendRedirect(request.getContextPath() + "/home.jsp");
 }

int qNo = Integer.parseInt(request.getParameter("qNo"));
question = questionDao.questionOne(qNo);
	
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

<title>modifyQuestion</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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

        if ($('.category:checked').length == 0) {
            $('#categoryMsg').text('카테고리를 선택하세요');
            allCheck = false;
        } else {
            $('#categoryMsg').text('');
        }

        return allCheck;
    }

    $('#signinBtn').click(function() {

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
<!-- 상단토마토바 -->
<section class="breadcrumb-section set-bg" data-setbg="<%=request.getContextPath()%>/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>상품문의</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<!-- 문의수정 -->
<%  // 작성자만
if(session.getAttribute("loginId").equals(question.getId())) {
%>
<form id="signinForm" action="<%=request.getContextPath()%>/question/modifyQuestionAction.jsp?qNo=<%=question.getqNo()%>" method="post">
<div class="container">
	<div class="checkout__form">
		    <h4>제목 : <input type= "text" name = "qTitle" value ="<%=question.getqTitle()%>"  id="title">
              	  	  <span id="titleMsg" class="msg"></span></h4>
		   	 <span class="blog__item__text">
		        <ul>
		        	<li><i class="fa fa-list"></i> 
		        		<label><input type="radio" name="qCategory" class="category" value="상품" <% if(question.getqCategory().equals("상품")) { %>checked<% } %>> 상품</label>
				        <label><input type="radio" name="qCategory" class="category" value="교환환불" <% if(question.getqCategory().equals("교환환불")) { %>checked<% } %>> 교환환불</label>
				        <label><input type="radio" name="qCategory" class="category" value="결제" <% if(question.getqCategory().equals("결제")) { %>checked<% } %>> 결제</label>
				        <label><input type="radio" name="qCategory" class="category" value="배송" <% if(question.getqCategory().equals("배송")) { %>checked<% } %>> 배송</label>
				        <label><input type="radio" name="qCategory" class="category" value="기타" <% if(question.getqCategory().equals("기타")) { %>checked<% } %>> 기타</label>
				    </li>
		            <li><i class="fa fa-calendar-o"></i><%=question.getCreatedate()%></li>
		            <li><i class="fa fa-comment-o"></i><%=question.getId()%></li>
		        </ul>
		    </span>
				내용 : <input type="text" name="qContent" value="<%=question.getqContent()%>" id="content" style="width:500px;">
				<button type="submit" class="btn btn-success" id="signinBtn">수정</button> 
			<span id="contentMsg" class="msg"></span>
		</div>
	</div>
</form>
<% } %>
<br>
<br>
<br>
<!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
</div>
    <!-- Js Plugins -->
    <script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath()%>/js/mixitup.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/main.js"></script>

</body>
</html>