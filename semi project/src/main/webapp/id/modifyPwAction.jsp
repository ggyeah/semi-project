<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	// 요청값 유효성 검사 
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String newPw = request.getParameter("newPw");
	String newPwCk = request.getParameter("newPwCk");
	
	// 요청값 디버깅
	System.out.println(YANG + id + " <-- modifyPwAction id" + RESET);
	System.out.println(YANG + pw + " <-- modifyPwAction pw" + RESET);
	System.out.println(YANG + newPw + " <-- modifyPwAction newPw" + RESET);
	System.out.println(YANG + newPwCk + " <-- modifyPwAction newPwCk" + RESET);
	
	// 요청값 객체에 묶어 저장
	Id loginId = new Id();
	loginId.id = id;
	loginId.lastPw = pw;
	
	PwHistory addPwHistory = new PwHistory();
	addPwHistory.id = id;
	addPwHistory.pw = newPw;
	
	Id modifyIdList = new Id();
	modifyIdList.id = id;
	modifyIdList.lastPw = newPw;
	
	// 클래스 객체 생성
	IdDao IdDao = new IdDao();
	
	// 입력한 아이디와 현재 비밀번호 일치하는지 확인하는 메서드 호출
	int selectId = IdDao.selectId(loginId);
	String msg = null;
	if(selectId == 1){
		System.out.println(YANG + "modifyPwAction 아이디와 현재 비밀번호 일치" + RESET);
	} else {
		System.out.println(YANG + "modifyPwAction 아이디와 현재 비밀번호 불일치" + RESET);
		%>
		<script>
			alert('비밀번호를 확인해주세요');
			history.back();
		</script>
		<%
		return;
	}
	
	// 새로운 비밀번호 일치여부
	if(!newPw.equals(newPwCk)) {
		%>
		<script>
			alert('비밀번호가 서로 일치하지않습니다');
			history.back();
		</script>
		<%
		return;
	}
	
	// 현재 비밀번호와 새로운 비밀번호 비일치 여부
	if(newPw.equals(pw)
			||newPwCk.equals(pw)) {
		%>
		<script>
			alert('현재 비밀번호와 새로운 비밀번호가 같습니다');
			history.back();
		</script>
		<%
		return;
	}
	// 비밀번호 갯수세는 메서드 호출
	int cntPw = IdDao.cntPw(id);
	System.out.println(YANG + cntPw + " <-- modifyPwAction cntPw" + RESET);
	
	// 비밀번호 수정
	// 비밀번호 이력의 비밀번호가 3개 이상이면
	if(cntPw >= 3){ 
		int deletePw = IdDao.deletePw(id); // 최근 비밀번호 하나를 지우고
		System.out.println(YANG + deletePw + " <-- modifyPwAction deletePw" + RESET);
		
		int insertPw = IdDao.insertPw(addPwHistory); // pw_history 테이블에 바뀐 비밀번호 추가
		System.out.println(YANG + insertPw + " <-- modifyPwAction insertPw" + RESET);
		
	// 비밀번호 이력의 비밀번호가 3개 미만이면 
	} else { 
		int insertPw = IdDao.insertPw(addPwHistory); // pw_history 테이블에 바뀐 비밀번호 추가
		System.out.println(YANG + insertPw + " <-- modifyPwAction insertPw" + RESET);
	}
	
	// id_list에 last_pw 업데이트하는 메서드 호출
	int modifyPw = IdDao.updatePw(modifyIdList);
	if(modifyPw > 0){
		System.out.println(YANG + "비밀번호 변경, last_pw 업데이트 완료!" + RESET);
		%>
		<script>
			alert('변경 성공!');
			history.back();
		</script>
		<%
		
	} else {
		%>
		<script>
			alert('비밀번호를 확인해주세요');
			history.back();
		</script>
		<%
		return;
	}
	
%>