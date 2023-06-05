<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청분석 : 로그인 아이디가 관리자일때만 카테고리 삭제 가능

	// 에러메시지 담을 때 사용할 변수
	String msg = null;
	
	/* 세션 유효성 검사 */ 
	
	
	/* 요청값 유효성검사 */
	if(request.getParameter("removeCategoryName") == null 
			|| request.getParameter("removeCategoryName").equals("")) {
			msg = URLEncoder.encode("카테고리를 선택해 주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/category/removeCategory.jsp?msg=" + msg);
		return;
	}
	
	// 유효성 검사 통과하면 변수에 저장
	String removeCategoryName = request.getParameter("removeCategoryName");
	// 디버깅
	System.out.println(SONG + removeCategoryName + " <-- removeCategoryAction removeCategoryName");
	
	// CategoryDao 객체 생성
	CategoryDao ctgrDao = new CategoryDao();
	// category 객체 생성 및 요청값 저장
	Category category = new Category();
	category.setCategoryName(removeCategoryName);
	// 카테고리 삭제 메소드 호출
	int removeCategoryRow = ctgrDao.removeCategory(removeCategoryName);
	if(removeCategoryRow == 1) {
		System.out.println(SONG + removeCategoryRow + " <-- removeCategoryAction 카테고리삭제성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
	} else {
		System.out.println(SONG + removeCategoryRow + " <-- removeCategoryAction 카테고리삭제실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/category/removeCategory.jsp");
	}
%>	