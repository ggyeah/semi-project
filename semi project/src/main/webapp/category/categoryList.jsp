<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	CategoryDao cDao = new CategoryDao(); // CategoryDao 객체 생성
	ArrayList<Category> categoryList = cDao.categoryList(); // categoryList 메서드 호출하여, 페이지에 표시할 categoryList 객체 가져오기
	
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>categoryList | Template</title>

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
    $(document).on("click", ".remove-category", function(e) {
      e.preventDefault();
      if (confirm("정말 삭제하시겠습니까?")) {
        var deleteLink = $(this);
        $.get(deleteLink.attr("href"), function() {
          deleteLink.closest("tr").remove();
          location.reload(); // 삭제 후에 화면을 다시 로드
        }).fail(function() {
          alert("삭제에 실패했습니다. 다시 시도해주세요.");
        });
      } else {
          location.reload(); // 취소를 눌렀을 때도 화면을 다시 로드 
      }
    });
  });
</script>
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
                    <h2>카테고리 관리</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<br>
<br>
<!-- 카테고리정보 관리 버튼 -->
<div class="container">
	<div>	
		<a href="<%=request.getContextPath()%>/category/addCategory.jsp">카테고리 추가</a>
		<a href="<%=request.getContextPath()%>/category/modifyCategory.jsp">카테고리 수정</a>
	</div>
</div>
<br>
<br>
<!--  카테고리리스트 -->
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="shoping__cart__table">
              <table>
                  <thead>
                     <tr>
						<th>카테고리</th>
						<th>생성일</th>
						<th>수정일</th>
						<th>삭제</th>
					 </tr>
				   </thead>
					<%
						for(Category category : categoryList) {
					%>
					<tbody>
					  <tr>
					     <td><%=category.getCategoryName()%></td>
						 <td><%=category.getCreatedate()%></td>
						 <td><%=category.getUpdatedate()%></td>
						 <td>
						 	<a href="<%=request.getContextPath()%>/category/removeCategoryAction.jsp?removeCategoryName=<%=category.getCategoryName()%>" class="remove-category">
						 		카테고리 삭제
						 	</a>
						 </td>
					  </tr>
					 </tbody>
					<% 
						}
					%>
			</table>
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