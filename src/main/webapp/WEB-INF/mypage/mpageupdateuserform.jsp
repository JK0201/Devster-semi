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
<div style="width : 800px; margin-left: 500px">
    <div>
        <strong>이메일</strong>
        <input type="email" id="m_email" required placeholder="${dto.m_email}" disabled>
        <span id="emailchkicon"></span>
    </div>
    <div>
        <strong>닉네임</strong>
        <input type="text" id="m_nickname" required value="${dto.m_nickname}">
        <span id="nicknamechkicon"></span>
    </div>
    <div>
        <strong>비밀번호</strong>
        <input type="password" id="m_pass" required placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
        <span id="passokicon"></span><br>
        <b>비밀번호확인</b>
        <input type="password" id="passchk" placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
        <span id="passchkicon"></span>
    </div>
    <div>
        <strong>이름 </strong>
        <input type="text" id="m_name" required value="${dto.m_name}">
        <span id="namechkicon"></span>
    </div>
    <div class="input-group phonechk">
        <strong>휴대폰</strong>
        <input type="tel" id="m_tele" required value="${dto.m_tele}">
        <span id="telechkicon"></span>
    </div>
    <div>
        <strong>사진</strong>
        <input type="file" id="m_photo">
        <br>
        <img id="showimg" src="" style="width: 400px">
        <br>
        <button onclick="setDefaultProfile()">기본 프로필사진으로 변경</button>
        <br>
        <button type="button" id="submitbtn" disabled>수정하기</button>
    </div>
</div>

<%--<script src="/js/membersignup.js"></script>--%>
<script>
    let passvalid = false;
    let passcheck = false;
    let nickvalid = false;
    let nickname = false;
    let namevalid = false;
    let phonevalid = false;

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

    $("#m_photo").change(function () {
        console.log("1:" + $(this)[0].files.length);
        console.log("2:" + $(this)[0].files[0]);
        //정규표현식
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
        var f = $(this)[0].files[0];//현재 선택한 파일
        if (!f.type.match(reg)) {
            alert("확장자가 이미지파일이 아닙니다");
            $(this).val("");
            return;
        }
        if ($(this)[0].files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#showimg").attr("src", e.target.result);
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }
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
        if (passcheck && passvalid && nickname && nickvalid && namevalid && phonevalid) {
            $("#submitbtn").prop("disabled", false);
        } else {
            $("#submitbtn").prop("disabled", true);
        }
    });

    //submit
    $("#submitbtn").click(function () {
        if (!passcheck || !passvalid) {
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

            formData.append("m_pass", $("#m_pass").val());
            formData.append("m_nickname", $("#m_nickname").val());
            formData.append("m_name", $("#m_name").val());
            formData.append("m_tele", $("#m_tele").val());
            formData.append("upload", $("#m_photo")[0].files[0]);

            $.ajax({
                type: "post",
                url: "/mypage/update",
                dataType: "text",
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    alert("정보 수정이 완료되었습니다.");
                    alert("개인 정보 수정으로 다시 로그인해주세요")
                    location.href='/member/outtest';
                }
            });
        }
    });

    function setDefaultProfile() {
        $.ajax({
            type: "get",
            url: "/mypage/updatedefaultphoto",
            success: function (res) {
                alert("프로필사진이 기본사진으로 변경되었습니다.");
            }
        });
    }
</script>
</body>
</html>

