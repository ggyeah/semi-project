<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	/* 인코딩 설정 */
	request.setCharacterEncoding("utf-8");

	/* 유효성 검사 */
	String loginId = (String)session.getAttribute("loginId");
	
	// CartDao 객체 생성
	CartDao cartDao = new CartDao();
	
	ArrayList<Cart> cartList = null; //장바구니 목록을 저장할 ArrayList 생성 및 초기화
	
	/* 로그인/비로그인 사용자의 장바구니 조회 목록 분기 */
	//1. 비로그인 사용자: session ArrayList<Cart>로 목록을 생성 및 조회
	if(session.getAttribute("loginId") == null){
		cartList = (ArrayList<Cart>) session.getAttribute("cartList");
		System.out.println(KIM+cartList+" <-- cart/cartList 비로그인 사용자의 장바구니"+RESET);
	} else {//2. 로그인 사용자: DB에 저장된 장바구니 조회
		cartList = cartDao.selectCart(loginId);
		System.out.println(KIM+cartList+" <-- cart/cartList 로그인 사용자의 장바구니"+RESET);
	}
	
	//String id = "user1"; //테스트용 코드. 이것만 실행될 시 loginId가 user1이 아니고, 일반 id 변수에 user1이 들어간 거니까 수정/삭제가 되지 않는다.
	
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
<!----------------------- 수정/삭제(실패/성공) 메세지 ----------------------->
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
<!----------------------- 장바구니 리스트 ------------------------->
	<h1>장바구니</h1>
	<%  //cartList에 담긴 상품이 없을 때 메세지 출력
		if(cartList == null || cartList.isEmpty()){
	%>
		<h2>장바구니가 없습니다.</h2>
	<%
		} else {
	%>
		<table>
			<tr>
				<th>장바구니 번호</th>
				<th>상품 번호</th>
				<th>수량 수정</th><!-- 버튼 클릭시 수정 -->
				<th>생성일</th>
				<th>수정일</th>
				<th>취소</th>
				<th>주문<th>
			</tr>
	
			<% //Cart 클래스의 객체 c를 cartList에서 가져와 반복 처리
				for(Cart c : cartList){
			%>
			<!-- 수정/삭제를 위해 필요한 값은 hidden으로 넘김 -->
			<tr>
				<td><%=c.getCartNo()%></td>
				<td><%=c.getProductNo()%></td>
				<td>
					<form action="modifyCartAction.jsp" method="post">
						<input type="hidden" name="id" value="<%=c.getId()%>">
						<input type="hidden" name="cartNo" value="<%=c.getCartNo()%>">
						<input type="hidden" name="productNo" value="<%=c.getProductNo()%>">
						<input type="number" name="cartCnt" value="<%=c.getCartCnt()%>">
						<input type="hidden" name="createdate" value="<%=c.getCreatedate()%>">
						<input type="hidden" name="updatedate" value="<%=c.getUpdatedate()%>">
						<input type="submit" value="수정">
					</form>
				</td>	
				<td><%=c.getCreatedate()%></td>
				<td><%=c.getUpdatedate()%></td>
				<td>
					<form action="removeCartAction.jsp" method="post">
					<input type="hidden" name="id" value="<%=c.getId()%>">
						<input type="hidden" name="cartNo" value="<%=c.getCartNo()%>">
						<input type="hidden" name="productNo" value="<%=c.getProductNo()%>">
						<input type="hidden" name="cartCnt" value="<%=c.getCartCnt()%>">
						<input type="hidden" name="createdate" value="<%=c.getCreatedate()%>">
						<input type="hidden" name="updatedate" value="<%=c.getUpdatedate()%>">
						<input type="submit" value="삭제">
					</form>
				</td>
			
<!--[시작]--------------------- 주문하기 버튼 ----------------------->
	<!-- 비로그인자/로그인자(일반 고객 회원/직원1/직원2) 조건에 따라 회원가입/고객주문/직원주문 페이지로 이동 -->
		<%	// 1. 비로그인자: loginId가 없을 경우
			if(session.getAttribute("loginId") == null){ 
		%>
				<td><a type="button" href="<%=request.getContextPath()%>/id/login.jsp">주문하기</a></td><!-- 로그인 페이지로 이동 -->
		<%
			// 2. 로그인자: loginId가 있을 경우(가입된 사람)
			  } else if(session.getAttribute("loginId") != null){ 
				  // 2-1. loginId가 있고, loginId가 관리자1,2인 경우: Home, 마이페이지, 직원관리
				  if(session.getAttribute("loginId").equals("admin") 
				  || session.getAttribute("loginId").equals("blue")){ 
		%>
					<td>
						<form action="<%=request.getContextPath()%>/orders/addOrders.jsp" method="post">
							<input type="hidden" name="productNo" value="<%=c.getProductNo()%>">
							<input type="hidden" name="id" value="<%=c.getId()%>">
							<input type="submit" value="주문하기">
						</form>
					</td>
		<%			// 2-2. loginId가 일반 고객 회원일 경우: Home, 장바구니, 마이페이지	
			  		} else { 
		%>	  			
				  		<td>
							<form action="<%=request.getContextPath()%>/orders/addOrders.jsp" method="post">
								<input type="hidden" name="productNo" value="<%=c.getProductNo()%>">
								<input type="hidden" name="id" value="<%=c.getId()%>">
								<input type="submit" value="주문하기">
							</form>
						</td>
		<%				
			  		}
			 }
		%>
				</tr>
		
<!--[끝]--------------------- 주문하기 버튼 ----------------------->		
		
	<%	
		   }
	%>
		</table>
	<%		
		}
	%>
</body>
</html>