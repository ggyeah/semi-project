<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// (비)로그인 사용자 확인
	System.out.println(KIM+session.getAttribute("loginId")+" <-- mainMenu loginId"+RESET);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainMenu</title>
</head>
<body>
	<div>
<!-- 비로그인자/로그인자(일반 고객 회원/직원1/직원2) 조건에 따라 분기 -->	
	<!-------------------------- 1. 비로그인자 -------------------------->
		<%  // 1. loginId가 없는 사람
			if(session.getAttribute("loginId") == null) { // 비로그인 사용자
			System.out.println(KIM+session.getAttribute("loginId")+" <-- mainMenu loginId(비로그인자)"+RESET);
		%>
			<ul>
				<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
				<li><a href="<%=request.getContextPath()%>/cart/cartList.jsp">장바구니</a></li>
				<li><a href="<%=request.getContextPath()%>/id/login.jsp">로그인</a></li>
				<li><a href="<%=request.getContextPath()%>/customer/addCustomer.jsp">회원가입</a></li>
			</ul>
	<!--------------------------- 2. 로그인자 ---------------------------->	
		
		<%	// 2. loginId가 있는 사람(가입된 사람)
			} else if(session.getAttribute("loginId") != null){
				if(session.getAttribute("loginId").equals("admin")){ //loginId가 관리자2(최고위직)일 경우
		%>	
					<ul>
						<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/id/logoutAction.jsp">로그아웃</a></li>
						<li><a href="<%=request.getContextPath()%>/employees/employeesOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a></li>
						<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 관리</a></li>
						<li><a href="<%=request.getContextPath()%>/customer/customerList.jsp">회원 정보조회</a></li>
						<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp">직원 관리</a></li>
						<li><a href="<%=request.getContextPath()%>/orders/ordersEmpList.jsp">회원 주문리스트</a></li><!-- 배송상태 변경 -->
						<li><a href="<%=request.getContextPath()%>/discount/discountList.jsp">할인관리</a></li>
					</ul>
		<%
				} else if(session.getAttribute("loginId").equals("blue")){ //loginId가 관리자1(일반 직원)일 경우 *추후 level로 변경
		%>
					<ul>
						<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/id/logoutAction.jsp">로그아웃</a></li>
						<li><a href="<%=request.getContextPath()%>/employees/employeesOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a></li>
						<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 관리</a></li>
						<li><a href="<%=request.getContextPath()%>/customer/customerList.jsp">회원 정보 조회</a></li><!-- 조회만 가능 -->
					</ul>
		<%		
				} else { //loginId가 일반 고객 회원일 경우
		%>
					<ul>
						<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/id/logoutAction.jsp">로그아웃</a></li>
						<li><a href="<%=request.getContextPath()%>/customer/customerOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a></li>
						<li><a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp">나의 주문리스트</a></li><!-- 해당 고객의 주문 리스트만 보이도록 -->
						<li><a href="<%=request.getContextPath()%>/cart/cartList.jsp?id=<%=(String)session.getAttribute("loginId")%>">장바구니</a></li>
					</ul>
		<%			
				}
			}
		%>
	</div>
</body>
</html>