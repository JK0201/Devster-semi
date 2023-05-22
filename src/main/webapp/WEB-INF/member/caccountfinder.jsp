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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            cursor: default;
        }

        #cmdisplay {
            display: none;
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

        #ptimer {
            position: absolute;
            right: 28%;
            top: 38%;
            color: #8007AD;
        }

        #preseticon {
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
            opacity: 0.6;
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
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</div>
    </div>

    <div class="inputdiv">
        <div style="margin-left:33px; padding-bottom: 20px;">
            <strong style="color:#8007AD; font-weight: bold; margin-bottom: 10px;">기업회원</strong>
        </div>
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="normmember" style="font-size: 20px"><span>휴대폰 번호로 찾기</span></a>
            </li>
        </ul>
        <div class="membermail" id="regnumgate">
            <b>사&nbsp;업&nbsp;자&nbsp;등&nbsp;록&nbsp;번&nbsp;호</b>
            <div class="input-group">
                <input type="text" placeholder="Registration Number" id="cm_reg">
                <button class="memberbtn" id="regbtn">확&nbsp;인</button>
            </div>
            <span id="regchk">　　</span>
        </div>
        <div id="cmdisplay">
            <div class="input__block">
                <b>이&nbsp;름&nbsp;(담&nbsp;당&nbsp;자)</b>
                <input type="text" placeholder="Name" class="input" id="pname" required/>
                <span id="pnamechkicon">　　</span>
            </div>
            <div class="membermail">
                <b>휴&nbsp;대&nbsp;폰&nbsp;(담&nbsp;당&nbsp;자)</b>
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
    </div>
</div>
<script>
    //reg chk
    let regvaild = false;
    let regcheck = false;

    $("#cm_reg").keyup(function () {
        var cm_reg = $("#cm_reg").val().replace(/-/g, '');

        //comp reg pattern
        function validReg(reg) {
            let regPattern = /^[0-9]{1,10}$/;
            return regPattern.test(reg);
        }

        if (!validReg(cm_reg)) {
            $("#regchk").html("<i class='bi bi-x' style='color:red;'></i>" +
                "사업자 등록번호를 확인해 주세요");
            regvaild = false;
        } else {
            $("#regchk").html("");
            regvaild = true;
            $.ajax({
                type: "get",
                url: "compregchk",
                data: {"cm_reg": cm_reg},
                dataType: "json",
                success: function (res) {
                    if (res.result == "no") {
                        return false;
                    } else {
                        regcheck = true;
                    }
                }
            });
        }
    });

    $("#regbtn").click(function () {
        if (!regcheck || !regvaild) {
            Swal.fire({
                icon: 'warning',
                title: '사업자 등록번호를 확인해주세요',

                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            return false;
        } else if ($("#cm_reg").val() == "") {
            Swal.fire({
                icon: 'warning',
                title: '사업자 등록번호를 확인해주세요',

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
            });
            $("#regnumgate").hide();
            $("#cmdisplay").slideDown();
            console.log($("#cm_reg").val());
        }
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

    function validName(name) {
        let namePattern = /^[가-힣]+$/;
        return namePattern.test(name);
    }

    //phone pattern
    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
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
        }
    )
    ;

    let code = "";
    let cnt = 0;
    $(document).on("click", "#pnumbtn", function () {
        let cm_name = $("#pname").val();
        let cm_cp = $("#pnum").val();
        let cm_reg = $("#cm_reg").val();

        console.log(cm_reg);

        $.ajax({
            type: "get",
            url: "cnpcheck",
            dataType: "json",
            data: {"cm_name": cm_name, "cm_cp": cm_cp, "cm_reg": cm_reg},
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
            let cm_name = $("#pname").val();
            let cm_cp = $("#pnum").val();
            let cm_reg = $("#cm_reg").val();

            $.ajax({
                type: "get",
                url: "cnpcheck",
                dataType: "json",
                data: {"cm_name": cm_name, "cm_cp": cm_cp, "cm_reg": cm_reg},
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
                                type: "post",
                                url: "cpaccinfo",
                                data: {"cm_name": cm_name, "cm_cp": cm_cp},
                                dataType: "text",
                                success: function () {
                                    location.replace("cpaccfound");
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
</script>
</body>
</html>