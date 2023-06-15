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

	/* 세션값 확인 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--ordersEmpList loginId param"+RESET);

	/* 유효성 검사 */
	if(loginId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	
	OrdersDao ordersDao = new OrdersDao();
	// 현재 페이지 번호
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	/* 1. 글에 필요한 값: beginRow, rowPerPage (oracleDB 사용시 endRow) */
	int rowPerPage = 3;
	int beginRow = (currentPage - 1) * rowPerPage; // ex. rowPerPage가 10일때 1, 11, 21... 출력
	//mariadb는 limit가 있어서 시작 번호와 끝번호를 따로 정해주지 않아도 됨.
	//beginRow부터 rowPerPage까지의 데이터를 가져오는 메소드를 호출, 결과 저장
	ArrayList<Orders> ecList = ordersDao.selectECOrders(beginRow, rowPerPage);//0부터 10까지
	
	//totalRow를 사용하기 위해 selectECOrdersCnt 메소드 호출 및 변수 저장
	int totalRow = ordersDao.selectECOrdersCnt();

	/* 2. 하단 바에 필요한 값: minpage(이전) pageperpage maxPage(다음) */
	int pagePerPage = 3;
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	int minPage = (((currentPage - 1) / pagePerPage) * pagePerPage) + 1; //하단 페이징에서 제일 작은 값
	int maxPage = minPage + (pagePerPage - 1); // 하단 페이징에서 제일 큰 값
	//마지막 번호가, 실제 페이지 번호보다 많지 않도록 처리
	if(maxPage > lastPage){
		maxPage = lastPage;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   table,td,th {border: 1px solid #000000; border-collapse: collapse;}
</style>
</head>
<body>
	<!-- 상단 네비 바(메인메뉴) -->
	<div>
		<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
	</div>
	
	<div>
			<%
				if(request.getParameter("msg")!=null){
			%>
				<%=request.getParameter("msg")%>
			<%
				}
			%>		
	</div>
	
     <div>
     <h2>모든 회원의 주문리스트</h2>
		<table>
			<tr>
				<th>주문번호</th>
				<th>상품번호</th>
				<th>ID</th>
				<th>주문상태</th>
				<th>수정</th><!-- 수정 버튼 -->
				<th>주문수량</th>
				<th>총 가격</th>
				<th>주문일</th>
				<th>수정일</th>
			</tr>
				<%
					for(Orders orders : ecList){
				%>
				<tr>
					<td><%=orders.getOrderNo()%></td>
					<td><%=orders.getProductNo()%></td>
					<td><%=orders.getId()%></td>
					<td><%=orders.getDeliveryStatus()%></td>
					<!-- '결제완료','주문취소','배송중','배송완료','구매확정' -->
					 <form action="<%=request.getContextPath()%>/orders/modifyEmpAction.jsp" method="post">
				       <input type="hidden" name="orderNo" value="<%=orders.getOrderNo()%>">
				       <% // 사용자가 구매확정 버튼을 눌렀을 시 배송 상태 변경 불가
				       	 if(orders.getDeliveryStatus().equals("구매확정")){
				       %>
				       		<td> </td>
				       <%	
				       	} else {
				       %>
						      <td>
							      <label><input type="radio" name="empOrdersModify" value="배송중">배송중</label>
							      <label><input type="radio" name="empOrdersModify" value="배송완료">배송완료</label>
							      <label><input type="submit" value="수정"></label>
						      </td>
				      <%
				       	}
				      %>
				    </form>
				    
					<td><%=orders.getOrderCnt()%></td>
					<td><%=orders.getOrderPrice()%></td>
					<td><%=orders.getCreatedate()%></td>
					<td><%=orders.getUpdatedate()%></td>
				</tr>
			<%
				}
			%>
		</table>
	 </div>
	 <div>
		 <nav>
			 <ul>
				 <li>
					<%
					// '이전'
					if(minPage > 1){
					%>
						<a href="<%=request.getContextPath()%>/orders/ordersEmpList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
					<%		
						}
						// 하단 페이징 번호
						for(int i = minPage; i <= maxPage; i = i+1){
							if(i == currentPage){
					%>
								<li><a class="page-link"><span><%=i%>&nbsp;</span></a></li>
					<%			
							} else {
					%>
								<li><a href="<%=request.getContextPath()%>/orders/ordersEmpList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;</li>
					<%			
							}
						}
						// '다음'
						if(maxPage != lastPage){
					%>
						<li><a class="page-link" href ="<%=request.getContextPath()%>/orders/ordersEmpList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a></li>
					<%		
						}
					%>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>