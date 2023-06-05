<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<% 
	//ANSI CODE	
	final String LIM = "\u001B[41m";
	final String RESET = "\u001B[0m"; 
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

    
    request.setCharacterEncoding("utf-8");
    ReviewDao reviewDao = new ReviewDao();
    ReviewImgDao reviewImgDao = new ReviewImgDao();
    String dir = request.getServletContext().getRealPath("/reviewImgUpload");
    System.out.println(dir +"< -- dir"); // getRealPath 실제위치
    
    int max = 10 * 1024 * 1024; // 100Mbyte
    
    MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
    // request 객체를 MultipartRequest는의 API를 사용할 수 있도록 랩핑
    // DefaultFileRenamePolicy: 업로드 폴더내 동일한 이름이 있으면 뒤에 숫자를 추가 
   	// new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
            
    // 요청값 유효성 검사 
    if (mRequest.getParameter("orderNo") != null
        && mRequest.getParameter("productNo") != null
        && mRequest.getParameter("reviewTitle") != null
        && mRequest.getParameter("reviewContent") != null) {
        
        // 폼에서 전달된 파라미터 값 가져오기
        int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
        int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
        String reviewTitle = mRequest.getParameter("reviewTitle");
        String reviewContent = mRequest.getParameter("reviewContent");
    
        // 디버깅 
        System.out.println(LIM+orderNo + "< -- modifyReview orderNo");
        System.out.println(productNo + "< -- modifyReview productNo");
        System.out.println(reviewTitle + "< -- modifyReview reviewTitle");
        System.out.println(reviewContent + "< -- modifyReview reviewContent");
    
        // 입력받은 값으로 Review 객체 생성
        Review review = new Review();
        review.setOrderNo(orderNo);
        review.setProductNo(productNo);
        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);
        
        // 리뷰 수정
        int row = reviewDao.modifyReview(review);
        
        // 이전 파일 삭제
        int deleteImgRow = reviewImgDao.deleteReviewImgFile(orderNo, dir);
        if (deleteImgRow == 1) {
            System.out.println("이전 파일 삭제 성공");
        } else {
            System.out.println("이전 파일 삭제 실패");
        }
        
        // 리뷰 이미지 수정
        if (mRequest.getFilesystemName("reviewImg") != null) {
            String type = mRequest.getContentType("reviewImg");
            String originFilename = mRequest.getOriginalFileName("reviewImg");
            String saveFilename = mRequest.getFilesystemName("reviewImg");
            
            ReviewImg reviewImg = new ReviewImg();
            reviewImg.setOrderNo(orderNo);
            reviewImg.setReviewOriFilename(originFilename);
            reviewImg.setReviewSaveFilename(saveFilename);
            reviewImg.setReviewFiletype(type);
            
            int rowCount = reviewImgDao.updateReviewImg(reviewImg);
            if (rowCount == 1) {
                System.out.println("리뷰 이미지 수정 성공");
            } else {
                System.out.println("리뷰 이미지 수정 실패" +RESET);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/review/reviewListOne.jsp?orderNo=" + orderNo);
    }
%>