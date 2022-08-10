<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="gallery_head.jsp"></jsp:include>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	String cpage = request.getParameter("cpage");
	
	if (id == null) {
	%>
	<script type="text/javascript">
		alert("로그인 후 글을 작성하실 수 있습니다.!");
		location.href = "../member/loginForm.jsp";
	</script>
	<%
	}
	%>
	<script type="text/javascript">
		window.onload = function() {
			document.getElementById('submit1').onclick = function() {
				if (document.wfrm.info.checked == false) {
					alert('이용약관에 동의를 하셔야 합니다.');
					return false;
				}

				if (document.wfrm.name.value.trim() == "") {
					alert('이름을 입력해주세요.');
					return false;
				}
				if (document.wfrm.pass.value.trim() == "") {
					alert('비밀번호를 입력해주세요.');
					return false;
				}
				if(document.wfrm.pass.value != ${pass}){
					alert('비밀번호가 잘못되었습니다.');
					return false;
				}
				if (document.wfrm.subject.value.trim() == "") {
					alert('제목을 입력해주세요.');
					return false;
				}

				// 이미지 게시판에서 추가되는 Javascript
				if (document.wfrm.upload.value.trim() == "") {
					alert('파일을 입력해 주세요.');
					return false;
				} else {
					const extension = document.wfrm.upload.value.split('.').pop();
					if (extension != 'png' && extension != 'jpg'
							&& extension != 'gif') {
						alert('이미지 파일 형식(png,jpg,gif)을 입력해 주세요.');
						return false;
					}
				}
				document.wfrm.submit();
			};
		};
	</script>
	<jsp:include page="gallery_navbar.jsp"></jsp:include>
	<br><br>
	<h1> Community</h1>
	<fieldset class="gallery_write">
	<div class="con_title"> 
		<p style="margin: 0px; text-align: right; margin-left: 300px; margin-right: 300px;">
			<img style="vertical-align: middle" alt="" src="../assets/imgs/home_icon.gif" /> 
			&gt; 커뮤니티 &gt; <strong>갤러리게시판</strong>
		</p>
	</div>
		<form action="board_write1_ok.jsp" method="post" name="wfrm" enctype="multipart/form-data">
			<div class="gallery_write">
				<!--게시판-->
				<div class="mb-3">
					<label for="name" class="form-label">작성자</label> 
					<input type="text" class="form-control" name="name" value=<%=id %> readonly="readonly" id="name">
				</div>
				<div class="mb-3">
					<label for="subject" class="form-label">제목</label> 
					<input type="text" class="form-control" name="subject">
				</div>
				<div class="mb-3">
					<label for="pass" class="form-label">비밀번호</label> 
					<input type="password" class="form-control" name="pass">
				</div>
				<div class="mb-3">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" name="content" rows="5" cols="20"></textarea>
				</div>
				<div class="mb-3">
					<label for="file" class="form-label">첨부파일</label> 
					<input type="file" class="form-control" name="upload">
				</div>
				<table class="gallery_term">
					<tr>
						<td style="border: 2px solid #e0e0e0; background-color: f9f9f9; padding: 20px; margin-right:40px;">
							<div class="mb-3"
								 style="padding-top: 10px; padding-bottom: 10px; font-weight: bold; padding-left: 10px;">
								※ 개인정보 수집 및 이용에 관한 안내
							</div>
							<div class="mb-3" style="padding-left: 7px;">
								<div
									style="width: 100%; height: 100%; font-size: 11px; letter-spacing: -0.1em; border: 1px solid #c5c5c5; background-color: #fff; padding-left: 7px; margin-right: 290px; padding-bottom: 12px; padding-top: 12px;">
									1. 수집 개인정보 항목 : 사용자 이름, 아이디, 메일 주소, 전화번호, 주소, 개인정보, 사진 <br>
									2. 개인정보의 수집 및 이용목적 : 제휴신청에 따른 본인확인 및 원활한 서비스 이용 경로 확보 <br> 
									3. 개인정보의 이용기간 : 모든 검토가 완료된 후 3개월간 이용자의 조회를 위하여 보관하며, 
									   이후 해당정보를 지체없이 파기합니다. <br> 
									4. 그 밖의 사항은 개인정보취급방침을 준수합니다.
								</div>
							</div>
							<div class="mb-3"
								style="padding-top: 7px; padding-left: 5px; padding-bottom: 7px;">
								<input type="checkbox" name="info" value="1" class="input_radio">
								개인정보 수집 및 이용에 대해 동의합니다.
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="btn_area" style="padding-left: 300px;">
				<span>
					<input type="button" value="목록으로" class="btn btn-dark" onclick="location.href='board_list1.jsp?cpage=<%=cpage%>'" />
				</span>
				<span>
					<input style="margin-left: 540px;" type="submit" id="submit1" value="글쓰기" class="btn btn-dark" />
				</span>
			</div>
		</form>
	</fieldset>
	<jsp:include page="../contactbar.jsp"></jsp:include>
</body>
</html>