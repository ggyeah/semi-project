<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 인코딩 */
	request.setCharacterEncoding("utf-8");
	
	// 유효성 검사
	if(request.getParameter("productNo")==null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 추가</title>
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
<style>
	.center{
		text-align:center;
	}
	.shoping__cart__item2{
		width: 630px;
		text-align: center;
		position: relative;
	}
	.button {
		font-size: 14px;
		color: #ffffff;
		text-transform: uppercase;
		display: inline-block;
		padding: 10px 20px 9px;
		background: #7fad39;
		border: none;
		text-align:center;
	}
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
	.checkout__input input {
   width: 100%;
   border: 1px solid #ebebeb;
   padding-left: 20px;
   font-size: 16px;
   color: #b2b2b2;
   border-radius: 4px;
}
.addressForm{
	width: 100%;
}
.addressTable{
	display:flex;
	justify-content: center;
}
.addressTable table{
	width: 30%;
}
</style>
</head>
<body>
<!----------------------- 메세지 ----------------------->
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
<!-- 상단 네비게이션 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>	
<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>배송지 추가</h2>
                        <div class="breadcrumb__option">
                             <a>Home</a>
                             <a>배송지 선택</a>
                            <span>배송지 추가</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb Section End -->	
<!---------------------- 배송지 추가 ---------------------->
	
		<section class="shoping-cart spad">
	        <div class="container">
	        
	        	<div class="checkout__form2">
		            <div class="row">
						<form action="<%=request.getContextPath()%>/address/addAddressAction.jsp" method="post" class="addressForm">
							<input type="hidden" name="productNo" value="<%=productNo%>">
							<input type="hidden" name="defaultAddress" value="N">	
							<div class="center addressTable">
								<table>
									<tr>
										<th>배송지명</th>
									</tr>
									<tr>	
										<td class="checkout__input">
											<input type="text" name="addAddressName" placeholder="배송지명을 입력하세요" class="center">
										</td>
									</tr>
									<tr>	
										<th>주소</th>
									</tr>
									<tr>	
										<td class="checkout__input">
											<input type="text" name="addAddress" placeholder="주소를 입력하세요" class="center">
										</td>
									</tr>
								</table>
							</div>
							<div class="center">
								<input type="checkbox" name="defaultAddress" value="Y" id="check">
								<label for="check">기본 배송지로 등록</label>
							</div>
							<div class="center">
								<button type="submit" class="button">추가</button>
							</div>
						</form>
					</div>
				  </div>
				 
				</div>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#check").change(function() {
            if ($(this).is(":checked")) {
                $("input[name='defaultAddress']").val("Y");
            } else {
                $("input[name='defaultAddress']").val("N");
            }
        });
    });
</script>          
</body>
</html>