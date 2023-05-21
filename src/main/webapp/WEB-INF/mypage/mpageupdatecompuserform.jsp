<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        .companyUser_info_update{
            padding: 0 30px;
        }

        .companyUser_info_update .title{
            font-weight: 700;
            font-size: 30px;
            color: #222;
        }

        .companyUser_info_update .wrapped{
            margin-top: 24px;
        }

        .companyUser_info_update .companyUser_informations{
            border-top: 1px solid rgb(34, 34, 34);
            padding-top: 40px;
            padding-left: 40px;
        }

        .companyUser_info_update .companyUser_informations strong{
            font-weight: 400;
            font-size: 15px;
            color: rgb(34, 34, 34);
            width: 100px;
            display: inline-block;
        }

        .companyUser_info_update .companyUser_informations input{
            width: 400px;
            padding: 12px 16px;
            border-radius: 4px;
            box-sizing: border-box;
            border: 1px solid rgb(212, 212, 212);
        }

        .companyUser_info_update .companyUser_informations input#cm_post{
            width: 100px;
            padding: 12px 16px;
            border-radius: 4px;
            box-sizing: border-box;
            border: 1px solid rgb(212, 212, 212);
            margin-left: 3px;
        }

        #addr_box{
            display: flex;
            margin-left: 100px;
        }

        .companyUser_info_update .companyUser_informations>div{
            margin-bottom: 24px;
        }

        .companyUser_info_update .companyUser_informations button{
            float: right;
            margin-right: 277px;
        }
    </style>

<div class="companyUser_info_update">

    <h1 class="title">계정 설정</h1>

    <div class="wrapped">
        <div class="companyUser_informations">
            <div>
                <strong>이메일</strong>
                <input type="email" id="cm_email" required placeholder="${dto.cm_email}" disabled>
                <span id="emailchkicon"></span>

            </div>
            <div>
                <strong>비밀번호</strong>
                <input type="password" id="cm_pass" required placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
                <span id="passokicon"></span><br>

            </div>
            <div>
                <strong>비밀번호확인</strong>
                <input type="password" id="passchk" placeholder="8~16자리/영문 대소문자, 숫자, 특수문자 조합">
                <span id="passchkicon"></span>
            </div>
            <div>
                <strong>회사명</strong>
                <input type="text" id="cm_compname" required value="${dto.cm_compname}">
                <span id="compnamechkicon"></span>
            </div>
            <div>
                <div class="input-group">
                    <strong>우편번호</strong>
                    <input type="text" id="cm_post" readonly required value="${dto.cm_post}">
                    <button type="button" id="postbtn" class="btn btn-sm btn-outline-secondary" style="margin-left: 4px;">우편번호 찾기</button>
                </div>
                <div id="addr_box" style="margin-top: 6px;">
                    <div style="display: flex">
                        <%--<h6>주소</h6>--%>
                        <input type="text" id="addr" readonly required value="${cm_addr1}" style="width: 200px; float:left;margin-left: 3px;">
                    </div>
                    <div style="display: flex; margin-left: 5px;">
                        <%--<h6>상세주소</h6>--%>
                        <input type="text" id="addrinfo" required value="${cm_addr2}" style="width: 195px; float:left;">
                        <span id="addrchkicon"></span>
                    </div>
                </div>
            </div>

            <div>
                <strong>전화번호</strong>
                <input type="tel" id="cm_tele" required value="${dto.cm_tele}">
                <span id="cpchkicon"></span>
            </div>
            <div>
                <strong>담당자</strong>
                <input type="text" id="cm_name" required value="${dto.cm_name}">
                <span id="namechkicon"></span>
            </div>
            <div>
                <strong>휴대폰</strong>
                <input type="tel" id="cm_cp" required value="${dto.cm_cp}">
                <span id="cmchkicon"></span>
            </div>
            <div>
                <button type="button" id="submitbtn" disabled class="btn btn-sm btn-outline-secondary">수정하기</button>
            </div>
        </div>
    </div>

</div>
<script>
    let passvalid = false;
    let passcheck = false;
    let compname = false;
    let compvalid = false;
    let namevalid = false;
    let phonecheck = false;
    let cphonecheck = false;
    let addrcheck = false;

    //pass check
    function updatePasswordStatus() {
        let pass = $("#cm_pass").val();
        let passMatch = $("#passchk").val();
        let valid = validPass(pass);

        if (valid) {
            $("#passokicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "<span>사용 가능한 비밀번호에요</span>");
            passvalid = true;
        } else {
            $("#passokicon").html("<div style='display: flex; margin-left: 100px;'><i class='bi bi-x' style='color:red;'></i>" +
                "<span style='font-size: 12px;'>8~16자리 영문 대소문자, 숫자, 특수문자의 조합으로 만들어주세요</span></div>");
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

    $("#cm_pass").keyup(function () {
        updatePasswordStatus();
    });

    $("#passchk").keyup(function () {
        updatePasswordStatus();
    });

    function validPass(pass) {
        let passPattern = /^[a-zA-Z0-9!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]+$/;
        return pass.length >= 8 && pass.length <= 16 && passPattern.test(pass);
    }

    //compname check
    $("#cm_compname").keyup(function () {
        let cm_compname = $(this).val();
        if (!validCompname(cm_compname)) {
            $("#compnamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>한글,영문과 숫자만 사용해주세요</span>");
            compvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "compnamechk",
                dataType: "json",
                data: {"cm_compname": cm_compname},
                success: function (res) {
                    if (res.result == "no") {
                        $("#compnamechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                            "<span>사용가능한 회사명입니다</span>");
                        $("#cm_compname").css({"border": "1px solid black", "box-shadow": "none"});
                        compname = true;
                    } else {
                        $("#compnamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "<span>이미 사용중인 회사명입니다</span>");
                        $("#cm_compname").css({"border": "1px solid red", "box-shadow": "none"});
                        compname = false;
                    }
                }
            });
            compvalid = true;
        }
    });

    function validCompname(compname) {
        let compNamePattern = /^[a-zA-Z0-9가-힣]{1,}$/;
        return compNamePattern.test(compname);
    }

    //kakao addr api
    window.onload = function () {
        $("#postbtn, #cm_post, #addr").click(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    $("#cm_post").val(data.zonecode);
                    $("#addr").val(data.address);
                    $("#addrinfo").focus();
                }
            }).open();
        });
    }

    //addr pattern
    $("#addrinfo").keyup(function(){
        let addrinfo=$(this).val();
        if (!validAddrPattern(addrinfo)) {
            $("#addrchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 주소를 입력해주세요</span>");
        } else {
            $("#addrchkicon").html("<i class='bi bi-check' style='color:green;'></i>");
        }
    });

    function validAddrPattern(addr) {
        let addrPattern=/^[0-9a-zA-Z가-힣()\-,.\s]{1,}$/
        return addrPattern.test(addr)
    }
    //name check
    $("#cm_name").keyup(function () {
        let cm_name = $(this).val();
        if (!validName(cm_name)) {
            $("#namechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이름을 입력해주세요</span>");
            namevalid = false;
        } else {
            $("#namechkicon").html("<i class='bi bi-check' style='color:green;'></i>");
            namevalid = true;
        }
    });

    function validName(name) {
        let namePattern = /^[가-힣]{1,}$/;
        return namePattern.test(name);
    }

    //phone chk
    $("#cm_cp").keyup(function () {
        let cm_cp = $(this).val();
        if (!validPhone(cm_cp)) {
            $("#cmchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 이름을 입력해주세요</span>");
            phonecheck = false;
        } else {
            $("#cmchkicon").html("<i class='bi bi-check' style='color:green;'></i>");
            phonecheck = true;
        }
    });

    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

    //company phone chk
    $("#cm_tele").keyup(function () {
        let cm_tele = $(this).val();
        if (!validCompNum3(cm_tele) && !validCompNum2(cm_tele)) {
            $("#cpchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>옳바른 번호를 입력해주세요</span>");
            cphonecheck = false;
        } else {
            $("#cpchkicon").html("<i class='bi bi-check' style='color:green;'></i>");
            cphonecheck = true;
        }
    });

    function validCompNum2(cphonenum2) {
        let cphoneNumPattern2 = /^\d{4}-?\d{4}$/;
        return cphoneNumPattern2.test(cphonenum2);
    }

    function validCompNum3(cphonenum3) {
        let cphoneNumPattern3 = /^0([0-9]{1,2})-?\d{3,4}-?\d{4}$/;
        return cphoneNumPattern3.test(cphonenum3)
    }

    //trigger function
    $(document).on("mouseover keyup", function () {
        if ($("#cm_post").val() == "" || $("#addr").val() == "" || $("#addrinfo").val() == "") {
            addrcheck = false;
        } else {
            addrcheck = true;
        }

        if (passcheck && passvalid && compname && compvalid && namevalid && phonecheck && cphonecheck && addrcheck) {
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
        } else if (!compname || !compvalid) {
            alert("회사명 확인");
            return false;
        } else if (!namevalid) {
            alert("담당자이름 확인");
            return false;
        } else if (!phonecheck) {
            alert("회사 전화확인");
            return false;
        } else if (!cphonecheck) {
            alert("담당자 전화 확인");
            return false;
        } else if (!addrcheck) {
            alert("주소 확인");
            return false;
        } else {
            alert("잘했어");
            let formData = new FormData();
            let cm_addr = $("#addr").val() + "," + $("#addrinfo").val().trim();

            formData.append("cm_pass", $("#cm_pass").val());
            formData.append("cm_compname", $("#cm_compname").val());
            formData.append("cm_post", $("#cm_post").val());
            formData.append("cm_addr", cm_addr);
            formData.append("cm_tele", $("#cm_tele").val());
            formData.append("cm_name", $("#cm_name").val());
            formData.append("cm_cp", $("#cm_cp").val());


            $.ajax({
                type: "post",
                dataType: "text",
                url: "updatecm",
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
</script>


