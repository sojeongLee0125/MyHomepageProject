# <center> 😎 Carpe Diem - 첫 번째 개인 프로젝트 </center>

![image](https://user-images.githubusercontent.com/92525310/148883792-41207cbc-2038-40ad-98b5-d89d50c1bae0.png)

## 🕹 프로젝트 소개

- 프로젝트 이름 : 자기계발 커뮤니티 <b><em>Carpe Diem</em></b>
- 프로젝트 주제 : 자기계발 관련 정보를 공유할 수 있는 커뮤니티 홈페이지
- 자기계발에 관심있는 사용자는 회원가입을 통해 해당 홈페이지의 회원이 될 수 있습니다.
- 회원이 되면 운동, 독서, 공부 등 자기계발과 관련된 자신의 활동을 게시판에 글과 사진으로 올리며 <br>
  소통할 수 있습니다.

## 💾 DB 구조

![image](https://user-images.githubusercontent.com/92525310/148019975-b8c1927c-4a0c-462f-88eb-974ca72eb423.png)

## :battery: 개발 환경

![image](https://user-images.githubusercontent.com/92525310/148327918-9da9abe8-0302-49bd-a797-a7ec0d349393.png)

 <개발 툴 버전>
- JavaSE 1.8
- Tomcat ver 8.5
- MySQL Server ver 5.7

## ⌚ 제작 기간 및 참여인원

- 2021년 6월 16일 ~ 2021년 7월 20일
- 개인 프로젝트

## 🎨 주요 기능

:rotating_light: <b>로그인 및 회원가입</b>
- 로그인 시에만 마이페이지를 볼 수 있게 navbar 버튼 구성
- JavaScript함수와 표현식을 활용한 회원가입 유효성 검사, 아이디 중복체크 검사
- 회원가입 시 우편주소 open-api로 주소 불러오기
- Open-API를 활용한 소셜로그인 기능 구현
- 비밀번호 찾기 기능 구현

:rotating_light: <b>마이페이지</b>
- 회원 정보 조회, 수정. 탈퇴 및 로그아웃 기능 구현
- 관리자 전용 아이디로 로그인 시 전체 회원정보 조회 가능

:rotating_light: <b>정보 공유 게시판</b>
- 기본적인 CRUD 기능 구현
- 답글 단계별 들여쓰기 구현
- 페이징 처리 및 최신글 순 출력 구현
- 세션값을 활용한 아이디 검증
- 본인 글에서만 수정,삭제 버튼 활성화
- 파일 업로드 기능 구현

:rotating_light: <b>갤러리 게시판</b>
- 글 목록에서 첨부 된 이미지 미리보기
- 글 작성일과 NOW()함수 비교로 NOW 이미지 삽입
- 글쓰기 시 파일 첨부 기능, 이미지 파일 유효성 검사
- 게시판에서 파일 다운로드 기능

:rotating_light: <b>기타</b>
- 카카오 OPEN-API 활용한 다국어 번역기 구현
- 문의사항에서 구글 SMTP서버를 활용한 메일 전송 기능 구현

## :thought_balloon: 회고 및 느낀점

:zap: 3달간 배운 JSP Model1 구조를 활용하여 홈페이지를 만들어 보았다. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아직까지는 구현에만 치중하여 코드들이 체계를 갖추지 못하고 어지럽지만          
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;차근차근 배워나가며 클린코드를 구현할 수 있도록 노력해야겠다.
   
:zap: 소셜 로그인 정보를 받아오는 것 까지는 구현하였으나 실제 회원가입으로 이어지는 부분은 구현하지 못하였다. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;다음 프로젝트에서는 이부분을 구현할 수 있도록 도전해봐야겠다.
   
:zap: 제이쿼리 기능들을 조금 더 다양하게 사용해 보도록 시도해봐야겠다.

:zap: jsp 모델1 구조를 구현해 보았으니 모델 2구조에 대해서도 공부하고 시도해보아야겠다.

## 📈 발표자료_PPT
<details>
<summary>발표자료 보기</summary>
<div markdown="1">
1.
<img src="https://user-images.githubusercontent.com/92525310/148328986-0837c846-db77-4c9e-b950-c3da3696550f.png">
2. 
<img src="https://user-images.githubusercontent.com/92525310/148329024-c883c49a-6947-47f9-bf9e-9a780895aa67.png">
3.
<img src="https://user-images.githubusercontent.com/92525310/148329055-3ee96071-e69f-4ce6-ba0d-ee53fde42aea.png">
4.
<img src="https://user-images.githubusercontent.com/92525310/148329091-579d0c44-9ae4-48b4-bf11-70262268658f.png">
5.
<img src="https://user-images.githubusercontent.com/92525310/148329116-3e214103-11d5-41cc-9995-a58778fc353a.png">
<img src="https://user-images.githubusercontent.com/92525310/148329156-fc70fa9f-5fd0-45ae-9637-93718c4463ca.png">
 </div>
</details>


## ✨프로젝트 참고 페이지
1) https://postcode.map.daum.net/guide#usage
2) https://developers.kakao.com/
3) https://juyoungit.tistory.com/164
4) https://academy.dream-coding.com/courses/portfolio (강의 영상 참조)
5) https://fontawesome.com/
6) https://www.youtube.com/watch?v=QPEUU89AOg8 (강의 영상 참조)


