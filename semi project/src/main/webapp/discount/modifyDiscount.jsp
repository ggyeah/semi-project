<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

//관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

DiscountDao discountDao = new DiscountDao();

Discount discount = new Discount();

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}

int productNo = Integer.parseInt(request.getParameter("productNo"));
discount= discountDao.discountOne(productNo);
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

<title>modifyDiscount</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 할인시작일 입력 폼에 포커스
    $('#discountStart').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        // 할인시작일 유효성 검사
        if ($('#discountStart').val() == '') {
            $('#discountStartMsg').text('할인시작일을 입력하세요');
            $('#discountStart').focus();
            allCheck = false;
        } else {
            $('#discountStartMsg').text('');
        }

        // 할인종료일 유효성 검사
        if ($('#discountEnd').val() == '') {
            $('#discountEndMsg').text('할인종료일을 입력하세요');
            $('#discountEnd').focus();
            allCheck = false;
        } else {
            $('#discountEndMsg').text('');
        }
        
        // 할인율 유효성 검사
        if ($('#discountRate').val() == '') {
            $('#discountRateMsg').text('할인율을 입력하세요');
            $('#discountRate').focus();
            allCheck = false;
        } else {
            $('#discountRateMsg').text('');
        }
        
        return allCheck;
    }
    
    $('#btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('form').submit();
        }
    });
});
</script>
</head>
<body>
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
                    <h2>할인관리</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<br>
<!-- 할인수정 -->
<%
if (discount != null) { // discount 객체가 null이 아닐 때만 수정 페이지를 표시합니다.
%>
 <div class="container">
   <div class="checkout__form">
      <h4>할인수정</h4>
		<form id="form" action="<%=request.getContextPath()%>/discount/modifyDiscountAction.jsp?productNo=<%=discount.getProductNo()%>" method="post">
            <div class="row">
                <div class="col-lg-8 col-md-6">
                    <div class="checkout__input">
                        <p>상품번호</p>
                        <%=discount.getProductNo()%>
                    </div>
                    <div class="checkout__input">
                        <p>할인시작일<span>*</span></p>
                       <input type= "date" name = "discountStart" value ="<%=discount.getDiscountStart()%>" id="discountStart">
           	  			<span id="discountStartMsg" class="msg"></span>
   	                 </div>
                    <div class="checkout__input">
                        <p>할인종료일<span>*</span></p>
						<input type= "number" step="0.1" name = "discountRate" value ="<%=discount.getDiscountRate()%>" id="discountRate">
           	 			 <span id="discountRateMsg" class="msg"></span>
                    </div>
                     <div class="checkout__input">
                        <p>할인율<span>*</span></p>
                        <input type= "number" step="0.1" name = "discountRate" value ="<%=discount.getDiscountRate()%>" id="discountRate">
           				 <span id="discountRateMsg" class="msg"></span>
                    </div>
						<button type="submit" class="btn btn-danger"> 수정</button>
                </div>
            </div>
        </form>
    </div>
</div>
<%} %>
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