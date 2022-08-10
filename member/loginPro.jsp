<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");

	MemberDAO mDAO = new MemberDAO();
	int check = mDAO.loginMember(id, pass);
	
	if(check == 1){
	%>
		<script type="text/javascript">
			alert("로그인 성공");
		</script>
	<%
		session.setAttribute("id", id);
		session.setAttribute("pass", pass);
		response.sendRedirect("../home.jsp");
	}else if(check == 0){
	%>
		<script type="text/javascript">
		  	alert("비밀번호 오류입니다.");
		  	history.back();
		</script>
	<%	
	}else{
 	%>
		<script type="text/javascript">
		  var result = confirm("회원정보가 없습니다.회원가입 하시겠습니까?");
			if(result){
				location.href="joinForm.jsp";
			}else{
			   history.back();
			}   
		 </script>
	<%
	}	
	%>
</body>
</html>