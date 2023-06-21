<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>
<%
response.setCharacterEncoding("utf-8");
// 관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 	
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

if(request.getParameter("productNo") == null  
|| request.getParameter("productNo").equals("")) {
response.sendRedirect(request.getContextPath() + "/discount/discountList.jsp");
}



int productNo = Integer.parseInt(request.getParameter("productNo"));
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
<title>addDiscount</title>
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
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
        <div class="container">
            <div class="checkout__form">
                <h4>할인관리</h4>
                <form id="form" action="<%=request.getContextPath()%>/discount/addDiscountAction.jsp" method="post">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="checkout__input">
                                <p>상품번호</p>
                                <input type="text" name="productNo" value="<%=productNo%>" readonly="readonly">
                            </div>
                            <div class="checkout__input">
                                <p>할인시작일</p>
                                <input type="date" name="discountStart"  id="discountStart">
									<span id="discountStartMsg" class="msg" style="color: green;"></span>
                            </div>
                            <div class="checkout__input">
                                <p>할인종료일</p>
                                
                               <input type="date" name="discountEnd"  id="discountEnd">
									<span id="discountEndMsg" class="msg" style="color: green;"></span>
                            </div>
                             <div class="checkout__input">
                                <p>할인율</p>
                                <input type="number" step="0.1" name="discountRate"  id="discountRate">
     							<span id="discountRateMsg" class="msg" style="color: green;"></span>
                            </div>
                            
                            <button type="submit"  class="site-btn" id="btn"> 추가 </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
 <!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
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
    
</body>
</html>