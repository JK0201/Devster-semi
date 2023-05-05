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
        #m_email {
            outline: none;
            /*border:none;*/
        }

        #m_email:focus {
            /*box-shadow: 0 0 0 2px red;*/
            border: 1px solid red;
            /*outline-color:red;*/
        }

        input:disabled {
            background-color: #ffffff;
        }

        #acaname {
            cursor: pointer;
        }

        #acaname:hover {
            color: red;
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

    <div>
        <div class="input-group">
            <b>이메일 </b>
            <input type="email" id="m_email" required>
            <span id="emailchkicon"></span>
        </div>
        <div>
            <b>비밀번호 </b>
            <input type="password" id="m_pass" required>
            <span id="passokicon"></span>
            <br>
            <b>비밀번호확인</b>
            <input type="password" id="passchk">
            <span id="passchkicon"></span>
        </div>
        <div>
            <b>닉네임</b>
            <input type="text" id="m_nickname" required>
            <span id="nicknamechkicon"></span>
        </div>
        <div>
            <b>이름 </b>
            <input type="text" id="m_name" required>
            <span id="namechkicon"></span>
        </div>
        <div class="input-group">
            <b>핸드폰</b>
            <input type="tel" id="m_tele" required>
            <button type="button" id="sendnumber">인증번호</button>
        </div>
        <div>
            <b>학원</b>
            <input type="text" id="ai_name" disabled data-bs-toggle="modal"
                   data-bs-target="#myAcademyInfoModal">
        </div>
        <div>
            <b>사진</b>
            <input type="file" name="upload" id="m_photo">
            <!-- 사진 미리보기 구현 해야함 -->
        </div>
    </div>
    <button type="button" id="submitbtn">가입하기</button>

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
                <div id="searchbox"></div>
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
                <div class="input-group">
                    <input type="text" id="regnumber">
                    <button type="button" id="regbtn"><span>본인인증</span></button>
                </div>

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
    let namevalid = false;
    let phonecheck = false;

    //emailcheck
    $("#m_email").keyup(function () {
        let m_email = $(this).val();
        if (!validEmail(m_email)) {
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
    function validEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //pass check
    $("#m_pass").keyup(function () {
        let pass = $(this).val();
        let passMatch = $("#passchk").val();
        let valid = validPass(pass);

        if (valid) {
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

        if (validPass(pass)) {
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


    function validPass(pass) {
        let passPattern = /^[a-zA-Z0-9!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]+$/;
        return pass.length >= 8 && passPattern.test(pass);
    }

    //nickname check
    $("#m_nickname").keyup(function () {
        let m_nickname = $(this).val();

        if (!validNickname(m_nickname)) {
            $("#nicknamechkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>사용불가능");
            nickvalid = false;
        } else {
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

    function validNickname(nickname) {
        let nickNamePattern = /^[a-zA-Z0-9가-힣]{2,10}$/;
        return nickNamePattern.test(nickname);
    }

    //name check
    $("#m_name").keyup(function () {
        let m_name = $(this).val();

        if (!validName(m_name)) {
            $("#namechkicon").html("<i class='bi bi-x-circle-fill' style='color:red;'></i>");
            namevalid = false;
        } else {
            $("#namechkicon").html("<i class='bi bi-check-circle-fill' style='color:green;'></i>");
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
                    resultList.html("검색어를 입력해주세요");
                } else {
                    s = "";
                    $.each(res, function (idx, ele) {
                        if (ele.ai_name.includes(ai_name)) {
                            s += `
                                <span id="acaname">\${ele.ai_name}</span><br>
                            `
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
        console.log($("#ai_name").val());
    });

    //phone check
    let code = "";
    $(document).on("click", "#sendnumber", function (e) {
        let phonenum = $("#m_tele").val();
        if (!validPhone(phonenum)) {
            alert("핸드폰 번호 확인");
            return false;
        } else {
            alert("인증번호가 발송되었습니다");
            $.ajax({
                type: "get",
                url: "phonechk?phonenum=" + phonenum,
                cache: false,
                success: function (res) {
                    console.log(res);
                    $("#myCellPhoneModal").modal("show");
                    code = res;
                }
            });
        }
    });

    $("#regbtn").click(function () {
        if ($("#regnumber").val() == code) {
            alert("인증 되었습니다");
            phonecheck = true;
        } else {
            alert("인증 번호 틀림");
            phonecheck = false;
        }
        console.log(phonecheck);
    });

    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

    //submit
    $("#submitbtn").click(function () {
        if (emailcheck == false || emailvalid == false) {
            $("#m_email").focus();
            return false;
        } else if (passcheck == false || passvalid == false) {
            alert("비밀번호 확인");
            return false;
        } else if (nickname == false || nickvalid == false) {
            alert("닉네임 확인");
            return false;
        } else if (namevalid == false) {
            $("#m_name").focus();
            return false;
        } /*else if (phonecheck == false) {
            alert("핸드폰 인증");
            return false;
        }*/

        if (emailcheck && passcheck && nickname && emailvalid && passvalid && nickvalid && namevalid) { //phonecheck 넣을것
            let formData=new FormData();
            formData.append("ai_name",$("#ai_name").val());
            formData.append("m_email",$("#m_email").val());
            formData.append("m_pass",$("#m_pass").val());
            formData.append("m_nickname",$("#m_nickname").val());
            formData.append("m_name",$("#m_name").val());
            formData.append("m_tele",$("#m_tele").val());
            formData.append("upload",$("#m_photo")[0].files[0]);

            $.ajax({
                type:"post",
                dataType:"text",
                url:"signupform",
                data:formData,
                processData:false,
                contentType:false,
                success:function(res) {
                    alert("회원가입을 축하드립니다\n +100 포인트");
                    location.href="signin";
                }
            });
        } else {
            return false;
        }
    });
</script>
</body>
</html>

