<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 수정 가능
	
	// 에러메시지 담을 때 사용할 변수
	String msg = null;
	
	/* 세션값 유효성 검사 */
	

	/* 요청값 유효성 검사 */
	if(request.getParameter("productNo") == null  
		|| request.getParameter("productNo").equals("")) {
		// productList.jsp으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	// 유효성 검사를 통과하면 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// 디버깅
	System.out.println(SONG + productNo + " <-- modifyProduct " + RESET);	
	
	ProductDao prodDao = new ProductDao(); // ProductDao 객체 생성
	Product productOne = prodDao.ProductListOne(productNo); // productNo 매개변수로 productOne 메서드 호출하여, 수정페이지에 표시할 상품정보 productOne 객체 가져오기

	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryList 객체 가져오기
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<style>
.button{
      padding-top: 7px;
   }
</style>
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>modifyProduct | Template</title>

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
</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

	<!-- 에러메세지 -->
	<div>
	<%
		if(request.getParameter("msg") != null){
	%>
		<%=request.getParameter("msg")%>
	<%
		}
	%>
	</div>

<!-- 수정할 상품 정보 입력 Begin -->
<section class="checkout spad">
		<div class="container">
			<div class="checkout__form">
				<h4>상품 수정 페이지</h4>
				<form action="<%=request.getContextPath()%>/product/modifyProductAction.jsp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="productNo" value="<%=productOne.getProductNo()%>">
					<div class="row">
					<div class="col-lg-12">
							<div class="row">
							<div class="col-lg-3">
								<div class="checkout__input">
								<p>카테고리명<span>*</span></p>
									<input type="text" name="" value="기존 선택 값 : <%=productOne.getCategoryName()%>" readonly="readonly">
								</div> 
							</div> 
							<div class="col-lg-2">
								<div class="checkout__input">
								<p>&nbsp;<span></span></p>
									<select class="category" name="categoryName">
									
										<option value="">카테고리를 선택하세요</option>
									<%
										for(Category category : categoryList) {
									%>
										<option value="<%=category.getCategoryName()%>"><%=category.getCategoryName()%></option>
									<% 
										}
									%>
									</select>
								</div>
							</div>
							</div>
						</div>
						</div>
						
						<br>
						
						<div class="row">
						<div class="col-lg-12">
							<div class="row">
								<div class="col-lg-3">
									<div class="checkout__input">
									<p>판매상태<span>*</span></p>
										<input type="text" name="" value="기존 선택 값 : <%=productOne.getProductStatus()%>" readonly="readonly">
									</div> 
								</div>
								<div class="col-lg-2"> 
									<div class="checkout__input">
										<p>&nbsp;<span></span></p>
										<select class="status" name="productStatus" required>
											<option value="">상태를 선택하세요</option>
											<option value="일시품절">일시품절</option>
											<option value="판매중">판매중</option>
											<option value="단종">단종</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						</div>
						
						<br>
      
						<div class="checkout__input">
							<p>상품명<span>*</span></p>
							<input type="text" name="productName" value="<%=productOne.getProductName()%>">
						</div>
  
						<div class="checkout__input">
							<p>가격<span>*</span></p>
							<input type="text" name="productPrice" value="<%=productOne.getProductPrice()%>">				
						</div>
     
						<div class="checkout__input">
							<p>재고량<span>*</span></p>
							<input type="text" name="productStock" value="<%=productOne.getProductStock()%>">
						</div>
						
						<div class="checkout__input">
							<p>상세설명<span>*</span></p>
							<input type="text" name="productInfo" value="<%=productOne.getProductInfo()%>">				
						</div>
						
						<div class="checkout__input">
							<p>이미지<span>*</span></p>
							<input class="button" type="file" name="productImg" required="required">
						</div>
					   
					<button type="submit" class="site-btn">상품수정</button>
				</form>
			</div>
		</div>
	</section>

<!-- 수정할 상품 정보 입력 End -->

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