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
	
	System.out.println(KIM+request.getParameter("cartNo")+" <-- cart/removeCartAction parameter cartNo"+RESET); //디버깅
	String loginId = (String)session.getAttribute("loginId");
	
	/* 유효성 검사 */
	if(request.getParameter("cartNo") == null
	|| request.getParameter("cartNo").equals("")){
		//받아온 cartNo가 없을 경우 List으로 redirect
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	System.out.println(KIM+cartNo+" <-- cart/removeCartAction parameter cartNo"+RESET); //디버깅
	
	/* 장바구니 번호 파라미터를 cart 클래스의 cart 객체 변수에 할당 */
	Cart cart = new Cart();
	cart.setCartNo(cartNo);
	
	/* 객체 생성 */
	//DB에 저장된 데이터를 삭제하는, removeCart 메서드를 사용하기 위해 Dao 사용을 선언
	CartDao cartDao = new CartDao();
	
	/* 장바구니 삭제 업데이트 */
	int row = cartDao.removeCart(cart.getCartNo());
	System.out.println(KIM+row+" <-- cart/removeCartAcion row"+RESET); //디버깅
	
	/* redirection */
	String msg = null;
	if(row == 0){
		// 삭제 실패 시 메시지 설정 및 장바구니 리스트로 redirect
		msg = URLEncoder.encode("삭제 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp?msg="+msg);
		return;
	} else {
		// 삭제 성공 시 메시지 설정 및 장바구니 리스트로 redirect
		msg = URLEncoder.encode("삭제 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp?msg="+msg);
		return;
	}
%>