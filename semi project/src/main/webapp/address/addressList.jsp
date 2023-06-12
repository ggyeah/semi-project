<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
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

	/* 유효성 검사 */
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	/* 세션값 ID 변수에 저장 */
	String loginId = (String)session.getAttribute("loginId");
	System.out.println(KIM+loginId+" <--address loginId param"+RESET);
	
	AddressDao addressDao = new AddressDao();
	Address adderss = new Address();
	ArrayList<Address> addressList = addressDao.selectAddress(loginId);
	
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
<script>
    function removeAddress(addressNo) {
        var result = confirm("정말로 삭제하시겠습니까?");
        if (result) {
            // 확인 버튼을 눌렀을 때
            var form = document.getElementById("removeForm_" + addressNo);
            form.submit(); // 폼 제출
        }
    }
</script>
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
		<h2>최근 배송지가 없습니다.</h2>
	<%
		} else {
	%>
	
		<% //Address 클래스의 객체 a를 addressList만큼 가져와 반복 처리
			for(Address a : addressList){
		%>
		<table>
			<tr>
				<td colspan="2"><%=a.getAddressName()%></td><!-- 배송지 이름 -->
				<%
					if(a.getDefaultAddress().equals("Y")){
				%>
					<td colspan="2" id="yellow">기본배송지</td><!-- 기본 배송지 표시 -->
				<%
					}
				%>
			</tr>
		</table>
		<table>
			<tr>	
				<th>주소</th>
				<th>생성일</th>
				<th>수정일</th>
				<th>수정</th>
				<th>삭제<th>
			</tr>
	
			<tr>
				<td><%=a.getAddress()%></td>
				<td><%=a.getCreatedate()%></td>
				<td><%=a.getUpdatedate()%></td>
				<td>
					<form action="<%=request.getContextPath()%>/modifyAddress.jsp" method="post">
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
					<form id="removeForm_<%=a.getAddressNo()%>" action="<%=request.getContextPath()%>/removeAddressAction.jsp" method="post">
						<input type="hidden" name="id" value="<%=a.getId()%>">
						<input type="hidden" name="addressNo" value="<%=a.getAddressNo()%>">
						<input type="hidden" name="addressName" value="<%=a.getAddressName()%>">
						<a href="javascript:void(0)" onclick="removeAddress(<%=a.getAddressNo()%>)">삭제</a>
					</form>
				</td>
			</tr>
	<%
			}		
		}
	%>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/address/addAddress.jsp">배송지 추가</a>
		</div>
</div>
</body>
</html>