<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
AnswerDao answerDao = new AnswerDao();
Answer answer = null;


if (request.getParameter("aNo") != null
	&&(request.getParameter("qNo") != null)){
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	answer = answerDao.answerOne(qNo);
 }

//본인이 작성한 문의거나 관리자2가 아니면 홈으로 되돌아감
if (session.getAttribute("loginId") != null) {
   String loginId = (String) session.getAttribute("loginId");
   if (!loginId.equals("admin") && (answer == null || !loginId.equals(answer.getId()))) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }
}

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
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#title').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#content').val() == '') {
            $('#contentMsg').text('내용을 입력하세요');
            $('#content').focus();
            allCheck = false;
        } else {
            $('#contentMsg').text('');
        }
        
        return allCheck;
    }

    $('#btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('#form').submit();
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
<!-- 답변수정 -->
<div class="container">
<%
if (answer != null) { // answer가 null이 아닌 경우에만 폼을 보여줌
%>
<div class="checkout__form">
	 <h4>&#10145;  답변수정</h4>
		<span class="blog__item__text">
	        <ul>
	            <li><i class="fa fa-calendar-o"></i><%=answer.getCreatedate()%></li>
	            <li><i class="fa fa-comment-o"></i><%=answer.getId()%></li>
	        </ul>
	      </span>
 	   <div class="hero__search__form">	 
 	   		<form action="<%=request.getContextPath()%>/answer/modifyAnswerAction.jsp?qNo=<%=answer.getqNo()%>&aNo=<%=answer.getaNo()%>" method="post" id="form" >     
			 	<input type="text" name="aContent"  id="content" value="<%=answer.getaContent()%>" >
				<button type="submit"  class="site-btn"  id="btn">수정</button>
				<div><span id="contentMsg" class="msg"></span></div>
			</form>
		</div>
	</div>
</div>	
<br>
<br>
<br>
<%
} 
%>
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