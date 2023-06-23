<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.util.*" %>
<%

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
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
	String msg = null;
	if(addCstm == 1){
		System.out.println(YANG + "customer 추가 성공" + RESET);
		// 회원가입 시 session cart 값 받아놓은 후 삭제
		HashMap<Integer, Cart> sessionCartMap = (HashMap<Integer, Cart>) session.getAttribute("sessionCartMap");
          if (sessionCartMap != null) {
              for (Cart sessionCart : sessionCartMap.values()) {
                  Cart cart = new Cart();
                  cart.setProductNo(sessionCart.getProductNo());
                  cart.setId(id);
                 
                 CartDao cartDao = new CartDao();
                   
                 int row = cartDao.addCart(cart);
                 if(row == 0){
                    // 추가 실패 
                    msg = URLEncoder.encode("장바구니 추가 실패", "utf-8");
                    return;
                 } else {
                    // 추가 성공
                    System.out.println(KIM+"장바구니 추가 성공"+RESET);
                    System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
                    response.sendRedirect(request.getContextPath()+"/home.jsp");
                 
                 }   
               }
      		 session.removeAttribute("sessionCartMap"); // 해시맵 세션값 비우기
		     response.sendRedirect(request.getContextPath()+"/home.jsp");
		     return;
          }
          response.sendRedirect(request.getContextPath()+"/home.jsp");
     } 
%>