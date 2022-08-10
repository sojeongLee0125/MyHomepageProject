<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html lang="ko">
<head>
</head>
<body>

<%
	request.setCharacterEncoding( "utf-8" );
	String uploadPath = request.getRealPath("/upload");
	String seq = request.getParameter( "seq" );
	String pass = request.getParameter( "pass" );
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int flag = 2;
	
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		
		String sql = "select filename from galleryboard_db where seq=?"; 
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		rs = pstmt.executeQuery();
		
		String filename = null;
		
		if( rs.next() ) {
			filename = rs.getString( "filename" );
		}
		
		pstmt.close();
		
		sql = "delete from galleryboard_db where seq=? and pass=?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		pstmt.setString( 2, pass);

		int result = pstmt.executeUpdate();
		
		if( result == 0 ) {
			flag = 1;
		} else if( result == 1 ) {
			flag = 0;
			if( filename != null ) {
				File file = new File( uploadPath + "/" + filename );
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
		out.println( "alert('글을 성공적으로 삭제했습니다.');" );
		out.println( "location.href='board_list1.jsp';" );
	} else if(flag == 1){
		out.println( "alert('비밀번호가 잘못되었습니다.');" );
		out.println( "history.back();" );
	} else {
		out.println( "alert('글 삭제에 실패했습니다.');" );
		out.println( "history.back();" );	
	}
	out.println( "</script>" );
%>
</body>
</html>