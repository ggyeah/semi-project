<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>login</title>

     <!-- Google Font -->
    <link href="<%=request.getContextPath() %>https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" type="text/css">
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		// 유효성 체크 함수
	    function validateForm() {	
	    	let allCheck = true;
	    	
	    	// id유효성 체크
			if ($('#id').val().length < 1) { 
				$('#idMsg').text('아이디를 입력하세요');
				$('#id').focus();
				allCheck = false;
			} else {
				$('#idMsg').text('');
			}
	    	
			// pw유효성 체크
			if ($('#pw').val().length < 1) { 
				$('#pwMsg').text('비밀번호를 입력하세요');
				$('#pw').focus();
				allCheck = false;
			} else {
				$('#pwMsg').text('');
			}
			
			return allCheck;
		}
		
		    $('#loginBtn').click(function(e) {
		        e.preventDefault(); // 기본 동작 방지
	
		        if (validateForm()) {
		            $('#loginForm').submit();
		        }
		    });
		}
	});


</script>
</head>
<body>
	<!------------ 상단 네비 바 ------------>
	<!-- 상단 네비 바(메인메뉴) -->
	<div>
		<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
	</div>
	
	<!-- 로그인 폼 -->
	
	<div class="text-center">
		<div class="shoping__checkout">
			<form id="loginForm" action="<%=request.getContextPath()%>/id/loginAction.jsp" method="post">
			<h5>로그인</h5>
			<div class="text-center">
				<div class="shoping__continue">
					<input type="text" name="id" id ="id "placeholder="아이디">
			    </div>    
				<br>
				<div class="shoping__continue">
					<input type="password" name="pw" id="pw" placeholder="비밀번호">
				</div>
				<br>
		          <button type="submit" id="loginBtn" class="site-btn">로그인</button>
				</div>
			</form>
		</div>
    </div>   
    
	<!-- Js Plugins -->
    <script src="<%=request.getContextPath() %>js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath() %>js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath() %>js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath() %>js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath() %>js/mixitup.min.js"></script>
    <script src="<%=request.getContextPath() %>js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>js/main.js"></script>

	<!------------ 하단 저작권 바 ------------>
	<div>
		<jsp:include page="/inc/copyRight.jsp"></jsp:include>
	</div>
	
</body>
</html>