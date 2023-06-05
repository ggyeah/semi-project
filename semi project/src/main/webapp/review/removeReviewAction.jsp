<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
// 세션 유효성 검사
if(session.getAttribute("loginId") != null) {
    String id = (String) session.getAttribute("loginId");
    String lastPw = request.getParameter("password");
    //디버깅
    System.out.println(id +"<removeReviewACtion sessionId");
    
 	// 요청값 객체에 묶어 저장
	Id loginId  = new Id();
	loginId.id = id;
	loginId.lastPw = lastPw;

	// 디버깅
	System.out.println(id + " <-- id");
	System.out.println(lastPw + " <-- lastPw");
	
	 IdDao idDao = new IdDao();
	 
    ResultSet loginRs = idDao.selectId(loginId);

    if (loginRs.next()) {
        // 세션 아이디와 입력된 비밀번호가 일치하면 리뷰 삭제 수행
        ReviewDao reviewDao = new ReviewDao();
        if (request.getParameter("orderNo") != null) {
            int orderNo = Integer.parseInt(request.getParameter("orderNo"));
            //디버깅
            System.out.println(orderNo +"<removeReviewACtion orderNo");       
			int row = reviewDao.removeReview(orderNo);
			System.out.println(row +"<removeReviewACtion row");  
            
            response.sendRedirect(request.getContextPath() + "/review/reviewListOne.jsp?orderNo=" + orderNo);
        }
    } else {
        // 세션 아이디와 입력된 비밀번호가 일치하지 않는 경우에 대한 처리
        // 예를 들어, 비밀번호가 잘못되었다는 메시지를 표시하거나 다른 동작을 수행할 수 있습니다.
    }
}
%>