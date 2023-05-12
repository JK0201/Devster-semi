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

        #preseticon {
            display: none;
        }

        #ereseticon {
            display: none;
        }
    </style>
</head>
<body>
<div>
    개인회원 비밀번호 찾기
    <div>
        <label class="phonemode">휴대폰 번호로 찾기</label>
        <br>
        <label class="emailmode">이메일 주소로 찾기</label>
    </div>
    <div id="phonefinder">
        회원정보에 등록된 정보로 비밀번호를 찾을수 있습니다.
        <div>
            <div>
                이메일
                <input type="email" id="pemail">
                <span id="emailchkicon"></span>
            </div>
            <div>
                이름
                <input type="text" id="pname">
                <span id="pnamechkicon"></span>
            </div>
            <div class="input-group">
                휴대폰 번호
                <input type="tel" id="pnum">
                <button type="button" id="pnumbtn" disabled>인증번호 발송</button>
                <i class="bi bi-arrow-clockwise" id="preseticon"></i>
            </div>
            <div>
                인증번호
                <input type="text" id="pregnum">
                <label id="ptimer"></label>
            </div>
        </div>
        <div>
            <button type="button" id="psubmitbtn" disabled>인증확인</button>
        </div>
    </div>
    <div id="emailfinder">
        회원정보에 등록된 정보로 비밀번호를 찾을수 있습니다.
        <div>
            <div>
                이름 <input type="text" id="ename">
                <span id="enamechkicon"></span>
            </div>
            <div class="input-group">
                이메일 주소
                <input type="email" id="enum">
                <button type="button" id="enumbtn" disabled>인증번호 발송</button>
                <i class="bi bi-arrow-clockwise" id="ereseticon"></i>
            </div>
            <div>
                인증번호
                <input type="text" id="eregnum">
                <label id="etimer"></label>
            </div>
        </div>
        <div>
            <button type="button" id="esubmitbtn" disabled>인증확인</button>
        </div>
    </div>
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

    //name check
    $("#pname").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#pnamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이름을 입력해주세요</span>");
        } else {
            $("#pnamechkicon").html("<i class='bi bi-check' style='color:green;'></i>");
        }
    });

    //name check
    $("#ename").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이름을 입력해주세요</span>");
        } else {
            $("#enamechkicon").html("<i class='bi bi-check' style='color:green;'></i>");
        }
    });

    $(document).on("keyup", "#pemail", function () {
        let email = $("#pemail").val();
        if (!validEmail(email)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이메일을 입력해주세요</span>");
        } else {
            $("#emailchkicon").html("<i class='bi bi-check' style='color:green;'></i>");
        }
    });

    //name patter
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
    let ptimeleft = 29;

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
    $(document).on("click", "#preseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        let b = confirm("인증 중 휴대폰 번호를 수정하면 현재 발송된 인증번호는\n더이상 사용하실 수 없습니다. 그래도 수정하시겠어요?");
                        if (b) {
                            clearInterval(ptimer);
                            pdisplay.html("");
                            $("#pregnum").val("");
                            $("#preseticon").hide();
                            $("#pnumbtn").text("인증번호 발송");
                            $("#psubmitbtn").prop("disabled", true);
                            $("#pnum").prop("readonly", false);
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
                    alert("등록되지 않은 회원입니다");
                    return false;
                } else {
                    $("#pnum").prop("readonly", true);
                    let phonenum = $("#pnum").val();
                    pdisplay = $("#ptimer");
                    ptimeleft = 30;
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
                                        alert("인증번호가 발송되었습니다");
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
                                                $("#pnumbtn").text("재발송");

                                                if (proc) {
                                                    clearInterval(ptimer);
                                                    pdisplay.html("00:30");
                                                    pStartTimer(ptimeleft, pdisplay);
                                                } else {
                                                    pStartTimer(ptimeleft, pdisplay);
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
                                let phonenum = $("#pnum").val();
                                alert("인증번호가 발송되었습니다");
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
                                            pdisplay.html("00:30");
                                            pStartTimer(ptimeleft, pdisplay);
                                        } else {
                                            pStartTimer(ptimeleft, pdisplay);
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
                        alert("이름과 전화번호를 확인해주세요");
                        return false;
                    } else {
                        alert("인증 되었습니다");
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
                                location.href = "update";
                            }
                        });
                    }
                }
            });
        } else {
            alert("인증 번호 틀림");
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
    let etimeleft = 29;
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
                        let b = confirm("인증 중 이메일을 수정하면 현재 발송된 인증번호는\n더이상 사용하실 수 없습니다. 그래도 수정하시겠어요?");
                        if (b) {
                            clearInterval(etimer);
                            edisplay.html("");
                            $("#eregnum").val("");
                            $("#ereseticon").hide();
                            $("#enumbtn").text("인증번호 발송");
                            $("#esubmitbtn").prop("disabled", true);
                            $("#enum").prop("readonly", false);
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
                    alert("등록되지 않은 회원입니다");
                    return false;
                } else {
                    $("#enum").prop("readonly", true);
                    let email = $("#enum").val();
                    edisplay = $("#etimer");
                    etimeleft = 30;
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
                                        alert("인증번호가 발송되었습니다");
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
                                                $("#enumbtn").text("재발송");

                                                if (eproc) {
                                                    clearInterval(etimer);
                                                    edisplay.html("00:30");
                                                    eStartTimer(etimeleft, edisplay);
                                                } else {
                                                    eStartTimer(etimeleft, edisplay);
                                                }
                                            }
                                        });
                                    } else {
                                        alert("인증번호 발급횟수를 초과하셨습니다\n잠시후 다시 시도해주세요");
                                        return false;
                                    }
                                }
                            });
                        } else if (ecnt > 0 && ecnt < 3) {
                            let b = confirm("정말 인증번호를 다시 받으시겠습니까?\n기존의 번호는..");
                            if (b) {
                                let email = $("#enum").val();
                                alert("인증번호가 발송되었습니다");
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
                                            edisplay.html("00:30");
                                            eStartTimer(etimeleft, edisplay);
                                        } else {
                                            eStartTimer(etimeleft, edisplay);
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
                        alert("이름과 이메일을 확인해주세요");
                        return false;
                    } else {
                        alert("인증 되었습니다");
                        clearInterval(etimer);
                        edisplay.html("");
                        $("#eregnum").prop("readonly", true);
                        $("#enumbtn").prop("disabled", true);
                        $("#ereseticon").hide();

                        $.ajax({
                            type: "get",
                            url: "findaccinfo",
                            data: {"m_name": m_name, "m_tele": m_email},
                            dataType: "text",
                            success: function () {
                                location.href = "update";
                            }
                        });
                    }
                }
            });
        } else {
            alert("인증 번호 틀림");
            $("#eregnum").val("");
            $("#eregnum").focus();
        }
    });
</script>
</body>
</html>

