<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="vo.*" %>
<%
QuestionDao questionDao = new QuestionDao();
AnswerDao answerDao = new AnswerDao();

Question question = new Question();
Answer answer = new Answer();

if (request.getParameter("qNo") != null){
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	question = questionDao.questionOne(qNo);
	answer = answerDao.answerOne(qNo);
 }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(document).on("click", ".remove-answer", function(e) {
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
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#title').focus();
    
    // 유효성 체크 함수
    function validateForm() {
        let allCheck = true; // allCheck 변수 초기화

        if ($('#content').val() == '') {
            $('#contentMsg').text('내용을 입력하세요');
            $('#content').focus();
            allCheck = false;
        } else {
            $('#contentMsg').text('');
        }
        
        return allCheck;
    }
    $('#btn').click(function(e) {
        e.preventDefault(); // 기본 동작 방지

        if (validateForm()) {
            $('#form').submit();
        }
    });
});
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
<h2>문의</h2>
	<table class="table table-bordered">
		
		<tr>
              <th>문의번호</th>
              <td><%=question.getqNo()%></td>
         </tr>
		<tr>
              <th>상품번호</th>
              <td><%=question.getProductNo()%></td>
         </tr>
		 <tr>
              <th>아이디</th>
              <td><%=question.getId()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>카테고리</th>
              <td><%=question.getqCategory()%></td>
           </tr>
		 <tr>
		<tr>
              <th>제목</th>
              <td><%=question.getqTitle()%></td>
           </tr>
		 <tr>
              <th>내용</th>
              <td><%=question.getqContent()%></td>
           </tr>
           <tr>
              <th>생성일</th>
              <td><%=question.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=question.getUpdatedate()%></td>
           </tr>
	</table>
	 <% // 로그인 상태이고 본인이 작성한 문의만 수정삭제가 보임 
        if (session.getAttribute("loginId") != null && session.getAttribute("loginId").equals(question.getId())) { %>
	<div>
		<a href="<%=request.getContextPath()%>/question/modifyQuestion.jsp?qNo=<%=question.getqNo()%>">수정</a>
		<a href="<%=request.getContextPath()%>/question/removeQuestion.jsp?qNo=<%=question.getqNo()%>&productNo=<%=question.getProductNo()%>">삭제</a>
	</div>	
	<% } %>
	<!-------------------  답변---------------------->
	
	 <% if (answer != null) { %>
	 <h2>답변</h2>
	<table class="table table-bordered">
	
		 <tr>
              <th>아이디</th>
              <td><%=answer.getId()%></td>
           </tr>
		 <tr>
		 <tr>
              <th>내용</th>
              <td><%=answer.getaContent()%></td>
           </tr>
           <tr>
              <th>생성일</th>
              <td><%=answer.getCreatedate()%></td>
           </tr>
           <tr>
              <th>수정일</th>
              <td><%=answer.getUpdatedate()%></td>
           </tr>
	</table>
<% // 로그인 상태이고 관리자1 본인이 작성한 답변이거나 관리자2만 수정삭제가 보임 
    if (session.getAttribute("loginId") != null && (session.getAttribute("loginId").equals(answer.getId()) || session.getAttribute("loginId").equals("admin"))) { %>	
	<div>
	<a href="<%=request.getContextPath()%>/answer/modifyAnswer.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>">수정</a>
    <a href="<%=request.getContextPath()%>/answer/removeAnswerAction.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>&productNo=<%=question.getProductNo()%>" class="remove-answer">삭제</a>
	</div>	
	  <%}} else { %>
	  	<!-------------------  답변추가---------------------->
<% 
//관리자만 답변을 남길 수 있게
EmployeesDao dao = new EmployeesDao();
ArrayList<Employees> list = dao.selectEmployeesList(); 

boolean checkId = false;
String loginId = (String) session.getAttribute("loginId");
if (loginId != null) {
for (Employees e : list){
   if (session.getAttribute("loginId").equals(e.getId())){
      checkId = true;
      break;
   		}
   }
}
if (checkId){%>
	<h3>답변</h3>
	<form action="<%=request.getContextPath()%>/answer/addAnswerAction.jsp?qNo=<%=question.getqNo()%>" method="post"  id="form" >
	<table class="table table-bordered">
		<tr>
		    <td>문의번호: <%=question.getqNo()%> 아이디: <input type="text" name="id" value="<%=session.getAttribute("loginId")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td><textarea rows="2" cols="60" name="aContent"  id="content"></textarea>
				<span id="contentMsg" class="msg"></span>
				<button type="submit" class="btn btn-danger"  id="btn"> 추가 </button></td>
		</tr>
	</table>
	</form> 
	  <% }} %>

</body>
</html>