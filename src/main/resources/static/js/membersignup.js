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