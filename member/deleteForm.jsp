<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="member_navbar.jsp"></jsp:include>
	<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
	}
	%>
	<div class="member_delete">
		<h2>정말로 탈퇴하시겠습니까?</h2>
		<img alt="reCheck" src="../assets/imgs/deletemember.gif"/>
		<form action="deletePro.jsp" method="post">
			<input type="hidden" name="id" value="<%=id%>"> 
			<label for="pass" class="form-label">비밀번호</label>
    		<input type="password" name="pass"> 
			<input type="submit" class="btn btn-dark" value="탈퇴하기">
			<input type="button" class="btn btn-danger" value="취소하기" onclick="history.back();"> 
		</form>
	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>