<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		$('#advertise').innerfade({
			animationtype : 'fade',
			speed :'8000ms',
			type : 'random'
		});
	});
</script>
</head>
<body>
	<jsp:include page="member_navbar.jsp"></jsp:include>
	<% 
         String id = (String)session.getAttribute("id");
     
	 if(id == null){
    	 response.sendRedirect("loginForm.jsp");
         }
   	%>
	<section class="main">
		<img src="../assets/imgs/mypage_avatar.jpg" alt="Avatar" class="main_avatar">
		<br>
		<h3><%=id %>님 환영합니다:)</h3> 
		<button class="btn" onclick="location.href='select.jsp';">회원정보 조회</button>
		<button class="btn" onclick="location.href='updateForm.jsp';">회원정보 수정</button>
		<button class="btn" onclick="location.href='deleteForm.jsp';">회원정보 삭제</button>
		<button class="btn redbtn" onclick="location.href='logout.jsp';">로그아웃</button>
		<hr>
		<% 		
                if( id != null && id.equals("admin")){ 		
                %>
		<a href="list.jsp"> 관리자용 - 회원 정보 목록(List)</a> <br>
		<%
                }
                %>
	</section>
	<div class="main_advertise">
		<ul id="advertise">
			<li><img src="../assets/imgs/banner01.png"></li>
			<li><img src="../assets/imgs/banner02.png"></li>
			<li><img src="../assets/imgs/banner03.png"></li>
			<li><img src="../assets/imgs/banner04.png"></li>
			<li><img src="../assets/imgs/banner05.png"></li>
		</ul>
	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
