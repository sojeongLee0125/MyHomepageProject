<%@page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include></head>
<body>
	<%
	 request.setCharacterEncoding("UTF-8");		
	%>
	<jsp:useBean id="mb" class="com.MemberBean"></jsp:useBean>
	<jsp:setProperty property="*" name="mb"/>
	<%
	MemberDAO mDAO = new MemberDAO();
	mDAO.joinMember(mb);
	%>
	<script type="text/javascript">
	   alert(" 회원가입 성공. 로그인페이지로 이동합니다. ");
	   location.href="loginForm.jsp";	
	</script>	
</body>
</html>