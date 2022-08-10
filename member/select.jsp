<%@ page import="com.MemberBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="member_navbar.jsp"></jsp:include>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");

	MemberBean smb = new MemberBean();
	MemberDAO mDAO = new MemberDAO();
	smb = mDAO.selectMember(id);
	%>
	<div class="memberselect">
		<img src="../assets/imgs/mypage_avatar.jpg" alt="Avatar" class="main_avatar">
		<h2>[Member Information]</h2>
			<table border="1" class="table table-striped table-bordered">
				<tr>
					<td>아이디</td>
					<td>이름</td>
					<td>나이</td>
					<td>성별</td>
					<td>이메일</td>
					<td>주소</td>
				</tr>
				<tr>
					<td><%=id%></td>
					<td><%=smb.getName()%></td>
					<td><%=smb.getAge()%></td>
					<td><%=smb.getGender()%></td>
					<td><%=smb.getEmail()%></td>
					<td><%=smb.getAddress()%></td>
				</tr>
			</table>
		<button class="btn btn-dark list_btn" onclick="location.href='main.jsp';">마이페이지</button>
	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>