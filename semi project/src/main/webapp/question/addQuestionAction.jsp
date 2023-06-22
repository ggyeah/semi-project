<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
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
QuestionDao questionDao = new QuestionDao();
// 유효값 검사 
if (request.getParameter("category")!= null
	|| request.getParameter("qTitle") != null
	|| request.getParameter("qContent")!= null) {
	//폼에서 전달된 파라미터 값 가져오기
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = request.getParameter("id");
	String qCategory = request.getParameter("qCategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	
	//디버깅 
	System.out.println(LIM + productNo+"addquestion productNo");
	System.out.println(id+"addquestion id");
	System.out.println(qCategory+"addquestion qCategory");
	System.out.println(qTitle+"addquestion qTitle");
	System.out.println(qContent+"addquestion qContent" + RESET);
	
	//입력받은 값으로 Question 객체 생성
	Question question = new Question();
	question.setProductNo(productNo);
	question.setId(id);
	question.setqCategory(qCategory);
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	
	int row = questionDao.addQuestion(question); 

    if (row == 1) {
        System.out.println("추가 성공");
    } else {
        System.out.println("추가실패");
    }
    
	response.sendRedirect(request.getContextPath() + "/product/productListOne.jsp?productNo="+productNo);
}
%>
