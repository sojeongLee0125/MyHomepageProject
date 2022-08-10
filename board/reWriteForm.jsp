<%@ page import="com.BoardBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>

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
	function checkPass() {

		var pass = document.rewrite.pass.value;
		var passcheck = ${pass};

		if (pass != passcheck) {
			alert("비밀번호가 올바르지 않습니다.");
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="board_navbar.jsp"></jsp:include>
	<br><br>
	<h1> Community</h1>
   <%
   int num = Integer.parseInt(request.getParameter("num"));
   int re_ref = Integer.parseInt(request.getParameter("re_ref"));
   int re_lev = Integer.parseInt(request.getParameter("re_lev"));
   int re_seq = Integer.parseInt(request.getParameter("re_seq"));
   %>
   	<div class="contents1" style="margin-top: 50px;">
		<div class="con_title">
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt="" src="../assets/imgs/home_icon.gif" /> 
					&gt; 커뮤니티 &gt; <strong>정보공유게시판</strong>
			</p>
		</div>
	</div>
  <fieldset class="rewriteform">
   <h2 class="update_title">답글쓰기</h2>
   <form action="reWritePro.jsp" name="rewrite" method="post" onsubmit="return checkPass()">
       <input type="hidden" name="num" value="<%=num%>">
       <input type="hidden" name="re_ref" value="<%=re_ref%>">
       <input type="hidden" name="re_lev" value="<%=re_lev%>">
       <input type="hidden" name="re_seq" value="<%=re_seq%>">
       <div class="mb-3">
  		<label for="name" class="form-label">작성자</label>
  		<input type="text" class="form-control" name="name" value="<%=id%>" readonly="readonly" >			
       </div>
       <div class="mb-3">
  		<label for="pass" class="form-label">비밀번호</label>
  		<input type="password" class="form-control" name="pass">			
       </div>
       <div class="mb-3">
  		<label for="subject" class="form-label">글제목</label>
  		<input type="text" class="form-control" name="subject" value="[답글]">			
       </div>
       <div class="mb-3">
  		<label for="content" class="form-label">글내용</label>
      		<textarea style="resize: none;" rows="10" cols="20" class="form-control"  name="content"></textarea>
       </div>      	      	
       <hr>
       <input type="submit" class="btn btn-dark" value="답글쓰기">     
       <input type="button" class="btn btn-dark" value="목록으로" onclick="location.href='board.jsp';">     
   </form>
  </fieldset>
  <jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
