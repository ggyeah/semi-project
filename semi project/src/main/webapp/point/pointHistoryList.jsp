<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%

PointHistoryDao pointHistoryDao = new PointHistoryDao();

int beginRow = 0;
int rowPerPage = 10;
String id = request.getParameter("id");

ArrayList<PointHistory> pList = pointHistoryDao.pointHistoryList(beginRow, rowPerPage, id);

int pointSum = pointHistoryDao.sumPoint(id);

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
                    <h2>포인트이력</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<br>
<!--  포인트리스트 -->

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="shoping__cart__table">
              <table>
                  <thead>
                      <tr>
				        <th>아이디</th>
				        <th>포인트적립일</th>
				        <th>포인트</th>
			   		 </tr>
			   	</thead>
				    <% for (PointHistory pointHistory : pList) { %>
				    <tbody>
				   	 <tr>
				        <td><%=pointHistory.getId()%></td>
				        <td><%=pointHistory.getCreatedate()%></td>
				        <td><%=pointHistory.getPointPm()%>  <%=pointHistory.getPoint()%></td>
				    <% } %>
			    </tr>
			   </tbody>
			</table>
         </div>
     </div>
   </div>
</div>
<div class="container">
   <div class="col-lg-12">
       <div class="shoping__checkout">
           <ul>
               <li><h5>포인트 총합</h5><span>Total : <%=pointSum%></span></li>
           </ul>
       </div>
   </div>
</div>
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