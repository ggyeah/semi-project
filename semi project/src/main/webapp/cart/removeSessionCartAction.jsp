<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
  int productNo = Integer.parseInt(request.getParameter("productNo"));

  // 현재 장바구니 세션 데이터 가져오기
  HashMap<Integer, Cart> sessionCartMap = (HashMap<Integer, Cart>) session.getAttribute("sessionCartMap");

  // 해당 상품 번호의 아이템 삭제
  sessionCartMap.remove(productNo);

  // 수정된 장바구니 데이터를 세션에 저장
  session.setAttribute("sessionCartMap", sessionCartMap);

  // 삭제 후 장바구니 페이지로 리다이렉트
  response.sendRedirect(request.getContextPath() + "/cart/cartList.jsp");
%>