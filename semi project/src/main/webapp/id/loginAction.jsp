<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	//세션 유효성 검사
	if(session.getAttribute("loginId") != null) {
	response.sendRedirect(request.getContextPath()+"/home.jsp");
	return;
	}

	// 요청값 변수 선언
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
   
	// 디버깅
	System.out.println(YANG + id + " <-- id" + RESET);
   
	// 요청값 객체에 묶어 저장
	Id loginId = new Id();
	loginId.id = id;
	loginId.lastPw = pw;
	
	// sql 클래스 객체 생성
	IdDao dao = new IdDao();
   
	// 로그인 메서드 호출
	String login = dao.login(loginId);
	String lastLogin = null;
	
	// id, pw, active 확인
	String empCstm = null;
	if(login.equals("정상계정")){ // 정상계정이면 직원인지 고객인지 구분하는 메서드 호출
		empCstm = dao.selectEmpCstm(loginId);
		System.out.println(YANG + empCstm + RESET);
	} else if(login.equals("탈퇴계정")){
		System.out.println(YANG + loginId.id + " : 탈퇴회원"+ RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	} else if(login.equals("휴면계정")){
		System.out.println(YANG + loginId.id + " : 휴면계정"+ RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp"); // 휴면계정 푸는 창으로
		return;
	} else{
		System.out.println(YANG + loginId.id + " : 로그인 실패"+ RESET);
		response.sendRedirect(request.getContextPath()+"/id/login.jsp"); // id, pw 틀려서 로그인 실패시 로그인창으로
		return;
	}
	
	// 직원이면 로그인
	if(empCstm.equals("직원")){
		session.setAttribute("loginId", loginId.id);
		System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	
	// 고객이면 최근 방문 시간 체크하는메서드 호출
	}else if (empCstm.equals("고객")){
		lastLogin = dao.selectCstmLastLogin(loginId);
		System.out.println(YANG + lastLogin + RESET);	
		
		if(lastLogin.equals("휴면계정")){ // 마지막 방문일 6개월 이상이면 휴면처리(active Y -> N)
			System.out.println(YANG + loginId.id + " : 마지막 로그인 날짜 6개월 이상 -> 휴면처리"+ RESET);
			response.sendRedirect(request.getContextPath()+"/home.jsp"); // 휴면계정 푸는 창으로
		} else if(lastLogin.equals("정상계정")){ // 마지막 방문일 6개월 미만이면 로그인 성공 (마지막 방문일 현재시간으로 업데이트 -> 세션에 저장)
			session.setAttribute("loginId", loginId.id);
			System.out.println(YANG + "로그인 성공 세션정보 : " + session.getAttribute("loginId") + RESET);
			
			HashMap<Integer, Cart> sessionCartMap = (HashMap<Integer, Cart>) session.getAttribute("sessionCartMap");
            if (sessionCartMap != null) {
                for (Cart sessionCart : sessionCartMap.values()) {
                    Cart cart = new Cart();
                    cart.setProductNo(sessionCart.getProductNo());
                    cart.setId(id);
                   
                   CartDao cartDao = new CartDao();
                     
                     int row = cartDao.addCart(cart);
                   if(row == 0){
                      // 추가 실패 시 메시지 설정 및 상품 리스트로 redirect
                      String msg = URLEncoder.encode("장바구니 추가 실패", "utf-8");
                      response.sendRedirect(request.getContextPath()+"/home.jsp");
                      return;
                   } else {
                      // 추가 성공 시 장바구니 리스트로 redirect
                      System.out.println(KIM+"장바구니 추가 성공"+RESET);
                      response.sendRedirect(request.getContextPath()+"/home.jsp");
                   }
                   response.sendRedirect(request.getContextPath()+"/home.jsp");
                   return;
      			   }
   		 }
 	 }   
 }

%>