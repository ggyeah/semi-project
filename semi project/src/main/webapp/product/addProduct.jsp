<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 추가 가능
	// 관리자 2의 level값을 가져옴
	EmployeesDao employeesDao = new EmployeesDao();
	ArrayList<Employees> twoEmployeesList = employeesDao.twoEmployeesList();
	
	String loginId = (String)session.getAttribute("loginId");
	boolean checkId = false;
	if(loginId != null) {
		for(Employees e : twoEmployeesList) {
			if(session.getAttribute("loginId").equals(e.getId())) {
				checkId = true;
				break;
			}
		}
	}
	
	/* 세션 유효성 검사 */
	// 관리자 레벨2가 아니면 : home으로 돌아가고, 알림창에 오류메세지 출력
	if(checkId == false) {
		String errorMsg = URLEncoder.encode("권한이 없습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/home.jsp?errorMsg=" + errorMsg);
		return;
	}
	
	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryList 객체 가져오기

	ProductDao productDao = new ProductDao();
	ProductImgDao productImgDao = new ProductImgDao();
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<style>
.button{
	padding-top: 7px;
	}
.error-msg {
	color: #F15F5F;
	}
</style>
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>addProduct | Template</title>

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 시작시 categoryName 입력 폼에 포커스
    $('#categoryName').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#categoryName').val() == '') {
            $('#categoryNameMsg').text('카테고리를 선택하세요').addClass('error-msg');
            $('#categoryName').focus();
            allCheck = false;
        } else {
            $('#categoryNameMsg').text('');
        }

        if ($('#Status').val() == '') {
            $('#StatusMsg').text('상태를 선택하세요').addClass('error-msg');
            $('#Status').focus();
            allCheck = false;
        } else {
            $('#StatusMsg').text('');
        }
        
        if ($('#Name').val() == '') {
            $('#NameMsg').text('상품이름을 입력하세요').addClass('error-msg');
            $('#Name').focus();
            allCheck = false;
        } else {
            $('#NameMsg').text('');
        }
        
        if ($('#Price').val() == '') {
            $('#PriceMsg').text('가격을 입력하세요').addClass('error-msg');
            $('#Price').focus();
            allCheck = false;
        } else {
            $('#PriceMsg').text('');
        }
        
        if ($('#Stock').val() == '') {
            $('#StockMsg').text('재고량을 입력하세요').addClass('error-msg');
            $('#Stock').focus();
            allCheck = false;
        } else {
            $('#StockMsg').text('');
        }
        
        if ($('#Info').val() == '') {
            $('#InfoMsg').text('내용을 입력하세요').addClass('error-msg');
            $('#Info').focus();
            allCheck = false;
        } else {
            $('#InfoMsg').text('');
        }
        return allCheck;
    }
     $('#Btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('#Form').submit();
        }
    });
});
</script>
</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

<!-- 새로운 상품 정보 입력 Begin -->
	<section class="checkout spad">
		<div class="container">
			<div class="checkout__form">
				<h4>상품 추가 페이지</h4>
				<form action="<%=request.getContextPath()%>/product/addProductAction.jsp" method="post" enctype="multipart/form-data"  id="Form" >
					<div class="col-lg-12 col-md-6">
						<div class="row">
						<div class="col-lg-12">
							<div class="checkout__input">
								<p>카테고리명<span>*</span></p>
								<select class="category" name="categoryName" id="categoryName">
									<option value="">카테고리를 선택하세요</option>
								<%
									for(Category category : categoryList) {
								%>
									<option value="<%=category.getCategoryName()%>"><%=category.getCategoryName()%></option>
								<% 
									}
								%>
								</select>
								<span id="categoryNameMsg" class="msg"></span>
							</div>    
						</div>
						</div>
						
						<br>
						
						<div class="row">
						<div class="col-lg-12">
							<div class="checkout__input">
								<p>판매상태<span>*</span></p>
								<select class="status" name="productStatus" id="Status">
									<option value="">상태를 선택하세요</option>
									<option value="일시품절">일시품절</option>
									<option value="판매중">판매중</option>
									<option value="단종">단종</option>
								</select>
								<span id="StatusMsg" class="msg"></span>
							</div>
						</div>
						</div>
						
						<br>
      
						<div class="checkout__input">
							<p>상품명<span>*</span></p>
							<input type="text" name="productName" id="Name">
							<span id="NameMsg" class="msg"></span>
						</div>
  
						<div class="checkout__input">
							<p>가격<span>*</span></p>
							<input type="text" name="productPrice" id="Price">	
							<span id="PriceMsg" class="msg"></span>			
						</div>

						
						<div class="checkout__input">
							<p>재고량<span>*</span></p>
							<input type="text" name="productStock" id="Stock">
							<span id="StockMsg" class="msg"></span>
						</div>

						<div class="checkout__input">
							<p>상세설명<span>*</span></p>
							<input type="text" name="productInfo" id="Info">
							<span id="InfoMsg" class="msg"></span>				
						</div>
						
						<div class="checkout__input">
							<p>이미지<span>*</span></p>
							<input type="file" name="productImg" class="button" required="required">
						</div>
					</div>        
						<button type="submit" class="site-btn" id="Btn">상품추가</button>
				</form>
			</div>
		</div>
	</section>
<!-- 새로운 상품 정보 입력 End -->

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