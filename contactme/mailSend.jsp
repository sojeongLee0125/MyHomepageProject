<%@ page import="mail.mailBean"%>
<%@ page import="mail.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String message = request.getParameter("message");

	%>
	<jsp:useBean id="mb" class="mail.mailBean"></jsp:useBean>
	<jsp:setProperty property="*" name="mb"/>
	
	<%
	MailSend ms = new MailSend();
	ms.ContactMailSend(mb);
	response.sendRedirect("../home.jsp");
	%>
</body>
</html>