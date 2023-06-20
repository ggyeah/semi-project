<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
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

   /* 유효성 검사 */
   String loginId = (String)session.getAttribute("loginId");
   
   // CartDao 객체 생성
   CartDao cartDao = new CartDao();
   
   ArrayList<Cart> cartList = null; //장바구니 목록을 저장할 ArrayList 생성 및 초기화
   
  // DB에 저장된 장바구니 조회
   cartList = cartDao.selectCart(loginId);
   System.out.println(KIM+(cartList!=null?true:false)+" <-- cart/cartList 장바구니"+RESET);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CartList</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(document).on("click", ".remove-cart", function(e) {
      e.preventDefault();
      if (confirm("정말 삭제하시겠습니까?")) {
        var deleteLink = $(this);
        $.get(deleteLink.attr("href"), function() {
          deleteLink.closest("tr").remove();
          location.reload(); // 삭제 후에 화면을 다시 로드
        }).fail(function() {
          alert("삭제에 실패했습니다. 다시 시도해주세요.");
        });
      }
    });
  });
</script>
<style>
   table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ogani | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
</head>
<body>
<!-- 상단 네비게이션 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<!----------------------- 수정/삭제(실패/성공) 메세지 ----------------------->
   <div>
         <%
            if(request.getParameter("msg")!=null){
         %>
            <%=request.getParameter("msg")%>
         <%
            }
         %>      
   </div>
<!--[begin]--------------------- 비로그인자 장바구니 리스트 ------------------------->

   <%
     if(session.getAttribute("loginId") == null){ // 로그인 아이디가 없을 경우
     	HashMap<Integer, Cart> sessionCartMap = (HashMap<Integer, Cart>) session.getAttribute("sessionCartMap");//비회원 장바구니 목록
      if (sessionCartMap == null || sessionCartMap.isEmpty()) { // 장바구니가 비었다면 메세지
   %>
              <h3>장바구니가 비어있습니다.</h3>
   <%
      } else { // 장바구니가 있다면 출력
   %>
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>상품 번호</th>
						            <th>주문 수량</th>
						            <th>생성일</th>
						            <th>수정일</th>
						            <th>주문</th>
						            <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%	// session의 cartList
                            	for (Cart cart : sessionCartMap.values()) {
   							%> 
                                <tr>
                                    <td class="shoping__cart__item">
                                        <%= cart.getProductNo() %>
                                    </td>
                                    <td class="shoping__cart__quantity">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <%= cart.getCartCnt() %>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <%= cart.getCreatedate() %>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <%= cart.getUpdatedate() %>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <a href="<%=request.getContextPath()%>/customer/addCustomer.jsp">주문</a>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <a href="<%= request.getContextPath() %>/cart/removeSessionCartAction.jsp?productNo=<%= cart.getProductNo() %>" class="remove-cart">삭제</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
         </div>
     </section>

<!--[end]--------------------- 비로그인자 장바구니 리스트 ------------------------->	
	  
<!--[begin]--------------------- 로그인자 장바구니 리스트 ------------------------->	  
   <%
      		}
     	}
     } else { // 로그인 아이디가 있을 경우
   
         if(cartList == null || cartList.isEmpty()){ // 장바구니가 비었다면 메세지
      %>
         <h3>장바구니가 비어있습니다.</h3>
      <%
         } else { // 장바구니가 있다면 출력
      %>
      <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>상품 번호</th>
						            <th>주문 수량</th>
						            <th>생성일</th>
						            <th>수정일</th>
						            <th>주문</th>
						            <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                             <% //Cart 클래스의 객체 c를 cartList에서 가져와 반복 처리
					            for(Cart c : cartList){
					         %>
                                <tr>
                                    <td class="shoping__cart__item">
                                        <%= c.getProductNo() %>
                                    </td>
                                    <td class="shoping__cart__quantity">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <%= c.getCartCnt() %>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <%= c.getCreatedate() %>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <%= c.getUpdatedate() %>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <form action="<%=request.getContextPath()%>/orders/addOrders.jsp" method="post">
						                  <input type="hidden" name="productNo" value="<%=c.getProductNo()%>">
						                  <input type="hidden" name="id" value="<%=c.getId()%>">
						                  <input type="submit" value="주문하기">
						               </form>
                                    </td>
                                    <td class="shoping__cart__item">
                                        <a href="<%=request.getContextPath()%>/cart/removeCartAction.jsp?cartNo=<%=c.getCartNo()%>" class="remove-cart">삭제</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <%
					            }
                        %>
                    </div>
                </div>
            </div>
         </div>
     </section>
   <%
       }
    }
   %>
<!--[end]--------------------- 비로그인자 장바구니 리스트 ------------------------->   
</body>
</html>