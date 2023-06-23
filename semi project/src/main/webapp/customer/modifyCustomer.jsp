<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- modifyCustomer id" + RESET);
	
	// 클래스 객체 생성
	CustomerDao dao = new CustomerDao();
	
	// 회원 상세 정보 보여주는 메소드 호출
	Customer customer = dao.selectCustomerOne(id);
	
%>
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
		// 유효성 체크 함수
	    function validateForm() {	
	    	let allCheck = true;
	    	
		    // cstmName유효성 체크
			if ($('#cstmName').val().length < 1) { 
				$('#nameMsg').text('이름을 입력하세요');
				$('#cstmName').focus();
				allCheck = false;
			} else {
				$('#nameMsg').text('');
			}
		    	
		    // cstmAddress유효성 체크
			if ($('#cstmAddress').val().length < 1) { 
				$('#addressMsg').text('주소를 입력하세요');
			 	$('#cstmAddress').focus();
				allCheck = false;
			} else {
				$('addressMsg').text('');
			}
		    
			// cstmEmail유효성 체크
			if ($('#cstmEmail').val().length < 1) { 
				$('#emailMsg').text('이메일을 입력하세요');
				$('#cstmEmail').focus();
				allCheck = false;
			} else {
	          $('emailMsg').text('');
			}
			
			// cstmBirth유효성 체크
			 if ($('#cstmBirth').val().length < 1) {
			     $('#birthMsg').text('생일을 입력하세요');
			     $('#cstmBirth').focus();
			     allCheck = false;
			 } else {
			     $('#birthMsg').text('');
			 }
			
			// cstmPhone유효성 체크
			if ($('#cstmPhone').val().length < 1) {
				$('#phoneMsg').text('연락처를 입력하세요');
				$('#cstmPhone').focus();
				allCheck = false;
			} else {
				$('#phoneMsg').text('');
			}
			
			// cstmGender유효성 체크
			if ($('.gender:checked').length == 0) {
				$('#genderMsg').text('성별을 선택하세요');
				allCheck = false;
			} else {
				$('#genderMsg').text('');
			}
		return allCheck;
		}
		
		$('#modifyBtn').click(function(e) {
	        e.preventDefault(); // 기본 동작 방지
	
	        if (validateForm()) {
	            $('#modifyForm').submit();
	            alert('회원정보 수정이 완료되었습니다');
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
	
	<!-- 회원정보 수정 폼 -->
	<div class="container">
		<div class="checkout__form">
			<h4>회원정보 수정</h4>
				<form id="modifyForm" action="<%=request.getContextPath() %>/customer/modifyCustomerAction.jsp" method="post">
					<div class="row">
						<div class="col-lg-8 col-md-6">
							<div class="checkout__input">
								<p>아이디</p>
								<input type="text" name="id" id="id" value="<%=customer.getId()%>" readonly="readonly">
							</div>
							<div class="checkout__input">
								<p>이름<span>*</span></p>
								<input type="text" name="cstmName" id="cstmName" value="<%=customer.cstmName%>">
								<span id="nameMsg" class="msg"></span>
							</div>
									<div class="checkout__input">
										<p>주소<span>*</span></p>
										<input type="text" name="cstmAddress" id="cstmAddress" value="<%=customer.cstmAddress%>">
										<span id="addressMsg" class="msg"></span>
									</div>
									<div class="checkout__input">
										<p>이메일<span>*</span></p>
										<input type="email" name="cstmEmail" id="cstmEmail" value="<%=customer.cstmEmail%>">
										<span id="emailMsg" class="msg"></span>
									</div>
									<div class="checkout__input">
										<p>생일<span>*</span></p>
										<input type="date" name="cstmBirth" id="cstmBirth" value="<%=customer.cstmBirth%>">
										<span id="birthMsg" class="msg"></span>
									</div>
									<div class="checkout__input">
										<p>연락처<span>*</span></p>
										<input type="tel" name="cstmPhone" id="cstmPhone" value="<%=customer.cstmPhone%>">
										<span id="phoneMsg" class="msg"></span>
									</div>
									<div class="checkout__input">
										<p>성별<span>*</span></p>
									</div>
									<div>
										<label><input type="radio" name="cstmGender" value="M" class="gender" <%if((customer.getCstmGender()).equals("M")) { %>checked<% } %>></label>
										<label>남</label>
										<label><input type="radio" name="cstmGender" value="F" class="gender" <%if((customer.getCstmGender()).equals("F")) { %>checked<% } %>></label>
										<label>여</label>
										<span id="genderMsg" class="msg"> </span>
									</div>
									<br>
									<div class="text-center">	
									<button type="submit" id="modifyBtn" class="site-btn">수정</button>
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