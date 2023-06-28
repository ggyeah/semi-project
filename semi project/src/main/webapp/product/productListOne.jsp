<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
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
	System.out.println(SONG + productNo + " <-- 상품번호" + RESET);

	
	ProductDao prodDao = new ProductDao(); // ProductDao 객체 생성
	Product productOne = prodDao.ProductListOne(productNo); // productNo 매개변수로 productOne 메서드 호출하여, 상세보기에 표시할 productOne 객체 가져오기
	DiscountDao discountDao = new DiscountDao(); // ProductDao 객체 생성
	Discount discount = discountDao.discountOneList(productNo);
	
	ProductImgDao productImgDao = new ProductImgDao();
	ArrayList<ProductImg> productImgs = new ArrayList<>();
	productImgs = productImgDao.getProductImages(productNo);
	
	CategoryDao ctgrDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = ctgrDao.categoryList(); // categoryList 메서드 호출하여, 옵션에 표시할 categoryCntList 객체 가져오기
	
	/* categoryName의 디폴트 값을 "전체"로 설정 */
	// null로 넘어와도 → 전체 카테고리의 게시글을 출력하고
	// "전체"로 넘어와도 → 전체 카테고리의 게시글을 출력해야 하기 때문
	String categoryName = "전체";
	if(request.getParameter("categoryName") != null){
		categoryName = request.getParameter("categoryName");	
	}
	
	/*---------lim : 리뷰리스트 -----------*/
	ReviewDao reviewDao = new ReviewDao();
	int beginRow = 0;
	int rowPerPage = 5;
	int totalRow = reviewDao.reviewCnt();
	// + 리뷰 페이징 추가 해야함
	ArrayList<Review> rList = reviewDao.reviewList(beginRow, rowPerPage, productNo);
	
	/*---------lim : 문의리스트 -----------*/
	QuestionDao questionDao = new QuestionDao();
	int qbeginRow = 0;
	int qrowPerPage = 5;
	int qtotalRow = questionDao.questionCnt();
	// + 문의 페이징 추가 해야함
	ArrayList<Question> qList = questionDao.questionList(qbeginRow, qrowPerPage, productNo);
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(document).on("click", ".remove-product", function(e) {
      e.preventDefault();
      if (confirm("정말 삭제하시겠습니까?")) {
        var deleteLink = $(this);
        $.get(deleteLink.attr("href"), function() {
          deleteLink.closest("tr").remove();
          window.location.href = "<%=request.getContextPath()%>/product/productList.jsp"; // 삭제 후에 화면을 다시 로드
          alert("상품 삭제가 완료되었습니다.");
        }).fail(function() {
          alert("상품 삭제에 실패했습니다. 다시 시도해주세요.");
        });
      } else {
          location.reload(); // 취소를 눌렀을 때도 화면을 다시 로드 
      }
    });
  });
</script>
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
<title>productListOne</title>
<style>
	table,td,th {border: 1px solid #000000; border-collapse: collapse;}
   .pro-qty2 {
      width: 140px;
      height: 50px;
      display: inline-block;
      position: relative;
      text-align: center;
      background: #f5f5f5;
      padding-top: 10px;
      margin-bottom: 5px;
   }
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
								<li><a href="<%=request.getContextPath()%>/product/productList.jsp?categoryName=<%=category.getCategoryName()%>"><%=category.getCategoryName()%></a></li>
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

<!------------  상품상세보기 ------------>
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__pic">
                    <%
						for(ProductImg pi: productImgs){
					%>
                        <div class="product__details__pic__item">
                            <img class="product__details__pic__item--large"
                                src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
                        </div>
                     <%
						}
					%>	   
	                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__text">
                        <h3><%=productOne.getProductName()%></h3>
                        <div class="product__details__rating">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-half-o"></i>
                            <span>(18 reviews)</span>
                        </div>
                        <div class="product__details__price"><%=discount.getDiscountedPrice()%>원</div>
                        <p><%=productOne.getProductInfo()%></p>
                        <div class="product__details__quantity">
                            <div class="quantity">
                                <div class="pro-qty2">
                                    1개 담기
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/cart/addCartAction.jsp?productNo=<%=productOne.getProductNo()%>" class="primary-btn">ADD TO CARD</a>
                        <a href="#" class="heart-icon"><span class="icon_heart_alt"></span></a>
                        <ul>
                            <li><b>Availability</b> <span><%=productOne.getProductStatus()%></span></li>
                            <li><b>Shipping</b> <span>3~4 day shipping. &nbsp;<samp>Free pickup today</samp></span></li>
                            <li><b>Weight</b> <span>0.5 kg</span></li>
                        </ul>
                    </div>
                    
                    <br>
                    
                    <!-- 상품정보 수정 및 삭제 버튼 -->
					<div>
					<%
						//loginId가 관리자2(최고위직)일 경우에만 상품 수정 및 삭제 가능
						if(session.getAttribute("loginId") != null){
							if(session.getAttribute("loginId").equals("admin")){ 
					%>
					<a href="<%=request.getContextPath()%>/product/modifyProduct.jsp?productNo=<%=productOne.getProductNo()%>" class="primary-btn">상품수정</a>
					<a href="<%=request.getContextPath()%>/product/removeProductAction.jsp?productNo=<%=productOne.getProductNo()%>" class="remove-product primary-btn">상품삭제</a>
					<%
							}
						}
					%>
					</div>
                </div>
                </div>
                </div>
                </section>
   
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="product__details__tab">
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
							aria-selected="true">상세정보</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<br>
    
    <div class="center">
	<div class="container">
		<div class="row">
		<div class="col-lg-3 col-md-6"></div>
			<div class="col-lg-6 col-md-6">
                	<div class="product__details__pic">
                    <%
						for(ProductImg pi: productImgs){
					%>
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
						</div>
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
						</div>
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
						</div>
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
						</div>
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>">
						</div>
					<%
						}
					%>	   
					</div>
                </div>
			<div class="col-lg-3 col-md-6"></div>
			</div>
		</div>
	</div>
	
                
                            
	
 <!------------lim :  문의 & 리뷰   ------------>
 <div class="container">
				<div class="product__details__tab">
                 <ul class="nav nav-tabs" role="tablist">
                     <li class="nav-item">
                         <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                             aria-selected="true">리뷰</a>
                     </li>
                     <li class="nav-item">
                         <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab"
                             aria-selected="false">문의</a>
                     </li>
                 </ul>
                 <!------------  리뷰리스트  ------------>
                 <div class="tab-content">
                     <div class="tab-pane active" id="tabs-1" role="tabpanel">
                         <div class="product__details__tab__desc">
                          <%// 로그인상태에서만 리뷰추가를 할 수 있게 : 리뷰추가를 누르면 본인 주문리스트로 넘어감 
							if(session.getAttribute("loginId") != null) { %>
								<a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp" class="primary-btn">
									리뷰추가
								</a> 
						   <% } %>
                           <% for (Review review : rList) { %>
                           	<div class="blog__item__text">
	                            <ul>
	                                <li><i class="fa fa-calendar-o"></i><%=review.getCreatedate()%></li>
	                                <li><i class="fa fa-comment-o"></i><%=review.getId()%></li>
	                            </ul>
                            </div>
                             <h6><a href="<%=request.getContextPath()%>/review/reviewListOne.jsp?orderNo=<%=review.getOrderNo()%>" style="color: black;">
									제목 : <%=review.getReviewTitle()%>
								</a>
							</h6>
                             <p><%=review.getReviewContent()%>
                               <a href="<%=request.getContextPath()%>/review/reviewListOne.jsp?orderNo=<%=review.getOrderNo()%>" class="blog__btn">…더보기<span class="arrow_right"></span></a>
                         	</p>
                         <% } %>
                         </div>
                     </div>
                      <!------------  문의리스트  ------------>
                     <div class="tab-pane" id="tabs-2" role="tabpanel">
                         <div class="product__details__tab__desc">
                         <% //로그인상태에서만 문의추가 할 수 있게 
							if(session.getAttribute("loginId") != null) { %>
								<a href="<%=request.getContextPath()%>/question/addQuestion.jsp?productNo=<%=productNo%>"  class="primary-btn">
									문의추가
								</a> 
						 <% } %>
                             <% for (Question question : qList) { %>
                            <div class="blog__item__text">
	                            <ul>
	                                <li><i class="fa fa-calendar-o"></i><%=question.getCreatedate()%></li>
	                                <li><i class="fa fa-comment-o"></i><%=question.getId()%></li>
	                            </ul>
                            </div>
                             <h6>
                             	<a href="<%=request.getContextPath()%>/question/questionListOne.jsp?qNo=<%=question.getqNo()%>" style="color: black;">
									제목 : <%=question.getqTitle()%>
								</a>
							</h6>
                                <p><%=question.getqContent()%>
                                	<a href="<%=request.getContextPath()%>/question/questionListOne.jsp?qNo=<%=question.getqNo()%>" class="blog__btn">…더보기<span class="arrow_right"></span></a>
                                </p>
                           <% } %>
                         </div>
                     </div>
                 </div>
             </div>
</div>

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