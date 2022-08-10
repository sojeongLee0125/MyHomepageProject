<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
</head>
<body>

<script type="text/javascript">
// 번역기 열기 팝업창	
function gotrans() {
	var pop = window.open("../translator.jsp", "pop",
	"width=600,height=800, scrollbars=no, resizable=yes");
}
</script>
	
	<div class="header">
  		<h1 onclick="location.href='../index.html';">Carpe-Diem</h1>
  		<p>Carpe diem, quam minimum credula postero</p>
	</div>
	<nav class="navbar">
		<div class="navbar__logo">
			<i class="fas fa-cannabis"></i> 
			<a href="../home.jsp">CarpeDiem</a>
		</div>
		<ul class="navbar__menu">
			<li class="navbar__menu__item"><a href="../home.jsp">Home</a></li>
			<li class="navbar__menu__item"><a href="../about.jsp">About</a></li>
			<c:if test="${id == null }">
			<li class="navbar__menu__item"><a href="../member/loginForm.jsp">Login/Join</a></li>
			</c:if>
			<c:if test="${id != null }">
			<li class="navbar__menu__item"><a href="../member/main.jsp">MyPage</a></li>
			</c:if>
			<li class="navbar__menu__item"><a onclick="gotrans()">Language Translator</a></li>
			<li class="navbar__menu__item"><a href="board.jsp">File Board</a></li>
			<li class="navbar__menu__item"><a href="../galleryboard/board_list1.jsp">GalleryBoard</a></li>
			<li class="navbar__menu__item"><a href="../contactme/contactme.jsp">Contact Me</a></li>
		</ul>
	</nav>
</body>
</html>
