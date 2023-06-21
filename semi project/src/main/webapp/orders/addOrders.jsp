<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	/* 인코딩 */
	request.setCharacterEncoding("utf-8");
	
	/* 세션값 확인 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--addOrders loginId param"+RESET);
	
	/* 유효성 검사 */
	if(session.getAttribute("loginId") == null
	|| request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	String id = loginId;
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(KIM+loginId+" <-- addOrders id parameter"+RESET);
	System.out.println(KIM+productNo+" <-- addOrders productNo parameter"+RESET);
	
	CustomerDao customerDao = new CustomerDao();
	Customer customerOne = customerDao.selectCustomerOne(id);
	
	CartDao cartDao = new CartDao();
	Cart cart = cartDao.selectCartOne(loginId);
	String address= "";
	
	// 배송지를 변경했을 시 변경된 주소를 address 변수에 복사
	if(request.getParameter("check") != null){
		address = request.getParameter("check");
	}
	
	OrdersDao ordersDao = new OrdersDao();
	
	// 주문 상세 정보 조회
	Orders orders = ordersDao.selectCustomerOrdersOne(loginId);
	
	// 상품 가격 조회
	ProductDao productDao = new ProductDao();
	Product product = productDao.ProductListOne(productNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Ogani | Template</title>

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
<title>addOrders</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $('.orders').click(function(event) {
        event.preventDefault(); // 기본 동작 중지
        
        if ($('#cstmAddress').val() === '') {
            alert('주소를 입력하세요');
            $('#cstmAddress').focus();
            return;
        } else {
            if (confirm("결제가 완료되었습니다.")) {
                $('#done').submit();
            }
        }
    });
});
</script>
<style>
.left {
	font-size: 16px;
	display: inline-block;
	margin-left: 20px;
	border-left: 0.5px solid #ccc;
	padding-left: 20px;
}
.orders {
	font-size: 14px;
	color: #ffffff;
	font-weight: 800;
	text-transform: uppercase;
	display: inline-block;
	padding: 13px 30px 12px;
	background: #7fad39;
	border: none;
}

</style>
</head>
<body>
<!-------------- 상단 네비게이션 바(메인메뉴) -------------->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

<!----------------------- 주문 추가 폼 ----------------------->
	<form id="done" action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=cart.getProductNo()%>">
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>주문</h2>
                        <div class="breadcrumb__option">
                            <a>Home</a>
                            <span>주문</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
      	<div class="container">
               <div class="checkout__form">
                  <h4><%=customerOne.getId()%></h4>
                      <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="row">
                                <div class="col-lg-2">
                                    <div class="checkout__input">
                                        <%=customerOne.getCstmName()%>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                	<div class="left">
	                                    <div class="checkout__input">
	                                        <%=customerOne.getCstmPhone()%>
	                                    </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                	<div class="left">
	                                    <div class="checkout__input">
	                                        <%=customerOne.getCstmEmail()%>
	                                    </div>
                                    </div>
                                </div>
                                <div class="col-lg-4"></div>
                            </div>
                          </div>
                        </div>
                 	</div>
                <br>
                <br>
             	<div class="checkout__form">
                     <h4>배송지 정보</h4>
                     <div class="row">
                  	 <div class="col-lg-8 col-md-6"> 
                         <div class="checkout__input">
                             <p>받는분<span>*</span></p>
                             <input type="text" name="cstmName" value="<%=customerOne.getCstmName()%>">
                         </div>
                         <div class="checkout__input">
                        		<p>배송지<span>*</span></p>
                        		<div class="row">
	                         		<div class="col-lg-4">
	                                  	<div class="checkout__input">
	                                      <input type="text" name="address" value="<%=address%>" id="cstmAddress" class="checkout__input__add">
	                                  	  <span id="addressMsg" class="msg"></span>
	                                  	</div>
	                            	</div>
	                                <div class="col-lg-4">
	                                    <div class="checkout__input">
	                                      <a href="<%=request.getContextPath()%>/address/addressList.jsp?productNo=<%=cart.getProductNo()%>" class="delivery-change" onclick="openUserDeliveryListPop();"><span class="">배송지관리</span></a>
	                                    </div>
	                                </div>
                            	</div>
                          </div>
                          <div class="checkout__input">
                                <p>주문 상품<span>*</span></p>
                                <input type="text" name="productName" value="<%=product.getProductName()%>" readonly="readonly">
                          </div>
                          <div class="checkout__input">
                                <p>수량<span>*</span></p>
                                <input type="text" name="orderCnt" value="<%=cart.getCartCnt()%>" readonly="readonly">
                            </div>
                          <div class="checkout__input">
                                <p>총 결제금액<span>*</span></p>
                                <input type="text" name="orderPrice" value="<%=(cart.getCartCnt())*(product.getProductPrice())%>" readonly="readonly">
                            </div>
                      </div>
                      <!-- 주문하기 -->  
                      <div class="col-lg-4 col-md-6">
                        <div class="checkout__order">
                            <h4>나의 주문</h4>
                            <div class="checkout__order__products">Products <span>Total</span></div>
                            <ul>
                                <li><%=product.getProductName()%> <span>&#8361;<%=product.getProductPrice()%></span></li>
                            </ul>
                             <div class="checkout__order__subtotal">Total <span>&#8361;<%=(cart.getCartCnt())*(product.getProductPrice())%></span></div>
                            <p>주문 후 3~4일 내에 배송될 예정입니다.</p>
                        </div>
                      </div>
                   </div>
                 </div>
              </div>
              <div class="featured__item__text"><button type="submit" class="orders">결제하기</button></div>
          </section>
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
          
               
</form>
</body>
</html>