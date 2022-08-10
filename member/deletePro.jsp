<%@page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		if (id == null) {
			response.sendRedirect("loginForm.jsp");
		}
		
		MemberDAO mDAO = new MemberDAO();		
		int check = mDAO.deleteMember(id, pass);
			
		if(check == 1){
		%>
		<script type="text/javascript">
			alert("정상적으로 회원탈퇴되었습니다.");
			location.href='../home.jsp';
		</script>
		<%
		session.invalidate();				
		}else if(check == -1){
				// 비밀번호 오류
		%>
		<script type="text/javascript">
			alert("비밀번호가 잘못되었습니다.");
		    history.back();
		</script>
		<%
		}else{
			// 비회원
		%>
		<script type="text/javascript">
			alert("회원정보가 없습니다.");
			history.back();
	    </script>
		<%
		}
		%>
</body>
</html>