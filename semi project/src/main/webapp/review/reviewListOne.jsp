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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<h2>상세보기</h2>
	<table class="table table-bordered">
		<tr>
              <th>주문번호</th>
              <td><%=orderNo%></td>
         </tr>
		 <tr>
              <th>상품번호</th>
              <td><%=review.getProductNo()%></td>
         </tr>
		 <tr>
              <th>아이디</th>
              <td><%=review.getId()%></td>
         </tr>
		 <tr>
              <th>제목</th>
              <td><%=review.getReviewTitle()%></td>
         </tr>
		 <tr>
              <th>사진</th>
               <% if (reviewImgs.size() > 0) { %>
              <td><img src="<%=request.getContextPath() + "/reviewImgUpload/" + reviewImgs.get(0).getReviewSaveFilename()%>"></td>
           	  <% } else { %>
       		 <td>이미지 없음</td>
    		<% } %>
           </tr>
		  <tr>
              <th>내용</th>
              <td><%=review.getReviewContent()%></td>
           </tr>
		   <tr>
              <th>생성일</th>
              <td><%=review.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=review.getUpdatedate()%></td>
           </tr>
	</table>
	

	 <% // 로그인 상태이고 본인이 작성한 리뷰만 수정삭제가 보임 
     if (session.getAttribute("loginId") != null && session.getAttribute("loginId").equals(review.getId())) { %>
	<div>
		<a href="<%=request.getContextPath()%>/review/modifyReview.jsp?orderNo=<%=review.getOrderNo()%>">수정</a>
		<a href="<%=request.getContextPath()%>/review/removeReview.jsp?orderNo=<%=review.getOrderNo()%>&productNo=<%=review.getProductNo()%>">삭제</a>
	</div>	
	<%}%>
</body>
</html>