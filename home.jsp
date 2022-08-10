<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
<!-- advertise jquery -->
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
	<%
	String id = (String)session.getAttribute("id");
	%>
	<!-- 상단바  -->
	<jsp:include page="navbar.jsp"></jsp:include>
	<!-- home left  -->
	<div class="row">
		<div class="side">
			<h2>O Me! O Life!</h2>
			<h3>BY WALT WHITMAN</h3>
			<p id="p0">
				Oh me! Oh life! <br> 
				of the questions of these recurring,<br>
				Of the endless trains of the faithless, <br> 
				of cities fill’d with the foolish,<br> 
				Of myself forever reproaching myself, <br>
				(for who more foolish than I, <br> 
				and who more faithless?)<br>
				Of eyes that vainly crave the light,<br> 
				of the objects mean,<br>
				of the struggle ever renew’d,<br> 
				Of the poor results of all, <br>
				of the plodding and sordid crowds I see around me,<br> 
				Of the empty and useless years of the rest, <br> 
				with the rest me intertwined,<br> 
				The question,<br> 
				O me! so sad, recurring—<br>
				What good amid these, O me, O life?
			</p>
			<p id="p1">
				Answer.<br> That you are here—<br> 
				that life exists and identity,
			</p>
			<p id="p2">
				That the powerful play goes on, <br> 
				and you may contribute a verse.
			</p>
		</div>
		<!-- Home right -->
		<div class="main">
			<div id="home" class="section">
				<img src="assets/imgs/trump.png" alt="Home_avatar photo" class="home__avatar" />
				<h1 class="home__title">
					Victory belongs to the most persevering.
				</h1>
				<c:if test="${id != null }">
				<span class="home__hi"> 
					<span style="color:orange;"><%=id%>님</span>
					Let's make a wonderful Today:) <br><br>
				</span>
				</c:if>
			</div>
			<!-- advertise  -->
			<ul id="advertise">
				<li><img src="assets/imgs/banner01.png"></li>
				<li><img src="assets/imgs/banner02.png"></li>
				<li><img src="assets/imgs/banner03.png"></li>
				<li><img src="assets/imgs/banner04.png"></li>
				<li><img src="assets/imgs/banner05.png"></li>
			</ul>
		</div>		
	</div>
	<!--footer -->
	<jsp:include page="contactbar.jsp"></jsp:include>
</body>
</html>