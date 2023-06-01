<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	/* 디버깅 색깔 지정 */
	final String RESET = "\u001B[0m";
	final String KIM = "\u001B[42m";
	
	/* 인코딩 설정 */
	response.setCharacterEncoding("utf-8");
	
	/* validation */
	if(request.getParameter("cartNo") == null
		|| request.getParameter("cartNo").equals("")){
		//받아온 데이터가 없을 경우 List으로 redirect
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
		}
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	System.out.println(KIM+cartNo+"<--removeCartAction parameter cartNo"+RESET);
	
	/* 장바구니 번호 파라미터 가져와 cart 클래스 데이터 수정 */
	Cart cart = new Cart();
	cart.setCartNo(cartNo);
	
	/* 객체 생성 */
	CartDao cartDao = new CartDao();
	
	/* 장바구니 삭제 업데이트 */
	int row = cartDao.removeCart(cartNo);
	System.out.println(KIM+row+"<--removeCartAcion row"+RESET);
	
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