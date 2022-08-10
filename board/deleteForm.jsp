<%@page import="com.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.BoardDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="board_head.jsp"></jsp:include>
	<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
	%>
		<script type="text/javascript">
			alert("로그인 후 글을 삭제하실 수 있습니다.!");
			location.href = "../member/loginForm.jsp";
		</script>
	<%
	}
	%>
</head>
<body>
	<jsp:include page="board_navbar.jsp"></jsp:include>	
   	<%     
     	int num = Integer.parseInt(request.getParameter("num"));
     	String pageNum = request.getParameter("pageNum");
   	%>
   	<div class="deleteform">
   	<h2> 정말로 삭제하시겠습니까? </h2>
   	<img alt="reCheck" src="../assets/imgs/recheck.gif"/>
   	<form action="deletePro.jsp?pageNum=<%=pageNum %>" method="post">
     		<input type="hidden" name="num" value="<%=num%>">
     		<label for="pass" class="form-label">비밀번호</label>
     		<input type="password" name="pass">
     		<input type="submit" class="btn btn-dark" value="삭제하기"> 
     		<input type="button" class="btn btn-danger" value="취소하기" onclick="history.back();"> 
  	</form>
   	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include> 
</body>
</html>
