<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
<script type="text/javascript">

/* 우편번호 가져오기 */
function goPopup() {
	var pop = window.open("jusoPopup.jsp", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}

function jusoCallBack(roadFullAddr) {
	var addressInfo = document.querySelector("#address");
	addressInfo.value = roadFullAddr;
}

/* 회원가입 유효성 검증 */
function checkValue(){
	
	var id = document.userInfo.id.value;
	var pass = document.userInfo.pass.value;
	var passck = document.userInfo.passck.value;
	var name = document.userInfo.name.value;
	var age = document.userInfo.age.value;
	var gender = document.userInfo.gender.value;
	var email = document.userInfo.email.value;
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	var address = document.userInfo.address.value;
	var agree = document.userInfo.agree.checked;
		
	if(id == ""){
	    alert("아이디를 입력하세요.");
	    document.userInfo.id.focus();
	    return false;
	}
	
	if(document.userInfo.idDuplication.value != "idCheck"){
        alert("아이디 중복체크를 해주세요.");
        return false;
        }
		
	if(pass.length < 6 || pass.length > 15 ){
		alert("비밀번호를 6자 이상 15자 이내로 입력해주세요. ");
		document.userInfo.pass.focus();
		return false;
	}
	
	if(pass != passck ){
        alert("비밀번호가 동일하지 않습니다.");
        return false;
        }
	
	if(name == ""){
		alert("이름을 입력하세요.");
		document.userInfo.name.focus();
		return false;
	}
	
	if(age == ""){
		alert("나이을 입력하세요.");
		document.userInfo.age.focus();
		return false;
	}
	
	if ((age < "0" || age > "9")){
	    alert("나이는 숫자만 가능합니다.");
	    document.userInfo.age.focus();
	    return false;
	}
	
	if(gender == ""){
		alert("성별을 체크해 주세요");
		return false;
	}
	
	if(email == ""){
		alert("이메일를 입력하세요");
		document.userInfo.email.focus();
		return false;
	}
	
        if(!emailRegExp.test(email)) {
        alert("이메일 형식이 올바르지 않습니다.");
        document.userInfo.email.focus();
        return false;
        }
	
	if(address == ""){
		alert("주소정보를 입력하세요");
		document.userInfo.address.focus();
		return false;
	}	
	
	if(!agree){
		alert("이용약관에 동의하셔야 회원가입이 가능합니다.");
		document.userInfo.agree.focus();
		return false;
	}
}

// 아이디 중복체크
function winopen(){
	var id = document.userInfo.id.value;
	
	if(id == "" || id.length < 0){
		alert("아이디를 먼저 입력해주세요")
		document.userInfo.id.focus();
	}else if((id < "0" || id > "9") && (id < "A" || id > "Z") && (id < "a" || id > "z")){
	    alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
	    document.userInfo.id.focus();
	}else{
	    window.open("joinIdCheck.jsp?userid="+document.userInfo.id.value,"","width=500, height=300");
	}
}

// 취소 클릭시 메인화면 이동
function goFirstForm() {
    location.href="../home.jsp";
}  

// 아이디 중복체크 검증
function inputIdChk(){
    document.userInfo.idDuplication.value ="idUncheck";
}

// Terms & Privacy
function goTerms() {
	var pop = window.open("terms.jsp", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}
</script>
</head>
<body>
	<jsp:include page="member_navbar.jsp"></jsp:include>
	<div class="joinform" >
		<h2>JOIN-US</h2>
		<p>Please fill in this form to create an account.</p>
		<form action="joinPro.jsp" method="post" name="userInfo" class="userInfo"
		      onsubmit="return checkValue()" style="border:1px solid #ccc">
		        <label for="id"><b>ID</b></label>
			<input type="text" name="id" maxlength="12" placeholder="12자리 이내 영어와 숫자 조합" 
			        onkeydown="inputIdChk()" required="required" > 
		        <input type="button" value="중복확인" class="iddupli" onclick="winopen()"> <br> 
			<input type="hidden" name="idDuplication" value="idUncheck">
			<label for="pass"><b>Password</b></label>
			<input type="password" name="pass" maxlength="15" placeholder="6자 이상 15자 이내"><br>
			<label for="passck"><b>Repeat Password</b></label>
			<input type="password" name="passck" maxlength="15" placeholder="비밀번호를 똑같이 입력해 주세요."><br> 
			<label for="name"><b>Name</b></label>
			<input type="text" name="name" class="name" maxlength="5" placeholder="이름을 입력하시오."><br>
			<label for="age"><b>Age</b></label>
			<input type="text" name="age"  maxlength="2" placeholder="나이를 입력하시오."><br>
			<label for="gender"><b>Gender</b></label>
			<div class="select">
     			<input type="radio" id="select" name="gender" class="gender" value="남자">
     			<label for="select">남자</label>
    			<input type="radio" id="select2" name="gender" class="gender" value="여자">
    			<label for="select2">여자</label>
			</div>
			<label for="email"><b>E-mail</b></label>
			<input type="text" name="email" class="email" placeholder="이메일을 입력하시오."><br>
			<label for="address"><b>Address</b></label>
			<input type="text" id="address" name="address"
			       placeholder="주소를 입력하시오" readonly="readonly"> 
			<input type="button" name="addressbtn" class="addressbtn" value="주소검색" onclick="goPopup();">
			<hr>
			<label><input type="checkbox" checked="checked" 
						  name="agree" style="margin-bottom:15px">
						  이용 약관 및 개인정보 보호 정책에 동의합니다.
                        </label>
			<p>By creating an account you agree to our 
				<a href="javascript:goTerms();" style="color:dodgerblue">Terms & Privacy</a>.
			</p>
			<input type="submit" value="회원가입">
			<input type="reset" value="초기화"> 
			<input type="button" value="회원가입 취소" onclick="goFirstForm()">
		</form>
	</div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
