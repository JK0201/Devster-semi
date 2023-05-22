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
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&family=Roboto&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
            charset="utf-8"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Roboto';
            background: white;
        }

        .container {
            display: block;
            max-width: 680px;
            width: 80%;
            margin: -60px auto;
        }

        .logo {
            font-size: 20px;
            text-align: center;
            margin: 120px 0 40px 0;
            transition: .2s linear;
        }

        .links {
            list-style-type: none;
        }

        .links li {
            display: inline-block;
            margin: 0 20px 0 0;
            transition: .2s linear;
        }

        .links li:nth-child(1):hover {
            opacity: 1;
        }

        .links li:nth-child(2) {
            opacity: .6;
        }

        .links li a {
            text-decoration: none;
            color: #0f132a;
            font-weight: bolder;
            text-align: center;
            cursor: pointer;
        }

        #normmember span {
            color: #8007AD;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
            box-shadow: 4px 4px 14px 7px #bdbebd;
            padding-top: 5vh;
            padding-bottom: 5vh;
        }

        .inputdiv .input__block {
            margin: 20px auto;
            display: block;
            position: relative;
        }

        .inputdiv .input__block.first-input__block::before {
            content: "";
            position: absolute;
            top: -15px;
            left: 50px;
            display: block;
            width: 0;
            height: 0;
            background: transparent;
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 15px solid rgba(15, 19, 42, .1);
            transition: .2s linear;
        }

        .inputdiv .input__block.signup-input__block::before {
            content: "";
            position: absolute;
            top: -15px;
            left: 150px;
            display: block;
            width: 0;
            height: 0;
            background: transparent;
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 15px solid rgba(15, 19, 42, .1);
            transition: .2s linear;
        }

        .inputdiv .input__block input {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 50px;
            margin: 0 auto;
            border-radius: 8px;
            border: none;
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
        }

        .inputdiv .input__block input:focus,
        .inputdiv .input__block input:active {
            outline: none;
            border: none;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .input__block input.repeat__password {
            opacity: 0;
            display: none;
            transition: .2s linear;
        }

        .inputdiv .signin__btn {
            background: #8007AD;
            color: white;
            display: block;
            width: 92.5%;
            max-width: 680px;
            height: 50px;
            border-radius: 8px;
            margin: 0 auto;
            border: none;
            cursor: pointer;
            font-size: 19px;
            font-family: 'Noto Sans KR', 'Roboto';
            box-shadow: 0 15px 30px rgba(114, 30, 166, .36);
            transition: .2s linear;
            font-weight: bold;
        }

        .inputdiv .signin__btn:hover {
            box-shadow: 0 0 0 rgba(233, 30, 99, 0);
        }

        .separator {
            display: block;
            margin: 30px auto 10px;
            text-align: center;
            height: 40px;
            position: relative;
            background: transparent;
            color: rgba(15, 19, 42, .5);
            font-size: 13px;
            width: 90%;
            max-width: 680px;
        }

        .separator::before {
            content: "";
            position: absolute;
            top: 8px;
            left: 0;
            background: rgba(15, 19, 42, .2);
            height: 1px;
            width: 35%;
        }

        .separator::after {
            content: "";
            position: absolute;
            top: 8px;
            right: 0;
            background: rgba(15, 19, 42, .2);
            height: 1px;
            width: 35%;
        }

        .kakao__btn,
        .naver__btn {
            display: block;
            width: 90%;
            max-width: 680px;
            margin: 20px auto;
            height: 50px;
            cursor: pointer;
            font-size: 14px;
            font-family: 'Noto Sans KR', 'Roboto';
            border-radius: 8px;
            border: none;
            line-height: 50px;
        }

        .kakao__btn {
            background: #F7E600;
            color: white;
            box-shadow: 0 15px 30px rgba(91, 144, 240, .36);
            transition: .2s linear;
            text-decoration: none;
        }

        .kakao__btn:hover {
            box-shadow: 0 0 0 rgba(91, 144, 240, 0);
        }

        .naver__btn {
            background: #2DB400;
            color: white;
            box-shadow: 0 15px 30px rgba(37, 40, 45, .36);
            transition: .2s linear;
        }

        .naver__btn:hover {
            box-shadow: 0 0 0 rgba(37, 40, 45, 0);
        }

        section p {
            margin-top: 4vh;
            text-align: center;
        }

        section p a {
            text-decoration: none;
            font-size: 17px;
            margin: 0 5px;
        }

        .memberlayout footer {
            margin-top: 200px;
        }

        #chkyes {
            color: #8007AD;
            display: none;
        }

        #compchkyes {
            color: #8007AD;
            display: none;
        }

        #kakao-signin {
            font-weight: bold;
            text-align: center;
            color: black;
            font-size: 2vh;
        }

        #naver-signin {
            font-weight: bold;
            text-align: center;
            color: white;
            font-size: 2vh;
        }

        #selmember span, #finder span {
            text-decoration: none;
            color: #0f132a;
            opacity: 0.6;
            font-weight: bold;
            transition: .2s linear;
        }

        #selmember span:hover,#finder span:hover {
            color:#8007AD;
            opacity: 1;
        }

        .inputdelbtn {
            opacity: 0.3;
            font-size: 19px;
            position: absolute;
            right: 65px;
            top: 11px;
            cursor: pointer;
            display: none;
        }

    </style>
</head>
<script>
    $(function () {
        let chk = localStorage.getItem("chk");
        let m_email = localStorage.getItem("m_email");
        let compchk = localStorage.getItem("compchk");
        let cm_email = localStorage.getItem("cm_email");

        if (chk == "yes") {
            $("#m_email").val(m_email);
            $("#chkno").css("display", "none");
            $("#chkyes").show();
            chkbtn = true;
        }

        if (compchk == 'yes') {
            $("#cm_email").val(cm_email);
            $("#compchkno").css("display", "none");
            $("#compchkyes").show();
            compchkbtn = true;
        }
    });
</script>
<body>
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">로&nbsp;그&nbsp;인</div>
    </div>

    <div class="inputdiv">
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="normmember"><span>일반회원</span></a>
            </li>
            <li>
                <a href="#" id="compmember"><span>기업회원</span></a>
            </li>
        </ul>

        <!-- email input -->
        <div id="normmode">
            <div class="first-input input__block first-input__block">
                <input type="email" placeholder="Email" class="input" id="m_email" required value="test@test.com"/>
                <i class="bi bi-x-circle-fill inputdelbtn"></i>
            </div>
            <!-- password input -->
            <div class="input__block">
                <input type="password" placeholder="Password" class="input" id="m_pass" required value="test1234"/>
                <i class="bi bi-x-circle-fill inputdelbtn"></i>
            </div>
            <div class="input__block">
                <label id="chkbtn" style="margin-left:3.5vh;">
                    <i class="bi bi-circle" id="chkno" style="opacity: 0.7;"></i>
                    <i class="bi bi-check-circle-fill" id="chkyes"></i>
                    <strong style="opacity: 0.7;">이메일 저장</strong>
                </label>
            </div>
            <div>
                <button class="signin__btn" id="signinbtn">로&nbsp;그&nbsp;인</button>
            </div>
            <div>
                <!-- separator -->
                <div class="separator">
                    <p>소셜 계정으로 간편 로그인</p>
                </div>
                <!-- kakao button -->
                <a id="kakao-login-btn" href="javascript:kakaoLogin()" class="kakao__btn">
                    <div id="kakao-signin">
                        <i class="bi bi-chat-fill"></i>
                        &nbsp;
                        <span>카카오 아이디로 로그인</span>
                    </div>
                </a>
                <!-- naver button -->
                <div class="naver__btn">
                    <div id="naver-signin">
                        <span>N</span>
                        &nbsp;
                        <span>네이버 아이디로 로그인</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- Comp member -->
        <div id="compmode">
            <div class="first-input input__block first-input__block">
                <input type="email" placeholder="Email" class="input repeat__password" id="cm_email" value="comp@comp.com"/>
                <i class="bi bi-x-circle-fill inputdelbtn"></i>
            </div>
            <div class="input__block">
                <input type="password" placeholder="Password" class="input repeat__password" id="cm_pass" value="123123123"/>
                <i class="bi bi-x-circle-fill inputdelbtn"></i>
            </div>
            <div class="input__block">
                <label id="compchkbtn" style="margin-left:3.5vh;">
                    <i class="bi bi-circle" id="compchkno" style="opacity: 0.7;"></i>
                    <i class="bi bi-check-circle-fill" id="compchkyes"></i>
                    <strong style="opacity: 0.7;">이메일 저장</strong>
                </label>
            </div>
            <div class="input__block">
                <button class="signin__btn" id="csigninbtn">로&nbsp;그&nbsp;인</button>
            </div>
        </div>
        <section>
            <p>
                <a href="selmember" id="selmember"><span>회원가입</span></a>
                <strong style="color:#0f132a; opacity: 0.6;">|</strong>
                <a href="finder" id="finder"><span>아이디/비밀번호 찾기</span></a>
            </p>
        </section>
    </div>
</div>
<div id="naver_id_login" style="display: none;"></div>

<script>
    $(document).ready(function () {
        let normmode = $("#normmode");
        let compmode = $("#compmode");
        let compmember = $(".links").find("li").find("#compmember");
        let normmember = $(".links").find("li").find("#normmember");

        let first_input = $(".inputdiv").find(".first-input");
        let hidden_input1 = $(".inputdiv").find(".input__block").find("#cm_email");
        let hidden_input2 = $(".inputdiv").find(".input__block").find("#cm_pass");

        compmode.hide();
        //----------- comp ---------------------
        compmember.on("click", function (e) {
            e.preventDefault();
            $(this).parent().find("span").css("color", "#8007AD");
            $(this).parent().css("opacity", "1");
            $(this).parent().siblings().find("span").css("color", "#0f132a");
            $(this).parent().siblings().css("opacity", ".5");
            normmode.hide();
            compmode.show();

            first_input.removeClass("first-input__block").addClass("signup-input__block");
            hidden_input1.css({
                "opacity": "1",
                "display": "block"
            });
            first_input.removeClass("first-input__block").addClass("signup-input__block");
            hidden_input2.css({
                "opacity": "1",
                "display": "block"
            });
        });

        //----------- norm ---------------------
        normmember.on("click", function (e) {
            e.preventDefault();
            $(this).parent().find("span").css("color", "#8007AD");
            $(this).parent().css("opacity", "1");
            $(this).parent().siblings().find("span").css("color", "#0f132a");
            $(this).parent().siblings().css("opacity", ".5");
            normmode.show();
            compmode.hide();

            first_input.addClass("first-input__block").removeClass("signup-input__block");
            hidden_input1.css({
                "opacity": "0",
                "display": "none"
            });
            first_input.addClass("first-input__block").removeClass("signup-input__block");
            hidden_input2.css({
                "opacity": "0",
                "display": "none"
            });
        });
    });
    $("#chkbtn").click(function () {
        $("#chkyes").toggle();
        $("#chkno").toggle();
        chkbtn = !chkbtn;
    });

    $("#compchkbtn").click(function () {
        $("#compchkyes").toggle();
        $("#compchkno").toggle();
        compchkbtn = !compchkbtn;
    });

    $("#m_email, #m_pass, #cm_email, #cm_pass").keyup(function () {
        if ($(this).val() != "") {
            $(this).siblings().show();
        } else {
            $(this).siblings().hide();
        }
    });

    $("#m_email, #m_pass, #cm_email, #cm_pass").keydown(function () {
        if ($(this).val() != "") {
            $(this).siblings().show();
        } else {
            $(this).siblings().hide();
        }
    });

    $(".inputdelbtn").click(function () {
        $(this).siblings().val("");
        $(this).hide();
    });

    //norm
    let chkbtn = false;
    let compchkbtn = false;
    let cnt = 0;
    let compcnt = 0;

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
                            Swal.fire({
                                icon: 'warning',
                                title: '이메일을 입력 해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                            return false;
                        }
                        if (m_pass == "") {
                            Swal.fire({
                                icon: 'warning',
                                title: '비밀번호를 입력 해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                            return false;
                        }

                        $.ajax({
                            type: "get",
                            url: "emailpasschk",
                            dataType: "json",
                            data: {"m_email": m_email, "m_pass": m_pass},
                            success: function (res) {
                                if (res.result == "yes") {
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
                                    Swal.fire({
                                        icon: 'warning',
                                        title: '아이디/비밀번호를\n확인해 주세요',
                                        confirmButtonText: '확인',
                                        confirmButtonColor: '#8007AD'
                                    });
                                }
                            }
                        });
                    } else {
                        $.ajax({
                            type: "get",
                            url: "blocksignin",
                            dataType: "text",
                            success: function () {
                                Swal.fire({
                                    icon: 'error',
                                    title: cnt + "회 잘못 입력 하셨습니다",
                                    confirmButtonText: '확인',
                                    confirmButtonColor: '#8007AD'
                                });
                            }
                        });
                    }
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '로그인이 제한 되었습니다',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
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

    //cm
    $("#csigninbtn").click(function () {
        $.ajax({
            type: "get",
            url: "csignincheck",
            cache: false,
            success: function (res) {
                if (res == "yes") {
                    if (compcnt < 4) {
                        let cm_email = $("#cm_email").val();
                        let cm_pass = $("#cm_pass").val();
                        if (cm_email == "") {
                            Swal.fire({
                                icon: 'warning',
                                title: '이메일을 입력 해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                        }
                        if (cm_pass == "") {
                            Swal.fire({
                                icon: 'warning',
                                title: '비밀번호를 입력 해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                            return false;
                        }

                        $.ajax({
                            type: "get",
                            url: "cemailpasschk",
                            dataType: "json",
                            data: {"cm_email": cm_email, "cm_pass": cm_pass},
                            success: function (res) {
                                if (res.result == "yes") {
                                    if (compchkbtn) {
                                        localStorage.setItem("compchk", "yes");
                                        localStorage.setItem("cm_email", cm_email);
                                    } else {
                                        localStorage.removeItem("compchk");
                                        localStorage.removeItem("cm_email");
                                    }
                                    location.replace("/");
                                } else {
                                    compcnt++
                                    Swal.fire({
                                        icon: 'warning',
                                        title: '아이디/비밀번호를\n확인해 주세요',
                                        confirmButtonText: '확인',
                                        confirmButtonColor: '#8007AD'
                                    });
                                }
                            }
                        });
                    } else {
                        $.ajax({
                            type: "get",
                            url: "cblocksignin",
                            dataType: "text",
                            success: function () {
                                Swal.fire({
                                    icon: 'error',
                                    title: compcnt + "회 잘못 입력 하셨습니다",
                                    confirmButtonText: '확인',
                                    confirmButtonColor: '#8007AD'
                                });
                            }
                        });
                    }
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '로그인이 제한 되었습니다',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
                    });
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
    naver_id_login.setButton("green", 3, 50);
    naver_id_login.setDomain("http://localhost:9000");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();

    $(document).on("click", ".naver__btn", function () {
        var btnNaverLogin = document.getElementById("naver_id_login").firstChild;
        btnNaverLogin.click();
    });

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
                                    location.replace("/");
                                } else {
                                    Swal.fire({
                                        icon: 'question',
                                        title: 'Devster 계정이 없습니다',
                                        text: '지금 바로 가입 하시겠습니까?',

                                        showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                                        confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                                        cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                                        confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                                        cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                                        reverseButtons: true // 버튼 순서 거꾸로
                                    }).then(result => {
                                        if (result.isConfirmed) {
                                            location.href = "apisignup";
                                        } else {
                                            return false;
                                        }
                                    });
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

