<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>    
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html lang="ko">
<head>
</head>
<body>
<%
	String uploadPath = request.getRealPath("/upload");
	int maxFileSize = 1024 * 1024 * 10;
	String encoding = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy() );
	
	String subject = multi.getParameter( "subject" );
	String name = multi.getParameter( "name" );
	String pass = multi.getParameter( "pass" );
	String content = multi.getParameter( "content" );
	String wip = request.getRemoteAddr();
	
	String filename = multi.getFilesystemName( "upload" );
	long filesize = 0;
	File file = multi.getFile( "upload" ); 
	if( file != null ) {
		filesize = file.length();
	}
	
	Connection con = null;
	PreparedStatement pstmt = null;
	
	int flag = 1;
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		
		String sql = "insert into galleryboard_db values (0, ?, ?, ?, ?, ?, ?, 0, ?, now())";
		pstmt = con.prepareStatement( sql );
		
		pstmt.setString( 1, subject );
		pstmt.setString( 2, name );
		pstmt.setString( 3, pass );
		pstmt.setString( 4, content );
		pstmt.setString( 5, filename );
		pstmt.setLong( 6, filesize );
		pstmt.setString( 7, wip );
		
		int result = pstmt.executeUpdate();
		if( result == 1 ) {
			flag = 0;
		}
	} catch( NamingException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} catch( SQLException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} finally {
		if( pstmt != null ) pstmt.close();
		if( con != null ) con.close();		
	}
	
	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println( "alert('글쓰기에 성공했습니다.');" );
		out.println( "location.href='board_list1.jsp';" );
	} else {
		out.println( "alert('글쓰기에 실패했습니다.');" );
		out.println( "history.back();");
	}
	out.println( "</script>" );
%>
</body>
</html>