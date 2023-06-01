<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	/* 인코딩 설정 */
	request.setCharacterEncoding("utf-8");

	/* validation */
	//String id = (String)session.getAttribute("loginId");
	
	//로그인 상태가 아니면 id를 null로 설정
	//if(session.getAttribute("loginId") == null){
	//	id = null;
	//}
	String id = "user1";
	
	// CartDao 객체 생성
	CartDao cartDao = new CartDao();
	// 장바구니 조회
	ArrayList<Cart> cartList = cartDao.selectCart(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CartList</title>
<style>
   table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<div><!-- 수정/삭제(실패/성공) 메세지 -->
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
	<!-- 장바구니 리스트 -->
	<h1>장바구니</h1>
	<%
		if(cartList.isEmpty()){
	%>
		<h2>장바구니가 없습니다.</h2>
	<%
		} else {
	%>
		<table>
			<tr>
				<th>cartNo</th>
				<th>productNo</th>
				<th>수량 수정</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>삭제</th>
			</tr>
	
			<% //Cart 클래스의 객체 c를 cartList에서 가져와 반복 처리
				for(Cart c : cartList){
			%>
			<tr>
				<td><%=c.getCartNo()%></td>
				<td><%=c.getProductNo()%></td>
				<td>
					<form action="modifyCartAction.jsp" method="post">
						<input type="hidden" name="cartNo" value="<%=c.getCartNo()%>">
						<input type="number" name="cartCnt" value="<%=c.getCartCnt()%>">
						<input type="submit" value="수정">
					</form>
				</td>	
				<td><%=c.getCreatedate()%></td>
				<td><%=c.getUpdatedate()%></td>
				<td>
					<form action="removeCartAction.jsp" method="post">
						<input type="hidden" name="cartNo" value="<%=c.getCartNo()%>">
						<input type="submit" value="삭제">
					</form>
				</td>
			</tr>
			<%
				}	
			%>
		</table>
	<%
		}
	%>
</body>
</html>