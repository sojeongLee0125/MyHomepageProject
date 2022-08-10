<%@ page import="mail.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="contact_head.jsp"></jsp:include>
	<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
	%>
		<script type="text/javascript">
			alert("로그인 후 글을 작성하실 수 있습니다.!");
			location.href = "../member/loginForm.jsp";
		</script>
	<%
	}
	%>
	
<script type="text/javascript">

function gocheck() {

	var name = document.fr.name.value;
	var email = document.fr.email.value;
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	var phone = document.fr.phone.value;
	var message = document.fr.message.value;
	
	if(name == "" ){
	    alert("이름를 입력하세요.");
	    document.fr.name.focus();
	    return false;
	}
	
	if(email == ""){
	    alert("이메일 입력하세요.");
	    document.fr.email.focus();
	    return false;
	}
	
	if(!emailRegExp.test(email)) {
	    alert("이메일 형식이 올바르지 않습니다.");
	    document.fr.email.focus();
	    return false;
	}
	
	if(phone == ""){
	    alert("전화번호를 입력하세요.");
	    document.fr.phone.focus();
	    return false;
	}
	
	if ((phone < "0" || phone > "9")){
	    alert("전화번호는 숫자만 가능합니다.");
	    document.fr.phone.focus();
	    return false;
	}
	
	if(message == ""){
	    alert("메세지를 입력하세요.");
	    document.fr.message.focus();
	    return false;
	}
	
	var pop = window.open("contactcheck.jsp", "pop",
			"width=570,height=420, scrollbars=no, resizable=yes");
}
</script>
</head>
<jsp:include page="contact_navbar.jsp"></jsp:include>
<body>
	<section class="contactme">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-8 col-xl-6 text-center">
					<h2 class="mt-0">Contact Me</h2>
					<hr class="divider" />
					<p class="text-muted mb-5">
						If you have any suggestions, Send me a messages<br> 
						and I will get back to you as soon as possible!
					</p>
				</div>
			</div>
			<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
				<div class="col-lg-6">
					<form action="mailSend.jsp" method="post" name="fr" id="contactForm" onsubmit="return gocheck()">
						<div class="form-floating mb-3">
							<input class="form-control" id="name" name="name" type="text" value=<%=id %> readonly="readonly" />
							<label for="name">User Name</label>
						</div>
						<div class="form-floating mb-3">
							<input class="form-control" id="email" name="email" type="email" /> 
						    <label for="email">Return Email address</label>
						</div>
						<div class="form-floating mb-3">
							<input class="form-control" id="phone" name="phone" type="tel"/>
							<label for="phone">Phone number</label>
						</div>
						<div class="form-floating mb-3">
							<textarea class="form-control" id="message" name="message" type="text"
								      style="height: 10rem"></textarea>
							<label for="message">Message</label>
						</div>
						<div class="d-grid">
							<button class="btn btn-success btn-xl" id="submitButton"
									type="submit">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
<jsp:include page="contactbar.jsp"></jsp:include>
</body>
</html>
