<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 현재 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(YANG + currentPage + " <-- employeesList currentPage" + RESET);
		
	// 클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
		
	// 전체행의 수 
	int totalRow = dao.selectEmployeesCnt();
	System.out.println(YANG + totalRow + " <-- employeesList totalRow" + RESET);
		
	// 페이지당 행의 수
	int rowPerPage = 10;
		
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	int endRow = beginRow + (rowPerPage - 1);
	if(endRow > totalRow) {
			endRow = totalRow;
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
		
	// 직원리스트 불러오는 메소드 호출
	ArrayList<Employees> list  = dao.selectEmployeesListByPage(beginRow, rowPerPage);
	
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;
	int minPage = (((currentPage-1) / pagePerPage) * pagePerPage) + 1;
	int maxPage = minPage + (pagePerPage - 1);
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}

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
                        <h2>직원관리</h2>
                        <div class="breadcrumb__option">
                            <a>관리자 메뉴</a>
                            <span>직원관리</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <br>
    <br>
    <!-- Breadcrumb Section End -->
    
	<!-- 직원 추가 버튼 -->
	<div class="container">
		<div class="col-lg-12">
			<div class="shoping__cart__btns">
				<a href="<%=request.getContextPath() %>/employees/addEmployees.jsp" class="primary-btn cart-btn">추가</a>
			</div>
		</div>
	</div>
		
	<!-- 직원목록 테이블 -->
	<section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <br>
                <br>
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>아이디</th>
                                    <th>이름</th>
                                    <th>관리자 레벨</th>
                                    <th>등록일</th>
                                    <th>수정일</th>
                                    <th>활성화 여부</th>
                                    <th>수정</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <%
							for(Employees e : list) {
							%>
							<tr>
								<td ><%=e.getId() %></td>
								<td><%=e.getEmpName() %></td>
								<td><%=e.getEmpLevel() %></td>
								<td><%=e.getCreatedate() %></td>
								<td><%=e.getUpdatedate() %></td>
								<td><%=e.getActive() %></td>
								<td><a href ="<%=request.getContextPath() %>/employees/modifyEmployees.jsp?id=<%=e.getId() %>">수정</a></td>
								<td><a href ="<%=request.getContextPath() %>/employees/removeEmployees.jsp?id=<%=e.getId() %>">삭제</a></td>
							<%
							}
							%>	
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
	
			<!-- 페이지 네비게이션 -->
			<div class="text-center">
				<div class="product__pagination">
					<%
					if(minPage > 1) {
					%>
						<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=minPage-pagePerPage%>"><i class="fa fa-long-arrow-left"></i></a>	
					<%
					}
					
					for(int i = minPage; i<=maxPage; i=i+1) {
						if(i == currentPage) {
					%>
							<a><span><%=i%></span></a>&nbsp;
					<%			
						} else {		
					%>
							<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
					<%	
						}
					}
					
					if(maxPage != lastPage) {
					%>
						<!--  maxPage + 1 -->
						<a href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=minPage+pagePerPage%>"><i class="fa fa-long-arrow-right"></i></a>
					<%
					}
			   		%>
				</div>
			</div>
		</div>
	</section>
		
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