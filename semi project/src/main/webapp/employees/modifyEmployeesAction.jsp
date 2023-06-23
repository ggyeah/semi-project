<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import ="vo.*" %>
<%

	// 인코딩
	request.setCharacterEncoding("UTF-8");

	//ANSI CODE	
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

	if(request.getParameter("empName") == null
		|| request.getParameter("empLevel") == null
		|| request.getParameter("empName").equals("")
		|| request.getParameter("empLevel").equals("")) {
	
		response.sendRedirect(request.getContextPath()+"/employees/modifyEmployees.jsp?id=" + request.getParameter("id"));
		return;	
	}
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String empName = request.getParameter("empName");
	int empLevel = Integer.parseInt(request.getParameter("empLevel"));

	// 요청값 디버깅
	System.out.println(YANG + id + " <-- modifyEmployeesAction id" + RESET);
	System.out.println(YANG + empName + " <-- modifyEmployeesAction empName" + RESET);
	System.out.println(YANG + empLevel + " <-- modifyEmployeesAction empLevel" + RESET);
	
	// employees 객체 생성해 요청값 저장
	Employees employees = new Employees();
	employees.setId(id);
	employees.setEmpName(empName);
	employees.setEmpLevel(empLevel);
	
	// 클래스 객체 생성
	EmployeesDao dao = new EmployeesDao();
	
	// update 메서드 호출
	int modify = dao.updateEmployees(employees);
	
	if(modify == 1){
		System.out.println(YANG + "employees 수정 성공" + RESET);
	} 
	
	response.sendRedirect(request.getContextPath() + "/employees/employeesList.jsp");
	

%>