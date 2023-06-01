<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<% 
request.setCharacterEncoding("utf-8");
ReviewDao reviewDao = new ReviewDao();
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
	
	//입력받은 값으로 Review 객체 생성
	Review review = new Review();
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	int row = reviewDao.modifyReview(review); 
}



response.sendRedirect(request.getContextPath() + "/review/reviewList.jsp");
%>
