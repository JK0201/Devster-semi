<img src="https://capsule-render.vercel.app/api?type=waving&color=0:16213E,10:0F3460,30:533483,75:5B2A86,100:E94560&height=100&section=header&text=&fontSize=0" width="100%"/>
<div align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Orbitron&weight=500&pause=10000&color=58A6FF&center=true&random=false&width=435&lines=Devster v1.0.0" alt="Typing SVG" />
  </a>
  <p>개발자를 꿈꾸는 학생들과 주니어 개발자들이 모인 개발 학원 커뮤니티</p>
  <p>[ 2023.05.02 - 2023.05.22 ]</p>
  <p>인원 : 6명</p>
  
  [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/JK0201/Devster-semi)
</div>
<br>
## Overview
- 해당 프로젝트는 복습의 목적으로 Node.js와 Express 프레임워크를 사용하여 만든 간단한 CRUD(Create, Read, Update, Delete) 웹 사이트입니다. NoSQL 데이터베이스인 MongoDB와 EJS 템플릿 엔진을 활용하여 서버에서 동적으로 HTML을 생성하는 SSR(Server-Side Rendering) 방식으로 제작되었습니다.
<br>

## 주요 기술
<div style=display:flex>
  <img src="https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white" />
  <img src="https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white" />
  <img src="https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white" />
  <img src="https://img.shields.io/badge/mybatis-222222.svg?style=for-the-badge&logo=twitter&logoColor=white" />
  <img src="https://img.shields.io/badge/naver-%2303C75A.svg?&style=for-the-badge&logo=naver&logoColor=white" />
</div>

## Features
  <details>
    <summary><b>메인 페이지</b></summary>
    <br>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/cdb6f703-0733-43e8-920c-2e54b132dbf7" width="45%"/>
    <br>
    <p> - 빠른 페이지 이동을 위한 네비게이션 기능</p>
    <p> - 회원가입/로그인 빠른이동
    <p> - 로그인 중일 시 로그아웃 버튼
    <p> - position:sticky를 활용한 간략한 페이지 소개</p>
    <hr>
  </details>
  
  <details>
    <summary><b>회원가입/로그인</b></summary>
    <br>
    <p><b># 회원가입 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/441ad8a3-398f-4324-b19b-d9a9b6fdd384" width="45%"/>
    <br>
    <p> - 아이디/비밀번호/닉네임 유효성검사
    <p> - 아이디 중복검사</p>
    <p> - Bcrypt + Salt 기능을 활용한 비밀번호 해싱</p>
    <br>
    <p><b># 로그인 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/f4d17add-900d-46c7-805c-60727394bfd7" width="45%"/>
    <br>
    <p> - Passport 라이브러리를 활용한 간단한 세션 방식 로그인 기능</p>
    <p> - [회원기능]이 필요한 요청에 대해 session체크 함수를 만들어 미들웨어로 활용</p>
    <hr>
  </details>
  
  <details>
    <summary><b>게시판</b></summary>
    <br>
    <p><b># 글 리스트 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/76dd6371-8fe7-4eb2-a0a0-981c849b62dc" width="45%"/>
    <br>
    <p> - 게시물 제목, 글 내용 검색기능</p>
    <p> - 제목, 글 내용,작성자명 표시</p>
    <p> - 업로드된 사진 미리보기 및 사진 개수 표시</p>
    <br>
    <p><b># 글 작성/수정 페이지 [회원기능]</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/2bd77ade-926c-453d-bee8-e93c89d448dc" width="45%"/>
    <br>
    <p> - 배열을 활용한 이미지 핸들링(이미지 추가/삭제)</p>
    <p> - 캐러셀 기능을 활용한 업로드 이미지 미리보기</p>
    <p> - Multer 라이브러리를 사용한 다중 이미지 업로드</p>
    <br>
    <p><b># 글 내용 조회 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/4fcd69cf-db05-48b5-b2a5-f95e68d11286" width="45%"/>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/baa55cf0-d8fe-476e-a725-03777e4c11d4" width="45%"/>
    <br>
    <p> - 본인 게시물 삭제/수정 [회원기능]</p>
    <p> - 글 작성자와 해당 게시물에 대한 1:1 채팅 기능 [회원기능]</p>
    <p> - 최초 메세지를 보내야 데이터베이스에 채팅방이 생성되도록 구현 (서버 요청 최소화)</p>
    <hr>
  </details>

  <details>
    <summary><b>채팅 [회원기능]</b></summary>
    <br>
    <p><b># 채팅 리스트 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/0033050a-1371-4cc9-919d-8120f518d4e9" width="45%" />
    <br>
    <p> - 유저별로 생성된 글 작성자와의 1:1 채팅방 리스트</p>
    <br>
    <p><b># 1:1 채팅 페이지</b></p>
    <img src="https://github.com/JK0201/NodeJS-CRUD/assets/124655981/0ac3dd5b-0433-45ad-ac69-e5e4a12edbf9" width="45%"/>
    <br>
    <p> - SSE(Server-Sent-Events)를 이용한 서버에서 클라이언트로 실시간 이벤트를 전달하는 단방향 통신 채팅방</p>
    <p> - 파이프라인을 만들어 POST요청이 발생할 때, MongoDB의 컬렉션 변화를 실시간으로 감지하고 메세지 업데이트</p>
    <hr>
  </details>
  <br>
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:16213E,10:0F3460,30:533483,75:5B2A86,100:E94560&height=40&section=footer&text=&fontSize=0" width="100%"/>



## 팀 발표용 README.md
<details>
  <summary><b>Details</b></summary>
  
##  🙂 member 

|이름|담당|깃허브|
|--------|---|---|
|김동규|질문게시판, 좋아요.싫어요 기능, 학원DB크롤링, 마이페이지, 무한스크롤, 전반적인 에러 수정 및 팀원 보조|https://github.com/kddongkyu |
|김규헌|DB설계, 로그인(API), 회원포인트, 등급로직, 회원가입, Drag&Drop기능|https://github.com/JK0201|
|정우영|프론트 총괄 및 최종정리, 공지게시판, 쪽지 기능, 레이아웃 설정|https://github.com/ll0605|
|권현오|채용정보 게시판, 구인구직 게시판, 리뷰게시판, 기업정보DB크롤링|https://github.com/kwohyuno|
|장수현|자유게시판, 검색기능 구현, Form화면 및 css참여, 게시판 접근권한|https://github.com/Xoohyun|
|김애리|리뷰게시판, 이력서 작성 및 폼, 쪽지CSS  |https://github.com/AERI-KIM|


<br><br>
## 🚩 프로젝트 소개 


  - 개발자들 꿈꾸는 학생들과 주니어 개발자들이 모인 개발 학원 커뮤니티 웹 사이트 Dev-ster
  <br>

![KakaoTalk_20230522_122156121](https://github.com/kddongkyu/bit701-four-semi/assets/124576045/c34496cd-0f8f-4865-8531-60997ae5dd10)


## ⏳ 프로젝트 일정 및 규모

+ 개발 기간 : 2023.5.2 ~ 2023.5.22
+ 인원 : 6명
  
 <br>


##  🔎 페이지 기능

<br>

+ ### 🔒로그인 
  + 카카오API , 네이버API 간편 로그인  능 
   + E-MAIL 인증 기능
   + 학원 선택 (크롤링) 
   + 기업 인증 (사업자번호)

  <br>

+ ### 📗 마이페이지
  + 나의 정보 확인 가능
  
  + 이력서 작성 헤드헌터 회원에게 (공개,비 공개)선택
  + 학원 인증

       <br>
+ ###  📕 자유게시판 
  + 무한 스크롤 
  + 검색기능(작성자, 제목)
  + 좋아요, 싫어요
  + 댓글, 대댓글
  + 인기글 퀵메뉴 
  
      <br>
+ ### 📙 질문게시판 
  + 무한 스크롤 
  + 검색기능(작성자, 제목)
  + 좋아요, 싫어요
  + 댓글, 대댓글
  + 인기글 퀵메뉴 
  + 답변글 사진 업로드 
  
    <br>
+ ###  📘 학원별게시판 
  + 학원인증 후 사용가능 
  + 각 학원의 학원생들만 이용 가능 
  + 무한 스크롤 
  + 검색기능(작성자, 제목)
  + 좋아요, 싫어요
  + 댓글, 대댓글
  + 인기글 퀵메뉴 
  + 답변글 사진 업로드 

      <br>
+ ### 📓 채용정보 
  + 무한 스크롤 
  + 검색기능
  + 회사 계정만 작성 가능 
  + 채용정보 확인 가능 

      <br>

+ ### 📒 회사 리뷰 
  + 무한 스크롤 
  + 검색기능
  + 크롤링으로 회사 정보 수집
  + 별점과 후기 작성 
  + 모달로 회사 상세정보 확인 가능

+ ### ✉ 쪽지기능 
  + 어느 페이지에서든 쪽지 이용 가능
  + 사용자 별로 쪽지 확인 가능
  + 미확인 쪽지 알림
      <br>

## 🖥 DB 설계
![KakaoTalk_20230522_110054915](https://github.com/kddongkyu/bit701-four-semi/assets/124576045/6040e549-9e50-485c-be42-8acaf2318c32)






## 🛠 front end 🛠

<br>

<div align="left">

<img src="https://img.shields.io/badge/Bootstrapap-7952B3?style=flat-square&logo=bootstrap&logoColor=white"/>
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white"/>
 <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=CSS3&logoColor=white"/> 
</div>

<br>


## 🔧 back-end 🔧

<br>
<div align="left">

<img src="https://img.shields.io/badge/Pyhon-3776AB?style=flat&logo=Python&logoColor=white"/> 
<img src="https://img.shields.io/badge/Java-007396?style=flat&logo=Java&logoColor=white" />
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black"/>
<img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jQuery&logoColor=white"/>
<img src="https://img.shields.io/badge/JSON-000000?style=flat-square&logo=json&logoColor=white"/>
</div>
<br>

​

## 🔧 Tools 🔧

<br>


<div align="left">

<img src="https://img.shields.io/badge/naver-Ferew0?style=flat-square&logo=naver&logoColor=white"/>
        <img src="https://img.shields.io/badge/intellijidea-00493C?style=flat-square&logo=intellijidea&logoColor=white"/>
        <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=Github&logoColor=white"/>
    <img src="https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=Docker&logoColor=white"/>
    <img src="https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white"/>
        <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=Spring&logoColor=white"/>
  <img src="https://img.shields.io/badge/notion-000000?style=flat&logo=notion&logoColor=white"/>
​
</div>
</details>
