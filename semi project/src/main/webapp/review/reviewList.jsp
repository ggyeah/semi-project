<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*" %>

<%
ReviewDao reviewDao = new ReviewDao();
int beginRow = 0;
int rowPerPage = 10;
int totalRow = reviewDao.reviewCnt();
// 페이징 추가 해야함
    ArrayList<Review> List = reviewDao.reviewList(beginRow, rowPerPage);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewlist</title>
</head>
<body>
 <h2 class="text-center">reviewlist</h2>
<table>
    <tr>
        <th>제목</th>
        <th>내용</th>
        <th>작성일</th>
        <th>수정일</th>
    </tr>
    <% for (Review review : List) { %>
    <tr>
        <td><%= review.getReviewTitle()%></td>
        <td><%= review.getReviewContent()%></td>
        <td><%= review.getCreatedate()%></td>
        <td><%= review.getUpdatedate()%></td>
    </tr>
    <% } %>
</table>

</body>
</html>