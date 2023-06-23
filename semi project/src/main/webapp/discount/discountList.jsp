<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//관리자 2가 아니면 홈으로 되돌아감
if (!session.getAttribute("loginId").equals("admin")) { 	
response.sendRedirect(request.getContextPath() + "/home.jsp");
}

DiscountDao discountDao = new DiscountDao();


//페이징
int totalRow = discountDao.discountCnt();

//현재페이지
int currentPage = 1;
if (request.getParameter("currentPage") != null){
  currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

int rowPerPage = 5;
int beginRow = (currentPage - 1) * rowPerPage; 


int pagePerPage = 5;
int lastPage = (totalRow % rowPerPage == 0) ? (totalRow / rowPerPage) : (totalRow / rowPerPage + 1);
int minPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
int maxPage = Math.min(minPage + pagePerPage - 1, lastPage);

ArrayList<Discount> dList = discountDao.discountList(beginRow,rowPerPage);
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
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(document).on("click", ".remove-discount", function(e) {
      e.preventDefault();
      if (confirm("정말 삭제하시겠습니까?")) {
        var deleteLink = $(this);
        $.get(deleteLink.attr("href"), function() {
          deleteLink.closest("tr").remove();
          location.reload(); // 삭제 후에 화면을 다시 로드
        }).fail(function() {
          alert("삭제에 실패했습니다. 다시 시도해주세요.");
        });
      }
    });
  });
</script>
<style>
  .center {
    display: flex;
    justify-content: center;
  }
</style>
</head>
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
                    <h2>할인관리</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<br>
<!------------------- 할인리스트 ---------------------->
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="shoping__cart__table">
              <table>
                  <thead>
                      <tr>
						<th>상품번호</th>
						<th>카테고리</th>
						<th>상품이름</th>
						<th>상태</th>
						<th>수량</th>
						<th>할인시작일</th>
						<th>할인종료일</th>
						<th>할인비율</th>
						<th>할인적용가격</th>
						<th></th>
						<th></th>
					</tr>
					</thead>
				<% 
					for(Discount discount : dList) {
				%>
				 <tbody>
					<tr>
				        <td><%= discount.getProductNo() %></td>
				        <td><%= discount.getCategoryName() %></td>
						<td>
							<a href="<%=request.getContextPath()%>/product/productListOne.jsp?productNo=<%=discount.getProductNo()%>"  class="btn btn-light">
				      		<%= discount.getProductName() %></a>
				      	</td>
				        <td><%= discount.getProductStatus() %></td>
				        <td><%= discount.getProductStock() %></td>
				       <% if(discount.getDiscountStart()!=null && discount.getDiscountEnd()!= null) {%>
				        <td><%= discount.getDiscountStart()%></td>
				        <td><%= discount.getDiscountEnd()%></td>
				        <%}else{%>
				        <td>할인적용안됨</td>
				        <td>할인적용안됨</td>
						<%} %>
						<td>
						    <%
						    double discountRate = discount.getDiscountRate();
						    if (discountRate == 0.0) {
						    %>
						        <a href="<%=request.getContextPath()%>/discount/addDiscount.jsp?productNo=<%=discount.getProductNo()%>" class="btn btn-light">
						            할인추가
						        </a>
						    <%
						    } else {
						        out.print(discountRate);
						    }
						    %>
						</td>
				        <td class="shoping__cart__price">$ <%=discount.getDiscountedPrice() %></td>
						 <% if(discount.getDiscountStart()!=null && discount.getDiscountEnd()!= null) {%>
						<td><a href="<%=request.getContextPath()%>/discount/modifyDiscount.jsp?productNo=<%=discount.getProductNo()%>"  style="text-decoration:none;color: #F15F5F;">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/discount/removeDiscountAction.jsp?discountNo=<%=discount.getDiscountNo()%>" class="remove-discount" style="text-decoration:none;color: #F15F5F; ">삭제</a></td>
					</tr>
				</tbody>
				<% }else {%>
				<% } }%>
			</table>
         </div>
     </div>
   </div>
</div>

<!--   페이징   -->

<div class="center">                    
	<div class="product__pagination">
        <%  // 하단 페이징 번호
           for(int i = minPage; i <= maxPage; i = i+1){
              if(i == currentPage){
        %>
              <a class="page-link" style="color:#2F9D27"><span><%=i%>&nbsp;</span></a>
        <%         
              } else {
        %>
             <a class="page-link" href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=i%>"><%=i%></a>
        <%         
              }
           }
           // 다음
           if(maxPage != lastPage){
        %> 
           <a href ="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=minPage+pagePerPage%>"><i class="fa fa-long-arrow-right"></i></a>
        <%     
           }
        %>
  </div>
</div>
 <br><br>



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