<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="member_head.jsp"></jsp:include>

<!-- 카카오 로그인  -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- 네이버 로그인  -->
<script type="text/javascript" 
        src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" 
        charset="utf-8">
</script>
</head>
<body>
	<%
	String id = (String) session.getAttribute("id");
	if (id != null) {
		response.sendRedirect("main.jsp");
	}
	%>
	<jsp:include page="member_navbar.jsp"></jsp:include>
	<div class="login_container">
		<form action="loginPro.jsp" method="post">
			<div class="login_row">
				<h2 class="top_description" style="text-align: center">
				Login with Social Media or Manually
				</h2>
				<div class="login_vl">
					<!-- 네이버 / 카카오 로그아웃 기능 몰래 삽입  -->
					<span class="login_inner" onclick="kakaoLogout();">or</span>
				</div>
				<div class="login_col">
					<div id="naver_id_login" style="margin-bottom: 10px;"></div>
					<a href="javascript:kakaoLogin();">
						<img src="../assets/imgs/kakao.png" style="width: 348px; height: 75px;">
					</a>
				</div>	
				<div class="login_col">
					<div class="hide-md-lg">
						<p>Or sign in manually:</p>
					</div>
					<input type="text" name="id" value="" class="login_id" placeholder="ID" required>
					<input type="password" name="pass" class="login_pass" placeholder="Password" required> 
					<button type="submit" class="submit_btn">LOG IN</button>
				</div>
			</div>
		</form>
	</div>
	<div class="login_bottom-container">
		<div class="login_row">
			<div class="login_col">
				<a href="joinForm.jsp" style="color: white" class="login_btn">Sign up</a>
			</div>
			<div class="login_col">
				<a href="javascript:passcheck();" style="color: white" class="login_btn">Forgot password?</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	/* 비밀번호 찾기 */
	function passcheck() {
		var pop = window.open("pass_search.jsp", "pop",
				"width=570,height=420, scrollbars=no, resizable=yes");
	}
	
	/* 카카오 소셜 로그인 */
	window.Kakao.init("84ad1ba1df9e1d2a9b342a6f3fe333b1");	
	
	function kakaoLogin() {
		window.Kakao.Auth.login({
			scope: 'profile_nickname, account_email, gender, age_range',
			success: function(authObj) {
				console.log(authObj);
				window.Kakao.API.request({
					url:'/v2/user/me',
					success: res => {
						const kakao_account = res.kakao_account;
						$('.login_id').val(kakao_account.email);
					}
				});
			}			
		});
	}
	
	/* 카카오 로그아웃 */
	function kakaoLogout() {
		/* 네이버 로그인된 것도 같이 로그아웃 되도록 실행 */
		naverLogout();		
	    
		if (Kakao.Auth.getAccessToken()) {
	            Kakao.API.request({
	              url: '/v1/user/unlink',
	              success: function (response) {
	        	 console.log(response)
	              },
	              fail: function (error) {
	          	 console.log(error)
	              },
	            })
	           Kakao.Auth.setAccessToken(undefined)
	       }
	}  
	
	/* 네이버 소셜 로그인 */
	var naver_id_login = new naver_id_login("LA85MtMzzQBm2Y265EP6", "http://localhost:8080/Project__01/member/loginForm.jsp");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("green", 3, 75);
	naver_id_login.setDomain(".service.com");
	naver_id_login.setState(state);
	naver_id_login.init_naver_id_login();
	console.log(naver_id_login.oauthParams.access_token);
	
	function naverSignInCallback() {
		$('.login_id').val(naver_id_login.getProfileData('email'));
	}
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	/*  네이버 로그아웃 */
	var testPopUp;
	function openPopUp() {
	    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
	}
	
	function closePopUp(){
	    testPopUp.close();
	}

	function naverLogout() {
		openPopUp();
		setTimeout(function() {
			closePopUp();
			}, 1000);
	}
	</script>
<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>
