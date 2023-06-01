<%@page import="javax.print.attribute.standard.PresentationDirection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% 
request.setCharacterEncoding("utf-8");
ReviewDao reviewDao = new ReviewDao();
ReviewImgDao reviewImgDao = new ReviewImgDao();
//유효값 검사 
if (request.getParameter("orderNo")!= null
	&& request.getParameter("productNo") != null
	&& request.getParameter("reviewTitle") != null
	&& request.getParameter("reviewContent") != null){
//폼에서 전달된 파라미터 값 가져오기
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
int productNo = Integer.parseInt(request.getParameter("productNo"));
String reviewTitle = request.getParameter("reviewTitle");
String reviewContent = request.getParameter("reviewContent");


//디버깅 
System.out.println(orderNo+"addReview orderNo");
System.out.println(productNo+"addReview orderNo");
System.out.println(reviewTitle+"addReview orderNo");
System.out.println(reviewContent+"addReview orderNo");

//입력받은 값으로 Review 객체 생성
Review review = new Review();
	review.setOrderNo(orderNo);
	review.setProductNo(productNo);
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);

	 // 리뷰 및 리뷰 이미지 저장
    int row = reviewDao.addReview(review);
    if (row == 1) {
        System.out.println("리뷰 추가 성공");

    	String dir = request.getServletContext().getRealPath("/upload");
    	System.out.println(dir);
    	
    	int max = 10 * 1024 * 1024; 
    	
    	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
    	
    	String type = mRequest.getContentType("reviewImg");
    	String originFilename = mRequest.getOriginalFileName("reviewImg");
    	String saveFilename = mRequest.getFilesystemName("reviewImg");
    	
        Part reviewImgPart = request.getPart("reviewImg");
        if (reviewImgPart != null && reviewImgPart.getSize() > 0) {
            String originalFilename = reviewImgPart.getSubmittedFileName();
            String savedFilename = UUID.randomUUID().toString();
            String fileType = reviewImgPart.getContentType();

            ReviewImg reviewImg = new ReviewImg();
            reviewImg.setOrderNo(orderNo);
            reviewImg.setReviewOriFilename(originalFilename);
            reviewImg.setReviewSaveFilename(savedFilename);
            reviewImg.setReviewFiletype(fileType);

            int rowCount = reviewImgDao.addReviewImg(reviewImg);
            if (rowCount == 1) {
                System.out.println("리뷰 이미지 추가 성공");
            } else {
                System.out.println("리뷰 이미지 추가 실패");
            }
        }
    } else {
        System.out.println("리뷰 추가 실패");
    }
}

response.sendRedirect(request.getContextPath() + "/review/reviewList.jsp");
%>

