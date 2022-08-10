<%@ page import="com.BoardBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="board_navbar.jsp"></jsp:include>
	
	<%
	String id = (String) session.getAttribute("id");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	BoardDAO bdao = new BoardDAO();

	// 글 조회수를 1증가
	bdao.updateReadcount(num);
	BoardBean bb = bdao.getBoard(num);
	String name = bb.getName();
	session.setAttribute("name", name);
	%>
	<br><br>
    <h1> Community</h1>
    	<div class="contents1"> 
		<div class="con_title"> 
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt="" src="../assets/imgs/home_icon.gif" /> 
					&gt; 커뮤니티 &gt; <strong>정보공유게시판</strong>
			</p>
		</div> 
	 </div>
	 <!--content  -->
	 <div class="content">
		<table width=100 style="table-layout: fixed" border="1" class="table table-striped table-bordered">
			<tr>
				<td>글번호</td>
				<td><%=bb.getNum()%></td>
				<td>조회수</td>
				<td><%=bb.getReadcount()%></td>
				<td>작성자</td>
				<td><%=name%></td>
				<td>작성일</td>
				<td><%=bb.getDate()%></td>
			</tr>
			<tr>
				<td>글제목</td>
				<td colspan="7"><%=bb.getSubject()%></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td colspan="3">
				미리보기: <a href="../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a>
				</td>
				<td colspan="4">
				다운로드: <a href="filedown.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile()%></a>
				</td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td colspan="7">
					<div class="mb-3">
  						<textarea style="resize: none;" class="form-control" name="content" rows="20" cols="100" readonly="readonly">
  						<%=bb.getContent()%>
  						</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="8">
				<c:if test="${id.equals(name)}">
					<input type="button" value="수정하기" class="btn btn-dark" 
					   	onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>';">
					<input type="button" value="삭제하기" class="btn btn-dark" 
					   	onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>';">
			    	</c:if>
			    	<input type="button" value="답글쓰기" class="btn btn-dark" 
				       onclick="location.href='reWriteForm.jsp?num=<%=bb.getNum()%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>';">
			    	<input type="button" value="목록으로" class="btn btn-dark" 
				       onclick="location.href='board.jsp?pageNum=<%=pageNum%>';">
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
