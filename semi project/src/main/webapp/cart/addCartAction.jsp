<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
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
	
	/* 로그인 여부에 따라 분기 */
	// 1. 비로그인 사용자의 경우, 세션 값에 장바구니 데이터를 추가
	if(session.getAttribute("loginId") == null){
		ArrayList<Cart> cartList = null; // ArrayList: 데이터 적재량에 따라 가변적으로 공간을 늘리거나 줄일 수 있음
			
			if(session.getAttribute("cartList") != null){
				cartList = (ArrayList<Cart>)session.getAttribute("cartList");
			} else {
				String id = (String)session.getAttribute("loginId");
				CartDao cartDao = new CartDao();
				cartList = cartDao.selectCart(id);
			}
		// 유효성 검사
		if(request.getParameter("product_no") == null
		|| request.getParameter("id") == null
		|| request.getParameter("cart_cnt") == null
		|| request.getParameter("product_no").equals("")
		|| request.getParameter("id").equals("")
		|| request.getParameter("cart_cnt").equals("")){
			//받아온 데이터가 없을 경우 productListOne으로 redirect
			int productNo = Integer.parseInt(request.getParameter("product_no"));
			response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo);
			return;
		}
		
		int productNo = Integer.parseInt(request.getParameter("product_no"));
		String id = (String)session.getAttribute("loginId");
		int cartCnt = Integer.parseInt(request.getParameter("cart_cnt"));
		
		//디버깅
		System.out.println(KIM+productNo+"<--addCartAction parameter productNo"+RESET);
		System.out.println(KIM+id+"<--addCartAction parameter id"+RESET);
		System.out.println(KIM+cartCnt+"<--addCartAction parameter cartCnt"+RESET);
		
		/* 객체에 추가할 데이터 담기 */
		Cart cart = new Cart();
		cart.setProductNo(productNo);
		cart.setId(id);
		cart.setCartCnt(cartCnt);

		/* 세션에 비로그인자 장바구니 데이터 추가 */
		CartDao cartDao = new CartDao();
        cartList = cartDao.addSessionCart(request, cartList, cart);
		
		/* redirection */
		// 추가될 시 장바구니 리스트로 redirect
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
		
	} else { //2. 로그인한 사용자의 경우 장바구니 데이터를 DB에 추가
		String loginId = (String)session.getAttribute("loginId");
		
		/* 유효성 검사 */
		if(request.getParameter("product_no") == null
		|| request.getParameter("id") == null
		|| request.getParameter("cart_cnt") == null
		|| request.getParameter("product_no").equals("")
		|| request.getParameter("id").equals("")
		|| request.getParameter("cart_cnt").equals("")){
		//받아온 데이터가 없을 경우 productListOne으로 redirect
		int productNo = Integer.parseInt(request.getParameter("product_no"));
		response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo);
		return;
		}
		
		int productNo = Integer.parseInt(request.getParameter("product_no"));
		String id = (String)session.getAttribute("loginId");
		int cartCnt = Integer.parseInt(request.getParameter("cart_cnt"));
		
		//디버깅
		System.out.println(KIM+productNo+"<--addCartAction parameter productNo"+RESET);
		System.out.println(KIM+id+"<--addCartAction parameter id"+RESET);
		System.out.println(KIM+cartCnt+"<--addCartAction parameter cartCnt"+RESET);
		
		/* 객체에 추가할 데이터 담기 */
		Cart cart = new Cart();
		cart.setProductNo(productNo);
		cart.setId(id);
		cart.setCartCnt(cartCnt);
		
		CartDao cartDao = new CartDao();
		
		/* DB에 로그인자 장바구니 데이터 추가 */
		int row = cartDao.addCart(cart);
		System.out.println(KIM+row+"<--addCartAcion row"+RESET);
		
		/* redirection */
		String msg = null;
		if(row == 0){
			// 추가 실패 시 메시지 설정 및 상품 리스트로 redirect
			msg = URLEncoder.encode("장바구니 추가 실패", "utf-8");
			response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo);
			return;
		} else {
			// 추가 성공 시 장바구니 리스트로 redirect
			response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
			return;
		}
	}
%>