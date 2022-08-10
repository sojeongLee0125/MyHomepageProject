<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding( "utf-8" );
	String id = (String) session.getAttribute("id");
	String cpage = request.getParameter( "cpage" );
	String seq = request.getParameter( "seq" );
	
	String subject = "";
	String name = "";
	String wip = "";
	String wdate = "";
	String hit = "";
	String content = "";
	String filename = "";
	String file = "";
	
	String pseq = "";
	String psubject = "";
	String nseq = "";
	String nsubject = "";
		
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	StringBuffer cresult = new StringBuffer();
	
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		
		String sql = "update galleryboard_db set hit=hit+1 where seq=?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		pstmt.executeUpdate();
		
		pstmt.close();
		
		sql = "select subject, name, wip, wdate, hit, content, filename, filesize from galleryboard_db where seq=?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		rs = pstmt.executeQuery();
		if( rs.next() ) {
			subject = rs.getString( "subject" );
			name = rs.getString( "name" );
			wip = rs.getString( "wip" ); 
			wdate = rs.getString( "wdate" );
			hit = rs.getString( "hit" );
			content = rs.getString( "content" ).replaceAll( "\n", "<br />" );
			filename = rs.getString( "filename" );
		}
		
		session.setAttribute("name", name);
		
		// 이전글
		sql = "select max(seq) seq, subject from galleryboard_db where seq < ?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			pseq = rs.getString( "seq" );
			psubject = rs.getString( "subject" );
		}
		
		// 다음글
		sql = "select min(seq) seq, subject from galleryboard_db where seq > ?";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, seq );
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			nseq = rs.getString( "seq" );
			nsubject = rs.getString( "subject" );
		}
	} catch( NamingException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} catch( SQLException e ) {
		System.out.println( "[에러] " + e.getMessage() );
	} finally {
		if( rs != null ) rs.close();
		if( pstmt != null ) pstmt.close();
		if( con != null ) con.close();
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="gallery_head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/board_view.css">
</head>
<body>
<jsp:include page="gallery_navbar.jsp"></jsp:include>
<br><br>
<h1> Community</h1>
<div class="contents1"> 
	<div class="con_title"> 
		<p style="margin: 0px; text-align: right; margin-left: 200px; margin-right: 200px;">
			<img style="vertical-align: middle;" alt="" src="../assets/imgs/home_icon.gif" /> &gt; 커뮤니티 &gt; <strong>갤러리게시판</strong>
		</p>
	</div>
	<div class="contents_view">	
	<!--게시판-->
		<div class="board_view">
			<table>
			<tr>
				<th width="10%">제목</th>
				<td width="90%"><%=subject %></td>
				<th width="20%">등록일</th>
				<td width="80%"><%=wdate %></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><%=name + "(" + wip + ")" %></td>
				<th>조회</th>
				<td><%=hit %></td>
			</tr>			
			<tr>
				<td colspan="4" height="200" valign="top" style="padding:20px; line-height:160%;">
					<div id="bbs_file_wrap">
						<div>
							<img class="view_img" src="../upload/<%=filename %>" style="margin-left: 250px;  width:800px; height: 1000px; " onerror=""  /><br />
						</div>
					</div>
					<span style="font-size: 40px; padding-left: 250px;"><%=content %></span>
				</td>
			</tr>			
			</table>
		</div>
		<div class="btn_area">
			<div class="align_left">			
				<input type="button" value="목록으로" class="btn_list btn btn-dark" style="cursor: pointer;" onclick="location.href='board_list1.jsp?cpage=<%=cpage %>'" />
			</div>
			<div class="align_right">
				<c:if test="${id.equals(name)}">
				<input type="button" value="수정하기" class="btn_list btn btn-dark" style="cursor: pointer;" onclick="location.href='board_modify1.jsp?cpage=<%=cpage %>&seq=<%=seq %>'" />
				<input type="button" value="삭제하기" class="btn_list btn btn-dark" style="cursor: pointer;" onclick="location.href='board_delete1.jsp?cpage=<%=cpage %>&seq=<%=seq %>'" />
				</c:if>
				<input type="button" value="글쓰기" class="btn_write btn btn-dark" style="cursor: pointer;" onclick="location.href='board_write1.jsp?cpage=<%=cpage %>'" />
			</div>	
		</div>
		<!--//게시판-->
		
		<!-- 이전글 / 다음글 -->
		<div class="next_data_area">
<%
	if( pseq == null ) {
		out.println( "<span class='b'>이전글 | </span><a>이전글이 없습니다.</a>" );				
	} else {
		out.println( "<span class='b'>이전글 | </span><a href='board_view1.jsp?cpage=" + cpage + "&seq=" + pseq + "'>" + "이전글 보기" + "</a>" );		
	}
%>
		</div>
		<div class="prev_data_area">
<%
	if( nseq == null ) {
		out.println( "<span class='b'>다음글 | </span><a>다음글이 없습니다.</a>" );				
	} else {
		out.println( "<span class='b'>다음글 | </span><a href='board_view1.jsp?cpage=" + cpage + "&seq=" + nseq + "'>" + "다음글 보기" + "</a>" );		
	}
%>
		</div>
	</div>
</div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>