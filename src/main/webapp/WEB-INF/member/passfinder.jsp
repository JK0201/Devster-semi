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

        .links {
            display: flex;
            justify-content: space-evenly;
            list-style-type: none;
            text-align: center;
            margin: 0 30px 0 0;
        }

        .links li {
            display: inline-block;
            font-size: 3vh;
            border-top: 2px solid transparent;
        }

        .links li:hover {
            border-color: #8007AD;
            transition: .3s linear;
        }

        .links li span:hover {
            color: #8007AD;
            opacity: 1 !important;
            transition: .3s linear;
        }

        .links li span {
            opacity: 0.6;
        }

        .links li a {
            text-decoration: none;
            color: #0f132a;
            font-weight: bolder;
            text-align: center;
            cursor: pointer;
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

        #ptimer, #etimer {
            position: absolute;
            right: 28%;
            top: 38%;
            color: #8007AD;
        }

        #preseticon, #ereseticon {
            display: none;
            position: absolute;
            right: 29.5%;
            color: #8007AD;
            font-size: 3vh;
            top: 28%;
            cursor: pointer;
            z-index: 1;
        }

        #normmember span {
            opacity: 1;
            color: #8007AD;
        }

        .compmode {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity:0.6; font-weight: bold;">비&nbsp;밀&nbsp;번&nbsp;호&nbsp;찾&nbsp;기</div>
    </div>

    <div class="inputdiv">
        <div style="margin-left:33px; padding-bottom: 20px;">
            <strong style="color:#8007AD; font-weight: bold; margin-bottom: 10px;">일반회원</strong>
        </div>
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="normmember" style="font-size: 20px"><span>휴대폰 번호로 찾기</span></a>
            </li>
            <li>
                <a href="#" id="compmember" style="font-size: 20px"><span>이메일로 찾기</span></a>
            </li>
        </ul>

        <div class="normmode" id="phonefinder">
            <div class="input__block">
                <b>이&nbsp;메&nbsp;일</b>
                <input type="text" placeholder="Email" class="input" id="pemail" required/>
                <span id="pmailchkicon">　　</span>
            </div>
            <div class="input__block">
                <b>이&nbsp;름</b>
                <input type="text" placeholder="Name" class="input" id="pname" required/>
                <span id="pnamechkicon">　　</span>
            </div>
            <div class="membermail">
                <b>휴&nbsp;대&nbsp;폰</b>
                <i class="bi bi-arrow-clockwise" style="cursor: pointer" id="preseticon"></i>
                <div class="input-group">
                    <input type="tel" placeholder="Cellphone" id="pnum" required/>
                    <button class="memberbtn" id="pnumbtn" disabled>인&nbsp;증&nbsp;요&nbsp;청</button>
                </div>
                <span id="telechkicon">　　</span>
            </div>
            <div class="membermail">
                <div class="pregnum">
                    <b>인&nbsp;증&nbsp;번&nbsp;호</b>
                    <label id="ptimer"></label>
                    <div class="input-group">
                        <input type="text" id="pregnum" required>
                        <button class="memberbtn" id="psubmitbtn" disabled>확&nbsp;인</button>
                    </div>
                    <span>　</span>
                </div>
            </div>
        </div>

        <div class="compmode" id="emailfinder">
            <div class="input__block">
                <b>이&nbsp;름</b>
                <input type="text" placeholder="Name" class="input" id="ename" required/>
                <span id="enamechkicon">　　</span>
            </div>
            <div class="membermail">
                <b>이&nbsp;메&nbsp;일</b>
                <i class="bi bi-arrow-clockwise" style="cursor: pointer" id="ereseticon"></i>
                <div class="input-group">
                    <input type="email" placeholder="Email" id="enum" required/>
                    <button class="memberbtn" id="enumbtn" disabled>인&nbsp;증&nbsp;요&nbsp;청</button>
                </div>
                <span id="emailchkicon">　　</span>
            </div>
            <div class="membermail">
                <div class="eregnum">
                    <b>인&nbsp;증&nbsp;번&nbsp;호</b>
                    <label id="etimer"></label>
                    <div class="input-group">
                        <input type="text" id="eregnum" required>
                        <button class="memberbtn" id="esubmitbtn" disabled>확&nbsp;인</button>
                    </div>
                    <span>　</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        let normmode = $("#phonefinder");
        let compmode = $("#emailfinder");
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
            $(this).parent().find("span").css("opacity", "1");
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
            $(this).parent().find("span").css("opacity", "1");
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

    //name check
    $("#pname").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#pnamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이름을 확인해 주세요");
        } else {
            $("#pnamechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "멋진 이름이네요!");
        }
    });

    //name check
    $("#ename").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#enamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이름을 확인해 주세요");
        } else {
            $("#enamechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "멋진 이름이네요!");
        }
    });

    $(document).on("keyup", "#pemail", function () {
        let email = $("#pemail").val();
        if (!validEmail(email)) {
            $("#pmailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이메일을 확인 해주세요");
        } else {
            $("#pmailchkicon").html("<i class='bi bi-check' style='color:green;'></i>");
        }
    });

    $(document).on("keyup", "#enum", function () {
        let email = $("#enum").val();
        if (!validEmail(email)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이메일을 확인 해주세요");
        } else {
            $("#emailchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "이메일 인증을 진행 해주세요");
        }
    });

    //name pattern
    function validName(name) {
        let namePattern = /^[가-힣]+$/;
        return namePattern.test(name);
    }

    //phone pattern
    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

    //email pattern
    function validEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //ptimer
    let ptimer = null;
    let proc = false;

    function pStartTimer(count, display) {
        let min, sec;
        ptimer = setInterval(function () {
            min = parseInt(count / 60, 10);
            sec = parseInt(count % 60, 10);

            min = min < 10 ? "0" + min : min; //0붙이기
            sec = sec < 10 ? "0" + sec : sec;

            display.html(min + ":" + sec);

            //타이머 끝
            if (--count < 0) {
                clearInterval(ptimer);
                display.html("시간초과");
                $("#psubmitbtn").prop("disabled", true);
                proc = false;
            }
        }, 1000);
        proc = true;
    }

    //setup
    let pdisplay = $("#ptimer");
    let ptimeleft = 180;

    //phone check
    $(document).on("keyup", "#pnum", function () {
        let phonenum = $("#pnum").val();
        if (!validPhone(phonenum)) {
            $("#pnumbtn").prop("disabled", true);
            $("#telechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "휴대폰 번호를 확인해주세요");
        } else {
            $("#pnumbtn").prop("disabled", false);
            $("#telechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "사용 가능한 휴대폰 번호입니다");
        }
    });

    //reset number
    btncnt = 0;
    $(document).on("click", "#preseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        Swal.fire({
                            icon: "warning",
                            title: "휴대폰 번호를 수정 하시겠어요?",
                            text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                            reverseButtons: true // 버튼 순서 거꾸로
                        }).then(result => {
                            if (result.isConfirmed) {
                                clearInterval(ptimer);
                                pdisplay.html("");
                                $("#pregnum").val("");
                                $("#preseticon").hide();
                                $("#pnumbtn").html("인&nbsp;증&nbsp;요&nbsp;청");
                                $("#psubmitbtn").prop("disabled", true);
                                $("#pnum").prop("readonly", false);
                                cnt = 0;
                                btncnt++;
                                phonecheck = false;
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '최대 수정 횟수를 초과했습니다',
                            text: '잠시 후 다시 시도해주세요',

                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    }
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: '최대 수정 횟수를 초과했습니다',
                text: '잠시 후 다시 시도해주세요',

                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
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

    let code = "";
    let cnt = 0;
    $(document).on("click", "#pnumbtn", function () {
        let m_email = $("#pemail").val();
        let m_name = $("#pname").val();
        let m_tele = $("#pnum").val();

        $.ajax({
            type: "get",
            url: "pfindcheck",
            dataType: "json",
            data: {"m_email": m_email, "m_name": m_name, "m_tele": m_tele},
            success: function (res) {
                if (res.result == "no") {
                    Swal.fire({
                        icon: 'warning',
                        title: '등록되지 않은 회원입니다',

                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
                    });
                    return false;
                } else {
                    $("#pnum").prop("readonly", true);
                    let phonenum = $("#pnum").val();
                    pdisplay = $("#ptimer");
                    ptimeleft = 180;
                    if (!validPhone(phonenum)) {
                        return false;
                    } else {
                        if (cnt == 0) {
                            $.ajax({
                                type: "get",
                                url: "blockcheck",
                                cache: false,
                                success: function (res) {
                                    if (res == "yes") {
                                        Swal.fire({
                                            icon: 'success',
                                            title: '인증번호가 발송되었습니다',

                                            confirmButtonText: '확인',
                                            confirmButtonColor: '#8007AD'
                                        });
                                        $("#psubmitbtn").prop("disabled", false);
                                        $.ajax({
                                            type: "get",
                                            url: "phonechk?phonenum=" + phonenum,
                                            cache: false,
                                            success: function (res) {
                                                code = res;
                                                cnt++;
                                                console.log(cnt);

                                                $("#preseticon").show();
                                                $("#pnumbtn").html("재&nbsp;발&nbsp;송");

                                                if (proc) {
                                                    clearInterval(ptimer);
                                                    pdisplay.html("03:00");
                                                    pStartTimer(ptimeleft, pdisplay);
                                                } else {
                                                    pStartTimer(ptimeleft, pdisplay);
                                                }
                                            }
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: '최대 발급 횟수를 초과했습니다',
                                            text: '잠시 후 다시 시도해주세요',
                                            confirmButtonText: '확인',
                                            confirmButtonColor: '#8007AD'
                                        });
                                        return false;
                                    }
                                }
                            });
                        } else if (cnt > 0 && cnt < 3) {
                            Swal.fire({
                                icon: "warning",
                                title: "인증번호를 재발급 받으시겠어요?",
                                text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                                showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                                confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                                cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                                confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                                cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                                reverseButtons: true // 버튼 순서 거꾸로
                            }).then(result => {
                                if (result.isConfirmed) {
                                    let phonenum = $("#pnum").val();
                                    Swal.fire({
                                        icon: 'success',
                                        title: '인증번호가 발송되었습니다',

                                        confirmButtonText: '확인',
                                        confirmButtonColor: '#8007AD'
                                    });
                                    $("#psubmitbtn").prop("disabled", false);
                                    $.ajax({
                                        type: "get",
                                        url: "phonechk?phonenum=" + phonenum,
                                        cache: false,
                                        success: function (res) {
                                            cnt++;
                                            code = res;
                                            console.log(cnt);

                                            if (proc) {
                                                clearInterval(ptimer);
                                                pdisplay.html("03:00");
                                                pStartTimer(ptimeleft, pdisplay);
                                            } else {
                                                pStartTimer(ptimeleft, pdisplay);
                                            }
                                        }
                                    });
                                }
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: '최대 발급 횟수를 초과했습니다',
                                text: '잠시 후 다시 시도해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                            $.ajax({
                                type: "get",
                                url: "blocksend",
                                cache: false,
                                success: function (res) {
                                }
                            });
                            return false;
                        }
                    }
                }
            }
        });
    });

    $(document).on("click", "#psubmitbtn", function () {
        if ($("#pregnum").val() == code) {
            let m_email = $("#pemail").val();
            let m_name = $("#pname").val();
            let m_tele = $("#pnum").val();

            $.ajax({
                type: "get",
                url: "pfindcheck",
                dataType: "json",
                data: {"m_email": m_email, "m_name": m_name, "m_tele": m_tele},
                success: function (res) {
                    if (res.result == "no") {
                        Swal.fire({
                            icon: 'warning',
                            title: '이름과 전화번호를 확인해주세요',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    } else {
                        Swal.fire({
                            icon: 'success',
                            title: '인증 되었습니다',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        }).then(result => {
                            clearInterval(ptimer);
                            pdisplay.html("");
                            $("#pregnum").prop("readonly", true);
                            $("#pnumbtn").prop("disabled", true);
                            $("#preseticon").hide();

                            $.ajax({
                                type: "get",
                                url: "findaccinfo",
                                data: {"m_email": m_email, "m_name": m_name},
                                dataType: "text",
                                success: function () {
                                    location.replace("update");
                                }
                            });
                        });
                    }
                }
            });
        } else {
            Swal.fire({
                icon: 'warning',
                title: '인증 번호를 확인해주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            $("#pregnum").val("");
            $("#pregnum").focus();
        }
    });

    //etimer
    let etimer = null;
    let eproc = false;

    function eStartTimer(count, display) {
        let min, sec;
        etimer = setInterval(function () {
            min = parseInt(count / 60, 10);
            sec = parseInt(count % 60, 10);

            min = min < 10 ? "0" + min : min; //0붙이기
            sec = sec < 10 ? "0" + sec : sec;

            display.html(min + ":" + sec);

            //타이머 끝
            if (--count < 0) {
                clearInterval(etimer);
                display.html("시간초과");
                $("#esubmitbtn").prop("disabled", true);
                eproc = false;
            }
        }, 1000);
        eproc = true;
    }

    //setup
    let edisplay = $("#etimer");
    let etimeleft = 180;
    //email check
    $(document).on("keyup", "#enum", function () {
        let email = $("#enum").val();
        if (!validEmail(email)) {
            $("#enumbtn").prop("disabled", true);
        } else {
            $("#enumbtn").prop("disabled", false);
        }
    });

    //reset email
    btncnt = 0;
    $(document).on("click", "#ereseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        Swal.fire({
                            icon: "warning",
                            title: "이메일을 수정 하시겠어요?",
                            text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                            reverseButtons: true // 버튼 순서 거꾸로
                        }).then(result => {
                            if (result.isConfirmed) {
                                clearInterval(etimer);
                                edisplay.html("");
                                $("#eregnum").val("");
                                $("#ereseticon").hide();
                                $("#enumbtn").html("인&nbsp;증&nbsp;요&nbsp;청");
                                $("#esubmitbtn").prop("disabled", true);
                                $("#enum").prop("readonly", false);
                                ecnt = 0;
                                btncnt++;
                                emailcode = false;
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '최대 수정 횟수를 초과했습니다',
                            text: '잠시 후 다시 시도해주세요',

                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    }
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: '최대 수정 횟수를 초과했습니다',
                text: '잠시 후 다시 시도해주세요',

                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
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

    $(document).on("click", "#enumbtn", function () {
        let m_name = $("#ename").val();
        let m_email = $("#enum").val();

        $.ajax({
            type: "get",
            url: "efindcheck",
            dataType: "json",
            data: {"m_name": m_name, "m_email": m_email},
            success: function (res) {
                if (res.result == "no") {
                    Swal.fire({
                        icon: 'warning',
                        title: '등록되지 않은 회원입니다',

                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
                    });
                    return false;
                } else {
                    $("#enum").prop("readonly", true);
                    let email = $("#enum").val();
                    edisplay = $("#etimer");
                    etimeleft = 180;
                    if (!validEmail(email)) {
                        return false;
                    } else {
                        if (ecnt == 0) {
                            $.ajax({
                                type: "get",
                                url: "blockcheck",
                                cache: false,
                                success: function (res) {
                                    if (res == "yes") {
                                        Swal.fire({
                                            icon: 'success',
                                            title: '인증번호가 발송되었습니다',

                                            confirmButtonText: '확인',
                                            confirmButtonColor: '#8007AD'
                                        });
                                        $("#esubmitbtn").prop("disabled", false);
                                        $.ajax({
                                            type: "get",
                                            url: "sendemail?email=" + email,
                                            cache: false,
                                            success: function (res) {
                                                ecode = res;
                                                ecnt++;
                                                console.log(ecnt);
                                                $("#ereseticon").show();
                                                $("#pnumbtn").html("재&nbsp;발&nbsp;송");

                                                if (eproc) {
                                                    clearInterval(etimer);
                                                    edisplay.html("03:00");
                                                    eStartTimer(etimeleft, edisplay);
                                                } else {
                                                    eStartTimer(etimeleft, edisplay);
                                                }
                                            }
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: '최대 발급 횟수를 초과했습니다',
                                            text: '잠시 후 다시 시도해주세요',
                                            confirmButtonText: '확인',
                                            confirmButtonColor: '#8007AD'
                                        });
                                        return false;
                                    }
                                }
                            });
                        } else if (ecnt > 0 && ecnt < 3) {
                            Swal.fire({
                                icon: "warning",
                                title: "인증번호를 재발급 받으시겠어요?",
                                text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                                showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                                confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                                cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                                confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                                cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                                reverseButtons: true // 버튼 순서 거꾸로
                            }).then(result => {
                                if (result.isConfirmed) {
                                    let email = $("#enum").val();
                                    Swal.fire({
                                        icon: 'success',
                                        title: '인증번호가 발송되었습니다',

                                        confirmButtonText: '확인',
                                        confirmButtonColor: '#8007AD'
                                    });
                                    $("#esubmitbtn").prop("disabled", false);
                                    $.ajax({
                                        type: "get",
                                        url: "sendemail?email=" + email,
                                        cache: false,
                                        success: function (res) {
                                            ecnt++;
                                            ecode = res;
                                            console.log(ecnt);

                                            if (eproc) {
                                                clearInterval(etimer);
                                                edisplay.html("03:00");
                                                eStartTimer(etimeleft, edisplay);
                                            } else {
                                                eStartTimer(etimeleft, edisplay);
                                            }
                                        }
                                    });
                                }
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: '최대 발급 횟수를 초과했습니다',
                                text: '잠시 후 다시 시도해주세요',
                                confirmButtonText: '확인',
                                confirmButtonColor: '#8007AD'
                            });
                            $.ajax({
                                type: "get",
                                url: "blocksend",
                                cache: false,
                                success: function (res) {
                                }
                            });
                            return false;
                        }
                    }
                }
            }
        });
    });

    $(document).on("click", "#esubmitbtn", function () {
        if ($("#eregnum").val() == ecode) {
            let m_name = $("#ename").val();
            let m_email = $("#enum").val();

            $.ajax({
                type: "get",
                url: "efindcheck",
                dataType: "json",
                data: {"m_name": m_name, "m_email": m_email},
                success: function (res) {
                    if (res.result == "no") {
                        Swal.fire({
                            icon: 'warning',
                            title: '이름과 이메일을 확인해주세요',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    } else {
                        Swal.fire({
                            icon: 'success',
                            title: '인증 되었습니다',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        }).then(result => {
                            clearInterval(etimer);
                            edisplay.html("");
                            $("#eregnum").prop("readonly", true);
                            $("#enumbtn").prop("disabled", true);
                            $("#ereseticon").hide();

                            $.ajax({
                                type: "get",
                                url: "findaccinfo",
                                data: {"m_name": m_name, "m_email": m_email},
                                dataType: "text",
                                success: function () {
                                    location.replace("update");
                                }
                            });
                        });
                    }
                }
            });
        } else {
            Swal.fire({
                icon: 'warning',
                title: '인증 번호를 확인해주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            $("#eregnum").val("");
            $("#eregnum").focus();
        }
    });
</script>
</body>
</html>

