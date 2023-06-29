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
	
	// 현재페이지
	int currentPage = 1;
	
	/* 유효성 검사 통과하면 변수에 저장 */
	if (request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이지에 보여줄 상품의 개수
	int rowPerPage = 12;
	// 시작 상품의 번호
	int beginRow = (currentPage-1) * rowPerPage;

	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryCntList 객체 가져오기
	
	/* categoryName의 디폴트 값을 "전체"로 설정 */
	// null로 넘어와도 → 전체 카테고리의 게시글을 출력하고
	// "전체"로 넘어와도 → 전체 카테고리의 게시글을 출력해야 하기 때문
	String categoryName = "전체";
	if(request.getParameter("categoryName") != null){
		categoryName = request.getParameter("categoryName");	
	}
	
	ProductDao productDao = new ProductDao();
	ArrayList<Product> productListCate = productDao.productListCateByPage(categoryName, beginRow, rowPerPage);

	DiscountDao discountDao = new DiscountDao();
	
	// 전체 상품의 수 구하기
	int totalRow = productDao.productCateCnt(categoryName);
	
	// 마지막 페이지
	int lastPage = totalRow / rowPerPage;
		// 딱 나누어 떨어지지 않으면 마지막 페이지 하나 추가
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		
	// 하단 페이지목록 : 한 번에 보여줄 페이지의 개수
	int pagePerPage = 5;
	// 페이지 목록 중 가장 작은 숫자의 페이지
	int minPage = ((currentPage - 1) / pagePerPage ) * pagePerPage + 1;
	// 페이지 목록 중 가장 큰 숫자의 페이지
	int maxPage = minPage + (pagePerPage - 1);
	// maxPage 가 last Page보다 커버리면 안되니까 lastPage를 넣어준다
	if (maxPage > lastPage){
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
    <title>productList | Template</title>

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
	.center {
	text-align: center;
	}
</style>
</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

 <!-- 카테고리 및 검색창 Begin -->
    <section class="hero hero-normal">
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
								<li><a href="<%=request.getContextPath()%>/product/productCateList.jsp?categoryName=<%=category.getCategoryName()%>"><%=category.getCategoryName()%></a></li>
							<% 
								}
							%>
							 <li><a href="<%=request.getContextPath()%>/product/discountProductList.jsp">할인상품</a></li>
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
                </div>
            </div>
        </div>
    </section>
<!-- 카테고리 및 검색창 End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2><%=categoryName%> 상품</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.html">Home &nbsp;</a>
                            <span><%=categoryName%> 상품</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
			<div class="col-lg-12 col-md-6">
                    
                    <div class="filter__item">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                                <div class="filter__sort">
                                    <span>정렬</span>
                                    <select>
                                        <option value="0">최신순</option>
                                        <option value="0">이름순</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <div class="filter__found">
                                    <h6>전체 <span><%=totalRow%></span>개의 상품이 있습니다</h6>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3">
                                <div class="filter__option">
                                    <span class="icon_grid-2x2"></span>
                                    <span class="icon_ul"></span>
                                </div>
                            </div>
                        </div>
                    </div>
	<div class="row"> 
		<%
			for(Product product : productListCate) {
				int productNo = product.getProductNo();
				Discount discount = discountDao.discountOneList(productNo);
				
				ProductImgDao productImgDao = new ProductImgDao();
				ArrayList<ProductImg> productImgs = new ArrayList<>();
				productImgs = productImgDao.getProductImages(productNo);
				if(productImgs.size() != 0){
		%>
		<script>
		$(document).ready(function() {
		  $(".product__item__pic<%=productNo%>").click(function() {
		    window.location.href = "<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=productNo%>";
		  });
		});
		</script>
		<div class="col-lg-3 col-md-4 col-sm-6">
			<div class="product__item">
				<div class="product__item__pic set-bg product__item__pic<%=productNo%>" data-setbg="<%=request.getContextPath()%>/productImgUpload/<%=productImgs.get(0).getProductSaveFilename()%>">
					<ul class="product__item__pic__hover">
						<li><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-heart"></i></a></li>
						<li><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-retweet"></i></a></li>
						<li><a href="<%=request.getContextPath()%>/cart/addCartAction.jsp?productNo=<%=product.getProductNo()%>"><i class="fa fa-shopping-cart"></i></a></li>
					</ul>
				</div>
				<div class="product__item__text">
					<h6><a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=product.getProductNo()%>">
						<%=product.getProductName()%></a></h6>
					<h5><%=discount.getDiscountedPrice()%>원</h5>
						<%=product.getProductStatus()%>
				</div>
			</div>
		</div>
		<%
				}
			}
		%>
	</div>  
                      	
<!------------ 페이지네이션 ------------>
	<div class="center">
	<div class="row">
	<div class="col-lg-12">
		<div class="product__pagination">
		<%
			if(minPage > 1) {	// 1페이지 아닐 때 이전버튼 표시
		%>
			<a href="<%=request.getContextPath()%>/product/productCateList.jsp?categoryName=<%=categoryName%>&currentPage=<%=minPage - 1%>"><i class="fa fa-long-arrow-left"></i></a>
		<%
			}
		%> 
		
		<%
			for(int i = minPage; i <= maxPage; i++) {
		%>
			<a href="<%=request.getContextPath()%>/product/productCateList.jsp?categoryName=<%=categoryName%>&currentPage=<%=i%>">
			<%=i%></a>
		<%
			}
		%>
		
		<%
			if(maxPage < lastPage) { // 마지막페이지 아닐 때 다음버튼 표시
		%>
		    <a href="<%=request.getContextPath()%>/product/productCateList.jsp?categoryName=<%=categoryName%>&currentPage=<%=maxPage + 1%>"><i class="fa fa-long-arrow-right"></i></a>
		<%
			}
		%>    
		</div>
	</div>
	</div>
	</div>
	</div>
</div>
</div>
    </section>
<!-- Product Section End -->

<!-- 상품추가버튼 -->
<%
	//loginId가 관리자2(최고위직)일 경우에만 상품 수정 및 삭제 가능
	if(session.getAttribute("loginId") != null){
		if(session.getAttribute("loginId").equals("admin")){ 
%>
	<div class="center">
	<div class="row">
		<div class="col-lg-12">
		<a href="<%=request.getContextPath()%>/product/addProduct.jsp" class="primary-btn">상품추가</a>
		</div>
	</div>
	</div>
<%
		}
	}
%>

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