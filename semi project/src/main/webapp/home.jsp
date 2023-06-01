<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
</head>
<body>
<!------------ 상단 네비 바 ------------>
<div>
	상단 네비 바(메인메뉴) 들어올 곳
</div>




<!------------ 카테고리 ------------>
<div>
	카테고리 들어올 곳
</div>




<!------------ 로그인 ------------>
<div>
	로그인 폼 들어올 곳
</div>




<!------------ 최신상품 ------------>
<div>
	최신상품 createdate순 5개 들어올 곳
	
	<!-- 더보기 누르면 상품리스트로 가도록 -->
	<a href="<%=request.getContextPath()%>/product/productList.jsp">
	더보기
	</a>
</div>




<!------------ 하단 저작권 바 ------------>
<div>
	하단 저작권 바 들어올 곳
</div>


</body>
</html>