<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	/* 인코딩 */
	request.setCharacterEncoding("utf-8");	

	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	/* 유효성 검사 */
	if(session.getAttribute("loginId") == null
	|| request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	/* 세션값 ID 변수에 저장 */
	String loginId = (String)session.getAttribute("loginId");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(KIM+loginId+" <--addressList loginId param"+RESET);
	System.out.println(KIM+productNo+" <--addressList productNo param"+RESET);
	
	AddressDao addressDao = new AddressDao();
	Address adderss = new Address();
	ArrayList<Address> addressList = addressDao.selectAddress(loginId);
	ArrayList<Address> defaultAddressList = addressDao.selectDefaultAddress(loginId);
	
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<title>addressList</title>
<style>
	#yellow {background-color:yellow;}
</style>
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
<style>
	.right{
		text-align: right;
	}
</style>
</head>
<body>
<!-------------- 상단 네비게이션 바(메인메뉴) -------------->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>

<!----------------------- 메세지 ----------------------->
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
<!--------------------- 배송지 리스트 ----------------------->
	<%
		if(addressList == null || addressList.isEmpty()){
	%>
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>배송지 관리</h2>
                        <div class="breadcrumb__option">
                             <a>Home</a>
                            <span>배송지 관리</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
     <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                        	<thead>
                                <tr>
                                    <th>주소</th>
									<th>수정</th>
									<th>삭제</th>
									<th>선택</th>
                                </tr>
                            </thead>
                            <tbody>
                        	<tr>
                        		<td colspan="4" class="center">
                            		<h4>배송지를 추가하세요.</h4>
                        		</td>
                        	</tr>
                        	</tbody>
                        </table>
                    </div>
                </div>
            </div>
         </div>
     </section>
	<%
		} else { // 배송지 정보가 있다면 출력
	%>
<!-------------------------- Breadcrumb Section Begin ------------------------>
		    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
		        <div class="container">
		            <div class="row">
		                <div class="col-lg-12 text-center">
		                    <div class="breadcrumb__text">
		                        <h2>배송지 관리</h2>
		                        <div class="breadcrumb__option">
		                             <a>Home</a>
		                            <span>배송지 관리</span>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </section>
<!--[begin]------------------------ 기본 배송지 선택 폼 -------------------------->			    
		    
				<section class="checkout spad">
			      	<div class="container">
			      		<!-- 타이틀; 기본 배송지 "이름" | 기본 배송지 표시 -->
						  <div class="checkout__form">
						  <h4>기본 배송지</h4>
						  <%
							for(Address b : defaultAddressList){			
						  %>
			                  <div class="row">
			                      <div class="col-lg-2">
			                          <div class="checkout__input">
			                              <%=b.getAddressName()%>
			                          </div>
			                      </div>
			                      <div class="col-lg-3">
			                      	<div class="checkout__input">
			                      		<span id="yellow">기본배송지</span>
			                      	</div>
			                      </div>
			                      <div class="col-lg-3"></div>
			                      <div class="col-lg-4"></div>
			                  </div>
			                </div>
			               <!-- 1행 7열 배송지 정보 출력 -->
			               	<div class="row">
			               			<div class="col-lg-9">
				                  		<table>
											<tr>
												<td>
													<%=b.getAddress()%>
												</td>
											</tr>
										</table>
									</div>
									<div class="col-lg-3">
									<table>
										<tr>
											<td>
												<form action="<%=request.getContextPath()%>/address/modifyAddress.jsp" method="post">
													<input type="hidden" name="productNo" value="<%=productNo%>">
													<input type="hidden" name="addressNo" value="<%=b.getAddressNo()%>">
													<input type="hidden" name="id" value="<%=b.getId()%>">
													<input type="hidden" name="addressName" value="<%=b.getAddressName()%>">
													<input type="hidden" name="address" value="<%=b.getAddress()%>">
													<input type="hidden" name="createdate" value="<%=b.getCreatedate()%>">
													<input type="hidden" name="updatedate" value="<%=b.getUpdatedate()%>">
													<input type="submit" value="수정">
												</form>
											</td>
											<td>
												<div class="col-lg-12">
													<form action="<%=request.getContextPath()%>/address/removeAddressAction.jsp" method="post">
														<input type="hidden" name="productNo" value="<%=productNo%>">
														<input type="hidden" name="id" value="<%=b.getId()%>">
														<input type="hidden" name="addressNo" value="<%=b.getAddressNo()%>">
														<input type="hidden" name="addressName" value="<%=b.getAddressName()%>">
														<input type="submit" value="삭제">
													</form>
												</div>
											</td>
											 <td>
											 	<div class="col-lg-12">
							                    	<a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?check=<%=b.getAddress()%>&productNo=<%=productNo%>">선택</a>
							                	</div>
							                </td>
										</tr>
									</table>
								</div>
							</div>
			      </section>
	          <%
			  		}
	          %>
<!--[end]------------------------ 기본 배송지 선택 폼 -------------------------->

<!--[begin]------------------------ 일반 배송지 선택 폼 -------------------------->	          
	          
								<%	
									for(Address a : addressList){
								%>
			      	<div class="container">
						<div class="checkout__form">
							<h4>일반 배송지</h4>
							<div class="row" rowspan="2">
								<div class="col-lg-9">
									<table>
										<tr>
											<td><%=a.getAddressName()%></td><!-- 배송지 이름 -->
										</tr>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-9">
									<table>
										<tr>
											<%=a.getAddress()%>
										</tr>
									</table>
								</div>
								<div class="col-lg-3">
									<table>
										<tr>	
											<td>
												<form action="<%=request.getContextPath()%>/address/modifyAddress.jsp" method="post">
													<input type="hidden" name="productNo" value="<%=productNo%>">
													<input type="hidden" name="addressNo" value="<%=a.getAddressNo()%>">
													<input type="hidden" name="id" value="<%=a.getId()%>">
													<input type="hidden" name="addressName" value="<%=a.getAddressName()%>">
													<input type="hidden" name="address" value="<%=a.getAddress()%>">
													<input type="hidden" name="createdate" value="<%=a.getCreatedate()%>">
													<input type="hidden" name="updatedate" value="<%=a.getUpdatedate()%>">
													<input type="submit" value="수정">
												</form>
											</td>
											<td>
												<div class="col-lg-12">
													<form action="<%=request.getContextPath()%>/address/removeAddressAction.jsp" method="post">
														<input type="hidden" name="productNo" value="<%=productNo%>">
														<input type="hidden" name="id" value="<%=a.getId()%>">
														<input type="hidden" name="addressNo" value="<%=a.getAddressNo()%>">
														<input type="hidden" name="addressName" value="<%=a.getAddressName()%>">
														<input type="submit" value="삭제">
													</form>
												</div>
											</td>
											 <td>
											 	<div class="col-lg-12">
							                    	<a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?check=<%=a.getAddress()%>&productNo=<%=productNo%>">선택</a>
							                	</div>
							                </td>
										</tr>
									</table>
								<%		
									}
								%>
									</div>
								</div>
							</div>
						<%
							}
						%>
					</div>
<!--[end]------------------------ 일반 배송지 선택 폼 -------------------------->			
<!-- 배송지 추가 버튼 -->
	<div>
		<a href="<%=request.getContextPath()%>/address/addAddress.jsp?productNo=<%=productNo%>">배송지 추가</a>
	</div>
<!--  선택된 주소가 없을 경우: 다시 주문폼으로 -->		
	<a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?productNo=<%=productNo%>">이전</a>

<!-- Js Plugins -->
   <script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery.nice-select.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/jquery.slicknav.js"></script>
   <script src="<%=request.getContextPath()%>/js/mixitup.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
   <script src="<%=request.getContextPath()%>/js/main.js"></script>
   
<!------------ 하단 저작권 바 ------------>
	<div>
		<jsp:include page="/inc/copyRight.jsp"></jsp:include>
	</div>
</body>
</html>