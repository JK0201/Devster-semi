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

<form action="" method="post" enctype="multipart/form-data">
    <div>
        <div class="input-group">
            <b>이메일 </b>
            <input type="email" name="m_email" id="m_email" required>
            <span id="emailchkicon"></span>
        </div>
        <style>
            #m_email{
                outline:none;
                /*border:none;*/
            }
            #m_email:focus{
                /*box-shadow: 0 0 0 2px red;*/
                border:1px solid red;
                /*outline-color:red;*/
            }

        </style>
        <div>
            <b>비밀번호 </b>
            <input type="password" name="m_pass" id="m_pass" required>
            <span id="passokicon"></span>
            <br>
            <b>비밀번호확인</b>
            <input type="password" id="passchk">
            <span id="passchkicon"></span>
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
        <div class="input-group">
            <b>핸드폰</b>
            <input type="tel" name="m_tele" required>
            <button type="button" data-bs-toggle="modal" data-bs-target="#myCellPhoneModal">본인인증</button>
        </div>
        <div>
            <b>학원</b>
            <input type="hidden" name="ai_idx">
            <input type="text" name="ai_name" id="ai_name" data-bs-toggle="modal" data-bs-target="#myAcademyInfoModal">
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
                <input type="text" id="modalname">
                <div id="searchbox">111</div>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- 핸드폰 인증 -->
<div class="modal" id="myCellPhoneModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Modal Heading</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <input type="text" id="regnumber">
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
    let passvalid = false;
    let passcheck = false;
    let nickvalid = false;
    let nickname = false;

    //emailcheck
    $("#m_email").keyup(function () {
        let m_email = $(this).val();

        if (!isValidEmail(m_email)) {
            $("#emailchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>" +
                "<span>이메일 형식</span>");
            emailvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "emailchk",
                dataType: "json",
                data: {"m_email": m_email},
                success: function (res) {
                    if (res.result == "yes") {
                        $("#emailchkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
                        emailcheck = true;
                        console.log("echk : " + emailcheck);
                    } else {
                        $("#emailchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>" +
                            "<span>중복</span>");
                        emailcheck = false;
                        console.log("echk : " + emailcheck);
                    }
                }
            });
            emailvalid = true;
        }
        console.log("eval : " + emailvalid);
    });

    //email pattern
    function isValidEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //pass check
    $("#m_pass").keyup(function () {
        let pass = $(this).val();
        let passMatch = $("#passchk").val();
        let isValid = isValidPass(pass);

        if (isValid) {
            $("#passokicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>" +
                "<span>사용가능</span>");
            passvalid = true;
        } else {
            $("#passokicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>" +
                "<span>사용불가능</span>");
            passvalid = false;
        }

        if (pass != passMatch) {
            $("#passchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>");
            passcheck = false;
        } else if (pass == "" && passMatch == "") {
            $("#passchkicon").empty();
            passcheck = false;
        } else {
            $("#passchkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
            passcheck = true;
        }
        console.log("pchk : " + passcheck);
        console.log("pval : " + passvalid);
    });

    $("#passchk").keyup(function () {
        let pass = $("#m_pass").val();
        let passMatch = $(this).val();

        if (isValidPass(pass)) {
            $("#passokicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>" +
                "<span>사용가능</span>");
            passvalid = true;

            if (pass != passMatch) {
                $("#passchkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>");
                passcheck = false;
            } else {
                $("#passchkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
                passcheck = true;
            }
        } else {
            $("#passokicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>" +
                "<span>사용불가능</span>");
            passvalid = false;
        }
        console.log("pchk : " + passcheck);
        console.log("pval : " + passvalid);
    });


    function isValidPass(pass) {
        let passPattern = /^[a-zA-Z0-9!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]+$/;
        return pass.length >= 8 && passPattern.test(pass);
    }

    //nickname check
    $("#m_nickname").keyup(function () {
        let m_nickname = $(this).val();

        if (!isValidNickname(m_nickname)) {
            $("#nicknamechkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>사용불가능");
            nickvalid = false;
        }
        else {
            $.ajax({
                type: "get",
                url: "nicknamechk",
                dataType: "json",
                data: {"m_nickname": m_nickname},
                success: function (res) {
                    if (res.result == "no") {
                        $("#nicknamechkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
                        nickname = true;
                        console.log("nn : " + nickname);
                    } else {
                        $("#nicknamechkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>사용불가능");
                        nickname = false;
                        console.log("nn : " + nickname);
                    }
                }
            });
            nickvalid = true;
        }
        console.log("nval : " + nickvalid);
    });

    function isValidNickname(nickname) {
        let nickNamePattern = /^[a-zA-Z0-9가-힣]{2,10}$/
        return nickNamePattern.test(nickname);
    }

    //학원 검색
    $(document).on("keyup", "#modalname", function () {
        let ai_name = $(this).val();
        console.log(ai_name);
        $.ajax({
            type: "get",
            url: "searchai",
            dataType: "json",
            data: {"ai_name": ai_name},
            success: function (res) {
                let resultList = $("#searchbox");
                resultList.empty();

                if ($("#modalname").val() == "") {
                    resultList.html("검색어를 입력해 주세요");
                } else {
                    s = "";
                    $.each(res, function (idx, ele) {
                        if (ele.ai_name.includes(ai_name)) {
                            s += `
                                \${ele.ai_name}<br>
                            `
                        }

                    });
                    resultList.html(s);
                }
            }
        });
    });

    //submit
    $("#submitbtn").click(function () {
        if ($("#m_email").val() == "") {
            alert("이메일을 입력해 주세요");
            return false;
        }
        /*let emailcheck = false;
        let passcheck = false;
        let nickname = false;*/
        if (emailcheck == false) {
            alert("이메일 확인");
            return false;
        } else if (passcheck == false) {
            alert("비밀번호 확인");
            return false;
        } else if (nickname == false) {
            alert("닉네임 확인");
            return false;
        }

        if (emailcheck && passcheck && nickname) {
            alert("굿");
        }
    });
</script>
</body>
</html>

