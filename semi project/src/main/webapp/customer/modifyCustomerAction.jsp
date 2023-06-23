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
		
		response.sendRedirect(request.getContextPath()+"/customer/employeesList.jsp");
		return;	
	}
	
	if(request.getParameter("cstmName") == null
		|| request.getParameter("cstmAddress") == null
		|| request.getParameter("cstmEmail") == null
		|| request.getParameter("cstmBirth") == null
		|| request.getParameter("cstmPhone") == null
		|| request.getParameter("cstmGender") == null
		|| request.getParameter("cstmName").equals("")
		|| request.getParameter("cstmAddress").equals("")
		|| request.getParameter("cstmEmail").equals("")
		|| request.getParameter("cstmBirth").equals("")
		|| request.getParameter("cstmPhone").equals("")
		|| request.getParameter("cstmGender").equals("")) {
		
		response.sendRedirect(request.getContextPath()+"/customer/modifyCustomer.jsp?id=" + request.getParameter("id"));
		return;		
	}
		
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String cstmName = request.getParameter("cstmName");
	String cstmAddress = request.getParameter("cstmAddress");
	String cstmEmail = request.getParameter("cstmEmail");
	String cstmBirth = request.getParameter("cstmBirth");
	String cstmPhone = request.getParameter("cstmPhone");
	String cstmGender = request.getParameter("cstmGender");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- modifyCustomerAction id" + RESET);
	System.out.println(YANG + cstmName + " <-- modifyCustomerAction cstmName" + RESET);
	System.out.println(YANG + cstmAddress + " <-- modifyCustomerAction cstmAddress" + RESET);
	System.out.println(YANG + cstmEmail + " <-- modifyCustomerAction cstmEmail" + RESET);
	System.out.println(YANG + cstmBirth + " <-- modifyCustomerAction cstmBirth" + RESET);
	System.out.println(YANG + cstmPhone + " <-- modifyCustomerAction cstmPhone" + RESET);
	System.out.println(YANG + cstmGender + " <-- modifyCustomerAction cstmGender" + RESET);
	
	// customer 객체 생성해 요청값 저장
	Customer customer = new Customer();
	customer.setId(id);
	customer.setCstmName(cstmName);
	customer.setCstmAddress(cstmAddress);
	customer.setCstmEmail(cstmEmail);
	customer.setCstmBirth(cstmBirth);
	customer.setCstmPhone(cstmPhone);
	customer.setCstmGender(cstmGender);
	
	// 클래스 객체 생성
	CustomerDao dao = new CustomerDao();
		
	// update 메서드 호출
	int modify = dao.updateCustomer(customer);
	
	if(modify == 1){
		System.out.println(YANG + "customer 수정 성공" + RESET);
	} 
		
	response.sendRedirect(request.getContextPath() + "/customer/customerOne.jsp?id=" + request.getParameter("id"));
	
%>