<%@ page import="com.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>
</head>
<body>
 <%
    // 로그아웃
    // 세션정보 초기화
    session.invalidate();
 %>
  <script type="text/javascript">
    alert('로그아웃되었습니다.');
    location.href="main.jsp";
  </script>
</body>
</html>