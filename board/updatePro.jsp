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
   %>
    <jsp:useBean id="bb" class="com.BoardBean"/>
    <jsp:setProperty property="*" name="bb"/>
   <%   
    BoardDAO bDAO = new BoardDAO();
    int check = bDAO.updateBoard(bb); 
    
    // 수정된 결과에 따른 페이지 이동 (-1, 0, 1)
    if(check == 1){
    	%>
    	 <script type="text/javascript">
    	    alert("글 수정을 완료하였습니다.");
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
    }else{
    	%>
	  <script type="text/javascript">
	     alert("비밀번호를 입력해주세요!");
	     history.back();
	  </script>    	
   	<%
    }
   %>
</body>
</html>
