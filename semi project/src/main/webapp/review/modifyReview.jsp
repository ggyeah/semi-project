<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//주문번호가 넘어오지 않으면 홈으로 돌아가게
if (request.getParameter("orderNo") == null){
	 response.sendRedirect(request.getContextPath() + "/home.jsp");
}

ReviewDao reviewDao = new ReviewDao();
ReviewImgDao reviewImgDao = new ReviewImgDao();

Review review = new Review();
List<ReviewImg> reviewImgs = new ArrayList<>();

int orderNo = Integer.parseInt(request.getParameter("orderNo"));
System.out.println(orderNo+"<- ㅡmodifyreview orderNo");

review = reviewDao.reviewListOne(orderNo);
reviewImgs = reviewImgDao.getReviewImages(orderNo); 
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

<title>modifyReview</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> // 파일삭제 확인
  $(document).ready(function() {
    $(document).on("click", ".remove-reviewImg", function(e) {
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
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#title').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#title').val() == '') {
            $('#titleMsg').text('제목을 입력하세요');
            $('#title').focus();
            allCheck = false;
        } else {
            $('#titleMsg').text('');
        }

        if ($('#content').val() == '') {
            $('#contentMsg').text('내용을 입력하세요');
            $('#content').focus();
            allCheck = false;
        } else {
            $('#contentMsg').text('');
        }
        
        return allCheck;
    }
    $('#signinBtn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('#signinForm').submit();
        }
    });
});
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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
                    <h2>상품리뷰</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 리뷰수정 -->
<br>
<% if(session.getAttribute("loginId").equals(review.getId())) {%>
<div class="container">
	<div class="checkout__form">
		<form id="signinForm" action="<%=request.getContextPath()%>/review/modifyReviewAction.jsp" method="post" enctype="multipart/form-data">
   			 <input type="hidden" name="productNo" value="<%=review.getProductNo()%>">
			 <input type="hidden" name="orderNo" value="<%=review.getOrderNo()%>">
   				 <h4>
   	 				제목 : <input type= "text" name = "reviewTitle" value ="<%=review.getReviewTitle()%>" id="title">
      			</h4>
      			 <span id="titleMsg" class="msg"></span>
   	  		 <span class="blog__item__text">
	        <ul>
	            <li><i class="fa fa-calendar-o"></i><%=review.getCreatedate()%></li>
	            <li><i class="fa fa-comment-o"></i><%=review.getId()%></li>
	        </ul>
      		</span>
        	 	<% if (reviewImgs.size() > 0) { %>
        	 	 <p>
          			<img src="<%=request.getContextPath() + "/reviewImgUpload/" + reviewImgs.get(0).getReviewSaveFilename()%>">
           	  		수정 전 파일: <%= reviewImgs.get(0).getReviewSaveFilename() %>
           	  		<a href="<%=request.getContextPath()%>/review/removeReviewImgAction.jsp?orderNo=<%=orderNo%>" class="remove-reviewImg">삭제</a>
           	  	</p>
           	  	<p><input type="file" name="reviewImg"></p>
		      <% } else { %>
		         <p>이미지 파일 없음</p>
		         	<input type="file" name="reviewImg">
		        <% } %>
			    <br>
			    <br>
				<p>내용 : <input type= "text" name = "reviewContent" value ="<%=review.getReviewContent()%>"  id="content" style="width:500px;">
				<button type="submit" class="btn btn-success"   id="signinBtn"> 수정</button>
				<span id="contentMsg" class="msg"></span></p>
			</form>
		</div>
	</div>
<% } %>
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