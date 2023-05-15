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
        #preseticon {
            display: none;
        }
    </style>
</head>
<body>
<div>
    기업회원 아이디 찾기
    <div>
        <label clsss="empmode">사업자등록번호로 찾기</label>
        <label class="phonemode">휴대폰 번호로 찾기</label>
    </div>
    <div id="phonefinder">
        회원정보에 등록된 정보로 아이디를 찾을수 있습니다.
        <div>
            <div>
                담당자명(이름) <input type="text" id="pname">
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
</div>
<script>
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
        let cm_name = $("#pname").val();
        let cm_cp = $("#pnum").val();

        $.ajax({
            type: "get",
            url: "cnpcheck",
            dataType: "json",
            data: {"cm_name": cm_name, "cm_cp": cm_cp},
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
            let cm_name = $("#pname").val();
            let cm_cp = $("#pnum").val();

            $.ajax({
                type: "get",
                url: "cnpcheck",
                dataType: "json",
                data: {"cm_name": cm_name, "cm_cp": cm_cp},
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
                            type: "post",
                            url: "cpaccinfo",
                            data: {"cm_name": cm_name, "cm_cp": cm_cp},
                            dataType: "text",
                            success: function () {
                                location.href = "cpaccfound";
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
</script>
</body>
</html>

