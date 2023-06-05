
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
//유효값 검사 
if (request.getParameter("qNo") != null
	&&request.getParameter("qCategory")!= null
	&& request.getParameter("qTitle") != null
	&& request.getParameter("qContent") != null) {
	//폼에서 전달된 파라미터 값 가져오기
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String qCategory = request.getParameter("qCategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	
	// 디버깅
	System.out.println(LIM+qNo+"modifyrquestion qNo");
	System.out.println(qCategory+"modifyrquestion qCategory");
	System.out.println(qTitle+"modifyrquestion qTitle");
	System.out.println(qContent+"modifyrquestion qContent"+RESET);
	
	//입력받은 값으로 Review 객체 생성
	Question question = new Question();
	question.setqNo(qNo);
	question.setqCategory(qCategory);
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	int row = questionDao.modifyQuestion(question); 

	response.sendRedirect(request.getContextPath() + "/question/questionListOne.jsp?qNo=" +qNo);
}


%>

