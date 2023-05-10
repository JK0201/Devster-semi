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
    <style>
        #emailfinder {
            display: none;
        }

        #reseticon {
            display: none;
            cursor: pointer;
        }
    </style>
</head>
<%
    String type = request.getParameter("type");
%>
<body>
<div>
    <%if (type.equals("0")) {%>
    개인회원 아이디 찾기
    <div>
        <label class="phonemode">휴대폰 번호로 찾기</label>
        <label class="emailmode">이메일 주소로 찾기</label>
    </div>
    <div id="phonefinder">
        회원정보에 등록된 정보로 아이디를 찾을수 있습니다.
        <div>
            <div>
                이름 <input type="text" id="pname">
            </div>
            <div class="input-group">
                휴대폰 번호
                <input type="tel" id="pnum">
                <button type="button" id="pnumbtn">인증번호 발송</button>
            </div>
            <div>
                인증번호
                <input type="text" id="pregnum">
                <label class="ptimer"></label>
                <i class="bi bi-arrow-clockwise" id="reseticon"></i>
            </div>
        </div>
    </div>
    <div id="emailfinder">
        회원정보에 등록된 정보로 아이디를 찾을수 있습니다.
        <div>
            <div>
                이름 <input type="text" id="ename">
            </div>
            <div class="input-group">
                이메일 주소
                <input type="email" id="enum">
                <button type="button" id="enumbtn">인증번호 발송</button>
            </div>
            <div>
                인증번호
                <input type="text" id="eregnum">
                <label class="timer"></label>
            </div>
        </div>
    </div>
    <div>
        <button type="button" id="submitbtn" disabled>인증확인</button>
    </div>
    <%}%>

    <%if (type.equals("2")) {%>
    <div>
        <div>
            <label id="cphonemode">휴대폰 번호로 찾기</label>
            <label id="cemailmode">이메일 주소로 찾기</label>
        </div>
        <div id="cphonefinder">
            회원정보에 등록된 정보로 아이디를 찾을수 있습니다.
            <div>
                <div>
                    이름 <input type="text" id="cpname">
                </div>
                <div class="input-group">
                    휴대폰 번호 <input type="tel" id="cpnum">
                    <button type="button" id="cpnumbtn">인증번호 발송</button>
                </div>
                <div>
                    인증번호 <input type="text" id="cregnum">
                </div>
            </div>
        </div>
        <div id="cemailfinder">
            회원정보에 등록된 정보로 아이디를 찾을수 있습니다.
            <div>
                <div>
                    이름 <input type="text" id="cename">
                </div>
                <div class="input-group">
                    휴대폰 번호 <input type="tel" id="cenum">
                    <button type="button" id="cenumbtn">인증번호 발송</button>
                </div>
                <div>
                    인증번호 <input type="text" id="ceregnum">
                </div>
            </div>
        </div>
        <div>
            <button type="button" id="csubmitbtn">인증확인</button>
        </div>
    </div>
    <%}%>
</div>
<script>
    $(".emailmode").click(function () {
        $("#emailfinder").show();
        $("#phonefinder").hide();
        $("#pname").val("");
        $("#pnum").val("");
        $("#pregnum").val("");

    });
    $(".phonemode").click(function () {
        $("#emailfinder").hide();
        $("#phonefinder").show();
        $("#ename").val("");
        $("#enum").val("");
        $("#eregnum").val("");
    });

    //email pattern
    function validEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //phone pattern
    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

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
                $("#submitbtn").prop("disabled", true);
                proc = false;
            }
        }, 1000);
        proc = true;
    }

    //setup
    let display = $("#ptimer");
    let timeleft = 29;

    //phone check
    $(document).on("keyup", "#pnum", function () {
        let phonenum = $("#pnum").val();
        if (!validPhone(phonenum)) {
            $("#pnumbtn").prop("disabled", true);
        } else {
            $("#pnumbtn").prop("disabled", false);
        }
    });

    //reset number
    btncnt = 0;
    $(document).on("click", "#reseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        let b = confirm("인증 중 휴대폰 번호를 수정하면 현재 발송된 인증번호는\n더이상 사용하실 수 없습니다. 그래도 수정하시겠어요?");
                        if (b) {
                            clearInterval(timer);
                            display.html("");
                            $("#regnumber").val("");
                            $("#reseticon").hide();
                            $(".phonereg").hide();
                            $("#sendnumber").text("인증요청");
                            $("#m_tele").prop("readonly", false);
                            $("#regbtn").prop("disabled", false);
                            cnt = 0;
                            btncnt++;
                            phonecheck = false;
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

    let code = "";
    let cnt = 0;
    $(document).on("click", "#sendnumber", function () {
        $("#m_tele").prop("readonly", true);
        let phonenum = $("#m_tele").val();
        display = $("#timer");
        timeleft = 30;
        if (!validPhone(phonenum)) {
            alert("번호를 확인해주세요");
            return false;
        } else {
            if (cnt == 0) {
                $.ajax({
                    type: "get",
                    url: "blockcheck",
                    cache: false,
                    success: function (res) {
                        if (res == "yes") {
                            alert("인증번호가 발송되었습니다");
                            $.ajax({
                                type: "get",
                                url: "phonechk?phonenum=" + phonenum,
                                cache: false,
                                success: function (res) {
                                    code = res;
                                    cnt++;
                                    console.log(cnt);

                                    $("#reseticon").show();
                                    $(".phonereg").show();
                                    $("#sendnumber").text("재발송");

                                    if (proc) {
                                        clearInterval(timer);
                                        display.html("00:30");
                                        startTimer(timeleft, display);
                                    } else {
                                        startTimer(timeleft, display);
                                    }
                                }
                            });
                        } else {
                            alert("인증번호 발급횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
                            return false;
                        }
                    }
                });
            } else if (cnt > 0 && cnt < 3) {
                let b = confirm("정말 인증번호를 다시 받으시겠습니까?\n기존의 번호는..");
                if (b) {
                    $("#regbtn").prop("disabled", false);
                    let phonenum = $("#m_tele").val();
                    alert("인증번호가 발송되었습니다");
                    $.ajax({
                        type: "get",
                        url: "phonechk?phonenum=" + phonenum,
                        cache: false,
                        success: function (res) {
                            cnt++;
                            code = res;
                            console.log(cnt);

                            if (proc) {
                                clearInterval(timer);
                                display.html("00:30");
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
        }
    });

    $(document).on("click", "#regbtn", function () {
        if ($("#regnumber").val() == code) {
            alert("인증 되었습니다");
            clearInterval(timer);
            display.html("");
            $("#regnumber").prop("readonly", true);
            $("#sendnumber").prop("disabled", true);
            $("#regbtn").prop("disabled", true);
            $("#reseticon").hide();
            phonecheck = true;
        } else {
            alert("인증 번호 틀림");
            $("#regnumber").val("");
            $("#regnumber").focus();
            phonecheck = false;
        }
    });
</script>
</body>
</html>

