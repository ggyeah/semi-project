<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*"%>
<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청분석 : 로그인 아이디가 관리자레벨2 일때만 상품 삭제 가능
	
	/* 세션 유효성 검사 */
	// 비밀번호확인 완성되면 코드 바꿔야함!!(세션아이디 값과 비밀번호를 가져와서 비교해야함)
	
	
	/* 요청값 유효성검사 */
	if(request.getParameter("productNo") == null  
		|| request.getParameter("productNo").equals("")) {
		// productList.jsp으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	// 유효성 검사를 통과하면 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// 디버깅
	System.out.println(SONG + productNo + " <-- removeProduct " + RESET);

	
	// 유효성 검사 통과하면 -> 폼에서 입력된 상품 정보를 가져와서 변수에 저장
	
	
	// ProductDao 및 Product 객체 생성 
	ProductDao productDao = new ProductDao();
	Product product = new Product();
	// ProductImgDao 및 ProductImg 객체 생성 
	ProductImgDao productImgDao = new ProductImgDao();
    ProductImg productImg = new ProductImg();
 	// getRealPath 실제위치
    String dir = request.getServletContext().getRealPath("/productImgUpload");
    System.out.println(SONG + dir +" <-- dir" + RESET); 
	
    // 상품이미지 삭제 메소드 호출
    int removeProductImgRow = productImgDao.removeProductImg(productNo, dir);
    if(removeProductImgRow == 1) {
    	System.out.println(SONG + removeProductImgRow + " <-- removeProductAction 상품이미지 삭제 성공" + RESET);
		
    	// 상품 삭제 메소드 호출
		int removeProductRow = productDao.removeProduct(productNo);
		if(removeProductRow == 1) {
			System.out.println(SONG + removeProductRow + " <-- removeProductAction 상품삭제성공" + RESET);
			response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		} else {
			System.out.println(SONG + removeProductRow + " <-- removeProductAction 상품삭제실패" + RESET);
			response.sendRedirect(request.getContextPath()+"/product/removeProduct.jsp?productNo="+productNo);
		}
    } else {
		System.out.println(SONG + removeProductImgRow + " <-- removeProductAction 상품이미지 삭제 실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/removeProduct.jsp?productNo="+productNo);
    }
%>