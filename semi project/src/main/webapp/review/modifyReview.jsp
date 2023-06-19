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
<body class="container">
<% if(session.getAttribute("loginId").equals(review.getId())) {%>
<h2>수정</h2>
<form id="signinForm" action="<%=request.getContextPath()%>/review/modifyReviewAction.jsp" method="post" enctype="multipart/form-data">

	<table class="table table-bordered">
		<tr>
              <th>주문번호</th>
              <td><input type= "text" name = "orderNo" value ="<%=review.getOrderNo()%>" readonly="readonly"></td>
           </tr>
		 <tr>
		 <tr>
              <th>상품번호</th>
              <td><input type= "text" name = "productNo" value ="<%=review.getProductNo()%>" readonly="readonly"></td>
           </tr>
		 <tr>
		 <tr>
              <th>아이디</th>
              <td><input type= "text" name = "id" value ="<%=review.getId()%>" readonly="readonly"></td>
           </tr>
		 <tr>
		 <tr>
              <th>제목</th>
              <td><input type= "text" name = "reviewTitle" value ="<%=review.getReviewTitle()%>" id="title">
        	  <span id="titleMsg" class="msg"></span></td>
         </tr>
          <tr>
          	<td>
		        <% if (reviewImgs.size() > 0) { %>
		            수정 전 파일: <%= reviewImgs.get(0).getReviewSaveFilename() %>
		          <a href="<%=request.getContextPath()%>/review/removeReviewImgAction.jsp?orderNo=<%=orderNo%>" class="remove-reviewImg">삭제</a>
		          </td>
		          <td>
		            <input type="file" name="reviewImg">
		        <% } else { %>
		            수정 전 파일 없음</td>
		          <td><input type="file" name="reviewImg">
		        <% } %>
            </td>
         </tr>
		<tr>
              <th>내용</th>
              <td><input type= "text" name = "reviewContent" value ="<%=review.getReviewContent()%>"  id="content">
           	  <span id="contentMsg" class="msg"></span></td>
           </tr>
		 <tr>
              <th>생성일</th>
              <td><%=review.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=review.getCreatedate()%></td>
           </tr>
	<tr>
		<th>수정하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"   id="signinBtn"> 수정</button></td>
	</tr>
</table>
</form>
<% }%>
</body>
</html>