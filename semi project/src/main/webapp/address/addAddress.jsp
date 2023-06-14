<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 인코딩 */
	response.setCharacterEncoding("utf-8");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 추가</title>
</head>
<body>
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
<!---------------------- 배송지 추가 ---------------------->
	<form action="<%=request.getContextPath()%>/address/addAddressAction.jsp" method="post">
		<table>
			<tr>
				<th>배송지명</th>
			</tr>
			<tr>	
				<td><input type="text" name="addAddressName" placeholder="배송지명을 입력하세요"></td>
			</tr>
			<tr>	
				<th>주소</th>
			</tr>
			<tr>	
				<td><input type="text" name="addAddress" placeholder="주소를 입력하세요"></td>
			</tr>
		</table>
		<div>
			<input type="checkbox" name="defaultAddress" value="Y" id="check">
			<label for="defaultAddressCheckbox">기본 배송지로 등록</label>
		</div>
		<button type="submit">추가</button>
		<input type="hidden" name="defaultAddress" value="N">
	</form>
	<script>
		document.getElementById("check").addEventListener("change", function() {
			if (this.checked) {
				document.getElementsByName("defaultAddress")[0].value = "Y";
			} else {
				document.getElementsByName("defaultAddress")[0].value = "N";
			}
		});
	</script>	
</body>
</html>