<%@ page import="com.BoardBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
<link rel="stylesheet" href="style.css" />
<%
String id = (String) session.getAttribute("id");
if (id == null) {
%>
	<script type="text/javascript">
		alert("로그인 후 글을 작성하실 수 있습니다.!");
		location.href = "../member/loginForm.jsp";
	</script>
<%
}
%>
<script type="text/javascript">
	
	function checkPass() {

		var pass = document.boardInfo.pass.value;
		var passcheck = ${pass};
		var subject = document.boardInfo.subject.value;
		var content = document.boardInfo.content.value;

		if (pass != passcheck) {
			alert("비밀번호가 올바르지 않습니다.");
			return false;
		}
		
		if(subject == ""){
		    	alert("제목을 입력하세요.");
		    	document.boardInfo.subject.focus();
		    	return false;
		}
		
		if(content == ""){
		    	alert("내용 입력하세요.");
		    	document.boardInfo.content.focus();
		    	return false;
		}
	}		
</script>
</head>
<body>
    <jsp:include page="board_navbar.jsp"></jsp:include>
    <br><br>
    <h1>Community</h1>
	<div class="contents1">
		<div class="con_title">
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt=""
					src="../assets/imgs/home_icon.gif" /> 
					&gt; 커뮤니티 &gt; <strong>정보공유게시판</strong>
			</p>
		</div>
	</div>
   <!-- write form  -->
   <fieldset class="writeform">
     <form action="writePro.jsp" name="boardInfo" method="post" enctype="multipart/form-data" onsubmit="return checkPass()">
      	<div class="mb-3">
  			<label for="id" class="form-label">아이디</label>
  			<input type="text" class="form-control" name="name" 
  			       value=<%=id %> readonly="readonly" id="name" >
	</div>
	<div class="mb-3">
  			<label for="pass" class="form-label">비밀번호</label>
  			<input type="password" class="form-control" name="pass">
	</div>
      	<div class="mb-3">
  			<label for="file" class="form-label">첨부파일</label>
  			<input type="file" class="form-control" name="file">
	</div>
	<div class="mb-3">
  			<label for="subject" class="form-label">제목</label>
  			<input type="text" class="form-control" name="subject">
	</div>
      	<div class="mb-3">
  			<label for="content" class="form-label">내용</label>
  			<textarea class="form-control" name="content" rows="5" cols="20"></textarea>
	</div>     	
      	<hr>
	<input type="submit" class="btn btn-dark" value="글쓰기">     
	<input type="button" class="btn btn-dark" value="목록으로" onclick="location.href='board.jsp';">     
     </form>
   </fieldset>
   <jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
