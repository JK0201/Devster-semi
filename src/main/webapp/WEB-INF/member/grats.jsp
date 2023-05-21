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

        .inputdiv .input__block input {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 50px;
            margin: 0 auto;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .input__block input:focus,
        .inputdiv .input__block input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .input__block b {
            margin-left: 40px;
        }

        .inputdiv .input__block span {
            margin-left: 40px;
            color: #808080;
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

        .memberlayout footer {
            margin-top: 200px;
        }

        .inputdiv .membermail {
            margin-bottom: 20px;
            display: block;
            position: relative;
        }

        .inputdiv .membermail input {
            float: left;
            display: block;
            width: 70%;
            max-width: 680px;
            height: 50px;
            margin-left: 33px;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .membermail b {
            margin-left: 40px;
        }

        .inputdiv .membermail span {
            margin-left: 40px;
            color: #808080;
        }

        .inputdiv .membermail input:focus,
        .inputdiv .membermail input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .memberbtn {
            background: #8007AD;
            color: white;
            display: block;
            width: 20%;
            height: 50px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 2vh;
            font-family: 'Noto Sans KR', 'Roboto';
            font-weight: bold;
            opacity: 0.85;
            transition: .2s linear;
        }

        .inputdiv .memberbtn:hover {
            opacity: 1;
        }

        #timer {
            position: absolute;
            right: 28%;
            top: 38%;
            color: #8007AD;
        }

        #reseticon {
            display: none;
            position: absolute;
            right: 29.5%;
            color: #8007AD;
            font-size: 3vh;
            top: 28%;
            cursor: pointer;
            z-index: 1;
        }

        #ai_name {
            cursor: default;
        }

        #acaname {
            cursor: pointer;
            text-decoration: underline transparent;
            width: 70%;
            margin-bottom: 2px;
            transition: .1s linear;
            font-size: 1.7vh;
            margin: 0.2vh auto;
        }

        #acaname:hover {
            color: #8007AD;
            text-decoration: underline #8007AD;
        }

        .emailreg {
            display: none;
        }

        /*upload*/
        #uploadpopupbox {
            color: #bdbebd;
            font-size: 2.5vh;
            font-weight: bold;
            width: 90%;
            margin: 0 auto;
            height: 60px;
            border: 3px dashed #808080;
            border-radius: 10px;
            line-height: 55px;
            cursor: pointer;
            text-align: center;
        }

        #dropbox {
            width: 90%;
            height: 100%;
            cursor: default;
        }

        .uploadbox {
            width: 100%;
            height: 430px;
            border: 3px dashed #808080;
            border-radius: 10px;
        }

        #dndtext {
            text-align: center;
            background-color: #8007AD;
            font-size: 30px;
            width: 220px;
            height: 50px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            margin: 0 auto;
            border: 1px solid gray;
        }

        #sizetxt {
            font-size: 23px;
            float: left;
            margin-left: 15px;
            font-weight: bold;
            color: #bdbebd;
            cursor: pointer;
        }

        .btnupload {
            font-size: 25px;
            float: right;
            margin-right: 15px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .btnupload:hover {
            color: #8007AD;
        }

        .alldelbtn {
            font-size: 25px;
            float: right;
            margin-right: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .alldelbtn:hover {
            color: #8007AD;
        }

        #preview {
            margin: 0 auto;
            width: 50%;
            height: 50%;
            text-align: center;
        }

        #divimgbox {
            margin: 0 auto;
        }

        .imgpreview {
            width: 35vw;
            height: 35vh;
        }

        .previewdelbtn {
            width: 120px;
            color: red;
            opacity: 60%;
            font-size: 90px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            display: none;
        }

        /*modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fefefe;
            border: 1px solid #888;
            width: 50%;
        }

        .close {
            color: #bdbebd;
            font-size: 40px;
            cursor: pointer;
            font-weight: bold;
        }

        .close:hover {
            color: #8007AD;
        }

        .searchbox {
            width: 70%;
            height: 37vh;
            border: 3px dashed #808080;
            border-radius: 10px;
            margin: 0 auto;
            padding-top: 1.5vh;
        }

        #countbox {
            font-weight: bold;
            width: 70%;
            margin: 0 auto;
            padding-top: 1vh;
        }

        #uploadbtn {
            text-align: center;
            background-color: #bdbebd;
            font-size: 25px;
            width: 120px;
            height: 45px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            border: 1px solid #bdbebd;
            transition: 0.2s linear;
        }

        #uploadbtn:hover {
            background-color: #8007AD;
        }

        .progress {
            margin: 0 auto;
            position: relative;
            width: 50%;
            border: 1px solid #bdbebd;
            padding: 1px;
            border-radius: 5px;
            display: none;
        }

        .bar {
            background-color: #8007AD;
            width: 0%;
            height: 20px;
            border-radius: 3px;
        }

        .percent {
            position: absolute;
            display: inline-block;
            top: -3px;
            left: 48%;
            font-weight: bold;
        }
    </style>
</head>
<body>
<input type="hidden" id="m_type" value="0">
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">회&nbsp;원&nbsp;가&nbsp;입</div>
    </div>

    <div class="inputdiv">
        <div class="membermail">
            <b>이&nbsp;메&nbsp;일</b>
            <i class="bi bi-arrow-clockwise" style="cursor: pointer" id="reseticon"></i>
            <div class="input-group">
                <input type="email" placeholder="email@example.com" id="m_email">
                <button class="memberbtn" id="sendemail" disabled>인&nbsp;증&nbsp;요&nbsp;청</button>
            </div>
            <span id="emailchkicon">　　</span>
        </div>
        <div class="membermail">
            <div class="emailreg">
                <b>인&nbsp;증&nbsp;번&nbsp;호</b>
                <label id="timer">03:00</label>
                <div class="input-group">
                    <input type="text" id="eregnumber" required>
                    <button class="memberbtn" id="eregbtn">확&nbsp;인</button>
                </div>
                <span>　</span>
            </div>
        </div>
        <div class="input__block">
            <b>비&nbsp;밀&nbsp;번&nbsp;호</b>
            <input type="password" placeholder="Password" class="input" id="m_pass" required/>
            <span id="passokicon">　　</span>
        </div>
        <div class="input__block">
            <b>비&nbsp;밀&nbsp;번&nbsp;호&nbsp;확&nbsp;인</b>
            <input type="password" placeholder="Password" class="input" id="passchk" required/>
            <span id="passchkicon">　　</span>
        </div>
        <div class="input__block">
            <b>이&nbsp;름</b>
            <input type="text" placeholder="Name" class="input" id="m_name" required/>
            <span id="namechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>핸&nbsp;드&nbsp;폰</b>
            <input type="tel" placeholder="Cellphone" class="input" id="m_tele" required/>
            <span id="telechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>닉&nbsp;네&nbsp;임</b>
            <input type="text" placeholder="Nickname" class="input" id="m_nickname" required/>
            <span id="nicknamechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>학&nbsp;원</b>
            <input type="text" placeholder="" class="input" id="ai_name" readonly required/>
            <span>　　</span>
        </div>
        <div class="input__block">
            <b>프&nbsp;로&nbsp;필&nbsp;사&nbsp;진&nbsp;(선&nbsp;택)</b>
            <!-- upload -->
            <div id="uploadpopupbox">사진 등록하기&nbsp;<i class="bi bi-plus-circle"></i></div>
            <section id="dropbox" style="margin:0 auto; display: none;">
                <div class="uploadbox">
                    <input type="file" accept=".jpg, .jpeg, .png" id="filebtn" class="btn-file d-none">
                    <div style="width:100%; height:70px; line-height: 60px;">
                            <span id="sizetxt" style="height:45px; font-size:2.5vh; margin-left:38%;">사진 등록하기&nbsp;<i
                                    class="bi bi-dash-circle"></i></span>
                        <i class="bi bi-recycle alldelbtn" style="height:45px;"></i>
                        <i class="bi bi-plus-circle btnupload" style="height:45px;"></i>
                    </div>
                    <div id="preview">
                        <div id="divimgbox" style="margin:0 auto; width:100%;">
                            <div style="padding-top:40px;">
                                <i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>
                                <div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">
                                    나만의 멋진 프로필<br>사진을 올려보세요!
                                </div>
                                <div id="dndtext">Drag & Drop</div>
                            </div>
                        </div>
                    </div>
                    <div style="width:100%; height:60px; padding-top:15px;">
                        <div class="progress">
                            <div class="bar progress-bar-striped progress-bar-animated"></div>
                            <div class="percent">0%</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="input__block">
            <b>동의</b>
        </div>
        <div style="width:100%; height:60px; padding-top: 15px; text-align:center;">
            <button type=button id="uploadbtn">확인</button>
        </div>
    </div>
    <!-- Academy Modal -->
    <div id="myUploadModal" class="modal">
        <div class="modal-content">
            <div class="inputdiv" style="box-shadow: none; padding-bottom: 0; padding-top:0;">
                <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
                    <i class="bi bi-x-circle close"></i>
                    <div class="membermail">
                        <b style="float: left; margint-left:40px; padding-left: 35px;">학&nbsp;원&nbsp;검&nbsp;색</b>
                        <div class="input-group" style="width:90%; margin:0 auto">
                            <input type="text" placeholder="검색 하실 학원명을 입력해주세요" id="modalname">
                            <button class="memberbtn" id="acanamebtn">등&nbsp;록</button>
                        </div>
                        <div style="margin: 0 auto; width: 76%; text-align: left; font-size: 1.5vh; color:#bdbebd; margin-bottom: 1vh">
                            <sapn>tip.찾으시는 학원명이 없으시다면 학원명 입력후 등록을 눌러주세요!</sapn>
                        </div>
                        <div class="searchbox">
                            <div id="searchbox"></div>
                            <div id="loadingbox"
                                 style="display: inline-block; margin-top: 30%;font-size: 3vh; color:#8007AD; opacity: .8;"></div>
                        </div>
                        <div id="countbox"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //modal
    $(document).ready(function () {
        // Open modal
        $("#ai_name").click(function () {
            $("#myUploadModal").fadeIn();
            $("#modalname").val("");
            $("#loadingbox").html("");
            $("#searchbox").html("");
            $("#countbox").html("학원명을 입력해 주세요");
        });

        //esc
        $(document).keyup(function (e) {
            if (e.keyCode == 27) {
                $(".close").click();
            }
        });

        // Close modal
        $(".close").click(function () {
            $("#myUploadModal").fadeOut();
        });

        $("#uploadpopupbox").click(function () {
            $(this).hide();
            $("#dropbox").slideDown();
        });

        $("#sizetxt").click(function () {
            $("#dropbox").slideUp(function () {
                $("#uploadpopupbox").show();
            });
        });
    });

    let emailvalid = false;
    let emailcheck = false;
    let emailcode = false;
    let passvalid = false;
    let passcheck = false;
    let nickvalid = false;
    let nickname = false;
    let namevalid = false;
    let phonevalid = false;
    let acacheck = false;

    //emailcheck
    $("#m_email").keyup(function () {
        let m_email = $(this).val();
        if (!validEmail(m_email)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "옳바른 이메일 형식을 써주세요");
            emailvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "emailchk",
                dataType: "json",
                data: {"m_email": m_email},
                success: function (res) {
                    if (res.result == "yes") {
                        $("#emailchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                            "사용가능한 E-mail입니다");
                        emailcheck = true;
                    } else {
                        $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "이미 사용중인 E-mail입니다");
                        $("#sendemail").prop("disabled", true);
                        emailcheck = false;
                    }
                }
            });
            emailvalid = true;
        }
    });

    //timer
    let timer = null;
    let proc = false;

    function startTimer(count, display) {
        let min, sec;
        timer = setInterval(function () {
            min = parseInt(count / 60, 10);
            sec = parseInt(count % 60, 10);

            min = min < 10 ? "0" + min : min; //0붙이기
            sec = sec < 10 ? "0" + sec : sec;

            display.html(min + ":" + sec);

            //타이머 끝
            if (--count < 0) {
                clearInterval(timer);
                display.html("시간초과");
                $("#eregbtn").prop("disabled", true);
                proc = false;
            }
        }, 1000);
        proc = true;
    }

    //setup
    let display = $("#timer");
    let timeleft = 180;

    //email check
    $(document).on("keyup", "#m_email", function () {
        let email = $("#m_email").val();
        if (!validEmail(email)) {
            $("#sendemail").prop("disabled", true);
        } else {
            $("#sendemail").prop("disabled", false);
        }
    });

    //reset email
    btncnt = 0;
    $(document).on("click", "#reseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        let b = confirm("인증 중 이메일을 수정하면 현재 발송된 인증번호는\n더이상 사용하실 수 없습니다. 그래도 수정하시겠어요?");
                        if (b) {
                            clearInterval(timer);
                            display.html("03:00");
                            $("#eregnumber").val("");
                            $("#reseticon").hide();
                            $(".emailreg").hide();
                            $("#sendemail").html("인&nbsp;증&nbsp;요&nbsp;청");
                            $("#m_email").prop("readonly", false);
                            $("#eregbtn").prop("disabled", false);
                            ecnt = 0;
                            btncnt++;
                            emailcode = false;
                        }
                    } else {
                        alert("수정 횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
                        return false;
                    }
                }
            });
        } else {
            alert("수정 횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
            $.ajax({
                type: "get",
                url: "blockreset",
                cache: false,
                success: function (res) {
                }
            });
            return false;
        }
    });

    let ecode = "";
    let ecnt = 0;
    $(document).on("click", "#sendemail", function () {
        $("#m_email").prop("readonly", true);
        let email = $("#m_email").val();
        display = $("#timer");
        timeleft = 180;
        if (ecnt == 0) {
            $.ajax({
                type: "get",
                url: "blockcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        alert("인증번호가 발송되었습니다");
                        $.ajax({
                            type: "get",
                            url: "sendemail?email=" + email,
                            cache: false,
                            success: function (res) {
                                ecode = res;
                                ecnt++;
                            }
                        });
                        $("#reseticon").show();
                        $(".emailreg").show();
                        $("#sendemail").html("재&nbsp;발&nbsp;송");

                        if (proc) {
                            clearInterval(timer);
                            display.html("03:00");
                            startTimer(timeleft, display);
                        } else {
                            startTimer(timeleft, display);
                        }
                    } else {
                        alert("인증번호 발급횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
                        return false;
                    }
                }
            });
        } else if (ecnt > 0 && ecnt < 3) {
            let b = confirm("정말 인증번호를 다시 받으시겠습니까?\n기존의 번호는..");
            if (b) {
                $("#eregbtn").prop("disabled", false);
                let email = $("#m_email").val();
                alert("인증번호가 발송되었습니다");
                $.ajax({
                    type: "get",
                    url: "sendemail?email=" + email,
                    cache: false,
                    success: function (res) {
                        ecnt++;
                        ecode = res;

                        if (proc) {
                            clearInterval(timer);
                            display.html("03:00");
                            startTimer(timeleft, display);
                        } else {
                            startTimer(timeleft, display);
                        }
                    }
                });
            }
        } else {
            alert("인증번호 발급횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
            $.ajax({
                type: "get",
                url: "blocksend",
                cache: false,
                success: function (res) {
                }
            });
            return false;
        }
    });

    $(document).on("click", "#eregbtn", function () {
        if ($("#eregnumber").val() == "") {
            alert("입력하세요");
            return false;
        } else {
            if ($("#eregnumber").val() == ecode) {
                alert("인증 되었습니다");
                clearInterval(timer);
                display.html("");
                $("#eregnumber").prop("readonly", true);
                $("#sendemail").prop("disabled", true);
                $("#sendemail").html("<i class='bi bi-check2'></i>")
                $("#eregbtn").prop("disabled", true);
                $("#reseticon").hide();
                emailcode = true;
            } else {
                alert("인증 번호 틀림");
                $("#eregnumber").val("");
                $("#eregnumber").focus();
                emailcode = false;
            }
        }
    });

    //email pattern
    function validEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //pass check
    function updatePasswordStatus() {
        let pass = $("#m_pass").val();
        let passMatch = $("#passchk").val();
        let valid = validPass(pass);

        if (valid) {
            $("#passokicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "사용 가능한 비밀번호에요");
            passvalid = true;
        } else {
            $("#passokicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "8~16자리 영문 대소문자, 숫자, 특수문자의 조합으로 만들어주세요");
            passvalid = false;
        }

        if (pass != passMatch) {
            $("#passchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "비밀번호와 일치하지 않아요");
            passcheck = false;
        } else {
            $("#passchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "비밀번호와 일치해요");
            passcheck = true;
        }

        if (pass == "" && passMatch == "") {
            $("#passchkicon").html("");
        }
    }

    $("#m_pass").keyup(function () {
        updatePasswordStatus();
    });

    $("#passchk").keyup(function () {
        updatePasswordStatus();
    });

    function validPass(pass) {
        let passPattern = /^[a-zA-Z0-9!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]+$/;
        return pass.length >= 8 && pass.length <= 16 && passPattern.test(pass);
    }

    //nickname check
    $("#m_nickname").keyup(function () {
        let m_nickname = $(this).val();

        if (!validNickname(m_nickname)) {
            $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "2~10자의 한글,영문과 숫자만 사용해주세요");
            nickvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "nicknamechk",
                dataType: "json",
                data: {"m_nickname": m_nickname},
                success: function (res) {
                    if (res.result == "no") {
                        $("#nicknamechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                            "사용가능한 ID입니다");
                        nickname = true;
                    } else {
                        $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "이미 사용중인 ID입니다");
                        nickname = false;
                    }
                }
            });
            nickvalid = true;
        }
    });

    function validNickname(nickname) {
        let nickNamePattern = /^[a-zA-Z0-9가-힣]{2,10}$/;
        return nickNamePattern.test(nickname);
    }

    //name check
    $("#m_name").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#namechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "옳바른 이름을 입력해주세요");
            namevalid = false;
        } else {
            $("#namechkicon").html("<i class='bi bi-check' style='color:green;'></i>");
            namevalid = true;
        }
    });

    function validName(name) {
        let namePattern = /^[가-힣]+$/;
        return namePattern.test(name);
    }

    //phone check
    $(document).on("keyup", "#m_tele", function () {
        let phonenum = $("#m_tele").val();
        if (!validPhone(phonenum)) {
            $("#telechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "옳바른 번호를 입력해주세요");
            phonevalid = false;
        } else {
            $("#telechkicon").html("<i class='bi bi-check' style='color:green;'></i>");
            phonevalid = true;
        }
    });

    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

    //academy
    $(document).on("keyup", "#modalname", function () {
        let ai_name = $(this).val();
        $.ajax({
            type: "get",
            url: "searchai",
            dataType: "json",
            data: {"ai_name": ai_name},
            success: function (res) {
                let resultList = $("#searchbox");
                resultList.empty();

                if ($("#modalname").val() == "") {
                    $("#loadingbox").html("");
                    $("#countbox").html("");
                    $("#countbox").html("학원명을 입력해주세요");
                } else {
                    let s = "";
                    let count = 0;
                    $.each(res, function (idx, ele) {
                        if (ele.ai_name.includes(ai_name)) {
                            $("#loadingbox").html("");
                            if (count >= 0 && count <= 10) {
                                s += `
                                <div id="acaname">\${ele.ai_name}</div>
                                `;
                                count++;
                            } else {
                                count++;
                            }
                        }
                        if (!ele.ai_name.includes(ai_name) && count == 0) {
                            $("#loadingbox").html("<label><div class='spinner-border spinner-border text-mute'></div>" +
                                "&nbsp;Loading</label>");
                        }
                    });
                    if (count == 0) {
                        $("#countbox").html("검색결과가 없습니다");
                    } else if (count >= 0 && count <= 10) {
                        $("#countbox").html("총" + count + "개의 검색결과");
                    } else {
                        s += "...";
                        $("#countbox").html("총" + count + "개의 검색결과");
                    }
                    resultList.html(s);
                }
            }
        });
    });

    $(document).on("click", "#acaname", function () {
        let txt = $(this).text();
        $("#modalname").val(txt);
        $("#ai_name").val(txt);
        if ($("#ai_name").val() != "") {
            acacheck = true;
        } else {
            acacheck = false;
        }
    });

    $(document).on("click", "#acanamebtn", function () {
        let txt = $("#modalname").val();
        $("#ai_name").val(txt);
        $("#myUploadModal").fadeOut();
        if ($("#ai_name").val() != "") {
            acacheck = true;
        } else {
            acacheck = false;
        }
    });

    //trigger function
    $(document).on("mouseover keyup", function () {
        if (emailcheck && emailvalid && emailcode && passcheck && passvalid && nickname && nickvalid && namevalid && phonevalid && acacheck) {
            console.log("true");
        } else {
            $("#submitbtn").prop("disabled", true);
        }
    });

    //DnD + Upload
    //upload
    var filesarr = [];

    $(".btnupload").click(function () {
        $("#filebtn").click();
    });

    $(document).on("change", "#filebtn", function (e) {
        var cnt = e.target.files.length;
        var data = e.target.files;

        if (!isValidBtn(data)) {
            return false
        } else {
            var file = Array.prototype.slice.call(data);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
        }

        //유효성
        function isValidBtn(data) {
            //이미지인가?
            for (let i = 0; i < cnt; i++) {
                if (data[i].type.indexOf("image") < 0) {
                    alert("이미지만 업로드 가능합니다");
                    return false;
                }
            }

            //클릭 업로드 개수
            if (filesarr.length + cnt > 1) {
                filesarr = [];
            }

            //파일의 사이즈는 20MB
            let totalsize = filestotalsize(filesarr) + filestotalsize(data);
            if (totalsize >= 1024 * 1024 * 50) {
                alert("전체 업로드 파일의 크기가 50Mb를 초과하였습니다");
                return false;
            }

            return true;
        }
    });

    //DnD
    var doc = document.querySelector("#dropbox");
    var btnupload = doc.querySelector(".btnupload");
    var inputfile = doc.querySelector("input[type='file']");
    var uploadbox = doc.querySelector(".uploadbox");

    //박스안에 drag 들어왔을 경우
    uploadbox.addEventListener("dragenter", function (e) {
        e.preventDefault();
    });

    //박스 안에 drag를 하고있을 경우
    uploadbox.addEventListener("dragover", function (e) {
        e.preventDefault();
        var vaild = e.dataTransfer.types.indexOf('Files') >= 0;
        if (!vaild) {
            this.style.borderColor = 'red';
        } else {
            $(this).css("border-color", "#8007AD");
            $("#dndtext").css("backgroundColor", "#bdbebd");
        }
    });

    //박스 밖으로 Drag가 나갈때
    uploadbox.addEventListener("dragleave", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#bdbebd");
        $("#dndtext").css("backgroundColor", "#8007AD");
    });

    //박스안에서 drag를 drop했을떄
    uploadbox.addEventListener("drop", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#808080");
        var data = e.dataTransfer;

        if (!isValid(data)) {
            return false;
        } else {
            var file = Array.prototype.slice.call(data.files);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
        }
    });

    //preview
    var fileidx = 0;

    function imgpreview(file) {
        file.forEach(function (f) {
            if (!f.type.match("image.*")) {
                alert("이미지만 업로드 가능합니다");
                return;
            }

            if (filesarr.length == 0) {
                $("#divimgbox").html("");
            }
            var reader = new FileReader();
            var s = "";
            reader.onload = function (e) {
                f.index = fileidx
                s += "<div id='box" + fileidx + "' style='float:left; position: relative;'>";
                s += "<div class='imgbox'>";
                s += "<img src='" + e.target.result + "' class='img-thumbnail imgpreview'>";
                s += "<i class='bi bi-dash-circle previewdelbtn' onclick='deletefile(\"" + fileidx + "\")'></i>";
                s += "</div>"
                s += "</div>";
                $("#divimgbox").hide().fadeIn("fast");
                $("#divimgbox").append(s);
                fileidx++;
            }
            reader.readAsDataURL(f);
        });
    }

    //del btn anime
    $(document).ready(function () {
        $(document).on("mouseenter", ".imgbox", function () {
            $(this).find(".previewdelbtn").show();
        });

        $(document).on("mouseleave", ".imgbox", function () {
            $(this).find(".previewdelbtn").hide();
        });
    });

    //delete
    function deletefile(index) {
        $("#box" + index).fadeOut("fast", function () {
            $(this).remove();

            let indexToRemove;
            for (let i = 0; i < filesarr.length; i++) {
                if (filesarr[i].index == index) {
                    indexToRemove = i;
                    break;
                }
            }
            if (indexToRemove != undefined) {
                filesarr.splice(indexToRemove, 1);
            }
            console.log(filesarr.length);
            if (filesarr.length == 0) {
                $("#divimgbox").html('<div style="padding-top:40px;">' +
                    '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                    '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                    '나만의 멋진 프로필<br>사진을 올려보세요!</div>' +
                    '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
            }
        });
    }

    //all del button
    $(".alldelbtn").click(function () {
        console.log(fileidx);

        filesarr = [];
        fileidx = 0;

        console.log(filesarr.length);
        if (filesarr.length == 0) {
            $("#divimgbox").html('<div style="padding-top:40px;">' +
                '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                '나만의 멋진 프로필<br>사진을 올려보세요!</div>' +
                '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
        }
    });

    //유효성 검사
    function isValid(data) {
        //파일인가?
        if (data.types.indexOf('Files') < 0)
            return false;

        //이미지인가?
        for (let i = 0; i < data.files.length; i++) {
            if (data.files[i].type.indexOf("image") < 0) {
                alert("이미지만 업로드 가능합니다");
                return false;
            }
        }

        //파일개수 최대 1개 (filesarr reset)
        if (filesarr.length + data.files.length > 1) {
            filesarr = [];
        }

        //파일의 사이즈는 총 20MB

        let totalsize = filestotalsize(filesarr) + filestotalsize(data.files);
        if (totalsize >= 1024 * 1024 * 50) {
            alert("전체 업로드 파일의 크기가 50MB를 초과하였습니다");
            return false;
        }
        return true;
    }

    //filestotal size
    function filestotalsize(files) {
        let totalsize = 0;
        for (let i = 0; i < files.length; i++) {
            totalsize += files[i].size;
        }
        return totalsize
    }

    //submit (json)
    $("#uploadbtn").click(function () {
        Swal.fire({
            title: '파일을 업로드 하시겠습니까?',
            text: '확인 버튼을 누르면 파일이 업로드 됩니다',
            icon: 'warning',

            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

            reverseButtons: true // 버튼 순서 거꾸로
        }).then(result => {
            if (result.isConfirmed) {

                let formData = new FormData();
                console.log(filesarr);
                console.log(filesarr.length);

                for (i = 0; i < filesarr.length; i++) {
                    console.log(filesarr[i]);
                    formData.append("upload", filesarr[i]);
                }

                var bar = $('.bar');
                var percent = $('.percent');

                $.ajax({
                    xhr: function () {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener('progress', function (e) {
                            if (e.lengthComputable) {
                                var percentComplete = Math.floor((e.loaded / e.total) * 100);

                                var percentVal = percentComplete + '%';
                                bar.width(percentVal);
                                percent.html(percentVal);
                            }
                        }, false);
                        return xhr;
                    },
                    type: "post",
                    url: "dndupdatetest",
                    dataType: "text",
                    data: formData,
                    processData: false,
                    contentType: false,
                    beforeSend: function () {
                        $("#uploadbtn").prop("disabled", true);
                        $(".progress").fadeIn('fast');
                        var percentVal = '0%';
                        bar.width(percentVal);
                        percent.html(percentVal);
                    },
                    complete: function () {
                        $(".progress").fadeOut('fast');
                    },
                    success: function () {
                        $("#uploadbtn").prop("disabled", false);
                        Swal.fire({
                            title: '파일 업로드를 완료했습니다',
                            icon: 'success',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        }).then(result => {
                            console.log(result);
                            $("#myUploadModal").fadeOut('fast');
                        });
                    }
                });
            } else {
                return false;
            }
        });
    });


</script>
</body>
</html>