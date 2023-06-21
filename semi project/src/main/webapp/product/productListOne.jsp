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
	
	ProductImgDao productImgDao = new ProductImgDao();
	ArrayList<ProductImg> productImgs = new ArrayList<>();
	productImgs = productImgDao.getProductImages(productNo);
	
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
</style>
</head>
<body>
<!------------ 상단 네비 바 ------------>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

<!------------  상품상세보기 ------------>
<div>
	<h1><%=productOne.getProductName()%> 상품 상세 페이지</h1>
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
	
	<table>
		<tr>
			<th>product_no</th>
			<td><%=productOne.getProductNo()%></td>
		</tr>
		<tr>
			<th>category_name</th>
			<td><%=productOne.getCategoryName()%></td>
		</tr>
		<tr>	
			<th>product_name</th>
			<td><%=productOne.getProductName()%></td>
		</tr>
		<tr>
			<th>product_price</th>
			<td><%=productOne.getProductPrice()%></td>
		</tr>
		<tr>
			<th>product_status</th>
			<td><%=productOne.getProductStatus()%></td>
		</tr>
		<tr>
			<th>product_stock</th>
			<td><%=productOne.getProductStock()%></td>
		</tr>
	<%
		if (productImgs.size() == 0){
	%>
			<tr>
				<th>product_img</th>
				<td>이미지가 없습니다.</td>
			</tr>
	<%
		}
		for(ProductImg pi: productImgs){
	%>
			<tr>
				<th>product_img</th>
				<td><img src="<%=request.getContextPath() + "/productImgUpload/" + pi.getProductSaveFilename()%>"></td>
			</tr>
	<%
		}
	%>	
		<tr>
			<th>product_info</th>
			<td><%=productOne.getProductInfo()%></td>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=productOne.getCreatedate()%></td>
		</tr>
		<tr>
			<th>updatedate</th>
			<td><%=productOne.getUpdatedate()%></td>
		</tr>
		<tr>
			<th>장바구니</th>
			<td><a href="<%=request.getContextPath()%>/cart/addCartAction.jsp?productNo=<%=productOne.getProductNo()%>">장바구니 추가</a></td>
		</tr>
	</table>
</div>
	<!-- 상품정보 수정 및 삭제 버튼 -->
	<%
		//loginId가 관리자2(최고위직)일 경우에만 상품 수정 및 삭제 가능
		if(session.getAttribute("loginId") != null){
			if(session.getAttribute("loginId").equals("admin")){ 
	%>
	<a href="<%=request.getContextPath()%>/product/modifyProduct.jsp?productNo=<%=productOne.getProductNo()%>">상품 수정</a>
	<a href="<%=request.getContextPath()%>/product/removeProduct.jsp?productNo=<%=productOne.getProductNo()%>">상품 삭제</a>
	<%
			}
		}
	%>
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