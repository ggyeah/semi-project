<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	/* 디버깅 색깔 지정 */
	final String RESET = "\u001B[0m";
	final String KIM = "\u001B[42m";
	
	/* 인코딩 설정 */
	request.setCharacterEncoding("utf-8");

	/* validation */
	// session - 세션값이 없다면 home으로 돌아가도록
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// request/response
	if(request.getParameter("cartNo") == null
	|| request.getParameter("cartCnt") == null){
		//받아온 데이터가 없을 경우 List로 redirect
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	
	/* 객체 생성 */
	CartDao cartDao = new CartDao();
	Cart cart = new Cart();
	
	/* 장바구니 번호와 수량 파라미터 가져오기 */
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	System.out.println(KIM+cartNo+"<--modifyCartAction parameter cartNo"+RESET);
	System.out.println(KIM+cartCnt+"<--modifyCartAction parameter cartCnt"+RESET);
	
	/* Cart 객체에 수정된 번호와 수량을 입력 */
	cart.setCartNo(cartNo);
	cart.setCartCnt(cartCnt);
	
	/* 장바구니 업데이트 */
	int row = cartDao.modifyCart(cart);
	System.out.println(KIM+row+"<--modifyCartAcion row"+RESET);
	
	/* redirection */
	String msg = null;
	if(row == 0){
		// 업데이트 실패 시 메시지 설정 및 장바구니 리스트로 redirect
		msg = URLEncoder.encode("수량 수정 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	} else {
		// 업데이트 성공 시 메시지 설정 및 장바구니 리스트로 redirect
		msg = URLEncoder.encode("수량 수정 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
%>