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
	
	// 요청값
	String id = request.getParameter("id");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- removeEmployees id" + RESET);
	
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

</head>
<body>
	<!------------ 상단 네비 바 ------------>
	<!-- 상단 네비 바(메인메뉴) -->
	<div>
		<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
	</div>
	
	<!-- 직원 삭제 폼 -->
	<div class="container">
		<div class="checkout__form">
			<h4>직원 삭제</h4>
				<form id="removeForm"action="<%=request.getContextPath() %>/employees/removeEmployeesAction.jsp" method="post">
					<div class="row">
						<div class="col-lg-8 col-md-6">
							<div class="checkout__input">
								<p>아이디</p>
								<input type="text" name="id" id="id" value="<%=employees.getId()%>" readonly="readonly">
							</div>
							<div class="checkout__input">
								<p>이름</p>
								<input type="text" name="empName" id="empName" value="<%=employees.empName %>" readonly="readonly">
							</div>
							<div class="checkout__input">
								<p>관리자 레벨</p>
								<input type="text" name="empLevel" id="empLevel" value="<%=employees.empLevel%>" readonly="readonly">
							</div>
							<div class="checkout__input">
							<p>활성화 여부<span>*</span></p>
							</div>
							<div>
								<label><input type="radio" name="active" value="Y" <%if((employees.getActive()).equals("Y")) { %>checked<% } %>></label>
								<label>Y</label>
								<label><input type="radio" name="active" value="D" <%if((employees.getActive()).equals("D")) { %>checked<% } %>></label>
								<label>D</label>
							</div>
							<br>
							<div class="text-center">	
							<button type="submit" id="removeBtn" class="site-btn">수정</button>
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