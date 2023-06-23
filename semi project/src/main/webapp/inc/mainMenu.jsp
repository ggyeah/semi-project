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
	
	// (비)로그인 사용자 확인
	System.out.println(KIM+session.getAttribute("loginId")+" <-- mainMenu loginId"+RESET);
	
	// 관리자 1의 level값을 가져옴
	EmployeesDao employeesDao = new EmployeesDao();
	ArrayList<Employees> oneEmployeesList = employeesDao.oneEmployeesList();
	
	boolean checkId = false;
	String loginId = (String) session.getAttribute("loginId");
	if (loginId != null) {
	for (Employees e : oneEmployeesList){
	   if (session.getAttribute("loginId").equals(e.getId())){
	      checkId = true;
	      break;
	   		}
	   }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainMenu</title>
</head>
<body>
	<div>
<!-- 비로그인자/로그인자(일반 고객 회원/직원1/직원2) 조건에 따라 분기 -->	
<!-------------------------- 1. 비로그인자 -------------------------->
		<%  // 1. loginId가 없는 사람
			if(session.getAttribute("loginId") == null) { // 비로그인 사용자
			System.out.println(KIM+session.getAttribute("loginId")+" <-- mainMenu loginId(비로그인자)"+RESET);
		%>
		
<!-- [Begin] Header Section -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <ul>
                                <li><i class="fa fa-envelope"></i> gdj66@gmail.com</li>
                                <li>100만원 이상 구매 시 무료 배송</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/home.jsp">Home</a>
                            </div>
                            <div class="header__top__right__social">  
                                <a href="<%=request.getContextPath()%>/cart/cartList.jsp">장바구니</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/customer/addCustomer.jsp">회원가입</a>
                            </div>
                             <div class="header__top__right__auth">
                                <a href="<%=request.getContextPath()%>/id/login.jsp"><i class="fa fa-user"></i> 로그인</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
        <div class="text-center">
            <div class="row">
                <div class="col-lg-12">
                        <a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/img/homelogo.png" alt="no logo"></a>
                    </div>
                </div>
                </div>
            </div>
    </header>
<!-- [End] Header Section -->
<!--------------------------- 2. 로그인자 ---------------------------->	
		
		<%	
			// 2. loginId가 있는 사람(가입된 사람)
			} 
			if(session.getAttribute("loginId") != null){
				if(session.getAttribute("loginId").equals("admin")){ //loginId가 관리자2(최고위직)일 경우
		%>	
	
 <!-- [Begin] Header Section -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <ul>
                                <li><i class="fa fa-envelope"></i> gdj66@gmail.com</li>
                                <li>100만원 이상 구매 시 무료 배송</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/home.jsp">Home</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/employees/employeesOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a>
                            </div>
                            <div class="header__top__right__language"><!-- 관리자 메뉴 -->
                                <div>관리자 메뉴</div>
                                <span class="arrow_carrot-down"></span>
                                <ul>
                                    <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">&nbsp;&nbsp; 카테고리</a></li>
                                    <li><a href="<%=request.getContextPath()%>/customer/customerList.jsp">&nbsp;&nbsp; 회원정보</a></li>
                                    <li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp">&nbsp;&nbsp; 직원관리</a></li>
                                    <li><a href="<%=request.getContextPath()%>/orders/ordersEmpList.jsp">&nbsp;&nbsp; 주문관리</a></li><!-- 배송상태 변경 -->
                                    <li><a href="<%=request.getContextPath()%>/discount/discountList.jsp">&nbsp;&nbsp; 할인관리</a></li>
                                    
                                </ul>
                            </div>
                             <div class="header__top__right__auth">
                                <a href="<%=request.getContextPath()%>/id/logoutAction.jsp"><i class="fa fa-sign-out"></i> 로그아웃</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="header__logo">
                        <a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/img/homelogo.png" alt="no logo"></a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>
    </header>
<!-- [End] Header Section -->
		<%
				} else if(checkId){//loginId가 관리자1(일반 직원)일 경우
		%>
 <!-- [Begin] Header Section -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <ul>
                                <li><i class="fa fa-envelope"></i> gdj66@gmail.com</li>
                                <li>100만원 이상 구매 시 무료 배송</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/home.jsp">Home</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/employees/employeesOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a>
                            </div>
                            <div class="header__top__right__language"><!-- 관리자 메뉴 -->
                                <div>관리자 메뉴</div>
                                <span class="arrow_carrot-down"></span>
                                <ul>
                                    <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">&nbsp;&nbsp; 카테고리</a></li>
                                    <li><a href="<%=request.getContextPath()%>/customer/customerList.jsp">&nbsp;&nbsp; 회원정보</a></li>
                                </ul>
                            </div>
                             <div class="header__top__right__auth">
                                <a href="<%=request.getContextPath()%>/id/logoutAction.jsp"><i class="fa fa-sign-out"></i> 로그아웃</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="header__logo">
                        <a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/img/homelogo.png" alt="no logo"></a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>
    </header>
<!-- [End] Header Section -->
		<%		
				} else { //loginId가 일반 고객 회원일 경우
		%>
<!-- [Begin] Header Section -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <ul>
                                <li><i class="fa fa-envelope"></i> gdj66@gmail.com</li>
                                <li>100만원 이상 구매 시 무료 배송</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/home.jsp">Home</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/customer/customerOne.jsp?id=<%=(String)session.getAttribute("loginId")%>">마이페이지</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/cart/cartList.jsp?id=<%=(String)session.getAttribute("loginId")%>">장바구니</a>
                            </div>
                            <div class="header__top__right__social">
                                <a href="<%=request.getContextPath()%>/orders/ordersCstmList.jsp">나의 주문리스트</a>
                            </div>
                             <div class="header__top__right__auth">
                                <a href="<%=request.getContextPath()%>/id/logoutAction.jsp"><i class="fa fa-sign-out"></i> 로그아웃</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="header__logo">
                        <a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/img/homelogo.png" alt="no logo"></a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>
    </header>
<!-- [End] Header Section -->
		<%			
				}
			}
		%>
	</div>
</body>
</html>