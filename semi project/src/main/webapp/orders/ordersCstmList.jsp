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
	
	/* 세션값 확인 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--ordersCstmList loginId param"+RESET);
	
	/* 유효성 검사 */
	if(loginId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	
	OrdersDao ordersDao = new OrdersDao();
	
	// 현재 페이지 번호
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	/* 1. 글에 필요한 값: beginRow, rowPerPage (oracleDB 사용시 endRow) */
	int rowPerPage = 3;
	int beginRow = (currentPage - 1) * rowPerPage; // ex. rowPerPage가 10일때 1, 11, 21... 출력
	
	//mariadb는 limit가 있어서 시작 번호와 끝번호를 따로 정해주지 않아도 됨.
	//beginRow부터 rowPerPage까지의 데이터를 가져오는 메소드를 호출, 결과 저장
	ArrayList<Orders> myList = ordersDao.selectCustomerOrders(beginRow, rowPerPage, loginId);//0부터 10까지
	
	//totalRow를 사용하기 위해 selectCustomerOrdersCnt 메소드 호출 및 변수 저장
	int totalRow = ordersDao.selectCustomerOrdersCnt(loginId);
	
	/* 2. 하단 바에 필요한 값: minpage(이전) pageperpage maxPage(다음) */
	int pagePerPage = 3;
	
	int lastPage = totalRow / rowPerPage; // pagePerPage X
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	int minPage = (((currentPage - 1) / pagePerPage) * pagePerPage) + 1; //하단 페이징에서 제일 작은 값
	int maxPage = minPage + (pagePerPage - 1); // 하단 페이징에서 제일 큰 값
	//마지막 번호가, 실제 페이지 번호보다 많지 않도록 처리
	if(maxPage > lastPage){
		maxPage = lastPage;
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script>
$(document).ready(function() {
  $(document).on("click", ".modify", function(e) {
    e.preventDefault();
    var modifyLink = $(this).find("a");
    if (confirm("구매를 확정하시겠습니까?")) {
      $.get(modifyLink.attr("href"), function() {
        alert("포인트가 추가되었습니다.");
        location.reload(); // 변경 후에 화면을 다시 로드
      });
      .done(function() {
        console.log("변경에 성공했습니다.");
      });
      .fail(function() {
        console.log("변경에 실패했습니다. 다시 시도해주세요.");
      });
    }
  });
});
</script>
<style>
	.center {
		text-align: center;
	}
	.table center{
		margin: 0 auto;
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
	                    <h2>나의 주문리스트</h2>
	                    <div class="breadcrumb__option">
	                         <span>Home -</span>
	                         <span>나의 주문리스트</span>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>	
<section class="shoping-cart spad">
    <div class="container">
<!-- 포인트 추가시 메세지 출력 -->
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>

    
     <div class="center">
	     <div class="checkout__form">
			<div class="row">
				<div class="col-lg-12">
					<table class="table center">
						<tr>
							<th>상품이름</th>
							<th>주문상태</th>
							<th>주문수량</th>
							<th>총 가격</th>
							<th>주문일</th>
							<th>구매확정</th>
						</tr>
							<%
								// 상품 이름 조회
								ProductDao productDao = new ProductDao();
								for(Orders orders : myList){
									Product product = productDao.ProductListOne(orders.getProductNo());
							%>
							<tr>
								<td><%=product.getProductName()%></td>
								<td><%=orders.getDeliveryStatus()%></td>
								<td><%=orders.getOrderCnt()%></td>
								<td><%=orders.getOrderPrice()%></td>
								<td><%=orders.getCreatedate()%></td>
								<td>
								<% // 이미 구매확정 버튼을 눌렀을 시 addReview로 이동
									if(orders.getDeliveryStatus().equals("구매확정")){
								%>
								 		<%
										ReviewDao reviewDao = new ReviewDao();
										Review review = new Review();
										review = reviewDao.reviewListOne(orders.getOrderNo());
										
								 		if (review != null) { //작성된 리뷰가 있으면 리뷰를 보러
								 		%>
          									<a href="<%=request.getContextPath()%>/review/reviewListOne.jsp?orderNo=<%=review.getOrderNo()%>">리뷰보기</a>
           								<% 
           								} else { // 작성된 리뷰가 없으면 리뷰작성으로  
           								%> 
           	  								<a href="<%=request.getContextPath()%>/review/addReview.jsp?orderNo=<%=orders.getOrderNo()%>&productNo=<%=orders.getProductNo()%>">리뷰작성</a>
									
								<%	// 배송완료일 때 구매확정 할 수 있도록 설정
           							}	
           						} else if(orders.getDeliveryStatus().equals("배송완료")){
								%>
									<button class="modify"><a href="<%=request.getContextPath()%>/orders/modifyCstmAction.jsp?orderNo=<%=orders.getOrderNo()%>&loginId=<%=loginId%>&deliveryStatus=<%=orders.getDeliveryStatus()%>">구매확정</a></button>
							    <%
									}
							    %>
							    </td>
							</tr>
						<%
							}
						%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="center">
		 <div class="product__pagination">
					<%
					// '이전'
					if(minPage > 1){
					%>
						<a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp?currentPage=<%=minPage-pagePerPage%>"><i class="fa fa-long-arrow-left"></i></a>
					<%		
						}
						// 하단 페이징 번호
						for(int i = minPage; i <= maxPage; i = i+1){
							if(i == currentPage){
					%>
								<a><span><%=i%>&nbsp;</span></a>
					<%			
							} else {
					%>
								<a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp?currentPage=<%=i%>"><%=i%></a>
					<%			
							}
						}
						// '다음'
						if(maxPage != lastPage){
					%>
						<a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp?currentPage=<%=minPage+pagePerPage%>"><i class="fa fa-long-arrow-right"></i></a>
					<%		
						}
					%>
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