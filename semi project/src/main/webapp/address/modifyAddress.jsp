<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	/* session */
	if(session.getAttribute("loginId")==null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String loginId = (String)session.getAttribute("loginId");
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	/* dao address 상세정보 가져오기 */
	AddressDao addressDao = new AddressDao();
	Address addressOne = addressDao.selectAddressOne(loginId, addressNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyAddress</title>
</head>
<body>
<h1>배송지 수정</h1>
	  <div>
		<form action="<%=request.getContextPath()%>/address/modifyAddressAction.jsp" method="post">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<input type="hidden" name="addressNo" value="<%=addressOne.getAddressNo()%>">
			<table>
<!--------------------- 오류 메세지 --------------------->
				<tr>
					<td colspan="2">
						<%
							String msg = request.getParameter("msg");
							if(msg != null){
						%>
							<%= msg %>
						<%	
							}
						%>
					</td>
				</tr>
<!--------------------- 수정 폼 --------------------->
				<!------- 배송지 명 ------->
				<tr>
					<th>배송지 명</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="addressName" value="<%=addressOne.getAddressName()%>">
					</td>
				</tr>
				<!------- 주소 ------->	
				<tr>
					<th>주소</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="address" value="<%=addressOne.getAddress()%>">
					</td>
				</tr>
				<!------- 기본 배송지로 ------->	
				<tr>
					<th>기본 배송지로 등록</th>
				</tr>
				<tr>
					<td><!-- 기존 기본 배송지 값을 표시(삼항 연산자) -->
						<input type="hidden" name="defaultAddress" value="<%=addressOne.getDefaultAddress()%>">
 	                    <input type="radio" name="newDefaultAddress" value="Y" <%= addressOne.getDefaultAddress().equals("Y") ? "checked" : "" %>> 예
	                    <input type="radio" name="newDefaultAddress" value="N" <%= addressOne.getDefaultAddress().equals("N") ? "checked" : "" %>> 아니오
					</td>
				</tr>
			</table>
			<div>
				<button type="submit">수정</button>
			</div>
		</form>
	</div>
</body>
</html>