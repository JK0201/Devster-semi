<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

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
        #ai_name {
            cursor: default;
        }

        #acaname {
            cursor: pointer;
        }

        #acaname:hover {
            color: red;
        }
    </style>
</head>
<script>
    $(function(){
        var refresh = localStorage.getItem("refresh");
        if(!refresh) {
            localStorage.setItem("refresh",true);
            location.reload();
        }else {
            localStorage.removeItem("refresh");
        }
        if ($("#m_email").val() == "") {
            location.replace("signin");
        }
    });
</script>
<body>
<input type="hidden" id="m_type" value="1">
<input type="hidden" id="m_email" value="${m_email}">
<input type="hidden" id="m_pass" value="${m_pass}">
<div style="width : 500px;">
    <b>이메일 ${m_email}
        패스 ${m_pass}
    </b>
    <br>
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
        <strong>닉네임</strong>
        <input type="text" id="m_nickname" required placeholder="2~10자리 / 한글,영문,숫자 사용가능">
        <span id="nicknamechkicon"></span>
    </div>
    <div>
        <strong>학원</strong>
        <input type="text" id="ai_name" required readonly data-bs-toggle="modal"
               data-bs-target="#myAcademyInfoModal">
    </div>
    <div>
        <strong>사진</strong>
        <input type="file" id="upload">
        <!-- 사진 미리보기 구현 해야함 -->
    </div>
    <div>
        <button type="button" id="submitbtn" disabled>가입하기</button>
    </div>
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
<script>
    let nickvalid = false;
    let nickname = false;
    let namevalid = false;
    let phonevalid = false;

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

    //trigger function
    $(document).on("mouseover keyup", function () {
        if (nickvalid && nickname && namevalid && phonevalid) {
            $("#submitbtn").prop("disabled", false);
        } else {
            $("#submitbtn").prop("disabled", true);
            console.log($("#m_pass").val());
        }
    });

    $("#submitbtn").click(function () {
        if (!nickvalid || !nickname) {
            alert("닉네임 확인");
            return false;
        } else if (!namevalid) {
            alert("이름확인");
            return false;
        } else if (!phonevalid) {
            alert("휴대폰 번호 확인");
            return false;
        } else {
            alert("잘했어");
            let formData = new FormData();
            formData.append("m_type", $("#m_type").val());
            formData.append("m_name", $("#m_name").val());
            formData.append("m_tele", $("#m_tele").val());
            formData.append("m_email", $("#m_email").val());
            formData.append("m_pass", $("#m_pass").val());
            formData.append("m_nickname", $("#m_nickname").val());
            formData.append("ai_name", $("#ai_name").val());
            formData.append("upload", $("#upload")[0].files[0]);

            // console.log($("#m_email").val());
            // console.log($("#m_type").val());
            // console.log($("#m_nickname").val());
            // console.log($("#ai_name").val());
            // console.log($("#upload")[0].files[0]);

            $.ajax({
                type: "post",
                url: "apisignupform",
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

    window.addEventListener("beforeunload", function (event) {
        event.preventDefault();
        event.returnValue = "";
    });
</script>
</body>
</html>

