<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*" %>
<%
	/* 디버깅 색깔 지정 */
	final String RESET = "\u001B[0m";
	final String KIM = "\u001B[42m";
	
	/* 인코딩 설정 */
	request.setCharacterEncoding("utf-8");
	
	/* 로그인 확인 */
	// 1. 비로그인 사용자의 경우, 세션 값에 장바구니 데이터를 추가
	if(session.getAttribute("loginId") == null){
		Cart cart; // 데이터 적재량에 따라 가변적으로 공간을 늘리거나 줄일 수 있는 ArrayList를 사용
			if(session.getAttribute("cart") != null){
				cart = (Cart)session.getAttribute("cart");
			} else {
				cart = new Cart();
			}
		// 유효성 검사
		if(request.getParameter("product_no") == null
		|| request.getParameter("id") == null
		|| request.getParameter("cart_cnt") == null
		|| request.getParameter("product_no").equals("")
		|| request.getParameter("id").equals("")
		|| request.getParameter("cart_cnt").equals("")){
			
		//받아온 데이터가 없을 경우 productOne으로 redirect
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
		}
		int productNo = Integer.parseInt(request.getParameter("product_no"));
		String id = (String)session.getAttribute("loginId");
		int cartCnt = Integer.parseInt(request.getParameter("cart_cnt"));
		
		//디버깅
		System.out.println(KIM+productNo+"<--addCartAction parameter productNo"+RESET);
		System.out.println(KIM+id+"<--addCartAction parameter id"+RESET);
		System.out.println(KIM+cartCnt+"<--addCartAction parameter cartCnt"+RESET);
		
		/* 객체 추가할 데이터 담기 */
		Cart cart2 = new Cart();
		cart2.setProductNo(productNo);
		cart2.setId(id);
		cart2.setCartCnt(cartCnt);
		
		/* 세션에 장바구니 데이터 추가*/
		cart = cart2;
		session.setAttribute("cart", cart);
		
		/* redirection */
		response.sendRedirect(request.getContextPath() + "/cart/cartList.jsp");
		return;
}
	//2. 로그인한 사용자의 경우 데이터베이스에 추가
	String loginId = (String)session.getAttribute("loginId");
	
	/* 유효성 검사 */
	if(request.getParameter("product_no") == null
	|| request.getParameter("id") == null
	|| request.getParameter("cart_cnt") == null
	|| request.getParameter("product_no").equals("")
	|| request.getParameter("id").equals("")
	|| request.getParameter("cart_cnt").equals("")){
	//받아온 데이터가 없을 경우 productOne으로 redirect
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
	return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("product_no"));
	String id = (String)session.getAttribute("loginId");
	int cartCnt = Integer.parseInt(request.getParameter("cart_cnt"));
	
	//디버깅
	System.out.println(KIM+productNo+"<--addCartAction parameter productNo"+RESET);
	System.out.println(KIM+id+"<--addCartAction parameter id"+RESET);
	System.out.println(KIM+cartCnt+"<--addCartAction parameter cartCnt"+RESET);
	
	/* 객체 추가할 데이터 담기 */
	Cart cart = new Cart();
	cart.setProductNo(productNo);
	cart.setId(id);
	cart.setCartCnt(cartCnt);
	
	CartDao cartDao = new CartDao();
	
	/* 장바구니에 상품 추가 */
	int row = cartDao.addCart(cart);
	System.out.println(KIM+row+"<--addCartAcion row"+RESET);
	
	/* redirection */
	String msg = null;
	if(row == 0){
		// 추가 실패 시 메시지 설정 및 상품 리스트로 redirect
		msg = URLEncoder.encode("장바구니 추가 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	} else {
		// 추가 성공 시 장바구니 리스트로 redirect
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
%>