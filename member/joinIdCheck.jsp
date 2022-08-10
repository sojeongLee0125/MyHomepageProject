<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="member_head.jsp"></jsp:include>
<style type="text/css">

h2{
font-weight: bold;
margin-left: 140px;
margin-top: 50px;
margin-bottom: 50px;
}

div{
margin-left: 80px;
margin-right: 70px;
}

fieldset{
margin-top: 10px;
}

span{
font-size: 20px;
}

.btn-danger{
margin-left: 5px;
width: 27%;

}

input[type="text"]{
width: 60%;
display: inline;
}

</style>
</head>
<body>
<h2>아이디 중복체크</h2>
<div>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("userid");

MemberDAO mdao = new MemberDAO();

int result = mdao.joinIdCheck(id);

if (result == 1){
%>
	 <span>사용가능한 아이디 입니다</span>&nbsp;
	 <input type="button" class="btn btn-dark" value="사용하기" onclick="result();">
<%
} else if (result == 0){
%>
	 <span>중복된 아이디 입니다.</span>
<%
}else{
	out.print("에러 발생!!!"); 
}
%>

<fieldset>
	<form action="joinIdCheck.jsp" method="post" name="ckfr">
		<label for="id" class="form-label"><b>ID</b></label>
    	<input type="text" name="userid" class="form-control" value="<%=id%>">
    	<input type="submit" class="btn btn-danger" value="중복 확인">
	</form>
</fieldset>
</div>

<!-- 선택된아이디 중복확인창에서 회원가입 페이지로 정보전달  -->
 <script type="text/javascript">
    function result(){
    	opener.document.userInfo.id.value = document.ckfr.userid.value;
    	opener.document.userInfo.id.readOnly=true;  
    	opener.document.userInfo.idDuplication.value ="idCheck";
    	window.close();
    } 
 </script>
</body>
</html>