<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
PointHistoryDao pointHistoryDao = new PointHistoryDao();
int beginRow = 0;
int rowPerPage = 10;
String id = (String)session.getAttribute("loginId");
ArrayList<PointHistory> pList = pointHistoryDao.pointHIstoryList(beginRow, rowPerPage, id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>포인트</h2>
<table>
    <tr>
        <th>주문번호</th>
        <th>상품번호</th>
        <th>아이디</th>
        <th>+,-</th>
        <th>포인트</th>
        <th>포인트적립일</th>
    </tr>
    <% for (PointHistory pointHistory : pList) { %>
    <tr>
        <td><%=pointHistory.getOrderNo()%></td>
        <td><%=pointHistory.getPointNo()%></td>
        <td><%=pointHistory.getId()%></td>
        <td><%=pointHistory.getPointPm()%></td>
        <td><%=pointHistory.getPoint()%></td>
        <td><%=pointHistory.getCreatedate()%></td>
    </tr>
    <% } %>
</table>
</body>
</html>