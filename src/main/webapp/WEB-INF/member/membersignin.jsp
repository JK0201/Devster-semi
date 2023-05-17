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
            display:
        }
    </style>
</head>
<script>
    $(function () {
        let chk = localStorage.getItem("chk");
        let m_email = localStorage.getItem("m_email");

        if (chk == "yes") {
            $("#m_email").val(m_email);
            $("#chkno").css("display", "none");
            $("#chkyes").show();
            chkbtn = true;
        }
    })
</script>
<body>
<div>
    <div>
        <strong id="normmember">일반회원 로그인</strong>
        &nbsp;&nbsp;&nbsp;
        <strong id="compmember">회사계정 로그인</strong>
    </div>
    <div class="norminput">
        <strong>개인 </strong>
        <input type="text" id="m_email" required>
        <strong>비밀번호 </strong>
        <input type="password" id="m_pass" required>
    </div>
    <div class="compinput">
        <strong>회사 </strong>
        <input type="text" id="cm_email">
        <strong>비밀번호 </strong>
        <input type="password" id="cm_pass">
    </div>
    <label id="chkbtn">
        <i class="bi bi-circle" id="chkno"></i>
        <i class="bi bi-check-circle-fill" id="chkyes"></i>
        <strong>아이디 저장하기</strong>
    </label>
    <div class="norminput">
        <button type="button" id="signinbtn" class="btn btn-outline-primary">로그인</button>
        - 소셜 계정으로 간편 로그인/회원가입 -
        <div style="margin-bottom: 30px;">
            <a id="kakao-login-btn" href="javascript:kakaoLogin()">
                <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
                     alt="카카오 로그인 버튼"/>
            </a>
        </div>
        <div id="naver_id_login"></div>
        <a href="selmember">회원가입</a>
        <strong>|</strong>
        <a href="finder">아이디/비밀번호 찾기</a>
    </div>
    <div class="compinput">
        <button type="button" id="csigninbtn">로그인</button>
        <a href="compsignup">회원가입</a>
        <strong>|</strong>
        <a href="finder">아이디/비밀번호 찾기</a>
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
        chkbtn = !chkbtn;
    });


    //norm
    let chkbtn = false;
    let cnt = 0;

    $("#signinbtn").click(function () {
        $.ajax({
            type: "get",
            url: "signincheck",
            cache: false,
            success: function (res) {
                if (res == "yes") {
                    if (cnt < 4) {
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

                        $.ajax({
                            type: "get",
                            url: "emailpasschk",
                            dataType: "json",
                            data: {"m_email": m_email, "m_pass": m_pass},
                            success: function (res) {
                                if (res.result == "yes") {
                                    alert("ㅎㅇ 출석포인트 +10점");
                                    if (chkbtn) {
                                        localStorage.setItem("chk", "yes");
                                        localStorage.setItem("m_email", m_email);
                                    } else {
                                        localStorage.removeItem("chk");
                                        localStorage.removeItem("m_email");
                                    }
                                    location.replace("/");
                                } else {
                                    cnt++;
                                    alert(cnt + "회 잘못 입력하셨습니다\n이메일과 비밀번호를 확인해주세요\n5회 잘못입력시 로그인 제한");
                                }
                            }
                        });
                    } else {
                        $.ajax({
                            type: "get",
                            url: "blocksignin",
                            dataType: "text",
                            success: function () {
                                alert("이용정지");
                                $("#signinbtn").prop("disabled", true);
                            }
                        });
                    }
                } else {
                    alert("로그인 제한");
                    $("#signinbtn").prop("disabled", true);
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

    //cm
    $("#csigninbtn").click(function () {
        let cm_email = $("#cm_email").val();
        let cm_pass = $("#cm_pass").val();

        if (cm_email == "") {
            alert("이메일을 입력해주세요");
            return false;
        }
        if (cm_pass == "") {
            alert("비밀번호를 입력해주세요");
            return false;
        }

        $.ajax({
            type: "get",
            url: "cemailpasschk",
            dataType: "json",
            data: {"cm_email": cm_email, "cm_pass": cm_pass},
            success: function (res) {
                if (res.result == "yes") {
                    alert("ㅎㅇ 출석포인트 +10점");
                    location.replace("/");
                } else {
                    alert("이메일과 비밀번호를 확인해주세요");
                }
            }
        });
    });

    $("#cm_email").keyup(function (e) {
        if (e.keyCode == 13) {
            $("#csigninbtn").click();
        }
    });

    $("#cm_pass").keyup(function (e) {
        if (e.keyCode == 13) {
            $("#csigninbtn").click();
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
                                    alert("ㅎㅇ 출석포인트 +10점");
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

    //out
    $("#outtest").click(function () {
        $.ajax({
            type: "get",
            url: "outtest",
            dataType: "text",
            success: function () {
                alert("로그아웃");
                location.href = "";
            }
        });
    });
</script>
</body>
</html>