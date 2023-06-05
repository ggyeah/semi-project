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
	
	// 요청분석 : 로그인 아이디가 관리자일때만 카테고리 수정 가능
	 
	// 에러메시지 담을 때 사용할 변수
	String msg = null;

	/* 세션 유효성 검사 */
		
		
	/* 요청값 유효성 검사 */
	if(request.getParameter("crntCategoryName") == null  
		|| request.getParameter("crntCategoryName").equals("")) {
	} else if (request.getParameter("newCategoryName") == null 
		|| request.getParameter("newCategoryName").equals("")) {
		// categoryList.jsp으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
		return;
	}
	// 유효성 검사를 통과하면 변수에 저장
	String crntCategoryName = request.getParameter("crntCategoryName");
	String newCategoryName = request.getParameter("newCategoryName");
	// 디버깅
	System.out.println(SONG + crntCategoryName + " <-- modifyCategoryAction crnt" + RESET);	
	System.out.println(SONG + newCategoryName + " <-- modifyCategoryAction new" + RESET);

	// CategoryDao 객체 생성
	CategoryDao ctgrDao = new CategoryDao();
	// category 객체 생성 및 요청값 저장
	Category category = new Category();
	category.setCategoryName(crntCategoryName);
	int modifyCategoryRow = ctgrDao.modifyCategory(crntCategoryName, newCategoryName);
	if(modifyCategoryRow == 1) {
		System.out.println(SONG + modifyCategoryRow + " <-- modifyCategoryAction 카테고리수정성공" + RESET);
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
    } else {
    	System.out.println(SONG + modifyCategoryRow + " <-- modifyCategoryAction 카테고리수정실패" + RESET);
        response.sendRedirect(request.getContextPath() + "/category/modifyCategoryForm.jsp?msg=" + msg);
    }
%>