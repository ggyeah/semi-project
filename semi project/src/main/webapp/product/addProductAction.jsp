<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
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
   	
	
	/* 상품 정보 요청값 유효성검사 */
	
	
	/* 상품이미지 정보 요청값 유효성검사 */
	
	
	//---------- 상품추가 ----------//
	// 유효성 검사 통과하면 -> 폼에서 입력된 상품 정보를 가져와서 변수에 저장
	String categoryName = mRequest.getParameter("categoryName");
	String productName = mRequest.getParameter("productName");
	int productPrice = Integer.parseInt(mRequest.getParameter("productPrice"));
	String productStatus = mRequest.getParameter("productStatus");
	int productStock = Integer.parseInt(mRequest.getParameter("productStock"));
	String productInfo = mRequest.getParameter("productInfo");
	
	// Product 객체에 값 설정
	product.setCategoryName(categoryName);
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductStatus(productStatus);
	product.setProductStock(productStock);
	product.setProductInfo(productInfo);	
	// 디버깅
	System.out.println(SONG + categoryName + " <-- addProductAction 변수 categoryName" + RESET);
	System.out.println(SONG + productName + " <-- addProductAction 변수 productName" + RESET);
	System.out.println(SONG + productPrice + " <-- addProductAction 변수 productPrice" + RESET);
	System.out.println(SONG + productStatus + " <-- addProductAction 변수 productStatus" + RESET);
	System.out.println(SONG + productStock + " <-- addProductAction 변수 productStock" + RESET);
	System.out.println(SONG + productInfo + " <-- addProductAction 변수 productInfo" + RESET);
	
	
	//---------- 상품이미지추가 ----------//
	// 상품 추가 메소드 호출
	int[] rowAndKey = productDao.addProduct(product);
	int addProductRow = rowAndKey[0]; 	// 상품 추가 결과의 행 수
	if(addProductRow == 1) {			// 상품 추가 성공 시, 상품번호를 가져와서 이미지를 추가할 수 있도록
		System.out.println(SONG + addProductRow + " <-- addProductAction 상품추가성공" + RESET);
		if(mRequest.getFilesystemName("productImg") != null){
		
			// 유효성 검사 통과하면 -> 폼에서 입력된 상품이미지 정보를 가져와서 변수에 저장
			int productNo = rowAndKey[1];	// GeneratedKeys로 상품 번호 가져오기
			String type = mRequest.getContentType("productImg");
		   	String originFilename = mRequest.getOriginalFileName("productImg");
		   	String saveFilename = mRequest.getFilesystemName("productImg");
		
		   	System.out.println(SONG + productNo + " <-- addProductAction 변수 productNo" + RESET);
		   	System.out.println(SONG + type + " <-- addProductAction 변수 type" + RESET);
			System.out.println(SONG + originFilename + " <-- addProductAction 변수 originFilename" + RESET);
			System.out.println(SONG + saveFilename + " <-- addProductAction 변수 saveFilename" + RESET);
			
			productImg.setProductNo(productNo);
			productImg.setProductOriFilename(originFilename);
			productImg.setProductSaveFilename(saveFilename);
			productImg.setProductFiletype(type);
			
			int addProductImgRow = productImgDao.addProductImg(productImg);
			if (addProductImgRow == 1) {
			    System.out.println(SONG + addProductImgRow + " <-- addProductAction 상품 이미지 추가 성공" + RESET);
			    response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
			    return;
			} else {
			    System.out.println(SONG + addProductImgRow + " <-- addProductAction 상품 이미지 추가 실패" + RESET);
			    response.sendRedirect(request.getContextPath()+"/product/addProduct.jsp");
			    return;
			}
		} response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
	} else {
		System.out.println(SONG + addProductRow + "<-- addProductAction 상품추가실패" + RESET);
		response.sendRedirect(request.getContextPath()+"/product/addProduct.jsp");
	}
%>