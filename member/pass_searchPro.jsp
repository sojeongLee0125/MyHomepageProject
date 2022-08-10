<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include></head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");		
	
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String resultPass = null;
	
	MemberDAO mDAO = new MemberDAO();
	resultPass = mDAO.passSearch(id, email);
	
	if(resultPass != null){
	%>
		<script type="text/javascript">
	   		alert(" 비밀번호 찾기 성공. 비밀번호:" + <%=resultPass %>);
	   		alert(" 로그인 페이지로 이동합니다.");
	   		window.open("loginForm.jsp");	
		</script>
	<%
	}else{
	%>
		<script type="text/javascript">
		   alert(" 해당되는 회원정보가 존재하지 않습니다.");
		   history.back();
		</script>
	<%
	} 
	%>
</body>
</html>