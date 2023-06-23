<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	/* session */
	if(session.getAttribute("loginId")==null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String loginId = (String)session.getAttribute("loginId");
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	/* dao address 상세정보 가져오기 */
	AddressDao addressDao = new AddressDao();
	Address addressOne = addressDao.selectAddressOne(loginId, addressNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyAddress</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.checkout__form2 {
		color: #1c1c1c;
		border: 1px solid #e1e1e1;
		border-radius: 1em;
		padding-top: 10px;
		padding-left: 5px;
		padding-right: 5px;
		padding-bottom: 10px;
		margin-bottom: 25px;
	}
	.button{
		padding-top: 10px;
	}
	.center {
		text-align: center;
	}
	.table center{
		margin: 0 auto;
	}
	.checkout__input2 {
		width: 200%;
		height: 46px;
		border: 1px solid #ebebeb;
		padding-left: 20px;
		font-size: 16px;
		color: #b2b2b2;
		border-radius: 4px;
	}
	.button {
		font-size: 14px;
		color: #ffffff;
		text-transform: uppercase;
		display: inline-block;
		padding: 10px 27px 9px;
		background: #7fad39;
		border: none;
	}
}
</style>
</head>
<body>
<!-------------- 상단 네비게이션 바(메인메뉴) -------------->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>배송지 수정</h2>
                    <div class="breadcrumb__option">
                         <a>Home</a>
                         <a>배송지 관리</a>
                        <span>배송지 수정</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="shoping-cart spad">
	<div class="container">
		<div class="checkout__form2">
			<div class="row">
			<div class="col-lg-12">
				<form action="<%=request.getContextPath()%>/address/modifyAddressAction.jsp" method="post">
				<input type="hidden" name="productNo" value="<%=productNo%>">
				<input type="hidden" name="addressNo" value="<%=addressOne.getAddressNo()%>">
					<div>
<!--------------------- 오류 메세지 --------------------->
								<%
									String msg = request.getParameter("msg");
									if(msg != null){
								%>
									<%= msg %>
								<%	
									}
								%>
					</div>
					<div class="col-lg-12 text-center">
						<table class="table center">	
<!--------------------- 수정 폼 --------------------->
							<!------- 배송지 명 ------->
							<tr>
								<th>배송지 명</th>
							</tr>
							<tr class="checkout__input">
								<td>
									<input type="text" name="addressName" value="<%=addressOne.getAddressName()%>">
								</td>
							</tr>
							<!------- 주소 ------->	
							<tr>
								<th>주소</th>
							</tr>
							<tr class="checkout__input">
								<td>
									<input type="text" name="address" value="<%=addressOne.getAddress()%>">
								</td>
							</tr>
							<!------- 기본 배송지로 ------->	
							<tr>
								<th>기본 배송지로 등록</th>
							</tr>
							<tr>
								<td><!-- 기존 기본 배송지 값을 표시(삼항 연산자) -->
									<input type="hidden" name="defaultAddress" value="<%=addressOne.getDefaultAddress()%>">
			 	                    <input type="radio" name="newDefaultAddress" value="Y" <%= addressOne.getDefaultAddress().equals("Y") ? "checked" : "" %>> 예
				                    <input type="radio" name="newDefaultAddress" value="N" <%= addressOne.getDefaultAddress().equals("N") ? "checked" : "" %>> 아니오
								</td>
							</tr>
						</table>
					</div>
					<div class="center">
						<button type="submit" class="button" >수정</button>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Js Plugins -->
   <script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery.nice-select.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery.slicknav.js"></script>
   <script src="<%=request.getContextPath()%>/js/mixitup.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/main.js"></script>
   
<!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
</div>
</body>
</html>