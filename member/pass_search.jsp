<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<jsp:include page="member_head.jsp"></jsp:include>
<style type="text/css">

.passsearch {
	margin-top: 50px;
	padding-left: 80px;
	padding-right: 80px;
}

h1 {
	margin-top: 50px;
	text-align: center;
	font-weight: bold;
}
</style>
<script type="text/javascript">
function checkValue(){
	var id = document.pwfr.id.value;
	var email = document.pwfr.email.value;
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	
	if(id == ""){
	    alert("아이디를 입력하세요.");
	    document.pwfr.id.focus();
	    return false;
	}
	
	if(email == ""){
	    alert("이메일을 입력하세요.");
	    document.pwfr.email.focus();
	    return false;
	}
	
    if(!emailRegExp.test(email)) {
        alert("이메일 형식이 올바르지 않습니다.");
        document.pwfr.email.focus();
        return false;
     }
}
</script>
</head>
<body>
<h1>비밀번호 찾기</h1>
	<form action="pass_searchPro.jsp" name="pwfr" method="post" 
		  class="passsearch" onsubmit="return checkValue();">
		<label for="id" class="form-label"><b>ID</b></label> 
		<input type="text" name="id" class="form-control"><br>
		<label for="email" class="form-label"><b>Email</b></label> 
		<input type="text" name="email" class="form-control"><br><br> 
		<input type="submit" value="비밀번호 찾기">
	</form>
</body>
</html>