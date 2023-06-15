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
<html>
<head>
<meta charset="UTF-8">
<title>addressList</title>
<style>
	#yellow {background-color:yellow;}
	table,td,th {border: 1px solid #000000; border-collapse: collapse; table-layout: fixed;}
</style>
</head>
<body>
	<div>
		<div>
			<h4>배송지 관리</h4>
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
		<h2>배송지를 추가하세요.</h2>
	<%
		} else {
	%>
		<h5>기본 배송지</h5>
	<%		
				for(Address b : defaultAddressList){
					
	%>				
					<table>
						<tr>
							<td colspan="2"><%=b.getAddressName()%></td><!-- 배송지 이름 -->
							<td colspan="2" id="yellow">기본배송지</td><!-- 기본 배송지 표시 -->
						</tr>
					</table>
					<table>
						<tr>	
							<th>주소</th>
							<th>최근 사용일</th>
							<th>생성일</th>
							<th>수정일</th>
							<th>수정</th>
							<th>삭제</th>
							<th>선택</th>
						</tr>
				
						<tr>
							<td><%=b.getAddress()%></td>
							<td><%=b.getAddressLastDate() != null ? b.getAddressLastDate() : "사용되지 않은 주소" %></td>
							<td><%=b.getCreatedate()%></td>
							<td><%=b.getUpdatedate()%></td>
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
								<form action="<%=request.getContextPath()%>/address/removeAddressAction.jsp" method="post">
									<input type="hidden" name="productNo" value="<%=productNo%>">
									<input type="hidden" name="id" value="<%=b.getId()%>">
									<input type="hidden" name="addressNo" value="<%=b.getAddressNo()%>">
									<input type="hidden" name="addressName" value="<%=b.getAddressName()%>">
									<input type="submit" value="삭제">
								</form>
							</td>
							 <td>
			                      <a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?check=<%=b.getAddress()%>&productNo=<%=productNo%>">선택</a>
			                </td>
						</tr>
					</table>
			<%		
					}
				}
           %>
      		<h5>일반 배송지</h5>
      		<%	
				for(Address a : addressList){
			%>
						<table>
							<tr>
								<td colspan="2"><%=a.getAddressName()%></td><!-- 배송지 이름 -->
							</tr>
						</table>
						<table>
							<tr>	
								<th>주소</th>
								<th>최근 사용일</th>
								<th>생성일</th>
								<th>수정일</th>
								<th>수정</th>
								<th>삭제</th>
								<th>선택</th>
							</tr>
					
							<tr>
								<td><%=a.getAddress()%></td>
								<td><%=a.getAddressLastDate() != null ? a.getAddressLastDate() : "사용되지 않은 주소"%></td>
								<td><%=a.getCreatedate()%></td>
								<td><%=a.getUpdatedate()%></td>
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
									<form action="<%=request.getContextPath()%>/address/removeAddressAction.jsp" method="post">
										<input type="hidden" name="productNo" value="<%=productNo%>">
										<input type="hidden" name="id" value="<%=a.getId()%>">
										<input type="hidden" name="addressNo" value="<%=a.getAddressNo()%>">
										<input type="hidden" name="addressName" value="<%=a.getAddressName()%>">
										<input type="submit" value="삭제">
									</form>
								</td>
								 <td>
				                      <a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?check=<%=a.getAddress()%>&productNo=<%=productNo%>">선택</a>
				                </td>
							</tr>
					<%		
						}
					%>
						</table>
						
			<div>
				<a href="<%=request.getContextPath()%>/address/addAddress.jsp?productNo=<%=productNo%>">배송지 추가</a>
			</div>
				<!--  선택된 주소가 없을 경우: 다시 주문폼으로 -->		
				<a type="button" href="<%=request.getContextPath()%>/orders/addOrders.jsp?productNo=<%=productNo%>">이전</a>
	</div>
</body>
</html>