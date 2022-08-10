<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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

	MultipartRequest multi = new MultipartRequest( request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy() );

	String cpage = multi.getParameter( "cpage" );
	String seq = multi.getParameter( "seq" );
	String pass = multi.getParameter( "pass" );
	
	String subject = multi.getParameter( "subject" );
	String content = multi.getParameter( "content" );
	
	String newFilename = multi.getFilesystemName( "upload" );
	long newFilesize = 0;
	File newFile = multi.getFile( "upload" ); 
	if( newFile != null ) {
		newFilesize = newFile.length();
	}
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int flag = 2;
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		
		String sql = "";
		sql = "select filename from galleryboard_db where seq=?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		rs = pstmt.executeQuery();
		
		String oldFilename = null;
		
		if( rs.next() ) {
			oldFilename = rs.getString( "filename" );
		}
		
		pstmt.close();
		
		if( newFilename != null ) {
			sql = "update galleryboard_db set subject=?, content=?, filename=?, filesize=? where seq=? and pass=?";
			pstmt = con.prepareStatement( sql );
			pstmt.setString( 1, subject );
			pstmt.setString( 2, content );
			pstmt.setString( 3, newFilename );
			pstmt.setLong( 4, newFilesize );
			pstmt.setString( 5, seq );
			pstmt.setString( 6, pass );				
		} else {
			sql = "update galleryboard_db set subject=?, content=? where seq=? and pass=?";
			pstmt = con.prepareStatement( sql );
			pstmt.setString( 1, subject );
			pstmt.setString( 2, content );
			pstmt.setString( 3, seq );
			pstmt.setString( 4, pass );
		}
		
		int result = pstmt.executeUpdate();
		if( result == 0 ) {
			flag = 1;
		} else if( result == 1 ) {
			flag = 0;
			if( newFilename != null && oldFilename != null ) {
				File file = new File( uploadPath + "/" + oldFilename );
				file.delete();
			}
		}
	} catch( NamingException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} catch( SQLException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} finally {
		if( pstmt != null ) pstmt.close();
		if( con != null ) con.close();
	}
	
	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert('글을 성공적으로 수정했습니다.');" );
		out.println( "location.href='board_view1.jsp?cpage=" + cpage + "&seq=" + seq + "';");
	} else if( flag == 1 ) {
		out.println( "alert('비밀번호가 잘못되었습니다.');" );
		out.println( "history.back();" );
	} else {
		out.println( "alert('글수정에 실패했습니다.');" );
		out.println( "history.back();" );	
	}
	out.println( "</script>" );
%>    
</body>
</html>