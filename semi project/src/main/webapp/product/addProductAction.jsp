<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 추가 가능
	 
	// 에러메시지 담을 때 사용할 변수
	String msg = null;

	/* 세션 유효성 검사 */
	
	
	
	/* 요청값 유효성검사 */
	
	
	
	// 유효성 검사 통과하면 -> 폼에서 입력된 상품 정보를 가져와서 변수에 저장
	String categoryName = request.getParameter("categoryName");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String productStatus = request.getParameter("productStatus");
	int productStock = Integer.parseInt(request.getParameter("productStock"));
	String productInfo = request.getParameter("productInfo");
	
	// Product 객체 생성 및 값 설정
	Product product = new Product();
	product.setCategoryName(categoryName);
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductStatus(productStatus);
	product.setProductStock(productStock);
	product.setProductInfo(productInfo);	
	
	// ProductDao 객체 생성 및 상품 추가 메소드 호출
	ProductDao productDao = new ProductDao();
	int addProductRow = productDao.addProduct(product);
	if(addProductRow == 1) {
		System.out.println(SONG + addProductRow + " <-- addProductAction 상품추가성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
	} else {
		System.out.println(SONG + addProductRow + "<-- addProductAction 상품추가실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/addProduct.jsp");
	}
%>