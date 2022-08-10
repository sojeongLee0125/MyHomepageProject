<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="gallery_head.jsp"></jsp:include>
	<%
	String id = (String)session.getAttribute("id");	
	if (id == null) {
	%>
	<script type="text/javascript">
		alert("로그인 후 글을 삭제하실 수 있습니다.");
		location.href = "../member/loginForm.jsp";
	</script>
	<%
	}
	%>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById('submit1').onclick = function() {
			if (document.dfrm.pass.value.trim() == "") {
				alert('비밀번호를 입력해주세요.');
				return false;
			}
			document.dfrm.submit();
		};
	};
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String cpage = request.getParameter("cpage");
	String seq = request.getParameter("seq");
	String subject = "";
	String name = "";

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();

		String sql = "select subject, name from galleryboard_db where seq=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, seq);

		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			subject = rs.getString("subject");
			name = rs.getString("name");
		}
	} catch (NamingException e) {
		System.out.println("[에러] " + e.getMessage());
	} catch (SQLException e) {
		System.out.println("[에러] " + e.getMessage());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}
	%>
	<jsp:include page="gallery_navbar.jsp"></jsp:include>
	<div class="gallery_delete">
		<div class="con_title"> 
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt="" src="../assets/imgs/home_icon.gif" /> 
				&gt; 커뮤니티 &gt; <strong>갤러리게시판</strong>
			</p>
		</div> 

		<h2>정말로 삭제하시겠습니까?</h2>
		<img class="gallery_delete_img" src="../assets/imgs/recheck.gif" />
		<br><br>
		<form action="board_delete1_ok.jsp" method="post" name="dfrm">
			<input type="hidden" name="seq" value="<%=seq%>" />
			<div class="mb-3">
				    	<label for="subject" class="form-label">제목</label> 
					<input type="text" class="form-control" name="subject" value="<%=subject%>" readonly="readonly">  
				    	<label for="name" class="form-label">글쓴이</label> 
					<input type="text" class="form-control" name="name" value="<%=name%>" readonly="readonly">  
					<label for="pass" class="form-label">비밀번호</label> 
					<input type="password" class="form-control" name="pass"> 			
			</div>
			<div class="btn_area">
					<input type="button" class="btn btn-dark"  id="submit1" value="삭제하기" style="cursor: pointer;" />
					<input type="button" value="취소하기" class="btn btn-danger"
					       style="cursor: pointer;"
					       onclick="location.href='board_view1.jsp?cpage=<%=cpage%>&seq=<%=seq%>'" />
					<input type="button" value="목록으로" class="btn btn-dark"
					       style="cursor: pointer;" onclick="location.href='board_list1.jsp?cpage=<%=cpage%>'" /> 
			</div>
		</form>
	</div>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
