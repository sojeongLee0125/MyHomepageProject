<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
<title>Translator</title>
<style type="text/css">

h1{
font-family: sans-serif;
text-align: center;
margin-top: 20px;
font-weight: bold;
}

.translator{
	margin-top: 30px;
	margin-left: 90px;
}

.btn{
	padding-right: 180px;
	padding-left: 180px;
}

</style>
</head>
<body>
	<h1>언어 번역기</h1>
	<div class="translator">
		<select id="src">
			<option value="kr">번역전: 한국어</option>
			<option value="en">번역전: 영어</option>
			<option value="jp">번역전: 일본어</option>
			<option value="cn">번역전: 중국어</option>
		</select>  
		<br><br>
		<textarea id="TextValue" rows="10" cols="50"></textarea>
		<br><br>
		<button id="search" class="btn btn-success">번역하기</button>
		<br><br>
		<select id="target">
			<option value="kr">번역후: 한국어</option>
			<option value="en">번역후: 영어</option>
			<option value="jp">번역후: 일본어</option>
			<option value="cn">번역후: 중국어</option>
		</select>
		<br><br>
		<textarea rows="10" cols="50"></textarea>
	</div>
	<!-- Jquery  -->
	<script
        src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous"
        ></script>
    	
	<!-- open api function -->
    	<script>
      	$(document).ready(function () {
        $("#search").click(function () {
          $.ajax({
            method: "GET",
            url: "https://dapi.kakao.com/v2/translation/translate",
            data: { 
            	query: $("#TextValue").val(),
            	src_lang: $("#src option:selected").val(),
            	target_lang: $("#target option:selected").val()
            },
            headers: {
              Authorization: "KakaoAK 11c19f191a250ea47ad8a4cc69a78aa1",
            },
          }).done(function (msg) {
            $("textarea").text(msg.translated_text);
          });
         });
     	});
       </script>
</body>
</html>
