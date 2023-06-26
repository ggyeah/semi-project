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

ProductDao prodDao = new ProductDao(); 
Product productOne = prodDao.ProductListOne(question.getProductNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

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
<title>questionListOne</title>
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
      } else {
          location.reload(); // 취소를 눌렀을 때도 화면을 다시 로드 
      }
    });
  });
</script>
<script>
$(document).ready(function() {
    // 시작시 title 입력 폼에 포커스
    $('#content').focus();
    
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
<style>
    .answer-container {
        margin-left: 20px; /* 앞쪽 공간 조절 */
    }
</style>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<!-- 상단 네비 바(메인메뉴) -->
<div>
	<jsp:include page="/inc/mainMenu.jsp"></jsp:include>
</div>
<!-- 상단토마토바 -->
<section class="breadcrumb-section set-bg" data-setbg="<%=request.getContextPath()%>/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text answer-container">
                     <P style="color:white;"><%=productOne.getProductName()%></P>
                    <h2>상품문의</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<!------------------- 문의 ---------------------->
<br>
<br>
<div class="container">
	<div class="checkout__order">
		    <h4>&nbsp;&nbsp;&nbsp;&nbsp;<%=question.getqTitle()%></h4>
		    <span class="blog__item__text">
		        <ul>
		        	<li><i class="fa fa-list"></i><%=question.getqCategory()%>문의</li>
		            <li><i class="fa fa-calendar-o"></i><%=question.getCreatedate()%></li>
		            <li><i class="fa fa-comment-o"></i><%=question.getId()%></li>
		        </ul>
		    </span>
		    <p class="answer-container"><%=question.getqContent()%></p>
				<% // 로그인 상태이고 본인이 작성한 문의만 수정삭제가 보임 
				if (session.getAttribute("loginId") != null && session.getAttribute("loginId").equals(question.getId())) { %>
				<div style="text-align: right;">
					<a href="<%=request.getContextPath()%>/question/modifyQuestion.jsp?qNo=<%=question.getqNo()%>" class="btn btn-outline-secondary">수정</a>
					<a href="<%=request.getContextPath()%>/question/removeQuestion.jsp?qNo=<%=question.getqNo()%>&productNo=<%=question.getProductNo()%>" class="btn btn-outline-secondary">삭제</a>
				</div>	
				<% } %>
		</div>
	</div> 
<br>

<!-------------------  답변---------------------->
<div class="container">
<% if (answer != null) { %>
 	<div class="checkout__form">
   	 <h4 class="answer-container">&#10145;  답변</h4>
   	   <span class="blog__item__text">
        <ul>
            <li><i class="fa fa-calendar-o"></i><%=answer.getCreatedate()%></li>
            <li><i class="fa fa-comment-o"></i><%=answer.getId()%></li>
        </ul>
      </span>
    
    <p class="answer-container"><%=answer.getaContent()%></p>
		<% // 로그인 상태이고 관리자1 본인이 작성한 답변이거나 관리자2만 수정삭제가 보임 
		    if (session.getAttribute("loginId") != null && (session.getAttribute("loginId").equals(answer.getId()) || session.getAttribute("loginId").equals("admin"))) { 
		 %>	
	<div style="text-align: right;">
		<a href="<%=request.getContextPath()%>/answer/modifyAnswer.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>" class="btn btn-outline-secondary">수정</a>
	    <a href="<%=request.getContextPath()%>/answer/removeAnswerAction.jsp?qNo=<%=question.getqNo()%>&aNo=<%=answer.getaNo()%>&productNo=<%=question.getProductNo()%>" class="remove-answer btn btn-outline-secondary">삭제</a>
	</div>
</div>
</div>
<br>
<br>
<br>

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
if (checkId) {
%>
 	<div class="checkout__form answer-container">
   	 <h4>&#10145;  답변</h4>
		<span class="blog__item__text">
			<ul>
			    <li><i class="fa fa-check"></i><%=question.getqNo()%></li>
				<li><i class="fa fa-comment-o"></i><%=session.getAttribute("loginId")%></li>
			 </ul>
		</span>            
    <div class="hero__search__form">
		<form action="<%=request.getContextPath()%>/answer/addAnswerAction.jsp?qNo=<%=question.getqNo()%>&id=<%=loginId%>" method="post"  id="form">
	         <input type="text" name="aContent"  id="content"  placeholder="답변을 입력하십시오" class="answer-container">
	         <button type="submit" class="site-btn" id="btn">추가</button>
		</form> 
		<div><span id="contentMsg" class="msg"></span></div>
	</div>
</div>
	  <% }} %>
	  <br>
	  <br>
	  <br>

	  
<!------------ 하단 저작권 바 ------------>
<div>
	<jsp:include page="/inc/copyRight.jsp"></jsp:include>
</div>
    <!-- Js Plugins -->
    <script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath()%>/js/mixitup.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
</body>
</html>