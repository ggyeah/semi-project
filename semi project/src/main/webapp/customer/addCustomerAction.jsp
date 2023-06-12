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
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("pw") == null
		|| request.getParameter("pw").equals("")) {
		msg = URLEncoder.encode("비밀번호를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;		
	}
	if(request.getParameter("ckPw") == null
		|| request.getParameter("ckPw").equals("")) {
		msg = URLEncoder.encode("비밀번호 확인을 입력해주세요", "utf-8");	
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("cstmName") == null
		|| request.getParameter("cstmName").equals("")) {
		msg = URLEncoder.encode("이름을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("cstmAddress") == null
		|| request.getParameter("cstmAddress").equals("")) {
		msg = URLEncoder.encode("주소를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("cstmEmail") == null
		|| request.getParameter("cstmEmail").equals("")) {
		msg = URLEncoder.encode("이메일을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
		return;	
	}
	if(request.getParameter("cstmBirth") == null
			|| request.getParameter("cstmBirth").equals("")) {
			msg = URLEncoder.encode("생일을 입력해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
			return;	
	}
	if(request.getParameter("cstmPhone") == null
			|| request.getParameter("cstmPhone").equals("")) {
			msg = URLEncoder.encode("연락처를 입력해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
			return;	
	}
	if(request.getParameter("cstmGender") == null
			|| request.getParameter("cstmGender").equals("")) {
			msg = URLEncoder.encode("성별을 입력해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
			return;	
	}
	if(request.getParameter("cstmAgree") == null
			|| request.getParameter("cstmAgree").equals("")) {
			msg = URLEncoder.encode("약관 동의여부를 선택해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/addCustomer.jsp?msg=" + msg);
			return;	
	}
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String ckPw = request.getParameter("ckPw");
	String cstmName = request.getParameter("cstmName");
	String cstmAddress = request.getParameter("cstmAddress");
	String cstmEmail = request.getParameter("cstmEmail");
	String cstmBirth = request.getParameter("cstmBirth");
	String cstmPhone = request.getParameter("cstmPhone");
	String cstmGender = request.getParameter("cstmGender");
	String cstmAgree = request.getParameter("cstmAgree");
	
	// 비밀번호 일치여부
	if(!pw.equals(ckPw)) {
		msg = URLEncoder.encode("비밀번호가 서로 일치하지않습니다", "utf-8");
		response.sendRedirect(request.getContextPath() +"/customer/addCustomer.jsp?msg=" + msg);
		return;
	}
	// 약관 동의여부
	if(cstmAgree.equals("N")) {
		msg = URLEncoder.encode("회원가입을 하려면 약관에 동의 해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() +"/customer/addCustomer.jsp?msg=" + msg);
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
	if(addId == 1){
		System.out.println(YANG + "customer id_list 추가 성공" + RESET);
	} 
	
	// pw_history insert 메서드 호출
	int addPw = IdDao.insertPw(addPwHistory);
	if(addPw == 1){
		System.out.println(YANG + "customer pw_history 추가 성공" + RESET);
	} 
	
	// customer 추가
	// 요청값 객체에 묶어 저장
	Customer addCustomer = new Customer();
	addCustomer.id = id;
	addCustomer.cstmName = cstmName;
	addCustomer.cstmAddress = cstmAddress;
	addCustomer.cstmEmail = cstmEmail;
	addCustomer.cstmBirth = cstmBirth;
	addCustomer.cstmPhone = cstmPhone;
	addCustomer.cstmGender = cstmGender;
	addCustomer.cstmAgree = cstmAgree;
		
	// 클래스 객체 생성
	CustomerDao cstmDao = new CustomerDao();
		
	// insert 메서드 호출
	int addCstm = cstmDao.insertCustomer(addCustomer);
	if(addCstm == 1){
		System.out.println(YANG + "customer 추가 성공" + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} 
		
%>