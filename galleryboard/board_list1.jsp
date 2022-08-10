<%@ page import="com.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="gallery_head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/board_list.css">
</head>
<body>
<jsp:include page="gallery_navbar.jsp"></jsp:include>
	<%
	request.setCharacterEncoding("utf-8");
	BoardDAO bDAO = new BoardDAO();
        int cnt = bDAO.getgalleryCount();

	int cpage = 1;
	
	if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
		cpage = Integer.parseInt(request.getParameter("cpage"));
	}

	int recordPerPage = 2;
	int totalRecord = 0;
	int totalPage = 5;
	int blockPerPage = 5;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	StringBuffer result = new StringBuffer();
	
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
	
		String sql = "select seq, subject, name, filename, date_format(wdate, '%Y-%m-%d %H:%m') wdate, hit, datediff(now(), wdate) wgap from galleryboard_db order by seq desc";
		pstmt = con.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
		rs = pstmt.executeQuery();
		rs.last();
		totalRecord = rs.getRow();
		rs.beforeFirst();
		totalPage = ( ( totalRecord - 1 ) / recordPerPage ) + 1;
		
		int skip = ( cpage - 1 ) * recordPerPage;
		if( skip != 0 ) rs.absolute( skip );
		
		for( int i=0 ; i<recordPerPage && rs.next() ; i++ ) {
			String seq = rs.getString( "seq" );
			String subject = rs.getString( "subject" );
			String name = rs.getString( "name" );
			String filename = rs.getString( "filename" );
			String wdate = rs.getString( "wdate" );
			String hit = rs.getString( "hit" );
			int wgap = rs.getInt( "wgap" );
			
			result.append( "<tr>" );
			result.append( "	<td class='last2'>" );
			result.append( "		<div class='board'>" );
			result.append( "			<table class='boardT'>" );
			result.append( "			<tr>" );
			result.append( "				<td class='boardThumbWrap'>" );
			result.append( "					<div class='boardThumb'>" );
			result.append( "						<a href='board_view1.jsp?cpage=" + cpage + "&seq=" + seq + "'><img src='../upload/" + filename + "' border='0' width='100%' /></a>" );
			result.append( "					</div>" );
			result.append( "				</td>" );
			result.append( "			</tr>" );
			result.append( "			<tr>" );
			result.append( "				<td class='boardThumbWraptd'>" );
			result.append( "					<div class='boardItem'>" );	
			result.append( "						<strong>" + subject +"</strong>" );
			if( wgap == 0 ) {
				result.append( "					<img src='../assets/imgs/icon_new.gif' alt='NEW'>") ;
			}
			result.append( "					</div>" );
			result.append( "				</td>" );
			result.append( "			</tr>" );
			result.append( "			<tr>" );
			result.append( "				<td class='boardThumbWraptd'><div class='boardItem'><span class='bold_blue'>" + name + "</span></div></td>" );
			result.append( "			</tr>" );
			result.append( "			<tr>" );
			result.append( "				<td class='boardThumbWraptd'><div class='boardItem'>" + wdate + " <font>|</font> Hit " + hit + "</div></td>" );
			result.append( "			</tr>") ;
			result.append( "		</table>" );
			result.append( "	</div>" );
			result.append( "</td>" );
			result.append( "</tr>" );
		}
	} catch( NamingException e ) {
		System.out.println( "[에러] : " + e.getMessage() );
	} catch(SQLException e) {
		System.out.println( "[에러] : " + e.getMessage() );
	} finally {
		if( rs != null ) rs.close();
		if( pstmt != null ) pstmt.close();
		if( con != null ) con.close();
	}
%>

<br><br>
<h1>Community</h1>
<div class="gallery_list"> 
	<div class="con_title"> 
		<p style="margin: 0px; text-align: right">
			<img style="vertical-align: middle" alt="" src="../assets/imgs/home_icon.gif" /> 
			&gt; 커뮤니티 &gt; <strong>갤러리게시판</strong>
		</p>
	</div> 
	<div class="contents_sub">			
		<div class="board_top">
			<div class="bold">
				<p>총 <span class="txt_orange"><%=cnt %></span>건</p>
			</div>
		</div>	
		<!--게시판-->
		<table class="board_list" style="padding-left: 600px;">
		<%=result %>
		</table>
		<!--버튼-->	
		<div class="align_right">		
			<input type="button" value="글쓰기" class="btn btn-dark" style="cursor: pointer;" onclick="location.href='board_write1.jsp?cpage=<%=cpage %>'" />
		</div>
		<!-- 페이지 -->
		<div class="paginate_regular">
			<div class="board_pagetab" align="middle">
			<%			
			int startBlock = ( ( cpage-1 ) / blockPerPage ) * blockPerPage + 1;
			int endBlock = ( ( cpage-1 ) / blockPerPage ) * blockPerPage + blockPerPage;
			if( endBlock >= totalPage ) {
				endBlock = totalPage;
			}

			if( startBlock == 1 ) {
				out.println( "<span class='on'>&lt;&lt;</span>" );
			} else {
				out.println( "<span class='off'><a href='board_list1.jsp?cpage=" + ( startBlock - blockPerPage ) + "'>&lt;&lt;</a></span>" );
			}

			out.println( "&nbsp;" );

			if( cpage == 1 ) {
				out.println( "<span class='on'>&lt;</span>" );
			} else {
				out.println( "<span class='off'><a href='board_list1.jsp?cpage=" + ( cpage - 1 )+ "'>&lt;&nbsp;</a></span>" );
			}

			out.println( "&nbsp;&nbsp;" );

			for( int i=startBlock ; i<=endBlock ; i++ ) {
				if( cpage == i ) {
					out.println( "<span class='on'>[ " + i + " ]</span>" );
				} else {
					out.println( "<span class='off'><a href='board_list1.jsp?cpage=" + i + "'>" + i + "</a></span>" );
				}
			}

			out.println( "&nbsp;&nbsp;" );

			if( cpage == totalPage ) {
				out.println( "<span class='on'>&gt;</span>" );
			} else {
				out.println( "<span class='off'><a href='board_list1.jsp?cpage=" + ( cpage + 1 )+ "'>&gt;</a></span>" );
			}

			out.println( "&nbsp;" );

			if( endBlock == totalPage ) {
				out.println( "<span class='on'>&gt;&gt;</span>" );
			} else {
				out.println( "<span class='off'><a href='board_list1.jsp?cpage=" + ( startBlock + blockPerPage ) + "'>&gt;&gt;</a></span>" );
			}
			%>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
