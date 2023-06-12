<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import ="vo.*" %>
<%

	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	//요청값 유효성 검사
	if(request.getParameter("id") == null
		|| request.getParameter("id").equals("")) {
			
		response.sendRedirect(request.getContextPath()+"/employees/employeesList.jsp");
		return;	
	}
	if(request.getParameter("active") == null
	|| request.getParameter("active").equals("")) {
			
	response.sendRedirect(request.getContextPath()+"/employees/removeEmployees.jsp?id=" + request.getParameter("id"));
	return;	
	}
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String active = request.getParameter("active");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- removeEmployeesAction id" + RESET);
	System.out.println(YANG + active + " <-- removeEmployeesAction active" + RESET);
	
	// idList 객체 생성해 요청값 저장
	Id idList = new Id();
	idList.setId(id);
	idList.setActive(active);

	// 클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
	
	// update 메서드 호출
	int remove = dao.updateEmpActive(idList);
	
	if(remove == 1){
		System.out.println(YANG + "employees 활성화여부 변경 성공" +RESET);
	} 
	
	response.sendRedirect(request.getContextPath() + "/employees/employeesList.jsp");
	
%>