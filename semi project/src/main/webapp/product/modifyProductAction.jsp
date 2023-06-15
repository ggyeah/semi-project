<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
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
	
	
	
	ProductDao productDao = new ProductDao();
	Product product = new Product();
	ProductImgDao productImgDao = new ProductImgDao();
    ProductImg productImg = new ProductImg();
    String dir = request.getServletContext().getRealPath("/productImgUpload");
  	// getRealPath 실제위치
    System.out.println(SONG + dir + RESET);
   	
 	// request객체를 MultipartRequest의 API를 사용할 수 있도록 랩핑 
 	// new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
	// DefaultFileRenamePolicy() 파일 중복이름정책 : 업로드 폴더내 동일한 이름이 있으면 뒤에 숫자를 추가
   	int max = 10 * 1024 * 1024; // 최대파일사이즈byte : 100Mbyte
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
   	
	
	
	
	/* 요청값 유효성검사 */
	
	
	
	// 유효성 검사 통과하면 -> 폼에서 입력된 상품 정보를 가져와서 변수에 저장
	String categoryName = request.getParameter("categoryName");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String productStatus = request.getParameter("productStatus");
	int productStock = Integer.parseInt(request.getParameter("productStock"));
	String productInfo = request.getParameter("productInfo");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 디버깅
	System.out.println(SONG + categoryName + RESET);
	System.out.println(SONG + productName + RESET);
	System.out.println(SONG + productPrice + RESET);
	System.out.println(SONG + productStatus + RESET);
	System.out.println(SONG + productStock + RESET);
	System.out.println(SONG + productInfo + RESET);
	System.out.println(SONG + productNo + RESET);

	
	//---------- 상품수정 ----------//
	// Product 객체에 요청값 저장
	product.setCategoryName(categoryName);
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductStatus(productStatus);
	product.setProductStock(productStock);
	product.setProductInfo(productInfo);	
	product.setProductNo(productNo);
	
	// 디버깅
	System.out.println(SONG + product.getCategoryName() + RESET);
	System.out.println(SONG + product.getProductName() + RESET);
	System.out.println(SONG + product.getProductPrice() + RESET);
	System.out.println(SONG + product.getProductStatus() + RESET);
	System.out.println(SONG + product.getProductStock() + RESET);
	System.out.println(SONG + product.getProductInfo() + RESET);

	
	// 상품 수정 메소드 호출
	int modifyProductRow = productDao.modifyProduct(product);
	if(modifyProductRow == 1) {
		System.out.println(SONG + modifyProductRow + " <-- modifyProductAction 상품수정성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
	} else {
		System.out.println(SONG + modifyProductRow + " <-- modifyProductAction 상품수정실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/modifyProduct.jsp");
	}
%>