<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	
	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값
	String id = request.getParameter("id");
		
	// 요청값 디버깅
	System.out.println(YANG + id + " <--employeesOne id" + RESET);

	// 클랙스 객체 생성
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
	
	<!-- Breadcrumb Section Begin -->
	
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>마이페이지</h2>
                        <div class="breadcrumb__option">
                            <a>Home</a>
                            <span>마이페이지</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
	<!-- 직원상세정보 폼 시작 -->
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<table>
						<tbody>
							<tr>
								<td class="shoping__cart__total">
									아이디
								</td>
								<td class="shoping__cart__item">
								<h5><%=employees.getId() %></h5>
								</td>
							</tr>
							<tr>
								<td class="shoping__cart__total">
									이름
								</td>
								<td class="shoping__cart__item">
									<h5><%=employees.getEmpName() %></h5>
								</td>
							</tr>
							<tr>
								<td class="shoping__cart__total">
									관리자 레벨
								</td>
								<td class="shoping__cart__item">
									<h5><%=employees.getEmpLevel() %></h5>
								</td>
							</tr>
							<tr>
								<td class="shoping__cart__total">
									등록일
								</td>
								<td class="shoping__cart__item">
									<h5><%=employees.getCreatedate() %></h5>
								</td>
							</tr>
							<tr>
								<td class="shoping__cart__total">
									수정일
								</td>
								<td class="shoping__cart__item">
									<h5><%=employees.getUpdatedate() %></h5>
								</td>
							</tr>
							</tbody>
                        </table>
                        <br>
                        <div class="text-center">
                        	<a href="<%=request.getContextPath() %>/id/modifyPw.jsp?id=<%=employees.getId() %>"><button type="button" class="site-btn">비밀번호 변경</button></a>
                        </div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 회원상세정보 폼 끝-->
	
	<!-- Js Plugins -->
    <script src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath() %>/js/mixitup.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/main.js"></script>
    
    <!------------ 하단 저작권 바 ------------>
	<div>
		<jsp:include page="/inc/copyRight.jsp"></jsp:include>
	</div>
	
</body>
</html>