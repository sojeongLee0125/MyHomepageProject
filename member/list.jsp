<%@page import="java.util.ArrayList"%>
<%@page import="com.MemberDAO"%>
<%@page import="com.MemberBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
	if(id == null || !id.equals("admin") ){ 
	%>
	 	<script type="text/javascript">
		alert("허가되지 않은 접근입니다.");
		location.href="main.jsp";
		</script>
	<%
	}
	MemberDAO mDAO = new MemberDAO();	
	ArrayList<MemberBean> memberlist = mDAO.listMember(id);
	%>

	<div class="memberlistAll">
	<h2>전체 회원정보 조회</h2>
	<table border="1" class="table table-striped table-bordered table-hover">
		<tr id="list_tr">
			<td>아이디</td>
			<td>이름</td>
			<td>나이</td>
			<td>성별</td>
			<td>이메일</td>
			<td>주소</td>
		</tr>
		<%
      	        for(int i=0 ; i<memberlist.size() ; i++){
    	        MemberBean lmb = (MemberBean) memberlist.get(i);
                %>
		<tr>
			<td><%=lmb.getId() %></td>
			<td><%=lmb.getName() %></td>
			<td><%=lmb.getAge() %></td>
			<td><%=lmb.getGender() %></td>
			<td><%=lmb.getEmail() %></td>
			<td><%=lmb.getAddress() %></td>
		</tr>
		<%
                }  
                %>
	</table>
	<button class="btn btn-dark list_btn" onclick="location.href='main.jsp';">마이페이지</button>
  </div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
