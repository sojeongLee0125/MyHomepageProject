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
   %>
   <jsp:useBean id="bb" class="com.BoardBean"/>
   <jsp:setProperty property="*" name="bb" />    		
   <% 
    bb.setIp(request.getRemoteAddr());
    BoardDAO bDAO = new BoardDAO();
    bDAO.reInsertBoard(bb);    
    response.sendRedirect("board.jsp");
   %>
</body>
</html>
