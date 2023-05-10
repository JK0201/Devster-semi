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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        #ai_name {
            cursor: default;
        }

        #acaname {
            cursor: pointer;
        }

        #acaname:hover {
            color: red;
        }

        #reseticon {
            display: none;
            cursor: pointer;
        }

        .emailreg {
            display: none;
        }
    </style>
</head>
<body>
<input type="hidden" id="m_type" value="0">
<div style="width : 500px;">
    <div>
        <strong>이메일</strong>
        <input type="email" id="m_email" required placeholder="email@example.com">
        <span id="emailchkicon"></span>
    </div>
    <div class="input-group emailchk">
        <strong>이메일</strong>
        <button type="button" id="sendemail" disabled>인증요청</button>
        <i class="bi bi-arrow-clockwise" id="reseticon"></i>
    </div>
    <div class="inputgroup emailreg">
        <label id="timer">00:30</label>
        <input type="text" id="eregnumber" required>
        <button type="button" id="eregbtn">확인</button>
    </div>
    <div>
        <strong>닉네임</strong>
        <input type="text" id="m_nickname" required placeholder="2~10자리 / 한글,영문,숫자 사용가능">
        <span id="nicknamechkicon"></span>
    </div>
    <div>
        <strong>비밀번호</strong>
        <input type="password" id="m_pass" required placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
        <span id="passokicon"></span>
        <b>비밀번호확인</b>
        <input type="password" id="passchk" placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
        <span id="passchkicon"></span>
    </div>
    <div>
        <strong>이름 </strong>
        <input type="text" id="m_name" required placeholder="이름 입력">
        <span id="namechkicon"></span>
    </div>
    <div class="input-group phonechk">
        <strong>휴대폰</strong>
        <input type="tel" id="m_tele" required placeholder="'-'빼고 숫자만 입력">
        <span id="telechkicon"></span>
    </div>
    <div>
        <strong>학원</strong>
        <input type="text" id="ai_name" required readonly data-bs-toggle="modal"
               data-bs-target="#myAcademyInfoModal">
    </div>
    <div>
        <strong>사진</strong>
        <input type="file" id="m_photo">
        <!-- 사진 미리보기 구현 해야함 -->
    </div>
</div>
<div>
    <button type="button" id="submitbtn" disabled>가입하기</button>
</div>
<!-- 학원 모달 -->
<div class="modal" id="myAcademyInfoModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Modal Heading</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div class="input-group">
                    <input type="text" id="modalname">
                    <button type="button" id="" data-bs-dismiss="modal">선택</button>
                </div>
                <div id="searchbox">검색어를 입력해주세요</div>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<%--<script src="/js/membersignup.js"></script>--%>
<script>
    let emailvalid = false;
    let emailcheck = false;
    let emailcode = false;
    let passvalid = false;
    let passcheck = false;
    let nickvalid = false;
    let nickname = false;
    let namevalid = false;
    let phonevalid = false;

    //emailcheck
    $("#m_email").keyup(function () {
        let m_email = $(this).val();
        if (!validEmail(m_email)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이메일 형식을 써주세요</span>");
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
                            "<span>사용가능한 E-mail입니다</span>");
                        emailcheck = true;
                    } else {
                        $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "<span>이미 사용중인 E-mail입니다</span>");
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
    let timeleft = 29;

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
                            display.html("00:30");
                            $("#eregnumber").val("");
                            $("#reseticon").hide();
                            $(".emailreg").hide();
                            $("#sendemail").text("인증요청");
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
        timeleft = 30;
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
                        $("#sendemail").text("재발송");

                        if (proc) {
                            clearInterval(timer);
                            display.html("00:30");
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
    });

    $(document).on("click", "#eregbtn", function () {
        if ($("#eregnumber").val() == ecode) {
            alert("인증 되었습니다");
            clearInterval(timer);
            display.html("");
            $("#eregnumber").prop("readonly", true);
            $("#sendemail").prop("disabled", true);
            $("#eregbtn").prop("disabled", true);
            $("#reseticon").hide();
            emailcode = true;
        } else {
            alert("인증 번호 틀림");
            $("#eregnumber").val("");
            $("#eregnumber").focus();
            emailcode = false;
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
                "<span>사용 가능한 비밀번호에요</span>");
            passvalid = true;
        } else {
            $("#passokicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>8~16자리 영문 대소문자, 숫자, 특수문자의 조합으로 만들어주세요</span>");
            passvalid = false;
        }

        if (pass != passMatch) {
            $("#passchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>비밀번호와 일치하지 않아요</span>");
            passcheck = false;
        } else {
            $("#passchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "<span>비밀번호와 일치해요</span>");
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
                "<span>2~10자의 한글,영문과 숫자만 사용해주세요</span>");
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
                            "<span>사용가능한 ID입니다</span>");
                        $("#m_nickname").css({"border": "1px solid black", "box-shadow": "none"});
                        nickname = true;
                    } else {
                        $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "<span>이미 사용중인 ID입니다</span>");
                        $("#m_nickname").css({"border": "1px solid red", "box-shadow": "none"});
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
                "<span>옳바른 이름을 입력해주세요</span>");
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
                    resultList.html("검색어를 입력해주세요");
                } else {
                    let s = "";
                    let result = false;
                    $.each(res, function (idx, ele) {
                        if (ele.ai_name.includes(ai_name)) {
                            s += `
                                <div id="acaname">\${ele.ai_name}</div>
                            `;
                            result = true
                        }
                        if (!result) {
                            s = "<label><div class='spinner-border spinner-border-sm text-mute'></div>" +
                                " Loading</label>";
                        }
                    });
                    resultList.html(s);
                }
            }
        });
    });

    $(document).on("click", "#acaname", function () {
        let txt = $(this).text();
        $("#modalname").val(txt);
        $("#ai_name").val(txt);
    });


    //phone check
    $(document).on("keyup", "#m_tele", function () {
        let phonenum = $("#m_tele").val();
        if (!validPhone(phonenum)) {
            $("#telechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 번호를 입력해주세요</span>");
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

    //trigger function
    $(document).on("mouseover keyup", function () {
        if (emailcheck && emailvalid && emailcode && passcheck && passvalid && nickname && nickvalid && namevalid && phonevalid) {
            $("#submitbtn").prop("disabled", false);
        } else {
            $("#submitbtn").prop("disabled", true);
        }
    });

    //submit
    $("#submitbtn").click(function () {
        if (!emailcheck || !emailvalid) {
            $("#m_email").focus();
            return false;
        } else if (!passcheck || !passvalid) {
            alert("비밀번호 확인");
            return false;
        } else if (!nickname || !nickvalid) {
            alert("닉네임 확인");
            return false;
        } else if (!namevalid) {
            $("#m_name").focus();
            return false;
        } else if (!phonevalid) {
            alert("핸드폰 인증");
            return false;
        } else {
            alert("잘했어");
            let formData = new FormData();

            formData.append("m_type", $("#m_type").val());
            formData.append("ai_name", $("#ai_name").val());
            formData.append("m_email", $("#m_email").val());
            formData.append("m_pass", $("#m_pass").val());
            formData.append("m_nickname", $("#m_nickname").val());
            formData.append("m_name", $("#m_name").val());
            formData.append("m_tele", $("#m_tele").val());
            formData.append("upload", $("#m_photo")[0].files[0]);

            $.ajax({
                type: "post",
                url: "signupform",
                dataType: "text",
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    alert("회원가입을 축하드립니다\n +100 포인트");
                    location.href = "grats";
                }
            });
        }
    });
</script>
</body>
</html>

