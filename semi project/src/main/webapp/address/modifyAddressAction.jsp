<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*" %>
<%
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	/* 인코딩 */
	request.setCharacterEncoding("utf-8");
	
	/* 유효성 검사 */
	if(request.getParameter("addressNo") == null
		|| request.getParameter("addressName") == null
		|| request.getParameter("address") == null
		|| request.getParameter("defaultAddress") == null
		|| request.getParameter("addressNo").equals("")
		|| request.getParameter("addressName").equals("")
		|| request.getParameter("address").equals("")
		|| request.getParameter("defaultAddress").equals("")){
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		response.sendRedirect(request.getContextPath()+"/address/modifyAddress.jsp?productNo="+productNo);
		return;
		}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	String addressName = request.getParameter("addressName");
	String address = request.getParameter("address");
	String defaultAddress = request.getParameter("defaultAddress");
	String loginId = (String)session.getAttribute("loginId");
	String newDefaultAddress = request.getParameter("newDefaultAddress");
	// 디버깅
	System.out.println(KIM+addressNo+" <--modifyAddressAction parameter addressNo"+RESET);
	System.out.println(KIM+addressName+"<--modifyAddressAction parameter addressName"+RESET);
	System.out.println(KIM+address+"<--modifyAddressAction parameter address"+RESET);
	System.out.println(KIM+defaultAddress+"<--modifyAddressAction parameter defaultAddress"+RESET);
	System.out.println(KIM+loginId+"<--modifyAddressAction parameter loginId"+RESET);
	
	AddressDao addressDao = new AddressDao();
	// default_address를 N -> Y로 바꿀 경우
	int defaultRow = 0;
	// default_address 기존 값이 있다면 모두 N으로 바꾸는 메소드를 실행
	if(defaultAddress.equals("N") && newDefaultAddress.equals("Y")) {
		defaultRow = addressDao.modifyDefaultAddress(loginId);
	}
	String msg = null;
	if(defaultRow == 0){ 
		System.out.println(KIM+defaultRow+"<--modifyAddressAction defaultRow fail"+RESET);
	} else {
		System.out.println(KIM+loginId+"<--modifyAddressAction defaultRow success"+RESET);
	}
	// 위 조건이 선행되어야 아래 실행됨
	
	/* address 객체에 데이터 담기 */
	Address addressOne = new Address();
	addressOne.setAddressNo(addressNo);
	addressOne.setAddressName(addressName);
	addressOne.setAddress(address);
	addressOne.setDefaultAddress(newDefaultAddress);
	addressOne.setId(loginId);
	
	// 수정 dao 사용
	int row = addressDao.modifyAddress(addressOne);
	System.out.println(row+KIM+"<--modifyAddressAction row"+RESET);
	
	if(row == 0){
		msg = URLEncoder.encode("수정 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/address/modifyAddress.jsp?addressNo="+addressNo+"&productNo="+productNo+"&msg="+msg);
		return;
	} else {
		response.sendRedirect(request.getContextPath()+"/address/addressList.jsp?productNo="+productNo);
		return;
	}

%>