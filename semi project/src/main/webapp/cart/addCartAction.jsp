<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*" %>
<%
   /* 디버깅 색깔 지정 */
   // ANSI CODE   
    final String RESET = "\u001B[0m"; 
    final String LIM = "\u001B[41m";
    final String KIM = "\u001B[42m";
    final String SONG = "\u001B[43m";
    final String YANG = "\u001B[44m";
   
   /* 인코딩 설정 */
   request.setCharacterEncoding("utf-8");
   
   /* 로그인 여부에 따라 분기 */
   
   // 1. 비로그인 사용자의 경우, 세션에 장바구니 데이터를 추가
   if (session.getAttribute("loginId") == null) {
	   if(request.getParameter("productNo")==null){
		   response.sendRedirect(request.getContextPath()+"/home.jsp");
		   return;
	   }
    int productNo = Integer.parseInt(request.getParameter("productNo"));

    // 현재 날짜/시간
    LocalDateTime now = LocalDateTime.now();
    // 형식화된 날짜/시간 문자열 생성
    String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    // 세션에서 기존의 장바구니 데이터 가져오기
    HashMap<Integer, Cart> sessionCartMap = (HashMap<Integer, Cart>) session.getAttribute("sessionCartMap");
    
    if (sessionCartMap == null) {
        // 기존 장바구니 데이터가 없으면 새로운 HashMap 생성
        sessionCartMap = new HashMap<>();
    }

    // 해당 상품 번호로 장바구니에 담긴 상품 수량 확인
    if (sessionCartMap.containsKey(productNo)) { // 같은 상품이 이미 담겨있으면
       String msg = URLEncoder.encode("이미 장바구니에 존재하는 상품입니다", "utf-8");
      response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo+"&msg="+msg);
       return;
    } else {
        // 상품이 장바구니에 없으면 새로운 Cart 객체 생성 및 추가
        Cart cart = new Cart();
        cart.setProductNo(productNo);
        cart.setCartCnt(1);
        cart.setCreatedate(formattedNow);
        cart.setUpdatedate(formattedNow);
        sessionCartMap.put(productNo, cart);
    }

    // 수정된 장바구니 데이터를 세션에 저장
    session.setAttribute("sessionCartMap", sessionCartMap);
    response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
   

   } else { //2. 로그인한 사용자의 경우 장바구니 데이터를 DB에 추가
      String loginId = (String)session.getAttribute("loginId");
      
      /* 유효성 검사 */
      if(request.getParameter("productNo") == null
      || request.getParameter("productNo").equals("")){
      //받아온 데이터가 없을 경우 productListOne으로 redirect
      int productNo = Integer.parseInt(request.getParameter("productNo"));
      response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo);
      return;
      }
      
      int productNo = Integer.parseInt(request.getParameter("productNo"));
      String id = (String)session.getAttribute("loginId");
      
      //디버깅
      System.out.println(KIM+productNo+" <-- cart/addCartAction parameter productNo"+RESET);
      System.out.println(KIM+id+" <-- cart/addCartAction parameter id"+RESET);
      
      /* 객체에 추가할 데이터 담기 */
      Cart cart = new Cart();
      cart.setProductNo(productNo);
      cart.setId(id);
      
      CartDao cartDao = new CartDao();
      
      /* DB에 로그인자 장바구니 데이터 추가 */
      int ckRow = cartDao.checkCart(cart, loginId);
      System.out.println(KIM+ckRow+" <-- cart/addCartAcion ckRow"+RESET);
      
      
      /* redirection */
      String msg = null;
      if(ckRow > 0){
         msg = URLEncoder.encode("이미 장바구니에 존재하는 상품입니다.", "utf-8");
         System.out.println(KIM+"장바구니 중복"+RESET);
         response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo+"&msg="+msg);
         return;
      }
      
      int row = cartDao.addCart(cart);
      System.out.println(KIM+row+" <-- cart/addCartAcion row"+RESET);
      if(row == 0){
         // 추가 실패 시 메시지 설정 및 상품 리스트로 redirect
         msg = URLEncoder.encode("장바구니 추가 실패", "utf-8");
         response.sendRedirect(request.getContextPath()+"/product/productListOne.jsp?productNo="+productNo+"&msg="+msg);
         return;
      } else {
         // 추가 성공 시 장바구니 리스트로 redirect
         System.out.println(KIM+"장바구니 추가 성공"+RESET);
         response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
         return;
      }
   }
%>