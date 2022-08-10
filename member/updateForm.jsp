<%@ page import="com.MemberBean"%>
<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
<script type="text/javascript">

// 우편주소 불러오기
function goPopup() {
	var pop = window.open("jusoPopup.jsp", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}

function jusoCallBack(roadFullAddr) {
	var addressInfo = document.querySelector("#address");
	addressInfo.value = roadFullAddr;
}

// 수정 유효성 검사	
function updateCheck(){
	
    	var o_passcheck = ${pass};
	var pass = document.updateuserInfo.pass.value;
	var passck = document.updateuserInfo.passck.value;
	var name = document.updateuserInfo.name.value;
	var age = document.updateuserInfo.age.value;
	var gender = document.updateuserInfo.gender.value;
	var email = document.updateuserInfo.email.value;
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	var address = document.updateuserInfo.address.value;
    
	if(pass.length < 6 || pass.length > 15 ){
		alert("비밀번호를 6자 이상 15자 이내로 입력해주세요. ");
		document.updateuserInfo.pass.focus();
		return false;
	}
	
    	if(pass != o_passcheck){
    	 	alert("비밀번호가 올바르지 않습니다.")
    	 	return false;
    	}
    
    	if(passck == ""){
        	alert("비밀번호 확인을 입력해주세요.")
        	return false;	
    	}
     
    	if(pass != passck){
   		alert("비밀번호 확인이 일치하지 않습니다.")
   		return false;
    	}
        
	if(name == ""){
		alert("이름을 입력하세요.");
		document.updateuserInfo.name.focus();
		return false;
	}
	
	if(age == ""){
		alert("나이을 입력하세요.");
		document.updateuserInfo.age.focus();
		return false;
	}
	
	if ((age < "0" || age > "9")){
	    alert("나이는 숫자만 가능합니다.");
	    document.updateuserInfo.age.focus();
	    return false;
	}
	
	if(gender == ""){
		alert("성별을 체크해 주세요");
		return false;
	}
	
	if(email == ""){
		alert("이메일를 입력하세요");
		document.updateuserInfo.email.focus();
		return false;
	}
	
    	if(!emailRegExp.test(email)) {
        	alert("이메일 형식이 올바르지 않습니다.");
        	document.updateuserInfo.email.focus();
        	return false;
     	}
	
	if(address == ""){
		alert("주소정보를 입력하세요");
		document.updateuserInfo.address.focus();
		return false;
	}
}

// 취소 클릭시 메인화면 이동
function goFirstForm() {
    location.href="main.jsp";
}  

</script>
</head>
<body>
<jsp:include page="member_navbar.jsp"></jsp:include>
	
	<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
	}

	MemberDAO mDAO = new MemberDAO();
	MemberBean mb = mDAO.updateInfoMember(id);
	%>

	<div class="updateform" >
		<h2>회원정보 수정</h2>
		<form action="updatePro.jsp" method="post" name="updateuserInfo" class="updateuserInfo"
		      onsubmit="return updateCheck()" style="border:1px solid #ccc">
		    	<label for="id"><b>ID</b></label>
			<input type="text" name="id" value="<%=id %>" readonly="readonly"> 	 
			<label for="pass"><b>Password</b></label>
			<input type="password" name="pass" maxlength="15" placeholder="비밀번호를 입력하시오."><br>
			<label for="passck"><b>Repeat Password</b></label>
			<input type="password" name="passck" maxlength="15" placeholder="비밀번호를 똑같이 입력해 주세요."><br> 
			<label for="name"><b>Name</b></label>
			<input type="text" name="name" maxlength="5" value="<%=mb.getName()%>"><br>
			<label for="age"><b>Age</b></label>
			<input type="text" name="age"  maxlength="2" value="<%=mb.getAge()%>"><br>
			<label for="gender"><b>Gender</b></label>
			<div class="select">
     				<input type="radio" id="select" name="gender" value="남자"
     				<%if(mb.getGender().equals("남자")){ %>
		           			checked
		        	<%} %>
     				><label for="select">남자</label>
    				<input type="radio" id="select2" name="gender" value="여자"
    				<%if(mb.getGender().equals("여자")){ %>
		           			checked
		        	<%} %>
    				><label for="select2">여자</label>
			</div>
			<label for="email"><b>E-mail</b></label>
			<input type="text" name="email" value="<%=mb.getEmail()%>"><br>
			<label for="address"><b>Address</b></label>
			<input type="text" id="address" name="address" value="<%=mb.getAddress()%>"> 
			<input type="button" name="addressbtn" class="addressbtn" value="주소검색" onclick="goPopup();">
			<hr>
			<input type="submit" value="수정하기">
			<input type="reset" value="초기화"> 
			<input type="button" value="수정취소" onclick="goFirstForm()">
		</form>
	</div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
