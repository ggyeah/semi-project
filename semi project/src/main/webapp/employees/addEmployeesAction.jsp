<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	//요청값 유효성 검사
	String msg = null;
	if(request.getParameter("id") == null
		|| request.getParameter("id").equals("")) {
		msg = URLEncoder.encode("아이디를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployees.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("pw") == null
		|| request.getParameter("pw").equals("")) {
		msg = URLEncoder.encode("비밀번호를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployees.jsp?msg=" + msg);
		return;		
	}
	if(request.getParameter("ckPw") == null
		|| request.getParameter("ckPw").equals("")) {
		msg = URLEncoder.encode("비밀번호 확인을 입력해주세요", "utf-8");	
		response.sendRedirect(request.getContextPath()+"/employees/addEmployees.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("empName") == null
		|| request.getParameter("empName").equals("")) {
		msg = URLEncoder.encode("이름을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployees.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("empLevel") == null
		|| request.getParameter("empLevel").equals("")) {
		msg = URLEncoder.encode("관리자 레벨을 지정해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployees.jsp?msg=" + msg);
		return;	
	}
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String ckPw = request.getParameter("ckPw");
	String empName = request.getParameter("empName");
	int empLevel = Integer.parseInt(request.getParameter("empLevel"));
	
	// 비밀번호 일치여부
	if(!pw.equals(ckPw)) {
		msg = URLEncoder.encode("비밀번호가 서로 일치하지않습니다", "utf-8");
		response.sendRedirect(request.getContextPath() +"/employees/addEmployees.jsp?msg=" + msg);
		return;
	}
	
	// id_list, pw_history 추가
	// 요청값 객체에 묶어 저장
	Id addIdList = new Id();
	addIdList.id = id;
	addIdList.lastPw = pw;
	
	PwHistory addPwHistory = new PwHistory();
	addPwHistory.id = id;
	addPwHistory.pw = pw;
	
	// 클래스 객체 생성
	IdDao IdDao = new IdDao();
	
	// id_list insert 메서드 호출
	int addId = IdDao.insertId(addIdList);
	if(addId > 0){
		System.out.println(YANG + "employees id_list 추가 성공" + RESET);
	} 
	
	// pw_history insert 메서드 호출
	int addPw = IdDao.insertPw(addPwHistory);
	if(addPw == 1){
		System.out.println(YANG + "employees pw_history 추가 성공" + RESET);
	} 
	
	// employees 추가
	// 요청값 객체에 묶어 저장
	Employees addEmployees = new Employees();
	addEmployees.id = id;
	addEmployees.empName = empName;
	addEmployees.empLevel = empLevel;
	
	// 클래스 객체 생성
	EmployeesDao EmpDao = new EmployeesDao();
	
	// insert 메서드 호출
	int addEmp = EmpDao.insertEmployees(addEmployees);
	if(addEmp > 0){
		System.out.println(YANG + "employees 추가 성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/employees/employeesList.jsp");
	} 

%>