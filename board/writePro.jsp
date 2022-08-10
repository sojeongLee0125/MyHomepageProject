<%@ page import="com.BoardBean"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
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
       
   int maxSize = 100 * 1024 * 1024;
 
   String realPath = request.getRealPath("/upload");
   System.out.println("realPath : "+realPath);
   
   // 파일 업로드
   MultipartRequest multi = 
                    new MultipartRequest(
                  		  request,
                  		  realPath,
                  		  maxSize,
                  		  "UTF-8",
                  		  new DefaultFileRenamePolicy()
                  		  );
   System.out.println("파일 업로드 완료");
   
   String name = multi.getParameter("name");
   String pass = multi.getParameter("pass");
   String file = multi.getFilesystemName("file");
   String subject = multi.getParameter("subject");
   String content = multi.getParameter("content");
    
   BoardBean bd = new BoardBean();
   bd.setName(name);
   bd.setPass(pass);
   bd.setFile(file);
   bd.setSubject(subject);
   bd.setContent(content);
   bd.setIp(request.getLocalAddr());
    
   BoardDAO bDAO = new BoardDAO();
   bDAO.insertBoard(bd);    
   response.sendRedirect("board.jsp");   
   %>   
    
</body>
</html>
