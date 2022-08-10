<%@ page import="com.MemberDAO"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
		
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
	}
	%>

	<jsp:useBean id="mb" class="com.MemberBean"></jsp:useBean>
	<jsp:setProperty property="*" name="mb" />

	<%
	MemberDAO mDAO = new MemberDAO();
	int ck = mDAO.updateMember(mb);
		
	if(ck == 1){
	%>
		<script type="text/javascript">
	 	alert("회원정보 수정 완료");
	 	location.href="main.jsp";
		</script>
	<%
	}else if(ck == -1){
	%>
		<script type="text/javascript">
	 	alert("비밀번호 오류입니다.");
	 	history.back();
		</script>
	<%	
	}else{
 	%>
		<script type="text/javascript">
	 	alert("회원정보가 존재하지 않습니다.");
	 	location.href="loginForm.jsp";
		</script>
	<%
	}
	%>
</body>
</html>