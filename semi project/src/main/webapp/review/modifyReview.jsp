<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ReviewDao reviewDao = new ReviewDao();
ReviewImgDao reviewImgDao = new ReviewImgDao();

Review review = new Review();
List<ReviewImg> reviewImgs = new ArrayList<>();

if (request.getParameter("orderNo") != null){
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo+"<- ㅡmodifyreview orderNo");
	review = reviewDao.reviewListOne(orderNo);
	 reviewImgs = reviewImgDao.getReviewImages(orderNo); 
 }


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyReview</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<h2>수정</h2>
<form action="<%=request.getContextPath()%>/review/modifyReviewAction.jsp" method="post" enctype="multipart/form-data">

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
              <th>제목</th>
              <td><input type= "text" name = "reviewTitle" value ="<%=review.getReviewTitle()%>"></td>
         </tr>
          <tr>
            <th>reviewImg(수정전 파일 : <%=reviewImgs.get(0).getReviewSaveFilename()%>)</th>
            <td>
               <input type="file" name="reviewImg">
            </td>
         </tr>
		<tr>
              <th>내용</th>
              <td><input type= "text" name = "reviewContent" value ="<%=review.getReviewContent()%>"></td>
           </tr>
		 <tr>
              <th>생성일</th>
              <td><%=review.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=review.getUpdatedate()%></td>
           </tr>
	<tr>
		<th>수정하시겠습니까?</th>
		<td><button type="submit" class="btn btn-danger"> 수정</button></td>
	</tr>
</table>
</form>

</body>
</html>