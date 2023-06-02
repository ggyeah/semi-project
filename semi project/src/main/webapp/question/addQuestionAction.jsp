<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%@ page import="java.util.*"%>
<% 
request.setCharacterEncoding("utf-8");
QuestionDao questionDao = new QuestionDao();
// 유효값 검사 
if (request.getParameter("category")!= null
	|| request.getParameter("qTitle") != null
	|| request.getParameter("qContent")!= null) {
	//폼에서 전달된 파라미터 값 가져오기
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = request.getParameter("id");
	String qCategory = request.getParameter("qcategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	
	//디버깅 
	System.out.println(productNo+"addquestion productNo");
	System.out.println(id+"addquestion id");
	System.out.println(qCategory+"addquestion qCategory");
	System.out.println(qTitle+"addquestion qTitle");
	System.out.println(qContent+"addquestion qContent");
	
	//입력받은 값으로 Question 객체 생성
	Question question = new Question();
	question.setProductNo(productNo);
	question.setId(id);
	question.setqCategory(qCategory);
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	int row = questionDao.addQuestion(question); 

	response.sendRedirect(request.getContextPath() + "/product/productListOne.jsp?productNo="+productNo);
}
%>
