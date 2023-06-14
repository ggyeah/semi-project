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
	response.setCharacterEncoding("utf-8");
	System.out.println(KIM+request.getParameter("addressNo")+"<--removeAddressAction parameter addressNo"+RESET);
	
	/* session 유효성 검사 */
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String loginId = (String)session.getAttribute("loginId");
	
	/* 유효성 검사 */
	if(request.getParameter("addressNo") == null){
		response.sendRedirect(request.getContextPath()+"/address/addressList.jsp");
		return;
	}
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	System.out.println(KIM+addressNo+" <-- removeAddressAction parameter addressNo"+RESET); //디버깅
	
	/* addressDao를 사용을 위한 선언 */
	AddressDao addressDao = new AddressDao();
	
	/* 배송지 삭제 */
	int row = addressDao.removeAddress(addressNo);
	System.out.println(KIM+row+" <-- removeAddressAction row"+RESET); //디버깅
	
	/* redirection */
	String msg = null;
	if(row == 0){
		// 삭제 실패 시 메시지 설정 및 address 리스트로 redirect
		msg = URLEncoder.encode("삭제 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/address/addressList.jsp?msg="+msg);
		return;
	} else {
		// 삭제 성공 시 메시지 설정 및 address 리스트로 redirect
		msg = URLEncoder.encode("삭제 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/address/addressList.jsp?msg="+msg);
		return;
	}
%>