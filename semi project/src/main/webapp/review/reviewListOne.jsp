<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
ReviewDao reviewDao = new ReviewDao();
ReviewImgDao reviewImgDao = new ReviewImgDao();

Review review = new Review();
List<ReviewImg> reviewImgs = new ArrayList<>();

//주문번호가 넘어오지않으면 홈으로 넘어가게
if (request.getParameter("orderNo") == null) {
	 response.sendRedirect(request.getContextPath() + "/home.jsp");
}

int orderNo = Integer.parseInt(request.getParameter("orderNo"));
System.out.println(orderNo + "<- reviewOneorderNo");

review = reviewDao.reviewListOne(orderNo);
reviewImgs = reviewImgDao.getReviewImages(orderNo); 

ProductDao prodDao = new ProductDao(); 
Product productOne = prodDao.ProductListOne(review.getProductNo());
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    .answer-container {
        margin-left: 20px; /* 앞쪽 공간 조절 */
    }
</style></head>
<body>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<!-- 상단토마토바 -->
<section class="breadcrumb-section set-bg" data-setbg="<%=request.getContextPath()%>/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <P style="color:white;"><%=productOne.getProductName()%></P>
                    <h2>상품리뷰</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<!--  리뷰 -->
<br>
<div class="container">
<div class="checkout__form">
   	 <h4 class="answer-container"><%=review.getReviewTitle()%></h4>
   	   <span class="blog__item__text">
        <ul>
            <li><i class="fa fa-calendar-o"></i><%=review.getCreatedate()%></li>
            <li><i class="fa fa-comment-o"></i><%=review.getId()%></li>
        </ul>
      </span>
          <p><% if (reviewImgs.size() > 0) { %>
          		<img src="<%=request.getContextPath() + "/reviewImgUpload/" + reviewImgs.get(0).getReviewSaveFilename()%>">
           	  <% } else { %>
           	  
    		 <% } %>
    	  </p>	
	
			<p class="answer-container"><%=review.getReviewContent()%></p>
			 <% // 로그인 상태이고 본인이 작성한 리뷰만 수정삭제가 보임 
		     if (session.getAttribute("loginId") != null && session.getAttribute("loginId").equals(review.getId())) { %>
			<div style="text-align: right;">
				<a href="<%=request.getContextPath()%>/review/modifyReview.jsp?orderNo=<%=review.getOrderNo()%>" class="btn btn-outline-secondary">수정</a>
				<a href="<%=request.getContextPath()%>/review/removeReview.jsp?orderNo=<%=review.getOrderNo()%>&productNo=<%=review.getProductNo()%>" class="btn btn-outline-secondary">삭제</a>
			</div>	
			<%}%>
		</div>
	</div>
<br>
<br>
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