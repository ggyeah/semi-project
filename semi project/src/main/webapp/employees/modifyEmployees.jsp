<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값
	String id = request.getParameter("id");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- modifyEmployees id" + RESET);
	
	// 클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
	
	// 직원 상세 정보 보여주는 메소드 호출
	Employees employees = dao.selectEmployeesOne(id);
	
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
	    	
	    	// empName유효성 체크
			if ($('#empName').val().length < 1) { 
				$('#nameMsg').text('이름을 입력하세요');
				$('#empName').focus();
				allCheck = false;
			} else {
				$('#nameMsg').text('');
			}
			// empLevel유효성체크
			if ($('.empLevel:checked').length == 0) {
				$('#levelMsg').text('관리자 레벨을 선택하세요');
				allCheck = false;
			} else {
				$('#levelMsg').text('');
			}
		return allCheck;
		}
		
	    $('#modifyBtn').click(function(e) {
	        e.preventDefault(); // 기본 동작 방지
	
	        if (validateForm()) {
	            $('#modifyForm').submit();
	            alert('직원정보 수정이 완료되었습니다');
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
	
	<!-- 직원정보 수정 폼 -->
	<div class="container">
		<div class="checkout__form">
			<h4>직원정보 수정</h4>
				<form id="modifyForm" action="<%=request.getContextPath() %>/employees/modifyEmployeesAction.jsp" method="post">
					<div class="row">
						<div class="col-lg-8 col-md-6">
							<div class="checkout__input">
								<p>아이디</p>
								<input type="text" name="id" id="id" value="<%=employees.getId()%>" readonly="readonly">
							</div>
							<div class="checkout__input">
								<p>이름<span>*</span></p>
								<input type="text" name="empName" id="empName" value="<%=employees.empName %>">
								<span id="nameMsg" class="msg"></span>
							</div>
							<div class="checkout__input">
								<p>관리자 레벨<span>*</span></p>
							</div>
							<div>
								<label><input type="radio" name="empLevel" value="1" class="empLevel" <%if(employees.getEmpLevel() == 1) { %>checked<% } %>></label>
								<label>1</label>
								<label><input type="radio" name="empLevel" value="2" class="empLevel" <%if(employees.getEmpLevel() == 2) { %>checked<% } %>></label>
								<label>2</label>
								<span id="levelMsg" class="msg"> </span>
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