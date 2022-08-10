<%@page import="com.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.BoardDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="board_head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="board_navbar.jsp"></jsp:include>
	<%
		BoardDAO bDAO = new BoardDAO();
		int cnt = bDAO.getBoardCount();
		
		// 한 페이지에 출력할 글의 개수
		int pageSize = 5;

		// 현 페이지의 위치정보
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		
		// 시작행번호 계산
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		
		// 끝행번호 계산
		int endRow = currentPage * pageSize;
				
		ArrayList boardList = null;
		if(cnt > 0){
		   boardList = bDAO.getBoardList(startRow,pageSize); 
		}	
	%>
	<br><br>
    <h1>Community</h1>
	<div class="contents1">
		<div class="con_title">
			<p style="margin: 0px; text-align: right">
				<img style="vertical-align: middle" alt=""
					 src="../assets/imgs/home_icon.gif" /> 
					 &gt; 커뮤니티 &gt; <strong>정보공유게시판</strong>
			</p>
		</div>
	</div>
	<div class="board">
		<div class="board_top">
			<div class="bold">
				<p style="margin-right: 100px;">
					총<span class="txt_orange"> <%=cnt%></span>건
				</p>
			</div>
		</div>
		<button class="writebtn btn btn-dark" 
				onclick="location.href='writeForm.jsp';">글쓰기
		</button>
		<!-- 게시판  -->
		<table border="1" class="table table-hover">
			<tr style="background-color: #E7E9EB ;">
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>IP</th>
			</tr>
			<%
      	     		for(int i=0 ; i<boardList.size() ; i++){
    	     			BoardBean bb = (BoardBean) boardList.get(i);
            		%>
			<tr>
				<td><%=bb.getNum() %></td>
				<td>
				<%
			          int wid = 0;
			          if(bb.getRe_lev()>0){ // 답글일때
				        wid = 10 * bb.getRe_lev()+200;
				 %> <img src="../assets/imgs/level.gif" height="15" width="<%=wid%>"> 
				    <img src="../assets/imgs/re.gif"> 
				 <% } %> 
				 <a href='content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'> 
				 	<%=bb.getSubject() %>
				 </a>
				</td>
				<td><%=bb.getName() %></td>
				<td><%=bb.getDate() %></td>
				<td><%=bb.getReadcount() %></td>
				<td><%=bb.getIp() %></td>
			</tr>
	  		<%
           		}  
           		%>
		</table>
		<hr>
		<%
        	
		// 페이징처리
     	 	if(cnt > 0){
    		
			// 한 페이지에서 보여줄 페이지 번호의 개수 
    	 		int pageBlock = 5;    	
    		
			// 전체 페이지 개수 => 전체 글 / 페이지 크기
    	 		int pageCount = cnt / pageSize + (cnt % pageSize == 0? 0:1);
    		
			// 페이지 블럭 시작번호 계산 
    	 		int startPage =((currentPage-1)/pageBlock)*pageBlock+1;  	
    		
			// 페이지 블럭 끝번호 계산
    	 		int endPage = startPage + pageBlock - 1;
    	 	
			if(endPage > pageCount){
    			endPage = pageCount;
    			}
    	
    			// [이전]
    	 		if(startPage > pageBlock){
    			%>
				<a href="board.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
			<%
    			}
    	 	
			// 페이지 번호
			for(int i=startPage;i<=endPage;i++){
    			%>
				<a href="board.jsp?pageNum=<%=i%>">[<%=i %>]</a>
			<%
    			}    	
    		
			// [다음]
    	 		if(endPage < pageCount){
    			%>
				<a href="board.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
			<%
    			}  	 
      		
		}
      		%>
    	</div>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
