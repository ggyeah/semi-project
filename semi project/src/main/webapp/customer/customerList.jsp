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
	
	// 현재 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(YANG + currentPage + " <-- customerList currentPage" + RESET);
	
	// 클래스 객체 생성
	CustomerDao dao = new CustomerDao();
	
	// 전체행의 수 
	int totalRow = dao.selectCustomerCnt();
	System.out.println(YANG + totalRow + " <-- customerList totalRow" + RESET);
	
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
	
	// 회원리스트 불러오는 메소드 호출
	ArrayList<Customer> list  = dao.selectCustomerListByPage(beginRow, rowPerPage);
	
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
                        <h2>회원정보</h2>
                        <div class="breadcrumb__option">
                            <a>관리자 메뉴</a>
                            <span>회원정보</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
	<!-- 회원목록 테이블 -->
	<section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>아이디</th>
                                    <th>이름</th>
                                    <th>마지막 방문일</th>
                                    <th>가입일</th>
                                    <th>활성화 여부</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <%
							for(Customer c : list) {
							%>
							<tr>
								<td><a href="<%=request.getContextPath() %>/customer/customerOne.jsp?id=<%=c.getId()%>"><%=c.getId() %></a></td>
								<td><%=c.getCstmName() %></td>
								<td><%=c.getCstmLastLogin() %></td>
								<td><%=c.getCreatedate() %></td>
								<td><%=c.getActive() %></td>
							<%
							}
							%>	
								
                              
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
            
                <div class="col-lg-12">
                    <!-- 페이지 네비게이션 -->
					<div class="text-center">
						<%
						if(minPage > 1) {
						%>
							<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>	
						<%
						}
						
						for(int i = minPage; i<=maxPage; i=i+1) {
							if(i == currentPage) {
						%>
								<span><%=i%></span>&nbsp;
						<%			
							} else {		
						%>
								<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
						<%	
							}
						}
						
						if(maxPage != lastPage) {
						%>
							<!--  maxPage + 1 -->
							<a href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
						<%
						}
				   		%>
					</div>
                    
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