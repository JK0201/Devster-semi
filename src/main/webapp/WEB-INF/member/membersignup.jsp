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
        #emailtxt {
            display: none;
        }
    </style>
</head>
<body>
로그인 : ${sessionScope.logstat}
<br>
m_idx : ${sessionScope.memidx}
<br>
nickname : ${sessionScope.memnick}
<br>
state : ${sessionScope.memstate}
<br>
ai_idx : ${sessionScope.acaidx}

<%--<input type="text" name="emailaddr" id="emailaddr" required>
    <span>@</span>
    <input type="text" name="emailtxt" id="emailtxt" required placeholder="example.com">
    <select name="emailsel" id="emailsel">
        <option>xxxx</option>
        <option value="gmail.com">gmail.com</option>
        <option value="naver.com">naver.com</option> <!-- 차후에 네이버 카카오 벨류값 받아와서 수정 -->
        <option value="kakao.com">kakao.com</option>
        <option value="daum.net">daum.net</option>
        <option value="nate.com">nate.com</option>
        <option value="1" >직접입력</option>
    </select>--%>

<form action="" method="post" enctype="multipart/form-data">
    <div>
        <div class="input-group">
            <b>이메일 </b>
            <input type="email" name="m_email" id="m_email" required>

            <button type="button" id="emailchk">중복확인</button>
        </div>
        <div>
            <b>비밀번호 </b>
            <input type="password" name="m_pass" id="m_pass" required>
            <b>비밀번호확인</b>
            <input type="password" id="passchk">
            <span id="emailchkicon"></span>
        </div>
        <div>
            <b>닉네임</b>
            <input type="text" name="m_nickname" id="m_nickname" required>
            <span id="nicknamechkicon"></span>
        </div>
        <div>
            <b>이름 </b>
            <input type="text" name="m_name" required>
        </div>
        <div>
            <b>핸드폰</b>
            <input type="tel" name="m_tele" required>
        </div>
        <div>
            <b>소속</b>
            <input type="text" name="ai_name" id="ai_name">
            <div id="searchbox">111</div>
        </div>
        <div>
            <b>사진</b>
            <input type="file" name="m_photo">
        </div>
        <div>
            <b>인증</b>
            <input type="file" name="m_filename">
        </div>
    </div>
    <button type="submit" id="submitbtn">가입하기</button>
</form>
<script>
    // $("#emailsel").change(function () {
    //     let sel = $("#emailsel").val();
    //     if (sel == "1") {
    //         $("#emailtxt").val("");
    //         $("#emailtxt").show();
    //     } else {
    //         $("#emailtxt").hide();
    //         $("#emailtxt").val($("#emailsel").val());
    //     }
    // });

    let emailcheck = false;
    let passcheck = false;
    let nickname = false;

    //emailcheck
    $("#emailchk").click(function () {
        let m_email = $("#m_email").val();
        console.log(m_email);

        if ($("#m_email").val() == "") {
            alert("이메일을 입력해 주세요");
            return false;
        }

        $.ajax({
            type: "get",
            url: "emailchk",
            dataType: "json",
            data: {"m_email": m_email},
            success: function (res) {
                if (res.result == "yes") {
                    alert("가입가능");
                    emailcheck = true;
                } else {
                    alert("가입불가능");
                }
            }
        });
    });

    //keyup false
    $("#emailtxt").keyup(function () {
        emailcheck = false;
    });

    //passcheck
    $("#m_pass").blur(function () {
        if ($(this).val() == $("#passchk").val()) {
            $("#emailchkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
            passcheck = true;
        } else {
            $("#emailchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>");
            passcheck = false;
        }
        console.log(passcheck);
    });
    $("#passchk").blur(function () {
        if ($(this).val() == $("#m_pass").val()) {
            $("#emailchkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
            passcheck = true;
        } else {
            $("#emailchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>");
            passcheck = false;
        }
        console.log(passcheck);
    });

    $("#m_nickname").blur(function () {
        let m_nickname = $(this).val();
        console.log(m_nickname);
        $.ajax({
            type: "get",
            url: "nicknamechk",
            dataType: "json",
            data: {"m_nickname": m_nickname},
            success: function (res) {
                if (res.result == "no") {
                    $("#nicknamechkicon").html("가입가능");
                } else {
                    $("#nicknamechkicon").html("가입불가능");
                }
            }
        });
    });

    $("#submitbtn").click(function () {

    });
</script>
</body>
</html>

