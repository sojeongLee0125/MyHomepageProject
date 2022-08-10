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
		alert("로그인 후 글을 수정하실 수 있습니다.!");
		location.href = "../member/loginForm.jsp";
	</script>
	<%
	}

     	int num = Integer.parseInt(request.getParameter("num"));
     	String pageNum = request.getParameter("pageNum");
     
     	BoardDAO bdao = new BoardDAO();
     	BoardBean bb = bdao.getBoard(num);    
   	%>
</head>
<body>
	<jsp:include page="board_navbar.jsp"></jsp:include>
	<br><br>
	<h1> Community</h1>
 	<div class="contents1" style="margin-top: 50px;">
		<div class="con_title">
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt=""
					src="../assets/imgs/home_icon.gif" /> 
					&gt; 커뮤니티 &gt; <strong>정보공유게시판</strong>
			</p>
		</div>
	</div>
	<fieldset class="updateform">
	<h2 class="update_title">작성 글 수정하기</h2>
		<form action="updatePro.jsp?pageNum=<%=pageNum %>" name="info_update" method="post">
			<div class="mb-3">
				<input type="hidden" name="num" value="<%=num%>"> 
  				<label for="name" class="form-label">글쓴이</label>
  				<input type="text" class="form-control" name="name" 
  				       value="<%=bb.getName()%>" readonly="readonly" id="name" >			
			</div>
			<div class="mb-3">
  				<label for="pass" class="form-label">비밀번호</label>
  				<input type="password" placeholder="비밀번호를 입력하세요." class="form-control" name="pass" id="pass" >			
			</div>
			<div class="mb-3">
  				<label for="subject" class="form-label">글제목</label>
  				<input type="text" class="form-control" name="subject" value="<%=bb.getSubject()%>" id="subject" >			
			</div>
			<div class="mb-3">
  				<label for="content" class="form-label">글내용</label>
  				<textarea style="resize: none;" rows="10" class="form-control" cols="20" name="content">
  				<%=bb.getContent() %>
  				</textarea>
			</div>
			<hr>
			<input type="submit" class="btn btn-dark" value="수정하기">     
			<input type="button" class="btn btn-danger" value="취소하기" onclick="history.back();">    
		</form>
	</fieldset>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
