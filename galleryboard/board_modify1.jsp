<%@ page language="java" contentType="text/html; charset=UTF-8"
	     pageEncoding="UTF-8"%>

<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
	request.setCharacterEncoding( "utf-8" );

	String cpage = request.getParameter( "cpage" );
	String seq = request.getParameter( "seq" );
	
	String subject = "";
	String name = "";
	String content = "";
	String filename = "";
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		
		String sql = "select subject, name, content, filename from galleryboard_db where seq=?";

		pstmt = con.prepareStatement( sql );
		pstmt.setString(1, seq);
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			subject = rs.getString( "subject" );
			name = rs.getString( "name" );
			content = rs.getString("content");
			filename = rs.getString("filename");
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
<link rel="stylesheet" type="text/css" href="../css/board_write.css">
    <%
	String id = (String)session.getAttribute("id");	
	if (id == null) {
	%>
	<script type="text/javascript">
	alert("로그인 후 수정하실 수 있습니다.");
	location.href = "../member/loginForm.jsp";
	</script>
	<%
	}
    %>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById("submit1").onclick = function() {
			if(document.mfrm.pass.value.trim() == "") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if(document.mfrm.pass.value != ${pass}){
				alert('비밀번호가 잘못되었습니다.');
				return false;
			}
			
			if(document.mfrm.subject.value.trim() == "") {
				alert("제목을 입력해 주세요.");
				return false;
			}
			
			if(document.mfrm.upload.value.trim() != "") {
				var extension = document.mfrm.upload.value.split('.').pop();
				if(extension != 'png' && extension != 'jpg' && extension != 'gif') {
					alert('이미지 파일을 입력해 주세요.');	
					return false;
				}
			}
			document.mfrm.submit();
		};
	};
</script>
</head>
<body>
<!-- 상단 디자인 -->
<jsp:include page="gallery_navbar.jsp"></jsp:include>
<br><br>
<h1> Community</h1>
<div class="contents1 gallery_modify"> 
	<div class="con_title"> 
		<p style="margin: 0px; text-align: right; margin-left: 300px; margin-right: 300px;">
			<img style="vertical-align: middle" alt="" src="images/home_icon.gif" /> 
			&gt; 커뮤니티 &gt; <strong>갤러리게시판</strong>
		</p>
	</div>
	<form action="board_modify1_ok.jsp" method="post" name="mfrm" enctype="multipart/form-data">
		<input type="hidden" name="cpage" value="<%=cpage %>" />
		<input type="hidden" name="seq" value="<%=seq %>" />
		<div class="contents_sub" style="padding-bottom: 100px;">	
			<!--게시판-->
			<h1>작성 글 수정하기</h1>	
			<div class="board_write" style="margin-top: 100px;">
				<table>
					<tr>
						<th class="form-label">글쓴이</th>
						<td class="top" colspan="3">
							<input type="text" name="name" value="<%=name %>" class="form-control" maxlength="5" readonly/>
						</td>
					</tr>
					<tr>
						<th class="form-label">제목</th>
						<td colspan="3">
							<input type="text" name="subject" value="<%=subject %>" class="form-control" />
						</td>
					</tr>
					<tr>
						<th class="form-label">비밀번호</th>
						<td colspan="3">
							<input type="password" name="pass" class="form-control"/>
						</td>
					</tr>
					<tr>
						<th class="form-label">내용</th>
						<td colspan="3">
							<textarea name="content" class="form-control"><%=content %></textarea>
						</td>
					</tr>
					<tr>
						<th class="form-label">첨부파일</th>
						<td colspan="3">
							기존 파일명 : <%=filename %><br /><br />
							<input type="file" name="upload" class="board_view_input" style="padding-bottom: 25px;"/>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="btn_area" style="padding-right: 450px; padding-left: 450px;">
				<div class="align_left">
					<input type="button" value="목록으로" class="btn btn-dark" style="cursor: pointer;" onclick="location.href='board_list1.jsp?cpage=<%=cpage %>'" />
					<input type="button" value="원글보기" class="btn btn-dark" style="cursor: pointer;" onclick="location.href='board_view1.jsp?cpage=<%=cpage %>&seq=<%=seq %>'" />
				</div>
				<div class="align_right">
					<input type="button" value="수정하기" id="submit1" class="btn_write btn btn-dark" style="cursor: pointer;" />
				</div>
			</div>
			<!--//게시판-->
		</div>
	</form>
</div>
<!-- 하단 디자인 -->
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>