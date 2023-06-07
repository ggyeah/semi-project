<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
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
	
	/* 로그인 확인 */
	if(session.getAttribute("loginId") == null){
		ArrayList<Cart> cartList = null;
		if(session.getAttribute("cart")!=null){
			cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		} else {
			int productNo = Integer.parseInt(request.getParameter("productNo"));
			// 비로그인자의 장바구니가 없을 시 productListOne으로 redirect
			response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo);
		}
		
		// 유효성 검사
		if(request.getParameter("cartNo") == null
		|| request.getParameter("cartCnt") == null){
			//받아온 데이터가 없을 경우 List로 redirect
			response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
			return;
		}
		
		/* 장바구니 번호와 수량 파라미터 가져오기 */
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
		System.out.println(KIM+cartNo+" <-- cart/modifyCartAction parameter cartNo"+RESET);
		System.out.println(KIM+cartCnt+" <-- cart/modifyCartAction parameter cartCnt"+RESET);
		
		/* Cart 클래스에 객체를 생성하여 수정할 번호와 수량을 저장 */
		Cart updatedCart = new Cart();
		updatedCart.setCartNo(cartNo);
		updatedCart.setCartCnt(cartCnt);
		
		/* 장바구니 수정 업데이트 */
		CartDao cartDao = new CartDao();
		cartList = cartDao.modifySessionCart(request, cartList, updatedCart); //cartDao의 modifySessionCart 메서드 사용
        session.setAttribute("cartList", cartList);
		
		/* redirection */
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
		
	} else { //2. 로그인한 사용자의 경우 DB에 저장된 장바구니 데이터를 삭제
		String loginId = (String)session.getAttribute("loginId");
		
		/* 유효성 검사 */
		if(request.getParameter("cartNo") == null
		|| request.getParameter("cartCnt") == null
		|| request.getParameter("cartNo").equals("")
		|| request.getParameter("cartCnt").equals("")){
			//받아온 데이터가 없을 경우 List로 redirect
			response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
			return;
		}
		
		/* 장바구니 번호와 수량 파라미터 가져오기 */
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
		System.out.println(KIM+cartNo+" <-- cart/modifyCartAction parameter cartNo"+RESET);
		System.out.println(KIM+cartCnt+" <-- cart/modifyCartAction parameter cartCnt"+RESET);
		
		/* 객체 생성 */
		//DB에 저장된 데이터를 수정하는, modifyCart 메서드를 사용하기 위해 Dao 사용을 선언
		CartDao cartDao = new CartDao();
		Cart cart = new Cart();
		cart.setCartNo(cartNo); // Cart 객체에 수정된 번호와 수량을 입력
		cart.setCartCnt(cartCnt);	
		
		/* DB에 저장된 장바구니 데이터 업데이트 */
		int row = cartDao.modifyCart(cart);
		System.out.println(KIM+row+" <-- cart/modifyCartAcion row"+RESET);
		
		/* redirection */
		String msg = null;
		if(row == 0){
			// 업데이트 실패 시 메시지 설정 및 장바구니 리스트로 redirect
			msg = URLEncoder.encode("수량 수정 실패", "utf-8");
			response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp?msg="+msg);
			return;
		} else {
			// 업데이트 성공 시 메시지 설정 및 장바구니 리스트로 redirect
			msg = URLEncoder.encode("수량 수정 성공", "utf-8");
			response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp?msg="+msg);
			return;
		}
	}
%>