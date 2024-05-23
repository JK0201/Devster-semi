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
<br>

## 나의 역할
  <details>
    <summary><b>DB 설계 및 연동</b></summary>
    <ul style="margin-top:10px">
      <li>MySQL 데이터베이스, 네이버 클라우드 초기 설정 및 연동</li>
      <li>데이터베이스 스키마 설계</li>
    </ul>
  </details>

  <details>
    <summary><b>회원가입/로그인/아이디 비밀번호 찾기</b></summary>
    <ul>
      <li>회원가입 UI/UX디자인 설계 및 구현</li>
      <li>사용자 입력 정보에 대한 필드 유효성 검사 기능 구현</li>
      <li>SHA256알고리즘 Salt를 사용하여 사용자 비밀번호 암호화 및 로그인 검증 기능 구현</li>
      <li>이메일과 핸드폰 인증을 통해 아이디 비밀번호 찾기 기능 구현</li>
    </ul>
  </details>
  
  <details>
    <summary><b>사용자 인증</b></summary>
    <ul>
      <li>JavaScript와 OAuth2.0 인증방식을 사용하여 카카오, 네이버 로그인 기능 구현</li>
      <li>Java Mail Sender 라이브러리를 사용하여 이메일 인증 및 검증 기능 구현</li>
      <li>CoolSms API를 사용하여 핸드폰 인증 및 검증 기능 구현</li>
      <li>공공데이터 사업자등록정보 API를 사용하여 기업회원 사업자등록증 인증 및 검증 기능 구현</li>
    </ul>
  </details>

  <details>
    <summary><b>파일 업로드</b></summary>
    <ul>
      <li>사용자 경험 증진을 위한 Drag&Drop및 미리보기 기능 구현</li>
      <li>파일 크기, 사이즈, 개수, 이미지 확장자 유효성 검사 기능 구현</li>
      <li>파일 업로드시 네이버 클라우드 버킷 저장 기능 구현</li>
    </ul>
  </details>  
  <br>

## 문제점 및 개선안
  <details>
    <summary><b>문제점</b></summary>
    <ul>
      <li>컨트롤러에 모든 기능이 집중되어 있어 코드 유지보수 및 재사용성이 떨어짐</li>
      <li>유효성 검사를 프론트엔드에서만 수행하여 보안 취약점이 존재함</li>
      <li>JavaScript코드가 모듈화 되지 않아 유지 보수 및 가독성이 떨어짐</li>
    </ul>
  </details>

  <details>
    <summary><b>개선안</b></summary>
    <ul>
      <li>기능 분리 : 서비스 레이어로 기능을 분리하여 코드 유지보수성을 높이고 재사용성을 향상</li>
      <li>유효성 검사 추가 : 서버 측 유효성 검사 추가 및 HTTP status code를 적극 활용하여 에러핸들링 및 보안 강화</li>
      <li>JavaScript 모듈화 : 코드를 모듈화하여 impotr/export를 활용하여 코드 유지보수성, 재사용성, 가독성을 향상</li>
    </ul>
  </details>  
<br>

## Outro
  <details>
    <summary><b>느낀점</b></summary>
    <ul>
      <li>첫 팀 프로젝트를 진행하면서 협업의 중요성을 절실히 느꼈습니다. 프로젝트 초반에는 역할 분담과 커뮤니케이션이 어려웠지만, 점차 팀원들과의 소통이 원활해 지면서 효율적으로 업무를 진행할 수 있었습니다.</li>
      <li>유효성 검사를 프론트엔드에서만 수행하여 보안 취약점이 존재함</li>
      <li>JavaScript코드가 모듈화 되지 않아 유지 보수 및 가독성이 떨어짐</li>
    </ul>
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
