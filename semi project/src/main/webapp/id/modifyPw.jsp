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
    <title>addEmployees</title>

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
		// 시작시 pw 입력 폼에 포커스
		$('#pw').focus();
		
	
			// pw유효성 체크
			$('#pw').blur(function(){
				if ($('#pw').val().length < 1) {
					$('#pwMsg').text('비밀번호를 입력해주세요');
					$('#pw').focus();
				} else {
					$('#pwMsg').text('');
					$('#newPw').focus();
				}
			});
			
			// newPw유효성 체크
			$('#newPw').blur(function(){
				if ($('#newPw').val().length < 4) {
					$('#newPwMsg').text('비밀번호는 4자이상이어야 합니다');
					$('#newPw').focus();
				} else {
					$('#newPwMsg').text('');
					$('#newPwCk').focus();
				}
			});
			
			// newPwCk유효성 체크
			$('#newPwCk').blur(function(){
				if ($('#newPwCk').val() != $('#newPw').val()) {
					$('#newPwMsg2').text('비밀번호를 확인하세요');
					$('#newPwCk').focus();
				} else {
					$('newPwMsg2').text('');
				}
			});
			
			// 유효성 체크 함수
			function validateForm() {	
		    	let allCheck = true;
			
		    	
		    	// pw유효성 체크
				if ($('pw').val().length < 1) { 
					$('#pw').focus();
					allCheck = false;
				}
		    	
				// newPw유효성 체크
				if ($('#newPw').val().length < 1) { 
					$('#newPw').focus();
					allCheck = false;
				} 
				
				// newPwCk유효성 체크
				if ($('#newPwCk').val().length < 1) { 
					$('#newPwCk').focus();
					allCheck = false;
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
		
	<!------------ 상단 네비 바 ------------>
	<!-- 상단 네비 바(메인메뉴) -->
	<div>
		<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
	</div>
	
	<!-- 비밀번호 변경 폼 -->
	<div class="container">
		<div class="checkout__form">
			<h4>비밀번호 변경</h4>
				<form id="modifyForm" action="<%=request.getContextPath() %>/id/modifyPwAction.jsp" method="post">
					<div class="row">
						<div class="col-lg-8 col-md-6">		
							<div class="checkout__input">
								<p>아이디</p>
								<input type="text" name="id" id="id "value="<%=request.getParameter("id")%>" readonly="readonly">
							</div>
							<div class="checkout__input">
								<p>현재 비밀번호<span>*</span></p>
								<input type="password" name="pw" id="pw" placeholder="현재 비밀번호를 입력하세요">
								<span id="pwMsg" class="msg"></span>
							</div>
							<div class="checkout__input">
								<p>새로운 비밀번호<span>*</span></p>
								<input type="password" name="newPw" id="newPw" placeholder="4자 이상의 새로운 비밀번호를 입력하세요">
								<span id="newPwMsg" class="msg"></span>
							</div>
							<div class="checkout__input">
								<p>새로운 비밀번호 확인<span>*</span></p>
								<input type="password" name="newPwCk" id="newPwCk" placeholder="비밀번호를 한번 더 입력하세요">
								<span id="newPwMsg2" class="msg"></span>
							</div>
							<br>
							<div class="text-center">
								<button type="submit" class="site-btn">변경</button>
							</div>
							<br>
						</div>
					</div>
				</form>
		</div>		
	</div>
	
	<!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
    
    <!------------ 하단 저작권 바 ------------>
	<div>
		<jsp:include page="/inc/copyRight.jsp"></jsp:include>
	</div>
	
</body>
</html>