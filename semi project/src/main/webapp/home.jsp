<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 처리
	response.setCharacterEncoding("UTF-8");
	
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryCntList 객체 가져오기
	
	/* categoryName의 디폴트 값을 "전체"로 설정 */
	// null로 넘어와도 → 전체 카테고리의 게시글을 출력하고
	// "전체"로 넘어와도 → 전체 카테고리의 게시글을 출력해야 하기 때문
	String categoryName = "전체";
	if(request.getParameter("categoryName") != null){
		categoryName = request.getParameter("categoryName");	
	}
	
	ProductDao productCateDao = new ProductDao();
	ArrayList<Product> productListCate = productCateDao.productListCateByPage(categoryName, 0, 10);

	ProductDao productDao = new ProductDao();
	ArrayList<Product> productList = productDao.productListByPage(0, 12);
	
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>home | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<!-- 카테고리 바 Begin -->
    <section class="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="hero__categories">
                        <div class="hero__categories__all">
                            <i class="fa fa-bars"></i>
                            <span>All category</span>
                        </div>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/product/productList.jsp?categoryName=전체">전체</a></li>
                            <%
								for(Category category : categoryList) {
							%>
								<li><a href="<%=request.getContextPath()%>/product/productList.jsp?categoryName=<%=category.getCategoryName()%>"><%=category.getCategoryName()%></a></li>
							<% 
								}
							%>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="hero__search">
                        <div class="hero__search__form">
                            <form action="#">
                                <input type="text" placeholder="What do yo u need?">
                                <button type="submit" class="site-btn">SEARCH</button>
                            </form>
                        </div>
                        <div class="hero__search__phone">
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h5>+82 02.000.000</h5>
                                <span>&nbsp; support 24/7 time</span>
                            </div>
                        </div>
                    </div>
                    <div class="hero__item set-bg" data-setbg="productImgUpload/minari.jpg">
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Hero Section End -->
    
<!-- Featured Section Begin -->
<section class="featured spad">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
	            <div class="section-title">
	                <h2>최신상품</h2>
	            </div>
	        </div>
	    </div>
	    
	    <div class="row featured__filter">
		<%
			for(Product product : productList) {
				int productNo = product.getProductNo();
				ProductImgDao productImgDao = new ProductImgDao();
				ArrayList<ProductImg> productImgs = new ArrayList<>();
				productImgs = productImgDao.getProductImages(productNo);
				if(productImgs.size() != 0){
		%>
		<script>
		$(document).ready(function() {
		  $(".featured__item__pic<%=productNo%>").click(function() {
		    window.location.href = "<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=productNo%>";
		  });
		});
		</script>
			<div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
				<div class="featured__item">
					<div class="featured__item__pic set-bg featured__item__pic<%=productNo%>" data-setbg="<%=request.getContextPath()%>/productImgUpload/<%=productImgs.get(0).getProductSaveFilename()%>">
						<ul class="featured__item__pic__hover">
							<li><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-heart"></i></a></li>
							<li><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-retweet"></i></a></li>
							<li><a href="<%=request.getContextPath()%>/cart/addCartAction.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-shopping-cart"></i></a></li>
						</ul>
					</div>
					<div class="featured__item__text">
			    		<h6><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>">
							<%=product.getProductName()%>
						</a></h6>
						<h5><%=product.getProductPrice()%>원</h5>
							<%=product.getProductStatus()%>
					</div>
				</div>
			</div>
		<%
				}
			}
		%>
		</div>
			<!-- 더보기 누르면 상품리스트로 가도록 -->
			<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryName=전체">
				더보기
			</a>
	</div>
</section>
<!-- Featured Section End -->

	
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