<%@page import="javax.print.attribute.standard.PresentationDirection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% 
	//ANSI CODE	
	final String LIM = "\u001B[41m";
	
	request.setCharacterEncoding("utf-8");
	ReviewDao reviewDao = new ReviewDao();
	ReviewImgDao reviewImgDao = new ReviewImgDao();	
    String dir = request.getServletContext().getRealPath("/reviewImgUpload");
   	System.out.println(dir);//getRealPath 실제위치
   	
   	int max = 10 * 1024 * 1024; // 100Mbyte
   	
   	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
   	//request 객체를 MultipartRequest는의 API를 사용할 수 있도록 랩핑
   	//DefaultFileRenamePolicy: 업로드 폴더내 동일한 이름이 있으면 뒤에 숫자를 추가 
    	
	//요청값 유효성 검사 
	if (mRequest.getParameter("orderNo")!= null
		&& mRequest.getParameter("productNo") != null
		&& mRequest.getParameter("reviewTitle") != null
		&& mRequest.getParameter("reviewContent") != null){
	//폼에서 전달된 파라미터 값 가져오기
	int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");

	//디버깅 
	System.out.println(orderNo+"addReview orderNo");
	System.out.println(productNo+"addReview productNo");
	System.out.println(reviewTitle+"addReview reviewTitle");
	System.out.println(reviewContent+"addReview reviewContent");

	//입력받은 값으로 Review 객체 생성
	Review review = new Review();
	review.setOrderNo(orderNo);
	review.setProductNo(productNo);
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	 // 리뷰 및 리뷰 이미지 저장
    int row = reviewDao.addReview(review);
	
    if (row == 1) { //1) 리뷰저장이 안료되면
        System.out.println("리뷰 추가 성공");
	// 2) 리뷰이미지 저장
    // 원본 request를 객체를 cos api로 랩핑
    // new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
    //요청값 유효성 검사 
	if (mRequest.getFilesystemName("reviewImg") != null){
    	String type = mRequest.getContentType("reviewImg");
    	String originFilename = mRequest.getOriginalFileName("reviewImg");
    	String saveFilename = mRequest.getFilesystemName("reviewImg");
    	
        ReviewImg reviewImg = new ReviewImg();
        reviewImg.setOrderNo(orderNo);
        reviewImg.setReviewOriFilename(originFilename);
        reviewImg.setReviewSaveFilename(saveFilename);
        reviewImg.setReviewFiletype(type);

            int rowCount = reviewImgDao.addReviewImg(reviewImg);
            if (rowCount == 1) {
                System.out.println("리뷰 이미지 추가 성공");
            } else {
                System.out.println("리뷰 이미지 추가 실패");
            }
    } else {
        System.out.println("리뷰 추가 실패");
    }
    }
}
response.sendRedirect(request.getContextPath() + "/review/reviewList.jsp");
%>

