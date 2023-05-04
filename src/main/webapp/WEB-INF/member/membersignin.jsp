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
        .compinput {
            display: none;
        }

        #chkyes {
            display: none;
        }
    </style>
</head>
<body>
<div>
    <div>
        <b id="normmember">일반회원 로그인</b>
        &nbsp;&nbsp;&nbsp;
        <b id="compmember">회사계정 로그인</b>
        <div class="norminput">
            <sapn>개인 :</sapn>
            <input type="text" name="m_email" id="m_email" required placeholder>
            <br>
            <span>비밀번호 : </span><input type="password" name="m_pass" id="m_pass" required>
        </div>
        <div class="compinput">
            <sapn>회사 :</sapn>
            <input type="text" name="cm_email" id="cm_email">
            <br>
            <span>비밀번호 : </span><input type="password" name="cm_pass" id="cm_pass">
        </div>
        <label id="chkbtn">
            <i class="bi bi-circle" id="chkno"></i>
            <i class="bi bi-check-circle-fill" id="chkyes"></i>
            <span>로그인 상태 유지하기</span>
        </label>
        <div>
            <button type="button" id="signinbtn">로그인</button>
        </div>
        <div class="norminput">
            -또는-
            <div style="margin-bottom: 30px;">
                <a id="kakao-login-btn" href="javascript:kakaoLogin()">
                    <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
                         alt="카카오 로그인 버튼"/>
                </a>
            </div>
            <div id="naver_id_login"></div>
        </div>
        <div class="norminput">
            <a href="signup">회원가입</a>
            <b>|</b>
            <a href="#">계정 찾기</a>
            <b>|</b>
            <a href="#">비밀번호 찾기</a>
        </div>
        <div class="compinput">
            <a href="compsignup">회원가입</a>
            <b>|</b>
            <a href="#">계정 찾기</a>
            <b>|</b>
            <a href="#">비밀번호 찾기</a>
        </div>
    </div>
</div>
<script>
    $("#normmember").click(function () {
        $(".norminput").show();
        $(".compinput").hide();
        $("#cm_email").val("");
        $("#cm_pass").val("");
    });

    $("#compmember").click(function () {
        $(".norminput").hide();
        $(".compinput").show();
        $("#m_email").val("");
        $("#m_pass").val("");
    });

    $("#chkbtn").click(function () {
        $("#chkyes").toggle();
        $("#chkno").toggle();
        chkbtn=!chkbtn;
    });

    //norm
    let chkbtn = false;

    $("#signinbtn").click(function () {
        let m_email = $("#m_email").val();
        let m_pass = $("#m_pass").val();

        if (m_email == "") {
            alert("이메일을 입력해주세요");
            return false;
        }
        if (m_pass == "") {
            alert("비밀번호를 입력해주세요");
            return false;
        }
        console.log(m_email + "," + m_pass);
        $.ajax({
            type: "get",
            url: "emailchk",
            dataType: "json",
            data: {"m_email": m_email},
            success: function (res) {
                if (res.result == "yes") {
                    alert("이메일과 비밀번호를 확인해주세요");
                } else {
                    $.ajax({
                        type: "get",
                        url: "emailpasschk",
                        dataType: "json",
                        data: {"m_email": m_email, "m_pass": m_pass},
                        success: function (res) {
                            if(res.result=="yes") {
                                alert("ㅎㅇ 출석포인트 +10점");
                                location.href="../";
                            }
                            else {
                                alert("이메일과 비밀번호를 확인해주세요");
                            }
                        }
                    });
                }
            }
        });
    });

    $("#m_email").keyup(function (e) {
        if (e.keyCode == 13) {
            $("#signinbtn").click();
        }
    });

    $("#m_pass").keyup(function (e) {
        if (e.keyCode == 13) {
            $("#signinbtn").click();
        }
    });

    //naver
    var naver_id_login = new naver_id_login("Qr3pEkAiiIBJ_L9HaGiY", "http://localhost:9000/member/navercallback");
    var state = naver_id_login.getUniqState();
    naver_id_login.setButton("green", 10, 40);
    naver_id_login.setDomain("http://localhost:9000");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();

    function redirectToMainPage() {
        window.location.href = "../";
    }

    function redirectToSignUp() {
        window.location.href = "apisignup"
    }

    //kakao
    window.Kakao.init("82a8d8044b53724691554098e719219c");

    function kakaoLogin() {

        window.Kakao.Auth.login({

            scope: 'profile_nickname, profile_image, account_email,',
            success: function (res) {
                console.log(res);
                window.Kakao.API.request({
                    url: '/v2/user/me',
                    success: res => {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);
                        console.log(kakao_account.email);
                        console.log(res.properties.nickname);
                        console.log(res.properties.profile_image)
                        let m_email = kakao_account.email;
                        alert(m_email);

                        $.ajax({
                            type: "get",
                            url: "apichk",
                            data: {"m_email": m_email},
                            dataType: "json",
                            success: function (res) {
                                if (res.result == "yes") {
                                    alert("ㅎㅇ 출석포인트 +10점");
                                    location.href = "../";

                                } else {
                                    alert("계정 없음");
                                    location.href = "apisignup";
                                }
                            }
                        });
                    }
                });
            }
        });
    }
    //save
    $("#chkbtn").click(function() {
        if(chkbtn) {
            console.log("yes");
        }
        else {
            console.log("no");
        }
    });
</script>
</body>
</html>