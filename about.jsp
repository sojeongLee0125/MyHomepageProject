<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<!-- About  -->
	<div class="about">
		<h1>About Here</h1>
		<h2>
			Show us what you achieved Today<br> 
			It could be a powerful motivation for everyone!!
		</h2>
		<!-- ICON category -->
		<div class="about__category">
			<div class="category">
				<div class="category__icon">
					<i class="fas fa-book-reader"></i>
				</div>
				<h2 class="category__title">Reading Books</h2>
				<div class="category__description">인상깊은 책</div>
			</div>
			<div class="category">
				<div class="category__icon">
					<i class="fas fa-running"></i>
				</div>
				<h2 class="category__title">Exercise</h2>
				<p class="category__description">운동 기록</p>
			</div>
			<div class="category">
				<div class="category__icon">
					<i class="far fa-images"></i>
				</div>
				<h2 class="category__title">Photo</h2>
				<p class="category__description">일상 사진</p>
			</div>
			<div class="category">
				<div class="category__icon">
					<i class="fas fa-server"></i>
				</div>
				<h2 class="category__title">Share Information</h2>
				<p class="category__description">정보 공유</p>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="contactbar.jsp"></jsp:include>
</body>
</html>