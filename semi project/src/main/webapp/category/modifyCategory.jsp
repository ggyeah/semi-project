<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자일때만 카테고리 수정 가능
	
	// 에러메시지 담을 때 사용할 변수
	String msg = null;
	
	/* 세션값 유효성 검사 */
	

	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryList 객체 가져오기
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>modifyCategory | Template</title>

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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#title').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#category').val() == '') {
            $('#categoryMsg').text('내용을 입력하세요');
            $('#category').focus();
            allCheck = false;
        } else {
            $('#categoryMsg').text('');
        }
        
        return allCheck;
    }
    $('#btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지`

        if (validateForm()) {
            $('#form').submit();
        }
    });
});
</script>
</head>
<body>
<!------------ 상단 네비 바 ------------>
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
                    <h2>카테고리 관리</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<!-- 카테고리 수정 -->
<div class="container">
<div class="checkout__form">
	 <h4> 카테고리 수정</h4>
 	   <div class="hero__search__form">
 	    <div class="col-lg-12">
 	  	 <form action="<%=request.getContextPath()%>/category/modifyCategoryAction.jsp" method="post" id="form">	  
 			<select class="form-select" name="crntCategoryName">
			<option value="">카테고리를 선택하세요</option>
			<%
				for(Category category : categoryList) {
			%>
				<option value="<%=category.getCategoryName()%>"><%=category.getCategoryName()%></option>
			<% 
				}
			%>
			</select>
			 	<input type="text" name="newCategoryName" id="category">
				<button type="submit"  class="site-btn"  id="btn">수정</button>
				<div><span id="categoryMsg" class="msg"></span></div>
			</form>
		</div>
		<a href="<%=request.getContextPath()%>/category/categoryList.jsp">이전으로</a>
		</div>
	</div>
</div>	
<br>
<br>
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