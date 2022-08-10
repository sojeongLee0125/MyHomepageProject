<%@ page import="com.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
</head>
<body>
   <%
     request.setCharacterEncoding("UTF-8");
     String pageNum = request.getParameter("pageNum");
     
     int num = Integer.parseInt(request.getParameter("num"));
     String pass =  request.getParameter("pass");
     
     BoardDAO bDAO = new BoardDAO();
     int check = bDAO.deleteBoard(num,pass);
     
     if(check == 1){
    	%>
    	 <script type="text/javascript">
    	    alert("글 정보 삭제완료!");
    	    location.href='board.jsp?pageNum=<%=pageNum%>';
    	 </script>    	
    	<%
     }else if(check == 0){
    	%>
    	 <script type="text/javascript">
    	     alert("비밀번호 오류입니다.");
    	     history.back();
    	 </script>    	
    	<%
     }else{ //check == -1
      	%>
	<script type="text/javascript">
             alert("해당 글 정보가 없습니다.");
	     history.back();
	</script>    	
   	<%
     }
   %>
</body>
</html>
