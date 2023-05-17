<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
            charset="utf-8"></script>
    <style>
    </style>
</head>
<body>
<div>
    <div>
        <a href="signup">일반회원</a>
        &nbsp;&nbsp;&nbsp;
        <a href="compsignup">기업회원</a>
    </div>
    <button type="button" id="signinbtn" class="btn btn-outline-primary">로그인</button>
    - 소셜 계정으로 간편 회원가입 -
    <div style="margin-bottom: 30px;">
        <a id="kakao-login-btn" href="javascript:kakaoLogin()">
            <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
                 alt="카카오 로그인 버튼"/>
        </a>
    </div>
    <div id="naver_id_login"></div>
    <a href="finder">아이디/비밀번호 찾기</a>
</div>

<script>
    //naver
    var naver_id_login = new naver_id_login("Qr3pEkAiiIBJ_L9HaGiY", "http://localhost:9000/member/navercallback");
    var state = naver_id_login.getUniqState();
    naver_id_login.setButton("green", 10, 40);
    naver_id_login.setDomain("http://localhost:9000");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();

    //kakao
    window.Kakao.init("82a8d8044b53724691554098e719219c");

    function kakaoLogin() {

        window.Kakao.Auth.login({

            // scope: 'profile_nickname, profile_image, account_email',
            scope: 'account_email',
            success: function (res) {
                console.log(res);
                let m_pass = res.access_token;
                window.Kakao.API.request({
                    url: '/v2/user/me',
                    success: res => {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);
                        // console.log(kakao_account.email);
                        // console.log(res.properties.nickname);
                        // console.log(res.properties.profile_image);
                        // let m_nickname = res.properties.nickname;
                        // let m_photo = res.properties.profile_image;
                        let m_email = kakao_account.email;
                        $.ajax({
                            type: "get",
                            url: "apichk",
                            data: {"m_email": m_email, "m_pass": m_pass},
                            dataType: "json",
                            success: function (res) {
                                if (res.result == "yes") {
                                    alert("이미 가입한 계정입니다");
                                    location.replace("/");
                                } else {
                                    let b = confirm("계정 없음");
                                    if (b) {
                                        location.href = "apisignup";
                                    } else {
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                });
            }
        });
    }
</script>
</body>
</html>

