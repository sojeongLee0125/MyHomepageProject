<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
</head>
<body>
   
   <%
     // 전달된 파라미터값 file_name
     String fileName = request.getParameter("file_name");
   
     // 서버에 업로드 폴더명
     String savePath = "upload";
     
     // 프로젝트(=context)
     ServletContext ctx = getServletContext();
     
     // "upload" 폴더의 실제 물리적인 경로
     String sDownloadPath = ctx.getRealPath(savePath);
     
     // 파일을 다운로드할 전체 경로를 생성
     String sFilePath = sDownloadPath + "\\" +fileName;
          
     // 파일을 저장시 한번에 큰 크기로 저장하는 배열 (버퍼)
     byte[] b = new byte[4096];
     
     // 파일 입출력 객체 
     FileInputStream fis = new FileInputStream(sFilePath);
     
     // 다운로드할 파일의 마임타입을 체크     
     String sMimeType = getServletContext().getMimeType(sFilePath);
          
     if(sMimeType == null){
    	 sMimeType = "application/octet-stream";
     }
     
     // 응답할 페이지의 데이터 마임타입을 설정
     response.setContentType(sMimeType);
     
     // 사용자의 브라우저 정보를 체크 (ie)     
     String agent = request.getHeader("User-Agent");
     
     boolean ieBrowser = (agent.indexOf("MSIE")>-1) || (agent.indexOf("Trident") > -1);
     
     // 파일명의 한글처리
     if(ieBrowser){
    	 //IE일 경우 다운로드시 한글이 깨짐, 공백문자 [+]표시되기 때문에 공백문자(%20)으로 변경
    	 fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
     }else{
    	 fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
     }
         
      // 다운로드 창의 형태로 실행
      response.setHeader("Content-Disposition", "attachment; filename="+fileName);
     
     // 응답객체를 사용해서 데이터 출력 통로를 생성
     ServletOutputStream out2 = response.getOutputStream();
     
     int numRead;
     
     while( (numRead = fis.read(b,0,b.length)) != -1){
    	 out2.write(b,0,numRead);
     }
     
     out2.flush();
     out2.close();
     fis.close();     
   
   %>
</body>
</html>